/****************************************************************************
 * zeabus_usb_cmd.h
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

#ifndef __ZEABUS_USB_CMD_H
#define __ZEABUS_USB_CMD_H

// The ID registered to Zeabus. Another appropriate is 0x0525:0xA4A7 belonging to a defuct company (NetChip Tech.).
#define ZEABUS_VENDOR_ID                (0x1209)
#define ZEABUS_PRODUCT_ID               (0xDCB0)

/* USB Vendor request */
#define ZEABUS_USB_REQ_PROG_FPGA        (0xA0)          // Request for FPGA programming directly from USB
#define ZEABUS_USB_REQ_PROG_BITSTREAM   (0xA1)          // Request to save an FPGA bitstream to SPI flash
#define ZEABUS_USB_REQ_PROG_FIRMWARE    (0xA2)          // Request to save new firmware to SPI flash
#define ZEABUS_USB_REQ_SYSTEM_RESET     (0xA3)          // Request to restart the whole system
#define ZEABUS_USB_REQ_READ_FLASH       (0xA4)          // Request for raw data from SPI flash
#define ZEABUS_USB_REQ_WRITE_FLASH      (0xA5)          // Write raw data to SPI flash
#define ZEABUS_USB_REQ_READ_EEPROM      (0xA6)          // Request for raw data from EEPROM
#define ZEABUS_USB_REQ_WRITE_EEPROM     (0xA7)          // Write raw data to EEPROM
#define ZEABUS_USB_REQ_SET_SOFT_RESET   (0xA8)          // Set FPGA soft reset
#define ZEABUS_USB_REQ_RES_SOFT_RESET   (0xA9)          // Reset FPGA soft reset
#define ZEABUS_USB_REQ_SEND_FPGA_DATA   (0xAA)          // Send data to FPGA through slave FIFO
#define ZEABUS_USB_REQ_FUNC_EN          (0xAB)          // Enable functioonal module
#define ZEABUS_USB_REQ_FUNC_DIS         (0xAC)          // Disable functional module
#define ZEABUS_USB_RESTART_FIFO         (0xAD)          // Restart SlaveFIFO engine

#endif // __ZEABUS_USB_CMD_H
