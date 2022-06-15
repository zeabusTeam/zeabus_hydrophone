/****************************************************************************
 * zeabus.h
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

#ifndef __ZEABUS_H
#define __ZEABUS_H

#include <stdbool.h>
#include <cyu3types.h>
#include <cyu3error.h>

/* FX3S GPIOs on Zebus Hydrophone */
#define ZEABUS_GPIO_LED           52

// CPLD mode (aka. system mode)
#define ZEABUS_GPIO_MODE0         50
#define ZEABUS_GPIO_MODE1         45

// FPGA control signals
#define ZEABUS_GPIO_FPGA_RESET    51
#define ZEABUS_GPIO_FPGA_INIT_B   37
#define ZEABUS_GPIO_FPGA_RDWR_B   38
#define ZEABUS_GPIO_FPGA_CSI_B    39
#define ZEABUS_GPIO_FPGA_DONE     40
#define ZEABUS_GPIO_FPGA_SRES     23
#define ZEABUS_GPIO_FPGA_FIR_EN   26

#define ZEABUS_GPIO_OTG_EN        57

// Bitmap use to confifure GPIO module at system start */
#define ZEABUS_GPIO_SIMPLE_BITMAP_LO  ( \
      (1 << ZEABUS_GPIO_FPGA_SRES) |  (1 << ZEABUS_GPIO_FPGA_FIR_EN) )
#define ZEABUS_GPIO_SIMPLE_BITMAP_HI ( \
      ( 1 << ( ZEABUS_GPIO_MODE0 - 32 ) ) | ( 1 << ( ZEABUS_GPIO_MODE1 - 32 ) ) \
    | ( 1 << ( ZEABUS_GPIO_LED - 32 ) ) | ( 1 << ( ZEABUS_GPIO_FPGA_RESET -32 ) ) \
    | ( 1 << ( ZEABUS_GPIO_FPGA_DONE - 32 ) ) | ( 1 << ( ZEABUS_GPIO_FPGA_INIT_B - 32 ) ) \
    | ( 1 << ( ZEABUS_GPIO_FPGA_RDWR_B - 32 ) ) | ( 1 << ( ZEABUS_GPIO_FPGA_CSI_B - 32 ) )  \
    | ( 1 << ( ZEABUS_GPIO_OTG_EN - 32 ) ) \
    )

/* DMA Socket allocation */
/* FX3S has some fixed sockets available as:
 *  - CPU : 1 consumer + 1 producer
 *  - USB (U-Port or UIB) : 16 consumers(egress) + 16 producers(ingress) (indexed from 0 - 15)
 *  - Storage (S-Port or SIB) : 6 bi-direction (indexed from 0 - 5)
 *  - GPIF II plus some interface logics (P-Port or PIB) : 16 bi-direction + 16 ingress (indexed from 0 - 31)
 *  - Low-Performance Port (LPP) : 1 pair for each device as:
 *          * CY_U3P_LPP_SOCKET_I2S_LEFT : Left-channel output to I2S port.
 *          * CY_U3P_LPP_SOCKET_I2S_RIGHT : Right-channel output to I2S port.
 *          * CY_U3P_LPP_SOCKET_UART_PROD : Incoming data from UART peer.
 *          * CY_U3P_LPP_SOCKET_UART_CONS : Outgoing data to UART peer.
 *          * CY_U3P_LPP_SOCKET_SPI_PROD : Incoming data from SPI slave.
 *          * CY_U3P_LPP_SOCKET_SPI_CONS  : Outgoing data to SPI slave.
 *          * CY_U3P_LPP_SOCKET_I2C_PROD : Incoming data from I2C slave.
 *          * CY_U3P_LPP_SOCKET_I2C_CONS : Outgoing data to I2C slave
 */

/* Note: For USB 2.0 the endpoints and corresponding sockets are one-to-one mapped
         i.e. EP 1 is mapped to UIB socket 1 and EP 2 to socket 2 so on */

#define ZEABUS_DMA_EP_USB_FPGA_CONSUMER_SOCKET   CY_U3P_UIB_SOCKET_CONS_4    /* USB BULK consumer */
#define ZEABUS_DMA_EP_USB_DATA_PRODUCER_SOCKET   CY_U3P_UIB_SOCKET_PROD_3    /* USB BULK producer */
#define ZEABUS_DMA_EP_USB_DATA_CONSUMER_SOCKET   CY_U3P_UIB_SOCKET_CONS_3    /* USB BULK  consumer */
#define ZEABUS_DMA_EP_USB_DEBUG_PRODUCER_SOCKET  CY_U3P_UIB_SOCKET_PROD_2    /* USB CDC BULK producer */
#define ZEABUS_DMA_EP_USB_DEBUG_CONSUMER_SOCKET  CY_U3P_UIB_SOCKET_CONS_2    /* USB CDC BULK  consumer */

extern CyU3PEvent   xZeabusEvent;              /* Event ID of USB event group */

#include "zeabus_usb_cmd.h"                     // We defined vendor's command in another file, which is also used by host software

/* Events */
#define ZEABUS_EVENT_REQ_USB_PROG_FPGA  (1 << 0)        // Request for FPGA programming from USB
#define ZEABUS_EVENT_REQ_SAVE_FPGA      (1 << 1)        // Request to save FPGA bitstream to SPI flash
#define ZEABUS_EVENT_REQ_SAVE_FIRMWARE  (1 << 2)        // Request to save FX3S firmware to SPI flash
#define ZEABUS_EVENT_REQ_READ_FLASH     (1 << 3)        // Request for raw data from SPI flash
#define ZEABUS_EVENT_REQ_WRITE_FLASH    (1 << 4)        // Write raw data to SPI flash
#define ZEABUS_EVENT_REQ_READ_EEPROM    (1 << 5)        // Request for raw data from EEPROM
#define ZEABUS_EVENT_REQ_WRITE_EEPROM   (1 << 6)        // Write raw data to EEPROM
#define ZEABUS_EVENT_REQ_SET_SOFT_RES   (1 << 7)        // Set FPGA soft reset
#define ZEABUS_EVENT_REQ_RES_SOFT_RES   (1 << 8)        // Reset FPGA soft reset
#define ZEABUS_EVENT_REQ_SEND_FPGA_DATA (1 << 9)        // Send data to FPGA through slave FIFO
#define ZEABUS_EVENT_REQ_FUNC_EN        (1 << 10)       // Enable functional module
#define ZEABUS_EVENT_REQ_FUNC_DIS       (1 << 11)       // Disable functional module
#define ZEABUS_EVENT_REQ_RESTART_FIFO   (1 << 12)       // Restart SlaveFifo engine

#endif // __ZEABUS_H