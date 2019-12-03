/****************************************************************************
 * zeabus_eeprom.h
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

#ifndef __ZEABUS_EEPROM_H
#define __ZEABUS_EEPROM_H

#include <cyu3typs.h>

/*
 * The ZTEX FPGA board used for Zeabus hydrophone has an I2C EEPROM with
 * the capacity of 2Kbit (256 bytes). The device is organized as 2 blocks
 * of 128 x 8-bit. The address of the device is set to 0xA6 in 7-bit format 
 * (the LSB is to indicate R/~W action). There is a 16-byte page buffer to
 * support writing in multiple bytes within 1 I2C command.
 */

bool zeabus_eeprom_init() ;
uint8_t zeabus_eeprom_read(uint8_t addr, uint8_t *buf, uint8_t size);
uint8_t zeabus_eeprom_write(uint8_t addr, uint8_t *buf, uint8_t size); 

#endif /* __ZEABUS_EEPROM_H */
