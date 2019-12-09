/****************************************************************************
 * zeabus_eeprom.c
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
 * 3. Neither the name NuttX nor the names of its contributors may be
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
#include <cyu3i2c.h>

#include "zeabus_eeprom.h"

#define _ZEABUS_EEPROM_ADDR (0xA6)
#define _ZEABUS_EEPROM_PAGESIZE (16)

uint8_t zeabus_eeprom_write(uint8_t addr, uint8_t* buf, uint8_t size) 
{
    CyU3PI2cPreamble_t preamble;
    uint8_t size2, sum;

    sum = 0;    
    while ( size > 0 )
    {
        if( size > _ZEABUS_EEPROM_PAGESIZE )
            size2 = _ZEABUS_EEPROM_PAGESIZE;
        else
            size2 = size;

        preamble.length    = 2;
        preamble.buffer[0] = _ZEABUS_EEPROM_ADDR;
        preamble.buffer[1] = addr;
        preamble.ctrlMask  = 0;

        if( CyU3PI2cTransmitBytes (&preamble, buf, size2, 1) != CY_U3P_SUCCESS )
            break;  /* Write failed */
    
        /* Move to next page */
        sum += size2;
        addr += size2;
        buf += size2;
        size -= size2;

        /* Wait for EEPROM to finish writing process */
        preamble.length = 1;
        if( CyU3PI2cWaitForAck(&preamble, 600) != CY_U3P_SUCCESS )
            break;   /* EEPORM failed */

        CyU3PThreadSleep (1);
    }
    
    return sum;
}

uint8_t zeabus_eeprom_read(uint8_t addr, uint8_t* buf, uint8_t size) 
{
    CyU3PI2cPreamble_t preamble;

    preamble.length    = 3;
    preamble.buffer[0] = _ZEABUS_EEPROM_ADDR;
    preamble.buffer[1] = addr;
    preamble.buffer[2] = _ZEABUS_EEPROM_ADDR | 1;
    preamble.ctrlMask  = 0x0002;    /* Send START after byte 2 was sent. */
    
    if( CyU3PI2cReceiveBytes(&preamble, buf, (uint32_t)size, 1) == CY_U3P_SUCCESS )
        return size;
    else
        return 0;
}

bool zeabus_eeprom_initialize() 
{
    CyU3PI2cConfig_t i2cConfig;

    if( CyU3PI2cInit() != CY_U3P_SUCCESS )
        return false;

    return true;
    CyU3PMemSet ((uint8_t *)&i2cConfig, 0, sizeof(i2cConfig));
    i2cConfig.bitRate    = 100000;          /* 100Kbps */
    i2cConfig.busTimeout = 0xFFFFFFFF;
    i2cConfig.dmaTimeout = 0xFFFF;
    i2cConfig.isDma      = CyFalse;         /* No DMA */
    if( CyU3PI2cSetConfig (&i2cConfig, NULL) != CY_U3P_SUCCESS )
        return false;

    return true;
}
