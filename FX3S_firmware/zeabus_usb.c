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
#include "zeabus_slavefifo.h"

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

#define ZEABUS_RELEASE      (0x0100)    /* BCD format in XX.XX */

/* Endpoint address of each USB stream. The MSB indicates the data direction (1 = device outgoing) */
#define ZEABUS_USB_EP_FPGA_BULKIN   (0x84)   /* EP 4 IN (comsumer) (device outgoing) */
#define ZEABUS_USB_EP_DATA_BULKOUT  (0x03)   /* EP 3 OUT (producer) (device incoming) */
#define ZEABUS_USB_EP_DATA_BULKIN   (0x83)   /* EP 3 IN (comsumer) (device outgoing) */
#define ZEABUS_USB_EP_DBG_BULKOUT   (0x02)   /* EP 2 OUT (producer) (device incoming) */
#define ZEABUS_USB_EP_DBG_BULKIN    (0x82)   /* EP 2 IN (consumer) (device outgoing) */
#define ZEABUS_USB_EP_DBG_INTERRUPT (0x81)   /* EP 1 INTR (device incoming) */

#define W2B(a)              (a) & 255, (a) >> 8

/* Reset the system in the same way as hard reset and soft reset
 * Refer to ARM9 document and EZ-USB FX3S technical document for reference
 */
#define REG_GCTL_CONTROL    (0xE0017E04UL)  // Global control register in ARM9
#define SystemReset()   (*((uint16_t*)(REG_GCTL_CONTROL))&=(0xF7FF))
#define Reboot()        (*((uint16_t*)(REG_GCTL_CONTROL))&=(0xFBFF))

/****************************************************************************
 * USB Descripters
 * We copy this part from Cypress SDK with a little modification.
 * =========
 * Important !!!!
 * Latest USB specification does not directly support composition of interfaces into
 * a single device (one such as CDC-ACM, which composes of CDC Data and 
 * CDC Control interfaces). Therfore, another USB device type has beed specified
 * as Class=0xEF (Miscelleneous device), Sub-class=0x02, and Protocol=0x01
 * for those that have this composition. Also, another configuration descriptor
 * is assigned to describe the composition, IAD descriptor.
 * 
 * FX3 SDK has no document about this issue. The incident was found by
 * comparing descriptors of an ST Nucleo board with the SDK examples.
 ****************************************************************************/

/* Standard device descriptor for USB 3.0 */
static const uint8_t CyFxUSB30DeviceDscr[] __attribute__ ((aligned (32))) =
{
    0x12,                           /* Descriptor size */
    CY_U3P_USB_DEVICE_DESCR,        /* Device descriptor type */
    0x10,0x03,                      /* USB 3.1 */
    0xEF,                           /* Device class : Miscelleneous device */
    0x02,                           /* Device sub-class */
    0x01,                           /* Device protocol : Interface Association (IAD) */
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
    0x00,0x02,                      /* USB 2.00 */
    0xEF,                           /* Device class : Miscelleneous */
    0x02,                           /* Device sub-class */
    0x01,                           /* Device protocol : Interface Association (IAD) */
    0x40,                           /* Maxpacket size for EP0 : 64 bytes */
    W2B(ZEABUS_VENDOR_ID),          /* Vendor ID : Little-Endian */
    W2B(ZEABUS_PRODUCT_ID),         /* Product ID : Little-Endian */
    W2B(ZEABUS_RELEASE),            /* Device release number : Little-Endian */
    0x01,                           /* Manufacture string index */
    0x02,                           /* Product string index */
    0x03,                           /* Serial number string index */
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
    0x00,                           /* Device class */
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
    0x8D,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x03,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x00,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0x32,                           /* Max power consumption of device (in 8mA unit) : 400mA */

    /* Interface Association Descriptor (IAD). This descriptor is absent in FX3 SDK */
    /* Windows requires this descriptor to combine CDC interfaces together as one dedvice */
    0x08,                           /* Descriptor size */
    0x0B,                           /* Interface Descriptor type */
    0x00,                           /* First interface index (not interface number) */
    0x02,                           /* Interface count */
    0x02,                           /* Interface class : Communication interface */
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

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

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information
                                        only over the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x06,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DBG_INTERRUPT,    /* Endpoint address and description */
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
    ZEABUS_USB_EP_DBG_BULKOUT,      /* Endpoint address and description */
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
    ZEABUS_USB_EP_DBG_BULKIN,       /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for consumer ep */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst (minus 1) : 1 ( - 1 ) */
    0x00,                           /* Max streams for bulk EP = 0 (No streams) */
    0x00,0x00,                      /* Bytes per interval : 0 for BULK */

    /* Interface 3: Vendor specific */
    /* Interface descriptor: Interface 0, Alt Setting 1 - Two endpoints */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x02,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x03,                           /* Number of endpoints */
    0xFF,                           /* Interface class : Vendor specific*/
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint descriptor for producer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKOUT,     /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for producer EP */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst : 0: burst 1 packet at a time */
    0x00,                           /* Mult.: Max number of packets : 1 */
    0x00,0x00,                      /* Bytes per interval : 0 for BULK */

    /* Endpoint descriptor for consumer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for consumer EP */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst : 0: burst 1 packet at a time */
    0x00,                           /* Mult.: Max number of packets : 1 */
    0x00,0x00,                      /* Bytes per interval : 0 for BULK */

    /* Endpoint descriptor for producer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_FPGA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x04,                      /* Max packet size = 1024 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Super speed endpoint companion descriptor for producer EP */
    0x06,                           /* Descriptor size */
    CY_U3P_SS_EP_COMPN_DESCR,       /* SS endpoint companion descriptor type */
    0x00,                           /* Max no. of packets in a burst : 0: burst 1 packet at a time */
    0x00,                           /* Mult.: Max number of packets : 1 */
    0x00,0x00                       /* Bytes per interval : 0 for BULK */
};

/* Standard high speed configuration descriptor */
static const uint8_t CyFxUSBHSConfigDscr[] __attribute__ ((aligned (32))) =
{
    /* Configuration descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_CONFIG_DESCR,        /* Configuration descriptor type */
    0x69,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x03,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x00,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0xC8,                           /* Max power consumption of device (in 2mA unit) : 400mA */

    /* Interface Association Descriptor (IAD). This descriptor is absent in FX3 SDK */
    /* Windows requires this descriptor to combine CDC interfaces together as one dedvice */
    0x08,                           /* Descriptor size */
    0x0B,                           /* Interface Descriptor type */
    0x00,                           /* First interface index (not interface number) */
    0x02,                           /* Interface count */
    0x02,                           /* Interface class : Communication interface */
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

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

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information
                                        only over the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x06,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DBG_INTERRUPT,    /* Endpoint address and description */
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
    ZEABUS_USB_EP_DBG_BULKOUT,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint Descriptor(BULK- CONSUMER) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DBG_BULKIN,       /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* Bulk endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Interface 3: Vendor specific */
    /* Interface descriptor: Interface 0, Alt Setting 1 - Two endpoints */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x02,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x03,                           /* Number of endpoints */
    0xFF,                           /* Interface class : Vendor specific*/
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint descriptor for producer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKOUT,     /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint descriptor for consumer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint descriptor for consumer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_FPGA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x00,0x02,                      /* Max packet size = 512 bytes */
    0x00                            /* Servicing interval for data transfers */
};

/* Standard full speed configuration descriptor */
static const uint8_t CyFxUSBFSConfigDscr[] __attribute__ ((aligned (32))) =
{
    /* Configuration descriptor */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_CONFIG_DESCR,        /* Configuration descriptor type */
    0x69,0x00,                      /* Length of this descriptor and all sub descriptors */
    0x03,                           /* Number of interfaces */
    0x01,                           /* Configuration number */
    0x00,                           /* COnfiguration string index */
    0x80,                           /* Config characteristics - bus powered */
    0x64,                           /* Max power consumption of device (in 2mA unit) : 200mA */

    /* Interface Association Descriptor (IAD). This descriptor is absent in FX3 SDK */
    /* Windows requires this descriptor to combine CDC interfaces together as one dedvice */
    0x08,                           /* Descriptor size */
    0x0B,                           /* Interface Descriptor type */
    0x00,                           /* First interface index (not interface number) */
    0x02,                           /* Interface count */
    0x02,                           /* Interface class : Communication interface */
    0x02,                           /* Interface sub class */
    0x01,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

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

    /* Call Management Functional Descriptor */
    0x05,                           /*  Descriptors Length (5) */
    0x24,                           /*  bDescriptorType: CS_INTERFACE */
    0x01,                           /*  bDescriptorSubType: Call Management Functional Descriptor */
    0x00,                           /*  bmCapabilities: Device sends/receives call management information only over
                                        the Communication Class Interface. */
    0x01,                           /*  Interface Number of Data Class interface */

    /* Abstract Control Management Functional Descriptor */
    0x04,                           /* Descriptors Length (4) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x02,                           /* bDescriptorSubType: Abstract Control Model Functional Descriptor */
    0x06,                           /* bmCapabilities: Supports the request combination of Set_Line_Coding,
                                       Set_Control_Line_State, Get_Line_Coding and the notification Serial_State */

    /* Union Functional Descriptor */
    0x05,                           /* Descriptors Length (5) */
    0x24,                           /* bDescriptorType: CS_INTERFACE */
    0x06,                           /* bDescriptorSubType: Union Functional Descriptor */
    0x00,                           /* bMasterInterface */
    0x01,                           /* bSlaveInterface */

    /* Endpoint Descriptor(Interrupt) */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DBG_INTERRUPT,    /* Endpoint address and description */
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
    ZEABUS_USB_EP_DBG_BULKOUT,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint Descriptor(BULK- CONSUMER) */

    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DBG_BULKIN,       /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* Bulk endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Interface 3: Vendor specific */
    /* Interface descriptor: Interface 0, Alt Setting 1 - Two endpoints */
    0x09,                           /* Descriptor size */
    CY_U3P_USB_INTRFC_DESCR,        /* Interface Descriptor type */
    0x02,                           /* Interface number */
    0x00,                           /* Alternate setting number */
    0x03,                           /* Number of endpoints */
    0xFF,                           /* Interface class : Vendor specific*/
    0x00,                           /* Interface sub class */
    0x00,                           /* Interface protocol code */
    0x00,                           /* Interface descriptor string index */

    /* Endpoint descriptor for producer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKOUT,     /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint descriptor for consumer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_DATA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00,                           /* Servicing interval for data transfers */

    /* Endpoint descriptor for consumer EP */
    0x07,                           /* Descriptor size */
    CY_U3P_USB_ENDPNT_DESCR,        /* Endpoint descriptor type */
    ZEABUS_USB_EP_FPGA_BULKIN,      /* Endpoint address and description */
    CY_U3P_USB_EP_BULK,             /* BULK endpoint type */
    0x40,0x00,                      /* Max packet size = 64 bytes */
    0x00                            /* Servicing interval for data transfers */
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

/* Place this buffer as the last buffer so that no other variable / code shares
 * the same cache line. Do not add any other variables / arrays in this file.
 * This will lead to variables sharing the same cache line. */
const uint8_t CyFxUsbDscrAlignBuffer[32] __attribute__ ((aligned (32)));

/************************************************************************************
 * Private Data
 ************************************************************************************/
static CyU3PDmaChannel  xDMAChHandleDataBulkIngress;  /* DMA MANUAL_IN channel handle for data OUT EP. */
static CyU3PDmaChannel  xDMAChHandleDataBulkEgress;   /* DMA MANUAL_OUT channel handle for data IN EP. */
static CyU3PDmaChannel  xDMAChHandleDbgBulkIngress;   /* DMA MANUAL_IN channel handle for debug OUT EP. */
static CyU3PDmaChannel  xDMAChHandleDbgBulkEgress;    /* DMA MANUAL_OUT channel handle for debug IN EP. */
static bool             bIsUSBActive = false;      /* Whether the USB sub-system is active or not. */
static uint8_t          au8LineCoding[] __attribute__ ((aligned (32))) = { 0x60, 0xE3, 0x16, 0, 0, 0, 8}; /* Line coding value. Init with 8N1 1.5MB*/

static uint8_t          au8Ep0Buffer[1024] __attribute__ ((aligned (32)));
static uint32_t         u32Ep0DWData = 0;
static uint16_t         u16Ep0WData = 0;

static bool             bIsSlaveFIFOInited = false;     // Whether the slave-FIFO has started. This flag allows USB to restart slave FIFO function.

/************************************************************************************
 * Private Functions
 ************************************************************************************/

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
        CyU3PUsbStall( ZEABUS_USB_EP_DBG_BULKIN, CyTrue, CyFalse );
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
        /* Turning low power mode off to avoid USB transfer delays. */
        CyU3PUsbLPMDisable ();
        size = 1024;
        break;

    default:
        return;     /* Quit if the speed is un-supported */
    }

    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyTrue;
    epCfg.epType = CY_U3P_USB_EP_BULK;
    epCfg.burstLen = (usbSpeed == CY_U3P_SUPER_SPEED) ? 4 : 1; /* Only Super Speed supports burst */
    epCfg.streams = 0;
    epCfg.pcktSize = size;

    /* Debug producer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig( ZEABUS_USB_EP_DBG_BULKOUT, &epCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* Debug consumer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig( ZEABUS_USB_EP_DBG_BULKIN, &epCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* Data producer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig( ZEABUS_USB_EP_DATA_BULKOUT, &epCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* Data consumer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig( ZEABUS_USB_EP_DATA_BULKIN, &epCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /* FPGA data consumer endpoint configuration */
    apiRetStatus = CyU3PSetEpConfig( ZEABUS_USB_EP_FPGA_BULKIN, &epCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler (apiRetStatus);
    }

    /*
       Configure the IN endpoint to allow combining data from multiple buffers into one burst.
       This can help achieve better performance in most cases.
     */
    CyU3PUsbEPSetBurstMode( ZEABUS_USB_EP_DBG_BULKIN, CyTrue );
    CyU3PUsbEPSetBurstMode( ZEABUS_USB_EP_DATA_BULKIN, CyTrue );
    CyU3PUsbEPSetBurstMode( ZEABUS_USB_EP_FPGA_BULKIN, CyTrue );

    /* Interrupt endpoint configuration. This is the legacy interface. No data is expected on it. */
    epCfg.epType = CY_U3P_USB_EP_INTR;
    epCfg.pcktSize = size;
    epCfg.isoPkts = 1;

    apiRetStatus = CyU3PSetEpConfig(ZEABUS_USB_EP_DBG_INTERRUPT, &epCfg);
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Flush the endpoint memory */
    CyU3PUsbFlushEp(ZEABUS_USB_EP_FPGA_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DATA_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DATA_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_INTERRUPT);

    /* Create a DMA MANUAL channels Debug port. */
    CyU3PMemSet ((uint8_t *)&dmaCfg, 0, sizeof (dmaCfg));
    /* The buffer size will be same as packet size for the
     * full speed, high speed and super speed non-burst modes.
     * For super speed burst mode of operation, the buffers will be
     * 1024 * burst length so that a full burst can be completed.
     * This will mean that a buffer will be available only after it
     * has been filled or when a short packet is received. */
    dmaCfg.size = size;

    /* Number of DMA buffers to be used. More buffers can give better throughput. */
    dmaCfg.count = 1;

    dmaCfg.prodSckId = ZEABUS_DMA_EP_USB_DEBUG_PRODUCER_SOCKET;
    dmaCfg.consSckId = CY_U3P_CPU_SOCKET_CONS;
    dmaCfg.dmaMode = CY_U3P_DMA_MODE_BYTE;
    /* Call-back is nor working as the system wait until the buffer has beed fully filled.
     * This makes the last chunk of data, which has the size less than a full block, stays waiting
     * and cannot arrived at the destination
     */
    dmaCfg.notification = 0;
    dmaCfg.cb = NULL;
    dmaCfg.prodHeader = 0;
    dmaCfg.prodFooter = 0;
    dmaCfg.consHeader = 0;
    dmaCfg.prodAvailCount = 0;

    apiRetStatus = CyU3PDmaChannelCreate( &xDMAChHandleDbgBulkIngress, CY_U3P_DMA_TYPE_MANUAL_IN, &dmaCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Create a DMA MANUAL_OUT channel for the consumer socket. */
    dmaCfg.prodSckId = CY_U3P_CPU_SOCKET_PROD;
    dmaCfg.consSckId = ZEABUS_DMA_EP_USB_DEBUG_CONSUMER_SOCKET;
    apiRetStatus = CyU3PDmaChannelCreate( &xDMAChHandleDbgBulkEgress, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Create a DMA MANUAL channels Data port. */
    CyU3PMemSet ((uint8_t *)&dmaCfg, 0, sizeof (dmaCfg));
    /* The buffer size will be same as packet size for the
     * full speed, high speed and super speed non-burst modes.
     * For super speed burst mode of operation, the buffers will be
     * 1024 * burst length so that a full burst can be completed.
     * This will mean that a buffer will be available only after it
     * has been filled or when a short packet is received. */
    dmaCfg.size = size;
    if( usbSpeed == CY_U3P_SUPER_SPEED )
        dmaCfg.size *= 4;

    /* Number of DMA buffers to be used. More buffers can give better throughput. */
    dmaCfg.count = 32;

    dmaCfg.prodSckId = ZEABUS_DMA_EP_USB_DATA_PRODUCER_SOCKET;
    dmaCfg.consSckId = CY_U3P_CPU_SOCKET_CONS;
    dmaCfg.dmaMode = CY_U3P_DMA_MODE_BYTE;
    /* Call-back is nor working as the system wait until the buffer has beed fully filled.
     * This makes the last chunk of data, which has the size less than a full block, stays waiting
     * and cannot arrived at the destination
     */
    dmaCfg.notification = 0;
    dmaCfg.cb = NULL;
    dmaCfg.prodHeader = 0;
    dmaCfg.prodFooter = 0;
    dmaCfg.consHeader = 0;
    dmaCfg.prodAvailCount = 0;

    apiRetStatus = CyU3PDmaChannelCreate( &xDMAChHandleDataBulkIngress, CY_U3P_DMA_TYPE_MANUAL_IN, &dmaCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* Create a DMA MANUAL_OUT channel for the consumer socket. */
    dmaCfg.prodSckId = CY_U3P_CPU_SOCKET_PROD;
    dmaCfg.consSckId = ZEABUS_DMA_EP_USB_DATA_CONSUMER_SOCKET;
    apiRetStatus = CyU3PDmaChannelCreate( &xDMAChHandleDataBulkEgress, CY_U3P_DMA_TYPE_MANUAL_OUT, &dmaCfg );
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    /* If the slave FIFO had been started before, then restart it */
    if( bIsSlaveFIFOInited )
    {
        (void)zeabus_slavefifo_start();
    }

    /* Set DMA Channel transfer size */
    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleDbgBulkIngress, 0); /* DMA transfer size is set to infinite */
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleDbgBulkEgress, 0); /* DMA transfer size is set to infinite */
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleDataBulkIngress, 0); /* DMA transfer size is set to infinite */
    if(apiRetStatus != CY_U3P_SUCCESS)
    {
        zeabus_app_err_handler(apiRetStatus);
    }

    apiRetStatus = CyU3PDmaChannelSetXfer(&xDMAChHandleDataBulkEgress, 0); /* DMA transfer size is set to infinite */
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
    CyU3PReturnStatus_t apiRetStatus[6];

    /* Update the flag so that the application thread is notified of this. */
    bIsUSBActive = false;

    /* Destroy the channels */
    CyU3PDmaChannelDestroy (&xDMAChHandleDbgBulkIngress);
    CyU3PDmaChannelDestroy (&xDMAChHandleDbgBulkEgress);
    CyU3PDmaChannelDestroy (&xDMAChHandleDataBulkIngress);
    CyU3PDmaChannelDestroy (&xDMAChHandleDataBulkEgress);

    /* Slave FIFO cut-out */
    bIsSlaveFIFOInited = zeabus_slavefifo_is_started();
    if( bIsSlaveFIFOInited )
    {
        zeabus_slavefifo_stop();
    }

    /* Flush the endpoint memory */
    CyU3PUsbFlushEp(ZEABUS_USB_EP_FPGA_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DATA_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DATA_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_BULKOUT);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_BULKIN);
    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_INTERRUPT);

    /* Disable endpoints. */
    CyU3PMemSet ((uint8_t *)&epCfg, 0, sizeof (epCfg));
    epCfg.enable = CyFalse;

    /* Producer endpoint configuration. */
    apiRetStatus[0] = CyU3PSetEpConfig(ZEABUS_USB_EP_DBG_BULKOUT, &epCfg);
    /* Consumer endpoint configuration. */
    apiRetStatus[1] = CyU3PSetEpConfig(ZEABUS_USB_EP_DBG_BULKIN, &epCfg);
    /* Interrupt endpoint configuration. */
    apiRetStatus[2] = CyU3PSetEpConfig(ZEABUS_USB_EP_DBG_INTERRUPT, &epCfg);
    /* Producer endpoint configuration. */
    apiRetStatus[3] = CyU3PSetEpConfig(ZEABUS_USB_EP_DATA_BULKOUT, &epCfg);
    /* Consumer endpoint configuration. */
    apiRetStatus[4] = CyU3PSetEpConfig(ZEABUS_USB_EP_DATA_BULKIN, &epCfg);
    /* Consumer endpoint configuration. */
    apiRetStatus[5] = CyU3PSetEpConfig(ZEABUS_USB_EP_FPGA_BULKIN, &epCfg);

    /* Whether some errors occured */
    if( (apiRetStatus[0] != CY_U3P_SUCCESS) || (apiRetStatus[1] != CY_U3P_SUCCESS) || (apiRetStatus[2] != CY_U3P_SUCCESS)
        || (apiRetStatus[3] != CY_U3P_SUCCESS) || (apiRetStatus[4] != CY_U3P_SUCCESS) || (apiRetStatus[5] != CY_U3P_SUCCESS) )
    {
        /* Report only one error */
        if(apiRetStatus[0] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[0]);
        if(apiRetStatus[1] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[1]);
        if(apiRetStatus[2] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[2]);
        if(apiRetStatus[3] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[3]);
        if(apiRetStatus[4] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[4]);
        if(apiRetStatus[5] != CY_U3P_SUCCESS)
            zeabus_app_err_handler(apiRetStatus[5]);
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
    uint8_t  bRequest, bReqType;
    uint8_t  bType, bTarget;
    uint16_t wValue, wIndex, wLength, readCount;
    CyBool_t isHandled = CyFalse;

    /* Decode the fields from the setup request. */
    /* For bReqType, 
        bits 0:4 determine recipient as either DEVICE, INTERFACE, ENDPOINT, or OTHER.
        bits 5:6 determine type as either STANDARD, CLASS, VENDOR, or RESERVED.
        bit 7 determine data transfer direction: 0 = Host -> Dev, 1 = Dev -> Host.
    */

    bReqType = (setupdat0 & CY_U3P_USB_REQUEST_TYPE_MASK);
    bType    = (bReqType & CY_U3P_USB_TYPE_MASK);
    bTarget  = (bReqType & CY_U3P_USB_TARGET_MASK);
    bRequest = ((setupdat0 & CY_U3P_USB_REQUEST_MASK) >> CY_U3P_USB_REQUEST_POS);
    wValue   = ((setupdat0 & CY_U3P_USB_VALUE_MASK)   >> CY_U3P_USB_VALUE_POS);
    wIndex   = ((setupdat1 & CY_U3P_USB_INDEX_MASK)   >> CY_U3P_USB_INDEX_POS);
    wLength   = ((setupdat1 & CY_U3P_USB_LENGTH_MASK) >> CY_U3P_USB_LENGTH_POS);

    if(bType == CY_U3P_USB_STANDARD_RQT)
    {
        /* Handle SET_FEATURE(FUNCTION_SUSPEND) and CLEAR_FEATURE(FUNCTION_SUSPEND)
         * requests here. It should be allowed to pass if the device is in configured
         * state and failed otherwise. */
        if((bTarget == CY_U3P_USB_TARGET_INTF) && ((bRequest == CY_U3P_USB_SC_SET_FEATURE)
                    || (bRequest == CY_U3P_USB_SC_CLEAR_FEATURE)) && (wValue == 0))
        {
            if(bIsUSBActive)
                CyU3PUsbAckSetup();
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
                if(wIndex == ZEABUS_USB_EP_DBG_BULKOUT)
                {
                    CyU3PUsbSetEpNak( ZEABUS_USB_EP_DBG_BULKOUT, CyTrue );
                    CyU3PBusyWait (125);

                    CyU3PDmaChannelReset( &xDMAChHandleDbgBulkIngress );
                    CyU3PUsbFlushEp( ZEABUS_USB_EP_DBG_BULKOUT );
                    CyU3PUsbResetEp( ZEABUS_USB_EP_DBG_BULKOUT );
                    CyU3PUsbSetEpNak( ZEABUS_USB_EP_DBG_BULKOUT, CyFalse );

                    CyU3PDmaChannelSetXfer (&xDMAChHandleDbgBulkIngress, 0); /* DMA transfer size is set to infinite */
                    CyU3PUsbStall (wIndex, CyFalse, CyTrue);
                    isHandled = CyTrue;
                    CyU3PUsbAckSetup ();
                }

                if(wIndex == ZEABUS_USB_EP_DBG_BULKIN)
                {
                    CyU3PUsbSetEpNak (ZEABUS_USB_EP_DBG_BULKIN, CyTrue);
                    CyU3PBusyWait (125);

                    CyU3PDmaChannelReset (&xDMAChHandleDbgBulkEgress);
                    CyU3PUsbFlushEp(ZEABUS_USB_EP_DBG_BULKIN);
                    CyU3PUsbResetEp(ZEABUS_USB_EP_DBG_BULKIN);
                    CyU3PUsbSetEpNak(ZEABUS_USB_EP_DBG_BULKIN, CyFalse);

                    CyU3PDmaChannelSetXfer(&xDMAChHandleDbgBulkEgress, 0); /* DMA transfer size is set to infinite */
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
            if( CyU3PUsbGetEP0Data( 7, au8Ep0Buffer, &readCount ) == CY_U3P_SUCCESS )
            {
                if(readCount == 0x07)
                {
                    /* Copy only the baud rate for further reply. The format is alwasy 8N1 */
                    au8LineCoding[0] = au8Ep0Buffer[0];
                    au8LineCoding[1] = au8Ep0Buffer[1];
                    au8LineCoding[2] = au8Ep0Buffer[2];
                    au8LineCoding[3] = au8Ep0Buffer[3];
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
    else if( bType == CY_U3P_USB_VENDOR_RQT )
    {
        // Extract data from request
        u16Ep0WData = wValue;
        u32Ep0DWData = ( (uint32_t)wIndex << 16 );
        u32Ep0DWData += ( (uint32_t)wValue & 0xFFFF );
        isHandled = CyTrue;
        if( wLength > 0 && ( ( bReqType & 0x80 ) == 0 ) )
            CyU3PUsbGetEP0Data( wLength, au8Ep0Buffer, &readCount );

        /* Response to each request */
        switch( bRequest )
        {
            case ZEABUS_USB_REQ_PROG_FPGA:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_USB_PROG_FPGA, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_PROG_BITSTREAM:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_SAVE_FPGA, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_PROG_FIRMWARE:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_SAVE_FIRMWARE, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_SYSTEM_RESET:
                if( u32Ep0DWData == 0x5555AAAA ) // Verify the signature code to prevent error
                    SystemReset();
                break;
            case ZEABUS_USB_REQ_READ_FLASH:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_READ_FLASH, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_WRITE_FLASH:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_WRITE_FLASH, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_READ_EEPROM:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_READ_EEPROM, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_WRITE_EEPROM:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_WRITE_EEPROM, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_SET_SOFT_RESET:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_SET_SOFT_RES, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_RES_SOFT_RESET:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_RES_SOFT_RES, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_SEND_FPGA_DATA:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_SEND_FPGA_DATA, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_FUNC_EN:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_FUNC_EN, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_REQ_FUNC_DIS:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_FUNC_DIS, CYU3P_EVENT_OR );
                break;
            case ZEABUS_USB_RESTART_FIFO:
                CyU3PEventSet( &xZeabusEvent, ZEABUS_EVENT_REQ_RESTART_FIFO, CYU3P_EVENT_OR );
                break;

            default:
                isHandled = CyFalse;     // Unknown command
                break;
        }
        CyU3PUsbAckSetup ();
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
uint16_t zeabus_usb_ep0_wdata( void )
{
    return( u16Ep0WData );
}

uint32_t zeabus_usb_ep0_dwdata( void )
{
    return( u32Ep0DWData );
}

uint8_t* zeabus_usb_ep0_buffer( void )
{
    return( au8Ep0Buffer );
}

uint32_t zeabus_usb_debug_send( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t    buf_p;
    uint32_t            sent, granule;

    sent = 0;
    while( size > 0 )
    {
        /* In this sub-system, the data must be able to be sent without waiting */
        if( CyU3PDmaChannelGetBuffer( &xDMAChHandleDbgBulkEgress, &buf_p, CYU3P_NO_WAIT ) != CY_U3P_SUCCESS )
            break;

        if( size < buf_p.size )
            granule = size;
        else
            granule = buf_p.size;

        /* Transfer data to DMA buffer */
        CyU3PMemCopy( buf_p.buffer, buf, granule );

        if( CyU3PDmaChannelCommitBuffer( &xDMAChHandleDbgBulkEgress, granule, 0 ) != CY_U3P_SUCCESS )
            break;

        /* Update variables */
        size -= granule;
        sent += granule;
        buf += granule;
    }

    return sent;
}

uint32_t zeabus_usb_debug_receive( uint8_t* buf, uint32_t max_size, int32_t wait_time )
{
    CyU3PDmaBuffer_t buf_p;
    uint32_t        count;
    uint32_t        waitOption;

    count = 0;
    if( wait_time == 0 )
        waitOption = CYU3P_NO_WAIT;
    else
    {
        if( wait_time < 0 )
            waitOption = CYU3P_WAIT_FOREVER;
        else
            waitOption = (uint32_t)wait_time;
    }

    /* This is a produce event notification to the CPU. This notification is
     * received upon reception of every buffer.
     */
    if( CyU3PDmaChannelGetBuffer( &xDMAChHandleDbgBulkIngress, &buf_p, waitOption ) == CY_U3P_SUCCESS )
    {
        if( buf_p.count < max_size )
            count = buf_p.count;
        else
            count = max_size;

        CyU3PMemCopy( buf, buf_p.buffer, count );
        /* Finish the receiving, then discard the DMA buffer for next incoming */
        CyU3PDmaChannelDiscardBuffer( &xDMAChHandleDbgBulkIngress );
    }

    return count;
}

uint32_t zeabus_usb_data_send( uint8_t* buf, uint32_t size )
{
    CyU3PDmaBuffer_t    buf_p;
    uint32_t            sent, granule;

    sent = 0;
    while( size > 0 )
    {
        /* In this sub-system, the data must be able to be sent without waiting */
        if( CyU3PDmaChannelGetBuffer( &xDMAChHandleDataBulkEgress, &buf_p, CYU3P_NO_WAIT ) != CY_U3P_SUCCESS )
            break;

        if( size < buf_p.size )
            granule = size;
        else
            granule = buf_p.size;

        /* Transfer data to DMA buffer */
        CyU3PMemCopy( buf_p.buffer, buf, granule );

        if( CyU3PDmaChannelCommitBuffer( &xDMAChHandleDataBulkEgress, granule, 0 ) != CY_U3P_SUCCESS )
            break;

        /* Update variables */
        size -= granule;
        sent += granule;
        buf += granule;
    }

    return sent;
}

uint32_t zeabus_usb_data_receive( uint8_t* buf, uint32_t max_size, int32_t wait_time )
{
    CyU3PDmaBuffer_t buf_p;
    uint32_t        count;
    uint32_t        waitOption;

    count = 0;
    if( wait_time == 0 )
        waitOption = CYU3P_NO_WAIT;
    else
    {
        if( wait_time < 0 )
            waitOption = CYU3P_WAIT_FOREVER;
        else
            waitOption = (uint32_t)wait_time;
    }
    
    /* This is a produce event notification to the CPU. This notification is
     * received upon reception of every buffer.
     */
    if( CyU3PDmaChannelGetBuffer( &xDMAChHandleDataBulkIngress, &buf_p, waitOption ) == CY_U3P_SUCCESS )
    {
        if( buf_p.count < max_size )
            count = buf_p.count;
        else
            count = max_size;

        CyU3PMemCopy( buf, buf_p.buffer, count );
        /* Finish the receiving, then discard the DMA buffer for next incoming */
        CyU3PDmaChannelDiscardBuffer( &xDMAChHandleDataBulkIngress );
    }


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
    if( CyU3PUsbSetDesc(CY_U3P_USB_SET_STRING_DESCR, 3, (uint8_t *)CyFxUSBSerialDscr) != CY_U3P_SUCCESS )
        return false;

    /* Connect the USB Pins with super speed operation enabled. */
    if( CyU3PConnectState( CyTrue, CyTrue ) == CY_U3P_SUCCESS )
        return true;
    else
        return false;
}