/****************************************************************************
 * zeabus_usb.c
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
#include <cyu3types.h>
#include <cyu3dma.h>
#include <cyu3usb.h>
#include <cyu3utils.h>
#include <cyu3externcend.h>

#include "zeabus.h"
#include "zeabus_error.h"
#include "zeabus_usb.h"

/*
 * USB Interface Block (UIB) in FX3S can operate as a USB3.0 peripheral.
 * It cooperates closely with DMA channels to achieve the USB super-speed.
 * There are 5 clock domains in UIB to support USB3.0 function.
 *  - DMA bus clock - derived from SYS_CLK
 *  - MMIO bus clock - derived from SYS_CLK
 *  - USB Spread-Spectrum clock - 125 MHz driven from USB PHY
 *  - Always-on clock - 32 kHz standby clock
 *  - External reference clock - 26 MHz XTal
 *
 * Zebus describes itself as a CDC/ACM device to be seen as a virtual COM port.
 * The maxmimum power current is presumed as 200 mA. It can be increased to
 * 900 mA in USB-3 mode or 500 mA in USB-2 mode. Currently, this module 
 * does not support sleep/suspend states.
 *
 */

// We borrow Cypress CDC vendor ID and product ID. The more appropriate is 0x0525:0xA4A7 belonging to a defuct company (NetChip Tech.).
#define ZEABUS_VENDOR_ID    (0x04B4)
#define ZEABUS_PRODUCT_ID   (0x0008)
#define ZEABUS_RELEASE      (0x0100)    /* BCD format in XX.XX */

/* Endpoint address of each USB stream. The MSB indicates the data direction (1 = device outgoing) */
#define ZEABUS_USB_EP_BULKOUT   (0x02)   /* EP 2 OUT (producer) (device incoming) */
#define ZEABUS_USB_EP_BULKIN    (0x82)   /* EP 2 IN (consumer) (device outgoing) */
#define ZEABUS_USB_EP_INTERRUPT (0x81)   /* EP 1 INTR (device incoming) */

#define W2B(a)              (a) & 255, (a) >> 8


/****************************************************************************
 * USB Descripters
 * We copy this part from Cypress SDK with a little modification.
 ****************************************************************************/

/* Standard device descriptor for USB 3.0 */
static const uint8_t CyFxUSB30DeviceDscr[] __attribute__ ((aligned (32))) =
{
    0x12,                           /* Descriptor size */
    CY_U3P_USB_DEVICE_DESCR,        /* Device descriptor type */
    0x10,0x03,                      /* USB 3.1 */
    0x00,                           /* Device class : defined in interface descripter */
    0x00,                           /* Device sub-class */
    0x00,                           /* Device protocol */
    0x09,                           /* Maxpacket size for EP0 : 2^9 */
    W2B(ZEABUS_VENDOR_ID),          /* Vendor ID : Little-Endian */
    W2B(ZEABUS_PRODUCT_ID),         /* Product ID : Little-Endian */
    W2B(ZEABUS_RELEASE),            /* Device release number : Little-Endian */
    0x01,                           /* Manufacture string index */
    0x02,                           /* Product string index */
    0x03,                           /* Serial number string index */
    0x01                            /* Number of configurations */
};

/* Standard device descriptor for USB 2.0 */
static const uint8_t CyFxUSB20DeviceDscr[] __attribute__ ((aligned (32))) =
{
    0x12,                           /* Descriptor size */
    CY_U3P_USB_DEVICE_DESCR,        /* Device descriptor type */
    0x10,0x02,                      /* USB 2.10 */
    0x00,                           /* Device class : defined in interface descripter */
    0x00,                           /* Device sub-class */
    0x00,                           /* Device protocol */
    0x40,                           /* Maxpacket size for EP0 : 64 bytes */
    W2B(ZEABUS_VENDOR_ID),          /* Vendor ID : Little-Endian */
    W2B(ZEABUS_PRODUCT_ID),         /* Product ID : Little-Endian */
    W2B(ZEABUS_RELEASE),            /* Device release number : Little-Endian */
    0x01,                           /* Manufacture string index */
    0x02,                           /* Product string index */
    0x00,                           /* Serial number string index */
    0x01                            /* Number of configurations */
};

/* Binary device object store descriptor */
static const uint8_t CyFxUSBBOSDscr[] __attribute__ ((aligned (32))) =
{
    0x05,                           /* Descriptor size */
    CY_U3P_BOS_DESCR,               /* BOS descriptor type */
    0x16,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x02,                           /* Number of device capability descriptors */

    /* USB 2.0 extension */
    0x07,                           /* Descriptor size */
    CY_U3P_DEVICE_CAPB_DESCR,       /* Device capability type descriptor */
    CY_U3P_USB2_EXTN_CAPB_TYPE,     /* USB 2.0 extension capability type */
    0x02,0x00,0x00,0x00,            /* Supported device level features: LPM support  */

    /* SuperSpeed device capability */
    0x0A,                           /* Descriptor size */
    CY_U3P_DEVICE_CAPB_DESCR,       /* Device capability type descriptor */
    CY_U3P_SS_USB_CAPB_TYPE,        /* SuperSpeed device capability type */
    0x00,                           /* Supported device level features  */
    0x0E,0x00,                      /* Speeds supported by the device : SS, HS and FS */
    0x03,                           /* Functionality support */
    0x00,                           /* U1 Device Exit latency */
    0x00,0x00                       /* U2 Device Exit latency */
};

/* Standard device qualifier descriptor */
static const uint8_t CyFxUSBDeviceQualDscr[] __attribute__ ((aligned (32))) =
{
    0x0A,                           /* Descriptor size */
    CY_U3P_USB_DEVQUAL_DESCR,       /* Device qualifier descriptor type */
    0x00,0x02,                      /* USB 2.0 */
    0x02,                           /* Device class */
    0x00,                           /* Device sub-class */
    0x00,                           /* Device protocol */
    0x08,                           /* Maxpacket size for EP0 */
    0x01,                           /* Number of configurations */
    0x00                            /* Reserved */
};

/* Standard super speed configuration descriptor */
static const uint8_t CyFxUSBSSConfigDscr[] __attribute__ ((aligned (32))) =
{
    /* Configuration descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_CONFIG_DESCR,        /* Configuration descriptor type */
    0x55,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x02,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x03,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0x19,                           /* Max power consumption of device (in 8mA unit) : 200mA */

    /* Interface 1 */
    /* Communication Interface descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x00,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x01,                           /* Number of endpoints */
    0x02,                           /* Interface class : Communication interface */
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* CDC Class-specific Descriptors */
    /* Header functional Descriptor */
    0x05,                           /* Descriptors length(5) */
    0x24,                           /* Descriptor type : CS_Interface */
    0x00,                           /* DescriptorSubType : Header Functional Descriptor */
    0x10,0x01,                      /* bcdCDC : CDC Release Number */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x02,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information
                                        only over the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_INTERRUPT,        /* Endpoint address and description */
    CY_U3P_USB_EP_INTR,             /* Interrupt endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x01,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for interrupt endpoint */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a Burst : 1 */
    0x00,                           /* Mult.: Max number of packets : 1 */
    0x00,0x04,                      /* Bytes per interval : (size * burst) = 1024 */

    /* Interface 2 */
    /* Data Interface Descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x01,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x02,                           /* Number of endpoints */
    0x0A,                           /* Interface class: Data interface */
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint Descriptor(BULK-PRODUCER) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKOUT,              /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for producer ep */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst minus 1 : 1 ( - 1 ) */
    0x00,                           /* Max streams for bulk EP = 0 (No streams) */
    0x00,0x00,                      /* Bytes per interval : 0 for BULK */

    /* Endpoint Descriptor(BULK- CONSUMER) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKIN,           /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for consumer ep */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst (minus 1) : 1 ( - 1 ) */
    0x00,                           /* Max streams for bulk EP = 0 (No streams) */
    0x00,0x00                       /* Bytes per interval : 0 for BULK */
};

/* Standard high speed configuration descriptor */
static const uint8_t CyFxUSBHSConfigDscr[] __attribute__ ((aligned (32))) =
{
    /* Configuration descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_CONFIG_DESCR,        /* Configuration descriptor type */
    0x43,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x02,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x03,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0x64,                           /* Max power consumption of device (in 2mA unit) : 200mA */

    /* Interface 1 */
    /* Communication Interface descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x00,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x01,                           /* Number of endpoints */
    0x02,                           /* Interface class : Communication Interface */
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* CDC Class-specific Descriptors */
    /* Header functional Descriptor */
    0x05,                           /* Descriptors length(5) */
    0x24,                           /* Descriptor type : CS_Interface */
    0x00,                           /* DescriptorSubType : Header Functional Descriptor */
    0x10,0x01,                      /* bcdCDC : CDC Release Number */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x02,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information
                                        only over the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_INTERRUPT,        /* Endpoint address and description */
    CY_U3P_USB_EP_INTR,             /* Interrupt endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x01,                           /* Servicing interval for data transfers */

    /* Interface 2 */
    /* Data Interface Descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x01,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x02,                           /* Number of endpoints */
    0x0A,                           /* Interface class: Data interface */
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint Descriptor(BULK-PRODUCER) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKOUT,          /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint Descriptor(BULK- CONSUMER) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKIN,           /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* Bulk endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */
};

/* Standard full speed configuration descriptor */
static const uint8_t CyFxUSBFSConfigDscr[] __attribute__ ((aligned (32))) =
{
    /* Configuration descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_CONFIG_DESCR,        /* Configuration descriptor type */
    0x43,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x02,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x03,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0x64,                           /* Max power consumption of device (in 2mA unit) : 200mA */

    /* Interface 1 */
    /* Communication Interface descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x00,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x01,                           /* Number of endpoints */
    0x02,                           /* Interface class: Communication interface*/
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* CDC Class-specific Descriptors */
    /* Header functional Descriptor */
    0x05,                           /* Descriptors length(5) */
    0x24,                           /* Descriptor type : CS_Interface */
    0x00,                           /* DescriptorSubType : Header Functional Descriptor */
    0x10,0x01,                      /* bcdCDC : CDC Release Number */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x02,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information only over
                                        the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_INTERRUPT,        /* Endpoint address and description */
    CY_U3P_USB_EP_INTR,             /* Interrupt endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x01,                           /* Servicing interval for data transfers */

    /* Interface 2 */
    /* Data Interface Descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x01,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x02,                           /* Number of endpoints */
    0x0A,                           /* Interface class: Data interface */
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint Descriptor(BULK-PRODUCER) */

    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKOUT,          /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint Descriptor(BULK- CONSUMER) */

    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_BULKIN,               /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* Bulk endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */
};

/* Standard language ID string descriptor */
static const uint8_t CyFxUSBStringLangIDDscr[] __attribute__ ((aligned (32))) =
{
    0x04,                           /* Descriptor size */
    0x03,                           /* Device descriptor type */
    0x09,0x04                       /* Language ID supported : English (US) */
};

/* Standard manufacturer string descriptor */
static const uint8_t CyFxUSBManufactureDscr[] __attribute__ ((aligned (32))) =
{
    0x1A,                           /* Descriptor size */
    0x03,                           /* Device descriptor type */
    'R', 0x00, 'o', 0x00, 'b', 0x00, 'i', 0x00, 'n', 0x00, '-', 0x00,
    'Z', 0x00, 'e', 0x00, 'a', 0x00, 'b', 0x00, 'u', 0x00, 's', 0x00
};

/* Standard product string descriptor */
const uint8_t CyFxUSBProductDscr[] __attribute__ ((aligned (32))) =
{
    0x36,                           /* Descriptor size */
    0x03,                           /* Device descriptor type */
    'A', 0x00, 'c', 0x00, 'o', 0x00, 'u', 0x00, 's', 0x00, 't', 0x00,
    'i', 0x00, 'c', 0x00, ' ', 0x00, 'P', 0x00, 'r', 0x00, 'o', 0x00,
    'c', 0x00, 'e', 0x00, 's', 0x00, 's', 0x00, 'i', 0x00, 'n', 0x00, 
    'g', 0x00, ' ', 0x00, 'm', 0x00, 'o', 0x00, 'd', 0x00, 'u', 0x00,
    'l', 0x00, 'e', 0x00
};

/* Standard serial string descriptor */
const uint8_t CyFxUSBSerialDscr[] __attribute__ ((aligned (32))) =
{
    0x14,                           /* Descriptor size */
    0x03,                           /* Device descriptor type */
    'A', 0x00, 'K', 0x00, 'P', 0x00,
    '2', 0x00, '0', 0x00, '2', 0x00, '0', 0x00,
    '0', 0x00, '1', 0x00
};

/************************************************************************************
 * Private Data
 ************************************************************************************/
static CyU3PDmaChannel xDMAChHandleBulkIngress;   /* DMA MANUAL_IN channel handle for OUT EP. */
static CyU3PDmaChannel xDMAChHandleBulkEgress;    /* DMA MANUAL_OUT channel handle for IN EP. */
static bool            bIsUSBActive = false;      /* Whether the USB sub-system is active or not. */
static uint8_t         au8LineCoding[] = { 0x60, 0xE3, 0x16, 0, 0, 0, 8}; /* Line coding value. Init with 8N1 1.5MB*/

/* Circular buffer for received data */
#define ZEABUS_BUF_POINTER_MASK (0x0FFF)        // Mask for curcular buffer pointer
static uint8_t          au8RecvBuf[4096];       // Buffer size should be multiple of 16 (as same as USB)
static volatile uint32_t         u32RecvBufHead = 0;     // Head pointer
static uint32_t         u32RecvBufTail = 0;     // Tail pointer
static uint32_t         u32USBBulkDest;         // Identify the target that USB BULK endpoints bound to.

/************************************************************************************
 * Private Functions
 ************************************************************************************/

/*--------------- DMA Management ------------------*/

/* Callback funtion for the DMA event notification. */
static void ZeabusBulkDmaCallback(
        CyU3PDmaChannel   *chHandle, /* Handle to the DMA channel. */
        CyU3PDmaCbType_t  type,      /* Callback type.             */
        CyU3PDmaCBInput_t *input)    /* Callback status.           */
{
    CyU3PDmaBuffer_t buf_p;
    uint32_t    l, count;

    if(type == CY_U3P_DMA_CB_PROD_EVENT)
    {
        /* This is a produce event notification to the CPU. This notification is 
         * received upon reception of every buffer. 
         */
        if( CyU3PDmaChannelGetBuffer( chHandle, &buf_p, CYU3P_NO_WAIT ) == CY_U3P_SUCCESS )
        {
            /* Copy the packet content to the reveiving buffer. All overflows are discarded */
            l = ( u32RecvBufHead + 1 ) & ZEABUS_BUF_POINTER_MASK;
            for(count = 0; count < buf_p.count; count++ )
            {
                if( l == u32RecvBufTail )   // Buffer full!!!
                    break;

                au8RecvBuf[l] = buf_p.buffer[count];

                l = (l + 1) & ZEABUS_BUF_POINTER_MASK;
            }
            u32RecvBufHead = ( l - 1 ) & ZEABUS_BUF_POINTER_MASK;
        }
        /* Finish the receiving, then discard the DMA buffer for next incoming */
        CyU3PDmaChannelDiscardBuffer( chHandle );

        /* Notify the system that some data are available */
        CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_USB_INCOMING, CYU3P_EVENT_OR );
    }
//    if(type == CY_U3P_DMA_CB_CONS_EVENT)
//    {
        /* This is a consume event notification to the CPU. This notification is 
         * received when a buffer is sent out from the device. 
         * Currently, we have nothing to do as the buffer is filled by 
         * API of sending data described below.
         */
//    }
}

/*--------------- USB Management ------------------*/

/* DMA BULK Event callback. Only supported event is RETRY */
static void ZeabusBulkAppEpEvtCB (
        CyU3PUsbEpEvtType evtype,
        CyU3PUSBSpeed_t   speed,
        uint8_t           epNum)
{
    /* Hit an endpoint retry case. Need to stall and flush the endpoint for recovery. */
    if( evtype == CYU3P_USBEP_SS_RETRY_EVT )
    {
        CyU3PUsbStall( ZEABUS_USB_EP_BULKIN, CyTrue, CyFalse );
    }
}


/* This is called when a SET_CONF event is received from 
 * the USB host. The endpoints are configured and the DMA pipe 
 * is setup in this function. */
static void ZeabusUSBAppStart( void )
{
    uint16_t size = 0;
    CyU3PEpConfig_t epCfg;
    CyU3PDmaChannelConfig_t dmaCfg;
    CyU3PReturnStatus_t apiRetStatus = CY_U3P_SUCCESS;
    CyU3PUSBSpeed_t usbSpeed = CyU3PUsbGetSpeed();

    /* First identify the usb speed. Once that is identified,
     * create a DMA channel and start the transfer on this. */

    /* Based on the Bus Speed configure the endpoint packet size */
    switch (usbSpeed)
    {
    case CY_U3P_FULL_SPEED:
        size = 64;
        break;

    case CY_U3P_HIGH_SPEED:
        size = 512;
        break;

    case  CY_U3P_SUPER_SPEED:
        size = 1024;
        break;

    default:
        return;     /* Quit if the speed is un-supported */
    }

    u32USBBulkDest = ZEABUS_USB_REQ_UNBIND_BULK;

    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyTrue;
    epCfg.epType = CY_U3P_USB_EP_BULK;
    epCfg.burstLen = (usbSpeed == CY_U3P_SUPER_SPEED) ? 16 : 1; /* Only Super Speed supports burst */
    epCfg.streams = 0;
    epCfg.pcktSize = size;

    /* Producer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig(ZEABUS_USB_EP_BULKOUT, &epCfg);
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* Consumer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig(ZEABUS_USB_EP_BULKIN, &epCfg);
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* Interrupt endpoint configuration. This is the legacy interface. No data is expected on it. */
    epCfg.epType = CY_U3P_USB_EP_INTR;
    epCfg.pcktSize = size;
    epCfg.isoPkts = 1;

    apiRetStatus = CyU3PSetEpConfig(ZEABUS_USB_EP_INTERRUPT, &epCfg);
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Flush the endpoint memory */
    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_INTERRUPT);

    /* Create a DMA MANUAL_IN channel for the producer socket. */
    CyU3PMemSet ((uint8_t *)&dmaCfg, 0, sizeof (dmaCfg));
    /* The buffer size will be same as packet size for the
     * full speed, high speed and super speed non-burst modes.
     * For super speed burst mode of operation, the buffers will be
     * 1024 * burst length so that a full burst can be completed.
     * This will mean that a buffer will be available only after it
     * has been filled or when a short packet is received. */
    dmaCfg.size = size;

    /* Number of DMA buffers to be used. More buffers can give better throughput. */
    dmaCfg.count = 4;

    dmaCfg.prodSckId = ZEABUS_DMA_EP_USB_PRODUCER_SOCKET;
    dmaCfg.consSckId = CY_U3P_CPU_SOCKET_CONS;
    dmaCfg.dmaMode = CY_U3P_DMA_MODE_BYTE;
    dmaCfg.notification = CY_U3P_DMA_CB_PROD_EVENT;
    dmaCfg.cb = ZeabusBulkDmaCallback;
    dmaCfg.prodHeader = 0;
    dmaCfg.prodFooter = 0;
    dmaCfg.consHeader = 0;
    dmaCfg.prodAvailCount = 0;

    apiRetStatus = CyU3PDmaChannelCreate (&xDMAChHandleBulkIngress,
            CY_U3P_DMA_TYPE_MANUAL_IN, &dmaCfg);
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Create a DMA MANUAL_OUT channel for the consumer socket. */
    dmaCfg.notification = CY_U3P_DMA_CB_CONS_EVENT;
    dmaCfg.prodSckId = CY_U3P_CPU_SOCKET_PROD;
    dmaCfg.consSckId = ZEABUS_DMA_EP_USB_CONSUMER_SOCKET;
    apiRetStatus = CyU3PDmaChannelCreate( &xDMAChHandleBulkEgress, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Set DMA Channel transfer size */
    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleBulkIngress, 0); /* DMA transfer size is set to infinite */
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleBulkEgress, 0); /* DMA transfer size is set to infinite */
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    CyU3PUsbRegisterEpEvtCallback( ZeabusBulkAppEpEvtCB, CYU3P_USBEP_SS_RETRY_EVT, 0x00, 0x02 );

    /* Update the flag so that the application thread is notified of this. */
    bIsUSBActive = true;
}

/* This function shall be called whenever a RESET
 * or DISCONNECT event is received from the USB host. The endpoints are
 * disabled and the DMA pipe is destroyed by this function. */
static void ZeabusUSBAppStop( void )
{
    CyU3PEpConfig_t epCfg;
    CyU3PReturnStatus_t apiRetStatus[3];

    /* Update the flag so that the application thread is notified of this. */
    bIsUSBActive = false;
    u32USBBulkDest = ZEABUS_USB_REQ_UNBIND_BULK;

    /* Destroy the channels */
    CyU3PDmaChannelDestroy (&xDMAChHandleBulkIngress);
    CyU3PDmaChannelDestroy (&xDMAChHandleBulkEgress);

    /* Flush the endpoint memory */
    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_INTERRUPT);

    /* Disable endpoints. */
    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyFalse;

    /* Producer endpoint configuration. */
    apiRetStatus[0] = CyU3PSetEpConfig(ZEABUS_USB_EP_BULKOUT, &epCfg);
    /* Consumer endpoint configuration. */
    apiRetStatus[1] = CyU3PSetEpConfig(ZEABUS_USB_EP_BULKIN, &epCfg);
    /* Interrupt endpoint configuration. */
    apiRetStatus[2] = CyU3PSetEpConfig(ZEABUS_USB_EP_INTERRUPT, &epCfg);

    /* Whether some errors occured */
    if( (apiRetStatus[0] != CY_U3P_SUCCESS) || (apiRetStatus[1] != CY_U3P_SUCCESS) || (apiRetStatus[2] != CY_U3P_SUCCESS))
    {
        /* Report only one error */
        if(apiRetStatus[0] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[0]);
        if(apiRetStatus[1] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[1]);
        if(apiRetStatus[2] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[2]);
    }
}

/************** Callback functions for USB events ****************/
/* This is the callback function to handle the general USB events. */
static void ZeabusUSBAppUSBEventCB (
        CyU3PUsbEventType_t evtype, /* Event type */
        uint16_t            evdata  /* Event data */
)
{
    switch (evtype)
    {
        case CY_U3P_USB_EVENT_SETCONF:
            /* Stop the application before re-starting. */
            if(bIsUSBActive)
            {
                ZeabusUSBAppStop ();
            }
            /* Start the loop back function. */
            ZeabusUSBAppStart ();
            break;

        case CY_U3P_USB_EVENT_CONNECT:
            break;

        case CY_U3P_USB_EVENT_RESET:
        case CY_U3P_USB_EVENT_DISCONNECT:
            /* Stop the source sink function. */
            if(bIsUSBActive)
            {
                ZeabusUSBAppStop ();
            }
            break;

        default:
            break;
    }
}

/* Callback to handle the USB Requests from EP0 */
#define SET_LINE_CODING        0x20
#define GET_LINE_CODING        0x21
#define SET_CONTROL_LINE_STATE 0x22

static CyBool_t ZeabusUSBAppUSBControlCB(
        uint32_t setupdat0, /* SETUP Data 0 */
        uint32_t setupdat1  /* SETUP Data 1 */
        )
{
    /* Fast enumeration is used. Only requests addressed to the interface, class,
     * vendor and unknown control requests are received by this function.
     */
    uint8_t  config_data[7];
    uint8_t  bRequest, bReqType;
    uint8_t  bType, bTarget;
    uint16_t wValue, wIndex, readCount;
    CyBool_t isHandled = CyFalse;

    /* Decode the fields from the setup request. */
    bReqType = (setupdat0 & CY_U3P_USB_REQUEST_TYPE_MASK);
    bType    = (bReqType & CY_U3P_USB_TYPE_MASK);
    bTarget  = (bReqType & CY_U3P_USB_TARGET_MASK);
    bRequest = ((setupdat0 & CY_U3P_USB_REQUEST_MASK) >> CY_U3P_USB_REQUEST_POS);
    wValue   = ((setupdat0 & CY_U3P_USB_VALUE_MASK)   >> CY_U3P_USB_VALUE_POS);
    wIndex   = ((setupdat1 & CY_U3P_USB_INDEX_MASK)   >> CY_U3P_USB_INDEX_POS);

    if(bType == CY_U3P_USB_STANDARD_RQT)
    {
        /* Handle SET_FEATURE(FUNCTION_SUSPEND) and CLEAR_FEATURE(FUNCTION_SUSPEND)
         * requests here. It should be allowed to pass if the device is in configured
         * state and failed otherwise. */
        if((bTarget == CY_U3P_USB_TARGET_INTF) && ((bRequest == CY_U3P_USB_SC_SET_FEATURE)
                    || (bRequest == CY_U3P_USB_SC_CLEAR_FEATURE)) && (wValue == 0))
        {
            if(bIsUSBActive)
                CyU3PUsbAckSetup ();
            else
                CyU3PUsbStall (0, CyTrue, CyFalse);

            isHandled = CyTrue;
        }

        /* CLEAR_FEATURE request for endpoint is always passed to the setup callback
         * regardless of the enumeration model used. When a clear feature is received,
         * the previous transfer has to be flushed and cleaned up. This is done at the
         * protocol level. Since this is just a loopback operation, there is no higher
         * level protocol. So flush the EP memory and reset the DMA channel associated
         * with it. If there are more than one EP associated with the channel reset both
         * the EPs. The endpoint stall and toggle / sequence number is also expected to be
         * reset. Return CyFalse to make the library clear the stall and reset the endpoint
         * toggle. Or invoke the CyU3PUsbStall (ep, CyFalse, CyTrue) and return CyTrue.
         * Here we are clearing the stall. */
        if((bTarget == CY_U3P_USB_TARGET_ENDPT) && (bRequest == CY_U3P_USB_SC_CLEAR_FEATURE)
                && (wValue == CY_U3P_USBX_FS_EP_HALT))
        {
            if(bIsUSBActive)
            {
                if(wIndex == ZEABUS_USB_EP_BULKOUT)
                {
                    CyU3PUsbSetEpNak (ZEABUS_USB_EP_BULKOUT, CyTrue);
                    CyU3PBusyWait (125);

                    CyU3PDmaChannelReset (&xDMAChHandleBulkIngress);
                    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKOUT);
                    CyU3PUsbResetEp (ZEABUS_USB_EP_BULKOUT);
                    CyU3PUsbSetEpNak (ZEABUS_USB_EP_BULKOUT, CyFalse);

                    CyU3PDmaChannelSetXfer (&xDMAChHandleBulkIngress, 0); /* DMA transfer size is set to infinite */
                    CyU3PUsbStall (wIndex, CyFalse, CyTrue);
                    isHandled = CyTrue;
                    CyU3PUsbAckSetup ();
                }

                if(wIndex == ZEABUS_USB_EP_BULKIN)
                {
                    CyU3PUsbSetEpNak (ZEABUS_USB_EP_BULKIN, CyTrue);
                    CyU3PBusyWait (125);

                    CyU3PDmaChannelReset (&xDMAChHandleBulkEgress);
                    CyU3PUsbFlushEp(ZEABUS_USB_EP_BULKIN);
                    CyU3PUsbResetEp(ZEABUS_USB_EP_BULKIN);
                    CyU3PUsbSetEpNak(ZEABUS_USB_EP_BULKIN, CyFalse);

                    CyU3PDmaChannelSetXfer(&xDMAChHandleBulkEgress, 0); /* DMA transfer size is set to infinite */
                    CyU3PUsbStall(wIndex, CyFalse, CyTrue);
                    isHandled = CyTrue;
                    CyU3PUsbAckSetup();
                }
            }
        }
    }

    /* Check for CDC Class Requests */
    else if(bType == CY_U3P_USB_CLASS_RQT)
    {
        isHandled = CyTrue;

        /* CDC Specific Requests */
        /* The line coding has no meaning here. Just keep the settting for the device reply
         * All data should be in 8N1 format.
         */
        /* set_line_coding */
        if(bRequest == SET_LINE_CODING)                                                      
        {
            if( CyU3PUsbGetEP0Data(0x07, config_data, &readCount) == CY_U3P_SUCCESS )
            {
                if(readCount == 0x07)
                {
                    /* Copy only the baud rate for further reply. The format is alwasy 8N1 */
                    au8LineCoding[0] = config_data[0];
                    au8LineCoding[1] = config_data[1];
                    au8LineCoding[2] = config_data[2];
                    au8LineCoding[3] = config_data[3];
                }
            }
        }
        /* get_line_coding */
        else if(bRequest == GET_LINE_CODING )                                                   
        {
            /* Reply back with the previous or default setting */
            (void)CyU3PUsbSendEP0Data( 0x07, au8LineCoding);
        }
         /* SET_CONTROL_LINE_STATE */
        else if(bRequest == SET_CONTROL_LINE_STATE)                                                   
        {
            if(bIsUSBActive)
                CyU3PUsbAckSetup ();
            else
                CyU3PUsbStall (0, CyTrue, CyFalse);
        }
        else
        {
            isHandled = CyFalse;
        }
    }

    /* handle vendor requests */
    //TODO: Vendor requests
    else if( bType == CY_U3P_USB_VENDOR_RQT )
    {
        switch( bRequest )
        {
            case ZEABUS_USB_REQ_UNBIND_BULK:
                // Unbind CDC bulk from other peripherals
            case ZEABUS_USB_REQ_BIND_BULK_FPGA:
                // Bind CDC bulk endpoints to FPGA interface
                isHandled = CyTrue;
                break;

            default:
                isHandled = CyFalse;     // Unknown command
                break;
        }
    }

    return isHandled;
}

/* Callback function to handle LPM requests from the USB 3.0 host. This function is invoked by the API
   whenever a state change from U0 -> U1 or U0 -> U2 happens. If we return CyTrue from this function, the
   FX3 device is retained in the low power state. If we return CyFalse, the FX3 device immediately tries
   to trigger an exit back to U0.

   This application does not have any state in which we should not allow U1/U2 transitions; and therefore
   the function always return CyTrue.
 */
static CyBool_t ZeabusUSBAppLPMRqtCB( CyU3PUsbLinkPowerMode link_mode )
{
    /* We do not support suspend/sleep modes at the moment */
    return CyTrue;
}

/************************************************************************************
 * Public API Functions
 ************************************************************************************/
/*
 * Loop sending data through egress DMA buffer.
 */
uint32_t zeabus_usb_send( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t    buf_p;
    uint32_t            sent, granule;

    sent = 0;
    while( size > 0 )
    {
        /* In this sub-system, the data must be able to be sent without waiting */
        if( CyU3PDmaChannelGetBuffer( &xDMAChHandleBulkEgress, &buf_p, CYU3P_NO_WAIT ) != CY_U3P_SUCCESS )
            break;

        if( size < buf_p.size )
            granule = size;
        else
            granule = buf_p.size;

        /* Transfer data to DMA buffer */
        CyU3PMemCopy( buf_p.buffer, buf, granule );

        if( CyU3PDmaChannelCommitBuffer( &xDMAChHandleBulkEgress, granule, 0 ) != CY_U3P_SUCCESS )
            break;

        /* Update variables */
        size -= granule;
        sent += granule;
        buf += granule;
    }

    return sent;
}

uint32_t zeabus_usb_reveive( uint8_t* buf, uint32_t max_size )
{
    uint32_t    l, count;

    if( u32RecvBufTail == u32RecvBufHead )
        return 0;       // Buffer is empty

    if( max_size == 0 )
        return 0;       // OOPS!!! Should not be here.

    l = u32RecvBufTail;
    for( count = 0; count < max_size; count++ )
    {
        buf[count] = au8RecvBuf[l];
        count++;
        l = (l + 1) & ZEABUS_BUF_POINTER_MASK;
        if( l == u32RecvBufHead )
            break;  // Notrhing more to read
    }
    u32RecvBufTail = l;

    return count;
}

/* This function initializes the USB module, UART module and sets the enumeration descriptors */
bool zeabus_usb_initialize( void )
{
    CyU3PReturnStatus_t apiRetStatus;

    /* Start the USB functionality. */
    apiRetStatus = CyU3PUsbStart();
    if( ( apiRetStatus != CY_U3P_SUCCESS ) && ( apiRetStatus != CY_U3P_ERROR_NO_REENUM_REQUIRED ) )
        return false;
 
    u32USBBulkDest = ZEABUS_USB_REQ_UNBIND_BULK;
    /* Setup the callback to handle the setup requests */
    /* The fast enumeration is the easiest way to setup a USB connection,
     * where all enumeration phase is handled by the library. Only the
     * class / vendor requests need to be handled by the application. */
    CyU3PUsbRegisterSetupCallback( ZeabusUSBAppUSBControlCB, CyTrue );

    /* Setup the callback to handle the USB events. */
    CyU3PUsbRegisterEventCallback( ZeabusUSBAppUSBEventCB );

    /* Register a callback to handle LPM requests from the USB 3.0 host. */
    CyU3PUsbRegisterLPMRequestCallback( ZeabusUSBAppLPMRqtCB );    

    /* Set the USB enumeration descriptors */

    /* Super speed device descriptor. */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_SS_DEVICE_DESCR, 0, (uint8_t *)CyFxUSB30DeviceDscr) != CY_U3P_SUCCESS )
        return false;

    /* High speed device descriptor. */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_HS_DEVICE_DESCR, 0, (uint8_t *)CyFxUSB20DeviceDscr) != CY_U3P_SUCCESS )
        return false;

    /* BOS descriptor */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_SS_BOS_DESCR, 0, (uint8_t *)CyFxUSBBOSDscr) != CY_U3P_SUCCESS )
        return false;

    /* Device qualifier descriptor */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_DEVQUAL_DESCR, 0, (uint8_t *)CyFxUSBDeviceQualDscr) != CY_U3P_SUCCESS )
        return false;

    /* Super speed configuration descriptor */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_SS_CONFIG_DESCR, 0, (uint8_t *)CyFxUSBSSConfigDscr) != CY_U3P_SUCCESS )
        return false;

    /* High speed configuration descriptor*/
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_HS_CONFIG_DESCR, 0, (uint8_t *)CyFxUSBHSConfigDscr) != CY_U3P_SUCCESS )
        return false;

    /* Full speed configuration descriptor */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_FS_CONFIG_DESCR, 0, (uint8_t *)CyFxUSBFSConfigDscr) != CY_U3P_SUCCESS )
        return false;

    /* String descriptor 0 */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_STRING_DESCR, 0, (uint8_t *)CyFxUSBStringLangIDDscr) != CY_U3P_SUCCESS )
        return false;

    /* String descriptor 1 */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_STRING_DESCR, 1, (uint8_t *)CyFxUSBManufactureDscr) != CY_U3P_SUCCESS )
        return false;

    /* String descriptor 2 */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_STRING_DESCR, 2, (uint8_t *)CyFxUSBProductDscr) != CY_U3P_SUCCESS )
        return false;

    /* String descriptor 3 */
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_STRING_DESCR, 2, (uint8_t *)CyFxUSBSerialDscr) != CY_U3P_SUCCESS )
        return false;

    /* Connect the USB Pins with super speed operation enabled. */
    if( CyU3PConnectState( CyTrue, CyTrue ) == CY_U3P_SUCCESS )
        return true;
    else
        return false;
}