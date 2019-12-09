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

#include "zeabus.h"
#include "zeabus_error.h"
#include "zeabus_usb.h"
#include "zeabus_gpio.h"
//#include "zeabus_gpif.h"
#include "zeabus_flash.h"
#include "zeabus_eeprom.h"

// Global variables
CyU3PEvent   xZeabusEvent;              /* Global system event group */

/* CPLD states
 * -- M0 M1  SPI: master --> salve  PROG_B      disable_flash  enable_flash
 * --  *  1          FX3 --> FLASH     1            hold          hold
 * --  0  0          FX3 --> FPGA   FPGA_RESET_N     0             1
 * --  1  0          FPGA -> FLASH  FPGA_RESET_N     1             0
 */

/* *********************************************************************
   ***** ztex_fpga_configured ******************************************
   ********************************************************************* */
bool is_fpga_configured() 
{
    return( zeabus_gpioread( ZEABUS_GPIO_FPGA_DONE ) );
}

/* *********************************************************************
   ***** ztex_fpga_reset ***********************************************
   ********************************************************************* */
void zeabus_fpga_reset()
{
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RESET, false );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, false ); 

    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RDWR_B, false );
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_CSI_B, false );

    CyU3PThreadSleep( 20 );
    
    zeabus_gpiowrite( ZEABUS_GPIO_FPGA_RESET, true );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, true ); 
}

/* *********************************************************************
   ***** ztex_fpga_config_start ****************************************
   ********************************************************************* */
// socket should be 0 for configuration from CPU
/*void ztex_fpga_config_start(CyU3PDmaSocketId_t socket) 
{
    uint8_t mode = socket > 0 ? 1 : 2;
    if ( ztex_fpga_config_started == mode ) return;  // already started in correct mode

    ztex_fpga_reset();

    ztex_fpga_config_started=mode;
    
    ztex_fpgaconf1_start(socket);   // start gpif
    
    if ( socket > 0) {          // start auto transfers 
    CyU3PDmaChannel* dma_p = CyU3PDmaChannelGetHandle(socket);
    if ( dma_p != NULL ) CyU3PDmaChannelSetXfer (dma_p, 0);   // errors may occur if restarted
    }

    uint8_t i = 0;
    while ( (!ztex_gpio_get(ZTEX_GPIO_FPGA_INIT_B)) && i<255 ) {
    CyU3PThreadSleep (1);
    i++;
    }

    ztex_fpga_init_b = ztex_gpio_get(ZTEX_GPIO_FPGA_INIT_B) ? 200 : 100;
    ztex_fpga_cs = 0;
    ztex_fpga_bytes = 0;
}*/

/* *********************************************************************
   ***** ztex_fpga_config_done *****************************************
   ********************************************************************* */
/*void ztex_fpga_config_done(CyBool_t fromFlash) { 
    ztex_fpga_init_b += ztex_gpio_get(ZTEX_GPIO_FPGA_INIT_B) ? 22 : 11;
    
    if ( ztex_fpga_config_started == 2)  ztex_fpgaconf1_send(ztex_ep0buf,16); // some extra clock's

    ztex_fpgaconf1_stop();  // stop gpif

    ztex_fpga_config_started = 0;

    if ( fromFlash ) ZTEX_REC( CyU3PPibDeInit() );

    if ( ZTEX_FPGA_CONFIGURED ) {
    ztex_gpio_set_input(ZTEX_GPIO_FPGA_RDWR_B);
    ztex_gpio_set_input(ZTEX_GPIO_FPGA_CSI_B);
    
    ZTEX_LOG("Info: Preparing USB for application");
    if ( ! fromFlash ) ztex_usb_stop_main();    // restart USB and reset PIB clock
    ztex_pib_clock2 = &ztex_pib_clock;
    if ( ! fromFlash ) ztex_usb_start_main();
    }
}
*/

void zeabus_main( uint32_t input )
{

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

    if( !zeabus_spi_flash_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );
    if( !zeabus_eeprom_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    /* Initialize FPGA */

    if( !zeabus_usb_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    while(1)    // Main loop of the system
    {
        /* Get event from the system then process it */
        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, true);
        CyU3PThreadSleep( 1000 );

        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, false);
        CyU3PThreadSleep( 1000 );

    }
}
