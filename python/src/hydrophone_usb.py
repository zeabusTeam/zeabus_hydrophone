import usb.core
import usb.util
import numpy as np
import os
import sys

"""
Zeabus hydrophone main module is composed of Cypress FX3S USB interface and 
Xilinx Artix7 FPGA chip. The analog module has two AD9248 ADC chips and two
MAX5387 digitally controled potentiometers. The system supports 4 hydrophones
with final sampling rate 1 MS/s. Each hydrophone input is buffered and amplified
with variable gain. The amplifier gain is controlled via varying the value
of a MAX5387 channel. The gain could be chosen from 1 to 11 with 256 steps
resolution. Output from the amplifier should be configured to be within 2 Vp-p.
The amplified signal is then converted into 14-bit 2'complement digital values
by the ADC chip. The ADC is set to sample data at the fixed rate of 64 MS/s.
The data, then, enter the FPGA chip and pass through an averaging filter, 
which provides the effective conversion rate at 1 MS/s. The filter also 
extends the resolution of data from 14-bit 2'complement values to 16-bit 
Q13.2 fixed-point values. Optional further filterings could be applied at
this step before passing to trigger-detection module. However, currently, 
there is none. The data stream from averaging filter is just delivered 
for detecting the value (aka. signal strength) that greater than a specified
level. If the trigger condition is met, the stream data that satisfied 
the trigger is send out of FPGA to FX3S along with the 1000 sampled data
prior to the point that trig. FX3S just relays the data to host computer
via USB3 connection. Each hydrophone has its own hardware for the above
steps. Moreover, all hydrophone functional units operate by a common
clock generator. Therefore, each sampling gives out a 64-bit datum composing
of 4 16-bit data from each channel. The only common to all flows is 
the trigger level, which is a 16-bit Q13.2 value.

Setting the common trigger level as well as the amplifier gain of each
channel is done by host computer sending a specific pattern of data
to FX3S, which relays the configuration data to FPGA. 

The USB3 interface to FX3S is configured to have VENDOR_ID = 0x1209 and
PRODUCT_ID = 0xDCB0. The connection has 4 interfaces with the end-points
and configuration as:

 Control interface: End-point 0: EP0 (INTR_IN + INTR_OUT). This end-point
   is mandatory for all USB devices. It is used to pass all USB control
   protocol. Zeabus hydrophone also uses this end-point to pass commands
   and some short arguments through vendor-request command type.
   Lengthy arguments go through end-point 3 residing in interface 2.

 Interface 0 and 1: Appear to the host computer as a communication port.
   These interfaces are used for debug and logging communication. They
   appear as a /dev/usb.modem device under Linux

 Interface 2: This is the main data communication between host computer
   and the module. There are 2 end-points. They are bulk-mode data channels 
   configured as:
     EP3 -  Bi-directional (EP3 BULK-IN and EP3 BULK-OUT). It is used 
       to transfer data to FX3S sub-system. All configurations and 
       bulky configuration data to the hydrophone module are communicated 
       through this end-point
     EP4 - Unidirectional (EP4 BULK-IN). It conveys only the ADC sampling 
       streams to host computer.

When plugged in to the host computer. The module automatically appears to
the host as a communication device (/dev/usb.modem). However, the main
functions require interface 3, which can only be used from low-level 
directly manipulation. It can be done through either libusb-1 or PyUsb module.

Communication packet formats are defined as:
- ADC stream (USB EP4): 
    2 bytes: ID (fixed as 0xDCB0)
    2 bytes sequence: packet counter value. Maximum value is wrapped to 0 when counted.
    4 bytes time stamp: time since the system starts in milli-second. The maximum
        value is wrapped to 0 when counted. (It takes 46 days of continuous running to
        overflow!!!)
    n * 4 bytes: stream of "n" sampled data that satisfied the trigger

- Trigger and gain setting (Control):
    2 bytes: ID (fixed as 0xDCB0)
    2 bytes: Bit-fields indicates which configuration to set. This field also indicates
        what data would follow. Each bit has meaning as:
            bit 15: 1 = enable trigger level setting
            bit 14: 1 = enable amplifier gains setting
            bit 13 - bit 0: (Unused)
    2 bytes: New trigger level. (Exists only when 15th bit of the bit-field is set)
    4 bytes: New amplifier gain for each channel. Each channel can have it gain different
        from others. (Thie field exists only when 14th bit of the bit-field is set)

- Module control (USB EP0): (This end-point is accessed by control_transfer function)

"""

# ID for Zeabus hydrophone module
VENDOR_ID = 0x1209
PRODUCT_ID = 0xDCB0

# USB Request Type
ZEABUS_USB_REQ_TYPE = (usb.util.CTRL_RECIPIENT_DEVICE | usb.util.CTRL_TYPE_VENDOR)

# USB Vendor requests
# All data, except FPGA direct data, are sended through ZEABUS_EP_DATA_*
ZEABUS_USB_REQ_PROG_FPGA = (0xA0)       # Request for FPGA programming directly from USB
ZEABUS_USB_REQ_PROG_BITSTREAM = (0xA1)  # Request to save an FPGA bitstream to SPI flash
ZEABUS_USB_REQ_PROG_FIRMWARE = (0xA2)   # Request to save new firmware to SPI flash
ZEABUS_USB_REQ_SYSTEM_RESET = (0xA3)    # Request to restart the whole system
ZEABUS_USB_REQ_READ_FLASH = (0xA4)      # Request for raw data from SPI flash
ZEABUS_USB_REQ_WRITE_FLASH = (0xA5)     # Write raw data to SPI flash
ZEABUS_USB_REQ_READ_EEPROM = (0xA6)     # Request for raw data from EEPROM (wValue = (bLen << 8) + bAddr)
ZEABUS_USB_REQ_WRITE_EEPROM = (0xA7)    # Write raw data to EEPROM (wValue = (bLen << 8) + bAddr)
ZEABUS_USB_REQ_ARM_SOFT_RESET = (0xA8)  # Arm FPGA soft reset
ZEABUS_USB_REQ_REL_SOFT_RESET = (0xA9)  # Release FPGA soft reset
ZEABUS_USB_REQ_SEND_FPGA_DATA = (0xAA)  # Send data to FPGA through slave FIFO

# Endpoints
ZEABUS_EP_DATA_IN = (usb.util.ENDPOINT_IN | 3)
ZEABUS_EP_DATA_OUT = (usb.util.ENDPOINT_OUT | 3)
ZEABUS_EP_FPGA_IN = (usb.util.ENDPOINT_IN | 4)

# For bReqType in control_transfer, 
#   bits 0:4 determine recipient as either DEVICE, INTERFACE, ENDPOINT, or OTHER.
#   bits 5:6 determine type as either STANDARD, CLASS, VENDOR, or RESERVED.
#   bit 7 determine data transfer direction: 0 = Host -> Dev, 1 = Dev -> Host.

class hydrophone_usb:
  """
  The usb communication to interface with hydrophone v3
  """

  def __init__( self ):
    # find our device
    self.dev = usb.core.find( idVendor=VENDOR_ID, idProduct=PRODUCT_ID )
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
        
    # Activate the only configuration available
    self.dev.set_configuration()

  def get_pulse_data( self, timeout = 900000 ): # Reading with default timeout = 15 minutes
    buffer = self.dev.read( ZEABUS_EP_FPGA_IN, 8192, timeout )
    return buffer
  
  #
  # Extra functions
  #
  def is_ready( self ):
    if self.dev is None:
      return False
    else:
      return True

  def arm_soft_reset( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    # Full function call with prototype for future reference.    
    self.dev.ctrl_transfer( 
      bmRequestType = (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ), # bmRequestType
      bRequest = ZEABUS_USB_REQ_ARM_SOFT_RESET,                   # bRequest
      wValue = 0,                                                 # wValue
      wIndex = 0,                                                 # wIndex
      data_or_wLength = None,                                     # data or length
      timeout = None                                              # timeout
    )

  def release_soft_reset( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
        
    self.dev.ctrl_transfer( 
      (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ), # bmRequestType
      ZEABUS_USB_REQ_REL_SOFT_RESET,              # bRequest
      0,                                          # wValue
      0,                                          # wIndex
      None,                                       # data or length
      None                                        # timeout
    )

  def __send_file( self, request_cmd, filepath ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
        
    fsize = os.path.getsize( filepath )
    print( 'Sending file ', filepath, ' with size ', fsize, ' byte' )
    if fsize > 0:
      offset = 0
      f = open( filepath, 'rb' )
      if f is not None:
        # Start the command
        self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
          request_cmd, wValue=(fsize & 0xFFFF), wIndex=(fsize >> 16), timeout=1000 )
        
        # Sending data
        while( offset < fsize ):
          print( 'From offset ', offset, ' : ', end='' )
          data = f.read( 4096 )
          sent_size = self.dev.write( ZEABUS_EP_DATA_OUT, data, 1000 )
          offset = offset + sent_size
          if sent_size < len(data):
            # We cannot send the whole data. Thus, adjusting the file pointer
            f.seek( offset )
          print( 'Sent ', sent_size, ' bytes.' )
        
        f.close()
      else:
          raise ValueError( 'Unable to open file' )
    else:
      raise ValueError( 'Unable to get file size' )
  
  def __send_stream( self, request_cmd, data ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
        
    fsize = len(data)
    print( 'Sending stream with size ', fsize, ' byte' )
    if fsize > 0:
      offset = 0
      # Start the command
      self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
        request_cmd, wValue=(fsize & 0xFFFF), wIndex=(fsize >> 16), timeout=1000 )
        
      # Sending data
      while( offset < fsize ):
        print( 'From offset ', offset, ' : ', end='' )
        sent_size = self.dev.write( ZEABUS_EP_DATA_OUT, data[offset:], 1000 )
        offset = offset + sent_size
        print( 'Sent ', sent_size, ' bytes.' )
    else:
      raise ValueError( 'Unable to get file size' )
  
  def program_fpga( self, filepath ):
    self.__send_file( ZEABUS_USB_REQ_PROG_FPGA, filepath )
  
  def write_firmware_to_flash( self, filepath ):
    self.__send_file( ZEABUS_USB_REQ_PROG_FIRMWARE, filepath )
  
  def write_fpga_to_flash( self, filepath ):
    self.__send_file( ZEABUS_USB_REQ_PROG_BITSTREAM, filepath )
  
  def send_data_to_fpga( self, data ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
    # Issue the command
    size = data.size
    self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
      ZEABUS_USB_REQ_SEND_FPGA_DATA, wValue=(size & 0xFFFF), wIndex=(size >> 16), 
      data_or_wLength=data, timeout=1000 )

  def invalidate_fpga_image( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    blank = np.zeros( 8, dtype=np.uint8 )
    # Start the command
    self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
      ZEABUS_USB_REQ_WRITE_EEPROM, wValue=0x0870, wIndex=0, timeout=1000 )
    self.dev.write( ZEABUS_EP_DATA_OUT, blank, 1000 )

# Main part
if __name__ == '__main__':
  # Check argument
  if len( sys.argv ) != 2:
    print( 'ERROR!!! This module should not run as standalone without argument' )
    print( '  Usage: python3 hydrophone_usb.py filename[.brv]' )
    sys.exit()
  hp = hydrophone_usb()
  if not hp.is_ready():
    print( 'Unable to open hydrophone device' )
    sys.exit()
  # Then write that file to FPGA
  hp.program_fpga( sys.argv[1] )
