/****************************************************************************
 * zeabus_fpgaconf.c
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

#include "zeabus_fpgaconf.h"
#include "zeabus_gpio.h"
#include "zeabus_usb.h"
#include "zeabus_slavefifo.h"

#define ZEABUS_FPGACONF_SOCKET_ID   CY_U3P_PIB_SOCKET_1

//Transition function values used in the state machine.
static uint16_t zeabus_fpgaconf_gpif_transition[]  = {
    0x0000, 0xAAAA, 0xFFFF
};

/* Table containing the transition information for various states. 
   This table has to be stored in the WAVEFORM Registers.
   This array consists of non-replicated waveform descriptors and acts as a 
   waveform table. */
static CyU3PGpifWaveData zeabus_fpgaconf_gpif_wavedata[]  = {
    {{0x1E739A01,0x040000C0,0x80000000},{0x00000000,0x00000000,0x00000000}},
    {{0x2E739C02,0x04400040,0x80000000},{0x00000000,0x00000000,0x00000000}},
    {{0x1E739A03,0x040000C0,0x80000000},{0x00000000,0x00000000,0x00000000}}
};

// Table that maps state indexes to the descriptor table indexes.
static uint8_t zeabus_fpgaconf_gpif_wavedata_position[]  = {
    0,1,2,1
};

// GPIF II configuration register values.
static uint32_t zeabus_fpgaconf_gpif_reg_value[]  = {
    0x800083B0,  /*  CY_U3P_PIB_GPIF_CONFIG */
    0x00000003,  /*  CY_U3P_PIB_GPIF_BUS_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_BUS_CONFIG2 */
    0x00000046,  /*  CY_U3P_PIB_GPIF_AD_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_STATUS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INTR */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INTR_MASK */
    0x00000082,  /*  CY_U3P_PIB_GPIF_SERIAL_IN_CONFIG */
    0x00000782,  /*  CY_U3P_PIB_GPIF_SERIAL_OUT_CONFIG */
    0x00100000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_DIRECTION */
    0x0000FFFF,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_DEFAULT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_POLARITY */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_TOGGLE */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000008,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_BUS_SELECT */
    0x00000006,  /*  CY_U3P_PIB_GPIF_CTRL_COUNT_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_COUNT_RESET */
    0x0000FFFF,  /*  CY_U3P_PIB_GPIF_CTRL_COUNT_LIMIT */
    0x0000010A,  /*  CY_U3P_PIB_GPIF_ADDR_COUNT_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_ADDR_COUNT_RESET */
    0x0000FFFF,  /*  CY_U3P_PIB_GPIF_ADDR_COUNT_LIMIT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_STATE_COUNT_CONFIG */
    0x0000FFFF,  /*  CY_U3P_PIB_GPIF_STATE_COUNT_LIMIT */
    0x0000010A,  /*  CY_U3P_PIB_GPIF_DATA_COUNT_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_DATA_COUNT_RESET */
    0x0000FFFF,  /*  CY_U3P_PIB_GPIF_DATA_COUNT_LIMIT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_COMP_VALUE */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CTRL_COMP_MASK */
    0x00000000,  /*  CY_U3P_PIB_GPIF_DATA_COMP_VALUE */
    0x00000000,  /*  CY_U3P_PIB_GPIF_DATA_COMP_MASK */
    0x00000000,  /*  CY_U3P_PIB_GPIF_ADDR_COMP_VALUE */
    0x00000000,  /*  CY_U3P_PIB_GPIF_ADDR_COMP_MASK */
    0x00000000,  /*  CY_U3P_PIB_GPIF_DATA_CTRL */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_DATA */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_INGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_ADDRESS */
    0x00000000,  /*  CY_U3P_PIB_GPIF_EGRESS_ADDRESS */
    0x80010400,  /*  CY_U3P_PIB_GPIF_THREAD_CONFIG */
    0x80010401,  /*  CY_U3P_PIB_GPIF_THREAD_CONFIG */
    0x80010402,  /*  CY_U3P_PIB_GPIF_THREAD_CONFIG */
    0x80010403,  /*  CY_U3P_PIB_GPIF_THREAD_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_LAMBDA_STAT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_ALPHA_STAT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_BETA_STAT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_WAVEFORM_CTRL_STAT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_WAVEFORM_SWITCH */
    0x00000000,  /*  CY_U3P_PIB_GPIF_WAVEFORM_SWITCH_TIMEOUT */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CRC_CONFIG */
    0x00000000,  /*  CY_U3P_PIB_GPIF_CRC_DATA */
    0xFFFFFFC1  /*  CY_U3P_PIB_GPIF_BETA_DEASSERT */
};

/* Clock config for FPGA programming (The field isDllEnable is different from slave mode) */
static CyU3PPibClock_t zeabus_fpgaconf_pib_clock = {
    .clkDiv = 6,                // 416 / 6.5 = 64 MHz
    .clkSrc = CY_U3P_SYS_CLK,   // 416 MHz
    .isHalfDiv = CyTrue,
    .isDllEnable = CyTrue
};

static const CyU3PGpifConfig_t zeabus_fpgaconf_gpif_data  = {
    (uint16_t)(sizeof(zeabus_fpgaconf_gpif_wavedata_position)/sizeof(uint8_t)),
    zeabus_fpgaconf_gpif_wavedata,
    zeabus_fpgaconf_gpif_wavedata_position,
    (uint16_t)(sizeof(zeabus_fpgaconf_gpif_transition)/sizeof(uint16_t)),
    zeabus_fpgaconf_gpif_transition,
    (uint16_t)(sizeof(zeabus_fpgaconf_gpif_reg_value)/sizeof(uint32_t)),
    zeabus_fpgaconf_gpif_reg_value
};

static bool bIsInitialized = false;
static bool bIsSending = false;         // Indicate whether a block of FPGA configuration is sent out
static CyU3PDmaChannel xFpgaDmaHandle;

/************************************************************************************
 * Private Functions
 ************************************************************************************/

/**********************************************************************
 * Function :  zeabus_fpgaconf_gpifstop
 **********************************************************************/
static bool zeabus_fpgaconf_gpifstart( void )
{
    CyU3PDmaChannelConfig_t dmaConfig;

    if ( !bIsInitialized ) 
    {
        // Setup PIB clock for master mode
        CyU3PGpifDisable( CyTrue );
        (void)CyU3PPibDeInit();
        if( CyU3PPibInit( CyTrue, &zeabus_fpgaconf_pib_clock ) != CY_U3P_SUCCESS )
        {
            return false;
        }

        // create dma channel    
        CyU3PMemSet ((uint8_t *)&dmaConfig, 0, sizeof(dmaConfig));
        dmaConfig.size           = 4096;
        dmaConfig.count          = 0;
        dmaConfig.prodAvailCount = 0;
        dmaConfig.dmaMode        = CY_U3P_DMA_MODE_BYTE;
        dmaConfig.prodHeader     = 0;
        dmaConfig.prodFooter     = 0;
        dmaConfig.consHeader     = 0;
        dmaConfig.consSckId      = ZEABUS_FPGACONF_SOCKET_ID;
        dmaConfig.prodSckId      = CY_U3P_CPU_SOCKET_PROD;
        dmaConfig.notification   = 0;
        dmaConfig.cb             = NULL;

        if( CyU3PDmaChannelCreate( &xFpgaDmaHandle, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaConfig ) != CY_U3P_SUCCESS )
        {
            return false;
        }

        /* Reload the GPIF state machine */
        if( CyU3PGpifLoad( &zeabus_fpgaconf_gpif_data ) != CY_U3P_SUCCESS )
        {
            CyU3PDmaChannelDestroy( &xFpgaDmaHandle );
            return false;
        }
        if( CyU3PGpifSocketConfigure( 1, ZEABUS_FPGACONF_SOCKET_ID, 2, CyFalse, 1 ) != CY_U3P_SUCCESS )
        {
            CyU3PDmaChannelDestroy( &xFpgaDmaHandle );
            return false;
        }

        if( CyU3PGpifSMStart (0, 0) != CY_U3P_SUCCESS )
        {
            CyU3PDmaChannelDestroy( &xFpgaDmaHandle );
            return false;
        }

        bIsInitialized = true;
    }

    return true;
}    


/**********************************************************************
 * Function :  zeabus_fpgaconf_gpifstop
 **********************************************************************/
static void zeabus_fpgaconf_gpifstop( void ) 
{
    CyU3PGpifDisable( CyTrue );
    (void)CyU3PPibDeInit();
    if ( bIsInitialized )
    {
        CyU3PDmaChannelDestroy( &xFpgaDmaHandle );
    }
}

/**********************************************************************
 * Function :  zeabus_fpga_reset
 **********************************************************************/
static void zeabus_fpga_reset()
{
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RESET, false );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, false ); 

    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RDWR_B, false );
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_CSI_B, false );

    CyU3PThreadSleep( 20 );
    
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RESET, true );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, true ); 
}

/************************************************************************************
 * Public API Functions
 ************************************************************************************/

/**********************************************************************
 * Function :  zeabus_fpgaconf_start
 **********************************************************************/
bool zeabus_fpgaconf_start( void )
{
    int i;

    /* Slave FIFO cut-out */
    if( zeabus_slavefifo_is_started() )
    {
        zeabus_slavefifo_stop();
    }

    i = 0;
    do
    {
        /* Try 3 times */
        zeabus_fpga_reset();
        i++;
    }while( ( !zeabus_fpgaconf_gpifstart() ) && i < 3 );   // start gpif

    if( i == 3 )
        return false;   // Unable to start

    /* Wait for INIT_B to be 1 */
    i = 0;
    while ( (!zeabus_gpioread( ZEABUS_GPIO_FPGA_INIT_B )) && (i < 255) )
    {
        CyU3PThreadSleep (1);       // Wait 1 ms
        i++;
    }

    bIsSending = false;
    if( i >= 255 )
        return false;
    else
        return true;

}

/**********************************************************************
 * Function :  zeabus_fpgaconf_stop
 **********************************************************************/
void zeabus_fpgaconf_done( void )
{
    uint8_t dummy[16];

    if( bIsSending )
    {
        // Flush out the configuration by sending some extra clocks
        zeabus_fpgaconf_send( dummy, 16 );
    }

    zeabus_fpgaconf_gpifstop();
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RDWR_B, true );
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_CSI_B, true );

    bIsInitialized = false;
    bIsSending = false;
}

/**********************************************************************
 * Function :  is_fpga_configured
 **********************************************************************/
bool zeabus_fpgaconf_send (uint8_t* buf, uint32_t size) 
{
    CyU3PDmaBuffer_t buf_p;

    if( !bIsInitialized )
        return false;

    buf_p.size  = size;
    buf_p.count = size;
    buf_p.buffer = buf;
    buf_p.status = 0;

    if( CyU3PDmaChannelSetupSendBuffer( &xFpgaDmaHandle, &buf_p ) != CY_U3P_SUCCESS )
        return false;

    if( CyU3PDmaChannelWaitForCompletion (&xFpgaDmaHandle, 500) != CY_U3P_SUCCESS )
        return false;

    bIsSending = true;
    return true;
}  
