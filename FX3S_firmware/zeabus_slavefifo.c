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
#include "Sync_Slave_FIFO.cydsn/cyfxgpif2config.h"

#define ZEABUS_FIFO_CONS_SOCKET_ID   CY_U3P_PIB_SOCKET_1
#define ZEABUS_FIFO_PROD_SOCKET_ID   CY_U3P_PIB_SOCKET_0

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
        dmaConfig.count          = 1;
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
        dmaConfig.size           = 8192;
        dmaConfig.count          = 2;
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
        if( CyU3PGpifSocketConfigure( 0, ZEABUS_FIFO_CONS_SOCKET_ID, 2, CyFalse, 1 ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to associate FPGA->FX3S DMA to the GPIF thread\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }

        if( CyU3PGpifSocketConfigure( 1, ZEABUS_FIFO_PROD_SOCKET_ID, 2, CyFalse, 1 ) != CY_U3P_SUCCESS )
        {
			_log( "Unable to associate FX3S->FPGA DMA to the GPIF thread\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }
     
		if( CyU3PGpifSMStart (0, 0) != CY_U3P_SUCCESS )
        {
			_log( "Unable to start slave-FIFO state machine\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
        }

		/* Set DMA Channel transfer size and start DMA engine. (DMA transfer size = 0 means infinite) */
		if( CyU3PDmaChannelSetXfer(&xDMAFIFOToFPGA, 0) != CY_U3P_SUCCESS )
		{
			_log( "Unable to start FX3S->FPGA DMA\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
		}

 		if( CyU3PDmaChannelSetXfer(&xDMAFIFOFromFPGA, 0) != CY_U3P_SUCCESS )
		{
			_log( "Unable to start FPGA->FX3S DMA\r\n" );
            CyU3PDmaChannelDestroy( &xDMAFIFOToFPGA );
            CyU3PDmaChannelDestroy( &xDMAFIFOFromFPGA );
            return false;
		}

       bIsInitialized = true;
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
    bIsInitialized = false;
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
        return false;

    if( CyU3PDmaChannelWaitForCompletion (&xDMAFIFOToFPGA, 500) != CY_U3P_SUCCESS )
        return false;

    return true;
}

bool zeabus_slavefifo_is_started( void )
{
    return( bIsInitialized );
}
