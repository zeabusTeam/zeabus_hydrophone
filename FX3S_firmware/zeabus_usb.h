/****************************************************************************
 * zeabus_usb.h
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
#ifndef __ZEABUS_USB_H
#define __ZEABUS_USB_H

#include "zeabus.h"

#define ZEABUS_USB_MAX_DATA_SIZE    16384   /* Maximum USB payload size */

bool zeabus_usb_initialize( void );
uint16_t zeabus_usb_ep0_wdata( void );
uint32_t zeabus_usb_ep0_dwdata( void );
uint8_t* zeabus_usb_ep0_buffer( void );
uint32_t zeabus_usb_debug_send( uint8_t* buf, uint32_t size );
uint32_t zeabus_usb_debug_receive( uint8_t* buf, uint32_t max_size, int32_t wait_time ); /* wait_time is in Tick count */
uint32_t zeabus_usb_data_send( uint8_t* buf, uint32_t size );
uint32_t zeabus_usb_data_receive( uint8_t* buf, uint32_t max_size, int32_t wait_time ); /* wait_time is in Tick count */

#endif // __ZEABUS_USB_H