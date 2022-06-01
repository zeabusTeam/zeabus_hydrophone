/****************************************************************************
 * zeabus_slavefifo.c
 *
 * Zeabus firmware for EZ-USB FX3 Microcontrollers
 * Copyright (C) 2019-2020 Zeabus Term, Kasetsart University.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name RobinLab nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/
#include <cyu3gpif.h>
#include <cyu3pib.h>
#include <cyu3dma.h>

#include "zeabus_error.h"
#include "zeabus_slavefifo.h"
#include "zeabus_usb.h"
#include "zeabus_gpio.h"
#include "Sync_Slave_FIFO.cydsn/cyfxgpif2config.h"

/* Note:
 * Thread 0 = FX3S ==> FPGA
 * Thread 1 = FX3S <== FPGA
 *
 * FLAGA : indicates that FX3S has some data to read. (0 = Empty)
 * FLAGB : indicates that FX3S has some spacce to accept more data (1 = Available)
 */
#define ZEABUS_FIFO_CONS_SOCKET_ID   CY_U3P_PIB_SOCKET_1
#define ZEABUS_FIFO_PROD_SOCKET_ID   CY_U3P_PIB_SOCKET_0

// A DMA buffer should have the same size as defined in FPGA part
#define ZEABUS_FIFO_DMA_BUFF_SIZE	8192

/* Clock config for FPGA programming (The field isDllEnable is different from FPGA configuration mode) */
static CyU3PPibClock_t zeabus_slavefifo_pib_clock = {
    .clkDiv = 6,                // 416 / 6.5 = 64 MHz
    .clkSrc = CY_U3P_SYS_CLK,   // 416 MHz
    .isHalfDiv = CyTrue,
    .isDllEnable = CyFalse
};

static bool bIsInitialized = false;
static CyU3PDmaChannel xDMAFIFOToFPGA;  	/* DMA Channel handle for FX3S->FPGA transfer. */
static CyU3PDmaChannel xDMAFIFOFromFPGA;	/* DMA Channel handle for FPGA->FX3S transfer. */

/************************************************************************************
 * Private Functions
 ************************************************************************************/
 /* Callback function to check for PIB ERROR*/
static void gpif_error_cb(CyU3PPibIntrType cbType, uint16_t cbArg)
{
	if(cbType==CYU3P_PIB_INTR_ERROR)
	{
		switch(CYU3P_GET_PIB_ERROR_TYPE(cbArg))
		{
			case CYU3P_PIB_ERR_THR0_WR_OVERRUN:
				_log( "Slave FIFO thread 0 writing overrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR1_WR_OVERRUN:
				_log( "Slave FIFO thread 1 writing overrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR2_WR_OVERRUN:
				_log( "Slave FIFO thread 2 writing overrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR3_WR_OVERRUN:
				_log( "Slave FIFO thread 3 writing overrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR0_RD_UNDERRUN:
				_log( "Slave FIFO thread 0 reading underrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR1_RD_UNDERRUN:
				_log( "Slave FIFO thread 1 reading underrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR2_RD_UNDERRUN:
				_log( "Slave FIFO thread 2 reading underrun\r\n" );
				break;
			case CYU3P_PIB_ERR_THR3_RD_UNDERRUN:
				_log( "Slave FIFO thread 3 reading underrun\r\n" );
				break;
			default:
				_log( "No Underrun/Overrun Error\r\n" );
				break;
		}
	}
}

/************************************************************************************
 * Public API Functions
 ************************************************************************************/

/**********************************************************************
 * Function :  zeabus_fpgaconf_start
 **********************************************************************/
bool zeabus_slavefifo_start( void )
{
    CyU3PDmaChannelConfig_t dmaConfig;
    // CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;

    if ( !bIsInitialized ) 
    {
        // Setup PIB clock for master mode
        CyU3PGpifDisable( CyTrue );
        (void)CyU3PPibDeInit();
        if( CyU3PPibInit( CyTrue, &zeabus_slavefifo_pib_clock ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to set PIB clock for slave FIFO\r\n" );
            return false;
        }

        // create dma channel for FX3S to FPGA
        CyU3PMemSet ((uint8_t *)&dmaConfig, 0, sizeof(dmaConfig));
        dmaConfig.size           = 1024;
        dmaConfig.count          = 0;
        dmaConfig.prodAvailCount = 0;
        dmaConfig.dmaMode        = CY_U3P_DMA_MODE_BYTE;
        dmaConfig.prodHeader     = 0;
        dmaConfig.prodFooter     = 0;
        dmaConfig.consHeader     = 0;
        dmaConfig.consSckId      = ZEABUS_FIFO_PROD_SOCKET_ID;
        dmaConfig.prodSckId      = CY_U3P_CPU_SOCKET_PROD;
        dmaConfig.notification   = 0;
        dmaConfig.cb             = NULL;

        if( CyU3PDmaChannelCreate( &xDMAFIFOToFPGA, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaConfig ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to create FX3S->FPGA DMA for slave FIFO\r\n" );
            return false;
        }

        // create dma channel for FPGA to FX3S
        dmaConfig.size           = ZEABUS_FIFO_DMA_BUFF_SIZE;
        dmaConfig.count          = 4;
        dmaConfig.consSckId      = ZEABUS_DMA_EP_USB_FPGA_CONSUMER_SOCKET;
        dmaConfig.prodSckId      = ZEABUS_FIFO_CONS_SOCKET_ID;

        if( CyU3PDmaChannelCreate( &xDMAFIFOFromFPGA, CY_U3P_DMA_TYPE_AUTO, &dmaConfig ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to create FPGA->FX3S DMA for slave FIFO\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            return false;
        }

        /* Reload the GPIF state machine */
        if( CyU3PGpifLoad( &CyFxGpifConfig ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to load GPIF state machine\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }
		
        if( CyU3PGpifSocketConfigure( 0, ZEABUS_FIFO_PROD_SOCKET_ID, 2, CyFalse, 1 ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to associate FX3S->FPGA DMA to the GPIF thread\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }
     
        if( CyU3PGpifSocketConfigure( 1, ZEABUS_FIFO_CONS_SOCKET_ID, 2, CyFalse, 1 ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to associate FPGA->FX3S DMA to the GPIF thread\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }

		/* Register a callback for notification of PIB interrupts*/
		CyU3PPibRegisterCallback(gpif_error_cb, 0xffff);
		
		if( CyU3PGpifSMStart (0, 0) != CY_U3P_SUCCESS )
        {
			_log( "Unable to start slave-FIFO state machine\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }

		/* Set DMA Channel transfer size and start auto-mode DMA engine. (DMA transfer size = 0 means infinite) */
		if( CyU3PDmaChannelSetXfer(&xDMAFIFOFromFPGA, 0) != CY_U3P_SUCCESS )
		{
			_log( "Unable to start FPGA->FX3S DMA\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
		}

		/* callback to see if there is any overflow of data on the GPIF II side*/
		CyU3PPibRegisterCallback( gpif_error_cb, 0xffff );
		
		// Finalize
		bIsInitialized = true;
		_log( "Slave FIFO started\r\n" );
    }

    return true;
}

void zeabus_slavefifo_stop( void )
{
    CyU3PGpifDisable( CyTrue );
    (void)CyU3PPibDeInit();
    if ( bIsInitialized )
    {
        CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
        CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
    }
	zeabus_gpiowrite( ZEABUS_GPIO_FPGA_SRES, true );	// Arm reset
    bIsInitialized = false;
	_log( "Slave FIFO stopped\r\n" );
}

bool zeabus_slavefifo_send( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t buf_p;

    if( !bIsInitialized )
        return false;

    buf_p.size  = size;
    buf_p.count = size;
    buf_p.buffer = buf;
    buf_p.status = 0;

    if( CyU3PDmaChannelSetupSendBuffer( &xDMAFIFOToFPGA, &buf_p ) != CY_U3P_SUCCESS )
	{
		_log( "Unable to allocate DMA buffer with size %u for sending %u bytes to FPGA\r\n", buf_p.size, size );
        return false;
	}

    if( CyU3PDmaChannelWaitForCompletion (&xDMAFIFOToFPGA, 500) != CY_U3P_SUCCESS )
	{
		_log( "Failed to send data to FPGA\r\n" );
        return false;
	}

	_log( "Sent data with size %u bytes to FPGA\r\n", size );
    return true;
}

bool zeabus_slavefifo_is_started( void )
{
    return( bIsInitialized );
}
