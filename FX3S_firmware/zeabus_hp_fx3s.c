/****************************************************************************
 * zeabus_hp_fx3s.c
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
#include <cyu3gpio.h>
#include <cyu3pib.h>

#include "zeabus.h"
#include "zeabus_error.h"
#include "zeabus_usb.h"
#include "zeabus_gpio.h"
//#include "zeabus_gpif.h"
#include "zeabus_flash.h"
#include "zeabus_eeprom.h"
#include "zeabus_config.h"
#include "zeabus_fpgaconf.h"

// Global variables
CyU3PEvent   xZeabusEvent;              /* Global system event group */

/************************************************************************************
 * Private Data
 ************************************************************************************/

/* CPLD states
 * -- M0 M1  SPI: master --> salve  PROG_B      disable_flash  enable_flash
 * --  *  1          FX3 --> FLASH     1            hold          hold
 * --  0  0          FX3 --> FPGA   FPGA_RESET_N     0             1
 * --  1  0          FPGA -> FLASH  FPGA_RESET_N     1             0
 */

/* Clock config for general processing except Synchronous Slave mode. */
static CyU3PPibClock_t zeabus_general_pib_clock = {
    .clkDiv = 6,                // 416 / 6.5 = 64 MHz
    .clkSrc = CY_U3P_SYS_CLK,   // 416 MHz
    .isHalfDiv = CyTrue,
    .isDllEnable = CyFalse
};

static uint8_t conv[] = "0123456789ABCDEF";

/************************************************************************************
 * Private Functions
 ************************************************************************************/

void b2str(uint8_t d, uint8_t* buf)
{
    buf[0] = conv[d>>4];
    buf[1] = conv[d&0xF];
}

/************************************************************************************
 * Public Functions
 ************************************************************************************/
void zeabus_main( uint32_t input )
{
    int i;
    uint8_t addr;
    uint8_t data[16], buf[4];

    /* Initialize event to notify USB incoming */
    if( CyU3PEventCreate( &xZeabusEvent ) != CY_U3P_SUCCESS )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    if( !zeabus_gpio_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );


    /* Configure GPIO pins */
    zeabus_configgpio_output( ZEABUS_GPIO_OTG_EN, false );
    zeabus_configgpio_output( ZEABUS_GPIO_LED, false );
    zeabus_configgpio_output( ZEABUS_GPIO_MODE1, true );
    zeabus_configgpio_output( ZEABUS_GPIO_MODE0, false );
    
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_RESET, true );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_CSI_B, true );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_RDWR_B, true );
    zeabus_configgpio_input( ZEABUS_GPIO_FPGA_DONE );
    zeabus_configgpio_input( ZEABUS_GPIO_FPGA_INIT_B );     
    CyU3PGpioSetIoMode( ZEABUS_GPIO_FPGA_INIT_B, CY_U3P_GPIO_IO_MODE_WPU ); // Enable pull-up

    /* After GPIO setup, setting CPLD state machine to enable flash memory */
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, false );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, true );

    if( !zeabus_spi_flash_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );
    if( !zeabus_eeprom_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    /* Initialize FPGA */

    /* Initialize PIB clock */
    if( CyU3PPibInit( CyTrue, &zeabus_general_pib_clock ) != CY_U3P_SUCCESS )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    if( !zeabus_usb_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    buf[2] = ' ';
    buf[3] = 0;
    addr = 0;
    CyU3PThreadSleep( 1000 );
    zeabus_usb_send( (uint8_t*)("\r\n"), 2 );
    zeabus_usb_send( (uint8_t*)("Start\r\n"), 7 );

    while(1)    // Main loop of the system
    {
        if( zeabus_spi_flash_read( (uint32_t)addr, data, 16 ) == 16 )
        {
            b2str(addr, buf);
            zeabus_usb_send( buf, 3 );
            zeabus_usb_send( (uint8_t*)": ", 2 );
            for(i = 0; i < 16; i++ )
            {
                b2str(data[i], buf);
                zeabus_usb_send( buf, 3 );
            }
            addr += 16;
        }
        else
        {
            zeabus_usb_send( (uint8_t*)("Failed"), 6 );
        }
        zeabus_usb_send( (uint8_t*)("\r\n"), 2 );
        /* Get event from the system then process it */
        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, true);
        CyU3PThreadSleep( 1000 );

        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, false);
        CyU3PThreadSleep( 1000 );

    }
}
