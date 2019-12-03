/****************************************************************************
 * zeabus_flash.h
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

#ifndef __ZEABUS_FLASH_H
#define __ZEABUS_FLASH_H

#include <cyu3typs.h>


/*
 * SPI Flash memory on ZTEX board is S25FL127S having 128 Mb or 16 MB capacity.
 * This Flash memory on ZTEX board has been configured as:
 *  - 256 byte programming buffer
 *  - 64 KB sector size
 *  - 1024 byte OTP area
 *  - Erase rate = 500 KB/s
 *  - Programming rate = 650 KB/s
 *  - Maximum SCLK frequency = 108 MHz
 *
 * Specifying page and sectors sizes as above plus the total capacity of flash
 * is 16 MB allows the address value to be partitioned into 3 fields as:
 *
 *    ssssssss pppppppp oooooooo
 *
 * The total allowable address bit is 24. The first MSB byte would be
 * the sector number (denoted as "s"). The next byte is page number within
 * the sepcified sector (denoted as "p"). The last byte is the data offset
 * within the page (denoted as "o").
 *
 * According to flash-memory technology, reading canbe performed at any 
 * position with the reading amount in bytes. However, writing should be
 * issues in whole pages. Moreover, erasing must be in the unit of sectors.
 * Dividing the address information as above eases these operations.
 * 
 */

#define FLASH_PAGE_SIZE     256
#define FLASH_SECTOR_SIZE   65536UL

/* API */
bool zeabus_spi_flash_initialize( void );
uint32_t zeabus_spi_flash_read( uint32_t addr, uint8_t* buf, uint32_t size );
uint16_t zeabus_spi_flash_page_write( uint16_t page, uint8_t* buf, uint16_t total );
uint8_t zeabus_spi_flash_erase_sector( uint8_t sector, uint8_t total );

#endif /* __ZEABUS_FLASH_H */