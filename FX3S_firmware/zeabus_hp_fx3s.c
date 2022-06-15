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
#include "zeabus_slavefifo.h"

#define ZEABUS_CONF_FIRMWARE_SPI_PAGE   (0)
#define ZEABUS_CONF_BITSTREAM_SPI_PAGE  (0x008000UL)

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

/* LED blinkting period using for some status showing */
static uint32_t u32LEDOnTime = 1000;
static uint32_t u32LEDOffTime = 1000;
/************************************************************************************
 * Private Functions
 ************************************************************************************/

/************************************************************************************
 * Function : zeabus_spi2fpga
 * This function load an FPGA bitstream from USB data channel flash to the FPGA.
 ************************************************************************************/
static bool zeabus_usb2fpga( uint32_t len )
{
    uint8_t buf[4096];
    uint32_t granule, s;

    if( !zeabus_fpgaconf_start() )
        return false;

    // Looping to get the betstream
    while( len > 0 )
    {
        if( len > 4096 )
            granule = 4096;
        else
            granule = len;

        s = zeabus_usb_data_receive( buf, granule, 500 );
        if( s > 0 )
        {
            // Write data
            if( !zeabus_fpgaconf_send( buf, s ) )
            {
                _log("Failed to write to FPGA\r\n");
                break;
            }
            len -= s;
        }
    }

    zeabus_fpgaconf_done();

    if( len == 0 )
        return true;
    else
        return false;
}

/************************************************************************************
 * Function : zeabus_spi2fpga
 * This function load the previously saved FPGA bitstream from SPI flash to the FPGA.
 ************************************************************************************/
static bool zeabus_spi2fpga( uint32_t addr, uint32_t len )
{
    uint8_t buf[4096];
    uint32_t granule;

    if( !zeabus_fpgaconf_start() )
        return false;

    while( len > 0 )
    {
        if( len > 4096 )
            granule = 4096;
        else
            granule = len;

        /* Transfer as a unit of 4096 byte max. */
        granule = zeabus_spi_flash_read( addr, buf, granule );
        if( granule > 0 )
        {
            if( !zeabus_fpgaconf_send( buf, granule ) )
            {
                _log("Failed to write to FPGA\r\n");
                break;
            }

            addr += granule;
            len -= granule;
        }
    }

    zeabus_fpgaconf_done();

    if( len == 0 )
        return true;
    else
        return false;
}

/************************************************************************************
 * Function : zeabus_flash2usb
 * This function read the SPI flash at the specified address and send them to usb.
 * The flash-memory capacity is 16MBytes (24-bit address) grouped into 65536 pages
 * further grouped into 256 sectors. Hence the byte address format is 0x00SSPPBB.
 ************************************************************************************/
static uint32_t zeabus_flash2usb( uint32_t addr, uint32_t len )
{
    uint8_t buf[4096];
    uint32_t granule, s;
    uint32_t count = 0;

    while( len > 0 )
    {
        if( len > 4096 )
            granule = 4096;
        else
            granule = len;
        s = zeabus_spi_flash_read( addr, buf, granule );
        if( s > 0 )
        {
            s = zeabus_usb_data_send( buf, s );
        }
        else
        {
            _log( "Read from flash failed at %06X\r\n", addr );
            break;
        }

        len -= s;
        count += s;
        addr += s;
    }

    return count;
}

/************************************************************************************
 * Function : zeabus_usb2flash
 * This function save the incoming bulk stream to a specified address in SPI flash.
 * The flash-memory capacity is 16MBytes (24-bit address) grouped into 65536 pages
 * further grouped into 256 sectors. Hence the byte address format is 0x00SSPPBB.
 ************************************************************************************/
static uint32_t zeabus_usb2flash( uint16_t page_addr, uint32_t len )
{
    uint8_t buf[4096], l, first;
    uint16_t page_count;
    uint32_t granule, s;
    uint32_t count = 0;

    // Erasing the required sectors
    /* Calculate the last sector to be erased */
    s = ((uint32_t)page_addr << 8) + len;
    if( s > 0xFFFFFFUL )
        return 0;   // The requested size is larger than the available space
    l = (uint8_t)( (s >> 16) & 0xFF );
    if( ( s & 0xFFFF ) != 0)    // Rounding up the sector fragment
        l++;
    first = (uint8_t)( (page_addr >> 8) & 0xFF );

    // Last - first + 1 = total sector
    l = l - first + 1;
    if( zeabus_spi_flash_erase_sector( first, l ) != l )
        return 0;   // Failed to format sectors

    // Looping to get the betstream
    while( len > 0 )
    {
        if( len > 4096 )
            granule = 4096;
        else
            granule = len;

        // Wait for incoming data
        s = zeabus_usb_data_receive( buf, granule, 500 );
        if( s > 0 )
        {
            // Write data
            page_count = (uint16_t)(s >> 8);
            if( (s & 0xFF) != 0 )
                page_count++;
            if( zeabus_spi_flash_page_write( page_addr, buf, page_count) != page_count )
            {
                _log("Save failed\r\n");
                break;  // Failed!!!
            }

            count += s;
            len -= s;
            page_addr += page_count;

            // The fragment of a page can only be the final block
            if( (s & 0xFF) != 0 )
                break;
        }
    }

    return count;
}

/************************************************************************************
 * Function : zeabus_eeprom2usb
 * This function read I2C EEPROM from the specified data and send to USB.
 ************************************************************************************/
static uint32_t zeabus_eeprom2usb( uint8_t addr, uint8_t len )
{
    uint8_t u;
    uint8_t buf[256];

    u = zeabus_eeprom_read( addr, buf, len );
    if( u > 0 )
        u = (uint8_t)zeabus_usb_data_send( buf, (uint32_t)u );

    return u;
}

/************************************************************************************
 * Function : zeabus_usb2eeprom
 * This function save the incoming bulk stream to a specified address in I2C EEPROM.
 ************************************************************************************/
static uint32_t zeabus_usb2eeprom( uint8_t addr, uint8_t len )
{
    uint8_t u;
    uint8_t buf[256];

    u = (uint8_t)zeabus_usb_data_receive( buf, (uint32_t)len, 500 );
    if( u > 0 )
         u = zeabus_eeprom_write( addr, buf, u );

    _log( "Wrote %u bytes\r\n", u );
    return u;
}

void zeabus_ledblinking( uint32_t input )
{
    while(1)
    {
        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, true);
        CyU3PThreadSleep( u32LEDOnTime );

        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, false);
        CyU3PThreadSleep( u32LEDOffTime );
    }
}

/************************************************************************************
 * Public Functions
 ************************************************************************************/
/* Clock config for FPGA programming (The field isDllEnable is different from FPGA configuration mode) */
// static CyU3PPibClock_t zeabus_general_pib_clock = {
//     .clkDiv = 6,                // 416 / 6.5 = 64 MHz
//     .clkSrc = CY_U3P_SYS_CLK,   // 416 MHz
//     .isHalfDiv = CyTrue,
//     .isDllEnable = CyFalse
// };

#define __MAIN_EVENTS   (ZEABUS_EVENT_REQ_USB_PROG_FPGA | ZEABUS_EVENT_REQ_SAVE_FPGA | ZEABUS_EVENT_REQ_SAVE_FIRMWARE \
                        | ZEABUS_EVENT_REQ_READ_FLASH | ZEABUS_EVENT_REQ_WRITE_FLASH | ZEABUS_EVENT_REQ_READ_EEPROM \
                        | ZEABUS_EVENT_REQ_WRITE_EEPROM | ZEABUS_EVENT_REQ_SEND_FPGA_DATA \
                        | ZEABUS_EVENT_REQ_SET_SOFT_RES | ZEABUS_EVENT_REQ_RES_SOFT_RES \
                        | ZEABUS_EVENT_REQ_FUNC_EN | ZEABUS_EVENT_REQ_FUNC_DIS )
void zeabus_main( uint32_t input )
{
    void *ptr;
    CyU3PThread     led_thread;
    uint32_t eventFlag;
    uint32_t addr, len;
    uint8_t b_addr, b_len;
    uint8_t* ep0_data;

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

     zeabus_configgpio_output( ZEABUS_GPIO_FPGA_FIR_EN, false );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_SRES, true );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_RESET, true );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_CSI_B, true );
    zeabus_configgpio_output( ZEABUS_GPIO_FPGA_RDWR_B, true );
    zeabus_configgpio_input( ZEABUS_GPIO_FPGA_DONE );
    zeabus_configgpio_input( ZEABUS_GPIO_FPGA_INIT_B );
    CyU3PGpioSetIoMode( ZEABUS_GPIO_FPGA_INIT_B, CY_U3P_GPIO_IO_MODE_WPU ); // Enable pull-up

    /* After GPIO setup, setting CPLD state machine to enable flash memory */
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, false );
    zeabus_gpiowrite( ZEABUS_GPIO_MODE1, true );

    if( !zeabus_usb_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    if( !zeabus_spi_flash_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );
    if( !zeabus_eeprom_initialize() )
        zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    CyU3PThreadSleep(2000);     // Wait 2 Seconds for all essential devices to be ready

    /* Initialize FPGA */
    if( zeabus_conf_initialize() )
    {
        // Found a valid FPGA image
        if(zeabus_conf_get_bitstream_info( &addr, &len ))
        {
            zeabus_spi2fpga( addr, len );
            // Automatically start slaveFIFO
            if( !zeabus_slavefifo_start() )
            {
                _log( "Failed to start slave FIFO\r\n" );
            }
        }
    }

    /* Initialize PIB clock. Should be performed after FPGA config */
    //if( CyU3PPibInit( CyTrue, &zeabus_general_pib_clock ) != CY_U3P_SUCCESS )
    //    zeabus_app_err_handler( CY_U3P_ERROR_FAILURE );

    // Start LED blinking to indicate system ready state
    ptr = CyU3PMemAlloc(256);
    /* Create the thread for the application */
    if( CyU3PThreadCreate( &led_thread,             /* App thread structure */
                        "22:Led",               /* Thread ID and thread name */
                        zeabus_ledblinking,     /* App thread entry function */
                        0,                      /* No input parameter to thread */
                        ptr,                    /* Pointer to the allocated thread stack */
                        256,                    /* App thread stack size */
                        8,                      /* App thread priority */
                        8,                      /* App thread priority */
                        CYU3P_NO_TIME_SLICE,    /* No time slice for the application thread */
                        CYU3P_AUTO_START        /* Start the thread immediately */
                        ) != CY_U3P_SUCCESS )
    {
        _log("Unable to start LED thread\r\n");
    }

    _log( "Starting main loop\r\n" );

    while(1)    // Main loop of the system
    {
        if ( CyU3PEventGet(&xZeabusEvent, __MAIN_EVENTS, CYU3P_EVENT_OR_CLEAR, &eventFlag, CYU3P_WAIT_FOREVER)  == CY_U3P_SUCCESS)
        {
            _log("Got a command\r\n");

            if( ( eventFlag & ZEABUS_EVENT_REQ_USB_PROG_FPGA ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                zeabus_slavefifo_stop();
                _log( "Start program FPGA for %d bytes\r\n", len );
                if( !zeabus_usb2fpga( len ) )
                {
                    _log( "Init Failed!!!\r\n" );
                }
                // Automatically start slave FIFO
                if( !zeabus_slavefifo_start() )
                {
                    _log( "Failed to start slave FIFO\r\n" );
                }
            }

            if( ( eventFlag & ZEABUS_EVENT_REQ_SEND_FPGA_DATA ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                ep0_data = zeabus_usb_ep0_buffer();
                _log( "Sending data with length %u to FPGA through slave FIFO\r\n", len );
                if( !( zeabus_slavefifo_send( ep0_data, len ) ) )
                    _log( "Failed to send data to FPGA.\r\n");
            }

            if( ( eventFlag & ZEABUS_EVENT_REQ_SET_SOFT_RES ) != 0 )
            {
                _log( "Set soft-reset signal\r\n" );
                zeabus_gpiowrite( ZEABUS_GPIO_FPGA_SRES, true );    // Arm soft reset
            }

            if( ( eventFlag & ZEABUS_EVENT_REQ_RES_SOFT_RES ) != 0 )
            {
                _log( "Reset soft-reset signal\r\n" );
                zeabus_gpiowrite( ZEABUS_GPIO_FPGA_SRES, false );    // Release soft reset
            }

            if( ( eventFlag & ZEABUS_EVENT_REQ_SAVE_FPGA ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                _log( "Start saving FPGA to SPI for %d bytes\r\n", len );
                if( zeabus_conf_invalidate() )  // Invalidate old stream
                {
                    if( zeabus_usb2flash( ZEABUS_CONF_BITSTREAM_SPI_PAGE, len ) != len )
                    {
                        _log( "Failed to save FPGA bitstream!!\r\n ");
                    }
                    else
                    {
                        if( !zeabus_conf_set_bitstream_info( ((uint32_t)ZEABUS_CONF_BITSTREAM_SPI_PAGE) << 8, len ) )
                        {
                            _log( "Failed to register new FPGA bitstream to the system\r\n" );
                        }
                    }
                }
            }

            if( ( eventFlag & ZEABUS_EVENT_REQ_SAVE_FIRMWARE ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                _log("Start saving firmware to SPI for %d bytes\r\n", len);
                if( zeabus_usb2flash( ZEABUS_CONF_FIRMWARE_SPI_PAGE, len ) != len )
                {
                    _log( "Failed to save firmware!!\r\n ");
                }
            }

            // Request for raw data from SPI flash
            if( ( eventFlag & ZEABUS_EVENT_REQ_READ_FLASH ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                ep0_data = zeabus_usb_ep0_buffer();
                addr = (uint32_t)(ep0_data[2]);
                addr <<= 8;
                addr += (uint32_t)(ep0_data[1]);
                addr <<= 8;
                addr += (uint32_t)(ep0_data[0]);
                _log("Reading SPI flash at %06X for %d bytes\r\n", addr, len);
                if( zeabus_flash2usb( addr, len ) != len )
                {
                    _log( "Failed to read SPI flash\r\n" );
                }
            }

            // Write raw data to SPI flash    
            if( ( eventFlag & ZEABUS_EVENT_REQ_WRITE_FLASH ) != 0 )
            {
                len = zeabus_usb_ep0_dwdata();
                ep0_data = zeabus_usb_ep0_buffer();
                addr = (uint32_t)(ep0_data[2]);
                addr <<= 8;
                addr += (uint32_t)(ep0_data[1]);
                addr <<= 8;
                addr += (uint32_t)(ep0_data[0]);
                _log("Writing SPI flash at %06X for %d bytes\r\n", addr, len);
                addr >>= 8; // Start writing only at the beginning of apage
                if( zeabus_usb2flash( (uint16_t)addr, len ) != len )
                {
                    _log( "Failed to write SPI flash\r\n ");
                }
            }

            // Request for raw data from EEPROM
            if( ( eventFlag & ZEABUS_EVENT_REQ_READ_EEPROM ) != 0 )
            {
                b_len = (uint8_t)(( zeabus_usb_ep0_wdata() >> 8 ) & 0xFF);
                b_addr = (uint8_t)( zeabus_usb_ep0_wdata() & 0xFF);
                _log("Reading EEPROM at %02X for %d bytes\r\n", b_addr, b_len);
                if( zeabus_eeprom2usb( b_addr, b_len ) != b_len )
                {
                    _log( "Failed to read EEPROM!!\r\n ");
                }
            }

            // Write raw data to EEPROM        
            if( ( eventFlag & ZEABUS_EVENT_REQ_WRITE_EEPROM ) != 0 )
            {
                b_len = (uint8_t)(( zeabus_usb_ep0_wdata() >> 8 ) & 0xFF);
                b_addr = (uint8_t)( zeabus_usb_ep0_wdata() & 0xFF);
                _log("Writing EEPROM at %02X for %d bytes\r\n", b_addr, b_len);
                if( zeabus_usb2eeprom( b_addr, b_len ) != b_len )
                {
                    _log( "Failed to write EEPROM!!\r\n");
                }
            }

            // Enable FIR filter
            if( ( eventFlag & ZEABUS_EVENT_REQ_FUNC_EN ) != 0 )
            {
                _log( "Enable functional module\r\n" );
                zeabus_gpiowrite( ZEABUS_GPIO_FPGA_FIR_EN, true );
            }

            // Disable FIR filter
            if( ( eventFlag & ZEABUS_EVENT_REQ_FUNC_DIS ) != 0 )
            {
                _log( "Disable functional module\r\n" );
                zeabus_gpiowrite( ZEABUS_GPIO_FPGA_FIR_EN, false );
            }

            // Restart Slave FIFO engine
            if( ( eventFlag & ZEABUS_EVENT_REQ_RESTART_FIFO ) != 0 )
            {
                _log( "Restart Slave FIFO Engine\r\n" );
                if( zeabus_slavefifo_is_started() )
                {
                    zeabus_slavefifo_stop();
                    zeabus_slavefifo_start();
                }

            }
        }
    }
}
