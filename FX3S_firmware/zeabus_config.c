/****************************************************************************
 * zeabus_config.c
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

#include "zeabus_config.h"
#include "zeabus_eeprom.h"


#define ZEABUS_CONF_SIG1    'Z'
#define ZEABUS_CONF_SIG2    'B'
#define ZEABUS_CONF_ADDR    (0x80)      // EEPROM address that store configuration
#define ZEABUS_CONF_SIZE    (8)

/************************************************************************************
 * Private Data
 ************************************************************************************/

/* Configuration fields in EEPROM */
static struct ZeabusConfig_t
{
    bool        bValid;
    uint32_t    u32BitAddr;     // Starting address of FPGA bitstream image in SPI Flash memory
    uint32_t    u32BitLength;   // Length of the stored FPGA bitstream
}xZeabusConfig;

static uint8_t ebuf[ZEABUS_CONF_SIZE];        // Buffer  for configuration processing

/************************************************************************************
 * Public API Functions
 ************************************************************************************/
bool zeabus_conf_initialize( void )  // Initialize configuration from EEPROM
{
    xZeabusConfig.bValid = false;

    /* Read the configuration */
    if( zeabus_eeprom_read( ZEABUS_CONF_ADDR, ebuf, ZEABUS_CONF_SIZE ) != ZEABUS_CONF_SIZE )
        return false;

    /* Verify the signatures */
    if( ebuf[0] != ZEABUS_CONF_SIG1 || ebuf[1] != ZEABUS_CONF_SIG2 )
        return false;

    /* Parse data */
    xZeabusConfig.u32BitAddr = (uint32_t)ebuf[2] << 16;
    xZeabusConfig.u32BitAddr |= ((uint32_t)ebuf[3] << 8);
    xZeabusConfig.u32BitAddr |= ((uint32_t)ebuf[4]);

    xZeabusConfig.u32BitLength = (uint32_t)ebuf[5] << 16;
    xZeabusConfig.u32BitLength |= ((uint32_t)ebuf[6] << 8);
    xZeabusConfig.u32BitLength |= ((uint32_t)ebuf[7]);

    xZeabusConfig.bValid = true;

    return true;
}

bool zeabus_conf_get_bitstream_info( uint32_t* addr, uint32_t* len )   // Get the current settting of FPGA bitstream address and its length
{
    if( !(xZeabusConfig.bValid) )
        return false;

    *addr = xZeabusConfig.u32BitAddr;
    *len = xZeabusConfig.u32BitLength;
    return true;
}

bool zeabus_conf_set_bitstream_info( uint32_t addr, uint32_t len )  // Set the Flash-memory address and length of FPGA bitstream
{
    /* Invalidate all configuration */
    xZeabusConfig.bValid = false;
    if( zeabus_eeprom_write( ZEABUS_CONF_ADDR, (uint8_t*)(" "), 1 ) != 1 )
        return false;

    /* Write data to eeprom */
    ebuf[0] = (uint8_t)( (addr >> 16 ) & 0xF );
    ebuf[1] = (uint8_t)( (addr >> 8 ) & 0xF );
    ebuf[2] = (uint8_t)( addr & 0xF );

    ebuf[3] = (uint8_t)( (len >> 16 ) & 0xF );
    ebuf[4] = (uint8_t)( (len >> 8 ) & 0xF );
    ebuf[5] = (uint8_t)( len & 0xF );
    if( zeabus_eeprom_write( ZEABUS_CONF_ADDR + 2, ebuf, 6 ) != 6 )
        return false;

    /* Update the signature byte */
    ebuf[0] = ZEABUS_CONF_SIG1;    
    if( zeabus_eeprom_write( ZEABUS_CONF_ADDR, ebuf, 1 ) != 1 )
        return false;

    /* Finally, update internal value */
    xZeabusConfig.u32BitAddr = addr;
    xZeabusConfig.u32BitLength = len;
    xZeabusConfig.bValid = true;

    return true;
}
