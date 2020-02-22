/****************************************************************************
 * zeabus_app_init.c
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
#include <cyu3system.h>
#include <cyu3os.h>

#include "zeabus.h"
#include "zeabus_error.h"

#define ZEABUS_MAIN_THREAD_STACK_SIZE   (16384)
#define ZEABUS_MAIN_THREAD_PRIORITY     (8)

extern void zeabus_main( uint32_t );

static CyU3PThread     xZeabusAppThread;             /* Application thread structure */

/* Application define function which creates the threads. */
void CyFxApplicationDefine ( void )
{
    void *ptr;
    uint32_t ret;

    /* Allocate the memory for the threads */
    ptr = CyU3PMemAlloc(ZEABUS_MAIN_THREAD_STACK_SIZE);

    /* Create the thread for the application */
    ret = CyU3PThreadCreate(&xZeabusAppThread,                  /* App thread structure */
                          "21:Zeabus_Hydrophone",               /* Thread ID and thread name */
                          zeabus_main,                          /* App thread entry function */
                          0,                                    /* No input parameter to thread */
                          ptr,                                  /* Pointer to the allocated thread stack */
                          ZEABUS_MAIN_THREAD_STACK_SIZE,        /* App thread stack size */
                          ZEABUS_MAIN_THREAD_PRIORITY,          /* App thread priority */
                          ZEABUS_MAIN_THREAD_PRIORITY,          /* App thread priority */
                          CYU3P_NO_TIME_SLICE,                  /* No time slice for the application thread */
                          CYU3P_AUTO_START                      /* Start the thread immediately */
                          );

    /* Check the return code */
    if( ret != CY_U3P_SUCCESS )
    {
        while(1);   // We cannot do any thing from now
        //zeabus_app_err_handler( ret );
    }
}

/* This is the real "main" of the program. It initializes system functions
 * such as clock speed and IO matrix. It also spawns the OS thread and invoke the 
 * main thread entry
 */
int main (void)
{
    CyU3PSysClockConfig_t clockConfig;
    CyU3PIoMatrixConfig_t io_cfg;

    /* Initialize the device */
    clockConfig.setSysClk400  = CyTrue;             // Initially, SYSCLK is 416 MHz for Zeabus module
    clockConfig.cpuClkDiv     = 2;                  // CPU_CLK = 416 / 2 = 208 MHz
    clockConfig.dmaClkDiv     = 2;                  // DMA_CLK = 208 / 2 = 104 MHz
    clockConfig.mmioClkDiv    = 2;                  // MMIO_CLK = 208 / 2 = 104 MHz
    clockConfig.useStandbyClk = CyFalse;            // No 32 kHz clock
    clockConfig.clkSrc         = CY_U3P_SYS_CLK;    // Use SYS_CLK directly (without pre-scaler)
    if( CyU3PDeviceInit( &clockConfig ) != CY_U3P_SUCCESS )
    {
        goto handle_fatal_error;
    }

    /* Initialize the caches. The D-Cache is kept disabled. Enabling this will cause performance to drop,
       as the driver will start doing a lot of un-necessary cache clean/flush operations. This effect
       is because FX3 implements complex DMA scheme, which could not coherence with cache scheme in ARM9.
       Enable the D-Cache only if there is a need to process the data being transferred by firmware code.
     */
    if( CyU3PDeviceCacheControl( CyTrue, CyFalse, CyFalse ) != CY_U3P_SUCCESS )
    {
        goto handle_fatal_error;
    }

    /* Configure the IO matrix for the device. On the FX3 DVK board, the COM port 
     * is connected to the IO(53:56). This means that either DQ32 mode should be
     * selected or lppMode should be set to UART_ONLY. Here we are choosing
     * UART_ONLY configuration. */
    io_cfg.isDQ32Bit = CyFalse;     // FX3S has only 16-bit mode
    io_cfg.s0Mode    = CY_U3P_SPORT_4BIT;   // SD card with 4-bit data bus
    io_cfg.s1Mode    = CY_U3P_SPORT_INACTIVE;
    io_cfg.useUart   = CyFalse;     // No UART
    io_cfg.useI2C    = CyTrue;      // I2C EEPROM
    io_cfg.useI2S    = CyFalse;     // No I2S
    io_cfg.useSpi    = CyTrue;      // SPI Flash
    io_cfg.lppMode   = CY_U3P_IO_MATRIX_LPP_DEFAULT;   // LPP only has SPI active

    /* Enable the GPIO which would have been setup by 2-stage booter. */
    io_cfg.gpioSimpleEn[0]  = (1 << ZEABUS_GPIO_FPGA_SRES);   // GPIO 0 - 31 are used by GPIF II except SRES (GPIO23)
    io_cfg.gpioSimpleEn[1]  = ZEABUS_GPIO_SIMPLE_BITMAP; // Define in zeabus.h
    io_cfg.gpioComplexEn[0] = 0;    // GPIO 0 - 31 are used by GPIF II
    io_cfg.gpioComplexEn[1] = 0;    // No complex GPIO.
    if ( CyU3PDeviceConfigureIOMatrix( &io_cfg ) != CY_U3P_SUCCESS )
    {
        goto handle_fatal_error;
    }

    /* This is a non returnable call for initializing the RTOS kernel */
    CyU3PKernelEntry ();

    /* Dummy return to make the compiler happy */
    return 0;

handle_fatal_error:

    /* Cannot recover from this error. */
    while (1);
}

