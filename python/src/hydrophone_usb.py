import usb.core     # Requires PyUSB package
import usb.util
#from usb.core import USBTimeoutError, USBError
import numpy as np
import struct
import os
import sys
import time

# This file is the core library to communicate with the hydrophone DSP board.

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
Q13.2 fixed-point values. Optional filterings could be applied at
this step before passing to trigger-detection module. However, currently,
there is none. The data stream from averaging filter is just delivered
for detecting the trigger (aka. signal strength) that is greater than a specified
level. If the trigger condition is met, the stream data that satisfied
the trigger is send out of FPGA to FX3S along with the 64 sampled data
prior to the point that trig. FX3S just relays the data to host computer
via USB3 connection. Each hydrophone has its own hardware for the above
steps. All hydrophone functional units operate by a common
clock generator. Therefore, each sampling gives out a 64-bit datum composing
of 4 16-bit data from each channel. The trigger threshold is common for
all 4 channels, which is a 16-bit Q13.2 value.

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

- Trigger, pinger frequency, and gain setting (Control):
    1 byte: ID + Configuration bits (fixed as 0xDC)
    1 byte: Configuration bit fields
        The configuraton bits are Bit-fields indicates which configuration to set.
        This field also indicates what data would follow. Each bit has meaning as:
            bit 7 - bit 4: pinger frequency (0 = 25kHz -> 15 = 40kHz in 1kHz steps)
            bit 3: 1 = enable trigger level setting
            bit 2: 1 = enable amplifier gains setting
            bit 1 - bit 0: (Unused)
    2 bytes: New trigger level. (Exists only when 3rd bit of the prefix is set)
    4 bytes: New amplifier gain for each channel. Each channel can have it gain different
        from others. (Thie field exists only when 2nd bit of the prefix is set)

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
ZEABUS_USB_REQ_SET_SOFT_RESET = (0xA8)  # Arm FPGA soft reset
ZEABUS_USB_REQ_RES_SOFT_RESET = (0xA9)  # Release FPGA soft reset
ZEABUS_USB_REQ_SEND_FPGA_DATA = (0xAA)  # Send data to FPGA through slave FIFO
ZEABUS_USB_REQ_FUNC_EN_SET = (0xAB)     # Set function-enable pin
ZEABUS_USB_REQ_FUNC_EN_RES = (0xAC)     # Reset function-enable pin

# Endpoints
ZEABUS_EP_DATA_IN = (usb.util.ENDPOINT_IN | 3)
ZEABUS_EP_DATA_OUT = (usb.util.ENDPOINT_OUT | 3)
ZEABUS_EP_FPGA_IN = (usb.util.ENDPOINT_IN | 4)

# For bReqType in control_transfer,
#   bits 0:4 determine recipient as either DEVICE, INTERFACE, ENDPOINT, or OTHER.
#   bits 5:6 determine type as either STANDARD, CLASS, VENDOR, or RESERVED.
#   bit 7 determine data transfer direction: 0 = Host -> Dev, 1 = Dev -> Host.

class bit_brv_conv:
  """
  Class to conver .bit file into brv stream
  """

  def __reverse_bit( self, in_dat ):
    dat = int( in_dat[0] )
    rev = dat
    count = 7
    dat >>= 1
    while dat != 0:
      rev <<= 1
      rev |= dat & 1
      dat >>= 1
      count -= 1
    rev <<= count
    rev &= 0xFF

    return rev

  def __skip_a_header( self, in_file ):
    raw = in_file.read( 2 )     # Reading header size
    if raw:
      len = int( raw[0] )
      len <<= 8
      len += int( raw[1] )
      print( 'Skip header with size ', len )
      raw = in_file.read( len )

  def is_bit_file( self, src_name ):
    in_file = open( src_name, 'rb' )
    if in_file is None:
      return False

    # Verify the input file
    # Field 1
    self.__skip_a_header( in_file )
    # Field 2
    self.__skip_a_header( in_file )
    # Field 3
    self.__skip_a_header( in_file )
    # Field 4
    sig = in_file.read( 1 )
    if( sig != b'b' ):
      in_file.close()
      return False
    self.__skip_a_header( in_file )
    # Field 5
    sig = in_file.read( 1 )
    if( sig != b'c' ):
      in_file.close()
      return False
    self.__skip_a_header( in_file )
    # Field 6
    sig = in_file.read( 1 )
    if( sig != b'd' ):
      in_file.close()
      return False
    self.__skip_a_header( in_file )
    # Field 7
    sig = in_file.read( 1 )
    in_file.close()
    if( sig != b'e' ):
      return False

    return True

  def get_brv_stream( self, src_name ):
    in_file = open( src_name, 'rb' )
    if in_file is None:
      raise ValueError( 'Unable to open input file' )

    # Verify the input file
    # Field 1
    self.__skip_a_header( in_file )
    # Field 2
    self.__skip_a_header( in_file )
    # Field 3
    self.__skip_a_header( in_file )
    # Field 4
    sig = in_file.read( 1 )
    if( sig != b'b' ):
      in_file.close()
      raise ValueError( 'Invalid file format signature "b" becomes ', chr(sig) )
    self.__skip_a_header( in_file )
    # Field 5
    sig = in_file.read( 1 )
    if( sig != b'c' ):
      in_file.close()
      raise ValueError( 'Invalid file format signature "c" becomes ', chr(sig) )
    self.__skip_a_header( in_file )
    # Field 6
    sig = in_file.read( 1 )
    if( sig != b'd' ):
      in_file.close()
      raise ValueError( 'Invalid file format signature "d" becomes ', chr(sig) )
    self.__skip_a_header( in_file )
    # Field 7
    sig = in_file.read( 1 )
    if( sig != b'e' ):
      in_file.close()
      raise ValueError( 'Invalid file format signature "e" becomes ', chr(sig) )

    # Processing the data
    raw = in_file.read( 4 )
    bitlen = int( raw[0] )
    bitlen <<= 8
    bitlen += int( raw[1] )
    bitlen <<= 8
    bitlen += int( raw[2] )
    bitlen <<= 8
    bitlen += int( raw[3] )

    # Processing data
    print( 'The input bitstream length = ' , bitlen )
    out_stream = bytearray(bitlen)      # Generate an empty byte stream
    idx = 0
    byte = in_file.read( 1 )
    while byte and idx < bitlen:
      rev = self.__reverse_bit( byte )
      out_stream[idx] = rev
      idx = idx + 1
      byte = in_file.read( 1 )
    in_file.close()
    print( 'Finish convert ' + str(idx) + ' bytes' )

    # Print final report
    return( out_stream )

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
    
    # Detach kernel driver from interface 2 (the custom interface)
    if self.dev.is_kernel_driver_active(2):
      try:
        self.dev.detach_kernel_driver(2)
      except usb.core.USBError as e:
        sys.exit("Could not detatch kernel driver from interface({0}): {1}".format(i, str(e)))

  #
  # Low-level API functions
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
      bRequest = ZEABUS_USB_REQ_SET_SOFT_RESET,                   # bRequest, set the RST to 1
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
      ZEABUS_USB_REQ_RES_SOFT_RESET,              # bRequest, reset the RST to 0
      0,                                          # wValue
      0,                                          # wIndex
      None,                                       # data or length
      None                                        # timeout
    )

  def set_function_enable_pin( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    self.dev.ctrl_transfer(
      (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ), ZEABUS_USB_REQ_FUNC_EN_SET,
      0, 0, None, None )
 
  def reset_function_enable_pin( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    self.dev.ctrl_transfer(
      (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ), ZEABUS_USB_REQ_FUNC_EN_RES,
      0, 0, None, None )

  def fx3s_reset( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    self.dev.ctrl_transfer(
      (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ), ZEABUS_USB_REQ_SYSTEM_RESET,
      0, 0, None, None )

  def invalidate_fpga_image( self ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')

    blank = np.zeros( 8, dtype=np.uint8 )
    # Start the command
    self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
      ZEABUS_USB_REQ_WRITE_EEPROM, wValue=0x0870, wIndex=0, timeout=1000 )
    self.dev.write( ZEABUS_EP_DATA_OUT, blank, 1000 )

  def verify_filename( self, src_name ):
    try:
      f = open( src_name, 'rb' )
      if f is not None:
        f.close()
        return src_name
    except:
      pass

    try:
      f = open( src_name + '.brv', 'rb' )
      if f is not None:
        f.close()
        return src_name + '.brv'
    except:
      pass

    try:
      f = open( src_name + '.bit', 'rb' )
      if f is not None:
        f.close()
        return src_name + '.bit'
    except:
      pass

    return None

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
          request_cmd, wValue=(fsize & 0xFFFF), wIndex=(fsize >> 16), timeout=5000 )

        # Sending data
        while( offset < fsize ):
          print( 'From offset ', offset, ' : ', end='' )
          data = f.read( 4096 )
          sent_size = self.dev.write( ZEABUS_EP_DATA_OUT, data, 5000 )
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
        request_cmd, wValue=(fsize & 0xFFFF), wIndex=(fsize >> 16), timeout=5000 )

      # Sending data
      while( offset < fsize ):
        print( 'From offset ', offset, ' : ', end='' )
        sent_size = self.dev.write( ZEABUS_EP_DATA_OUT, data[offset:], 5000 )
        offset = offset + sent_size
        print( 'Sent ', sent_size, ' bytes.' )
    else:
      raise ValueError( 'Stream length must be greater than 0' )

  def program_file_fpga( self, filepath ):
    # Disable all current functions
    self.arm_soft_reset()
    self.reset_function_enable_pin()

    print( 'Write FPGA file ' + filepath + ' to FPGA' );
    self.__send_file( ZEABUS_USB_REQ_PROG_FPGA, filepath )

  def program_stream_fpga( self, data ):
    # Disable all current functions
    self.arm_soft_reset()
    self.reset_function_enable_pin()

    print( 'Write firmware strem to FPGA' )
    self.__send_stream( ZEABUS_USB_REQ_PROG_FPGA, data )

  def write_firmware_to_flash( self, filepath ):
    print( 'Write firmware file ' + filepath + ' to firmware flash' );
    self.__send_file( ZEABUS_USB_REQ_PROG_FIRMWARE, filepath )

  def write_file_fpga_to_flash( self, filepath ):
    print( 'Write FPGA file ' + filepath + ' to flash' );
    self.__send_file( ZEABUS_USB_REQ_PROG_BITSTREAM, filepath )

  def write_stream_fpga_to_flash( self, data ):
    print( 'Write FPGA strem to flash' )
    self.__send_stream( ZEABUS_USB_REQ_PROG_BITSTREAM, data )

  def send_control_to_fpga( self, data ):
    # was it found?
    if self.dev is None:
      raise ValueError('Device not found')
    # Issue the command
    size = data.size
    print( 'sending control with size ', size, 'wValue=', (size & 0xFFFF), 'wIndex=', (size >> 16))
    self.dev.ctrl_transfer( (ZEABUS_USB_REQ_TYPE | usb.util.CTRL_OUT ),
      ZEABUS_USB_REQ_SEND_FPGA_DATA, wValue=(size & 0xFFFF), wIndex=(size >> 16),
      data_or_wLength=data, timeout=1000 )

  def get_stream_data( self, timeout = 900000 ): # Reading with default timeout = 15 minutes
    buffer = self.dev.read( ZEABUS_EP_FPGA_IN, 8192, timeout )
    return buffer

  #
  # Main API functions
  #

  # Set module parameters.
  # threshold = signal threshold level (Max = 1 means 100%)
  # LNA_Gain_1 = amplifier gain for channel 1 (Max = 1 means maximum)
  # LNA_Gain_2 to LNA_Gain_4 = amplifier gain for channel 2 - 4. The basic conditions are same as channel 1
  #     except that if any of these gain has negative value, gain of the corresponding channel is set to
  #     the same value of channel 1
  def sent_dsp_param( self, threshold = 0, LNA_Gain_1 = -1, LNA_Gain_2 = -1, LNA_Gain_3 = -1, LNA_Gain_4 = -1 ):
    buf_size = 2
    if( threshold > 0 ):
      buf_size = buf_size + 2
    if( LNA_Gain_1 >= 0 ):
      buf_size = buf_size + 4
    if( buf_size == 2 ):
      # Nothig to send
      return
    buffer = np.empty( buf_size, dtype='uint8' )

    # Set ID
    buffer[0] = 0xDC

    # Initialize bit-field
    buffer[1] = 0

    # Set threshold (if exists)
    if( threshold > 0 ):
      buffer[1] = buffer[1] | 0b00001000
      if( threshold > 1 ):
        threshold = 1
      #threshold = threshold & 0xFFFF
      #thres_value = np.uint16( threshold )
      thres_value = np.uint16( threshold * 32767 )
      buffer[2] = np.uint8( thres_value >> 8 )
      buffer[3] = np.uint8( thres_value & 0xFF )
      print(f'Threshold {thres_value} with msb = {buffer[2]:X}, lsb = {buffer[3]:X}')
      gain_index = 4
    else:
      gain_index = 2

    # Set Gain (if exists)
    if( LNA_Gain_1 > 1 ):
      LNA_Gain_1 = 1
    if( LNA_Gain_2 > 1 ):
      LNA_Gain_2 = 1
    if( LNA_Gain_3 > 1 ):
      LNA_Gain_3 = 1
    if( LNA_Gain_4 > 1 ):
      LNA_Gain_4 = 1
    
    if( LNA_Gain_1 >= 0 ):
      buffer[1] = buffer[1] | 0b00000100

      buffer[gain_index] = np.uint8( 255 * LNA_Gain_1 )

      gain_index = gain_index + 1
      if( LNA_Gain_2 >= 0):
        buffer[gain_index] = np.uint8( 255 * LNA_Gain_2 )
      else:
        buffer[gain_index] = buffer[4]

      gain_index = gain_index + 1
      if( LNA_Gain_3 >= 0):
        buffer[gain_index] = np.uint8( 255 * LNA_Gain_3 )
      else:
        buffer[gain_index] = buffer[4]

      gain_index = gain_index + 1
      if( LNA_Gain_4 >= 0):
        buffer[gain_index] = np.uint8( 255 * LNA_Gain_4 )
      else:
        buffer[gain_index] = buffer[4]

    # Send the buffer to FPGA through control endpoint
    self.send_control_to_fpga( buffer )

    # Delay a bit for FX3S to process the request
    time.sleep(0.005)

  def get_pulse_data( self, timeout ):
    # Loop for 10 times reading
    _err_count = 0
    while( _err_count < 100 ):
      buffer = self.get_stream_data( timeout )
      if( len(buffer) > 0 ):
        if( buffer[0] == 0xDC and buffer[1] == 0xB0 ):
          seq = int( struct.unpack( '>H', buffer[2:4] )[0] )        # Slicing includes the start index but excludes the end index
          timestamp = int( struct.unpack( '>L', buffer[4:8] )[0] )
          payload_len = int( len( buffer[8:] ) / 2 )
          raw = struct.unpack( f'>{payload_len}h', buffer[8:] )     # Remove the preemble
          return seq, timestamp, raw
          
      _err_count = _err_count + 1   # Reaching here means the packet is invalid
      if(len(buffer) == 0):
        print('Got an empty packet')
      else:
        print(f'Got an incorrect packet with id {buffer[0]:X}, and {buffer[1]:X}')

    # If reach here, the error count have reached 100
    # We return empty signal with sequence number and time stamp equal to 0
    #raise IOError( 'Too much error data from ADC' )
    return 0, 0, tuple()


# Main part
if __name__ == '__main__':
  # Check argument
  if len( sys.argv ) != 2 and len( sys.argv ) != 3:
    print( 'ERROR!!! This module should not run as standalone without argument' )
    print( '  Usage: python3 hydrophone_usb.py CMD' )
    print( '     CMD    command to DSP board' )
    print( '        fx3s filename[.bin]        Write FX3S firmware to firmware ROM' )
    print( '        prog filename[.bit/.brv]   Write an FPGA image directly to the FPGA chip' )
    print( '        burn filename[.bit/.brv]   Write an FPGA image to firmware ROM' )
    print( '        inval                      Invalidate FGPA image in firmware ROM' )
    print( '        reset                      Issue a reset pulse to FPGA' )
    print( '        setrst                     Set reset signal to FPGA' )
    print( '        resrst                     Clear reset signal to FPGA' )
    sys.exit()
  hp = hydrophone_usb()
  if not hp.is_ready():
    print( 'Unable to open hydrophone device' )
    sys.exit()

  # Action selection
  if len( sys.argv ) == 2:      # Only command provided
    if sys.argv[1] == 'inval':
      hp.invalidate_fpga_image()
    elif sys.argv[1] == 'reset':
      hp.arm_soft_reset()
      hp.release_soft_reset()
    elif sys.argv[1] == 'setrst':
      hp.arm_soft_reset()
    elif sys.argv[1] == 'resrst':
      hp.release_soft_reset()
    else:
      print( 'Unknown command ' + sys.argv[1] )
  else:
    if sys.argv[1] == 'prog':
      src_name = hp.verify_filename( sys.argv[2] )
      if src_name is None:
        print( 'File name ' + sys.argv[2] + ' does not exist' )
        sys.exit()

      bbconv = bit_brv_conv()
      if bbconv.is_bit_file( src_name ):
        bstream = bbconv.get_brv_stream( src_name )
        hp.program_stream_fpga( bstream )
      else:
        hp.program_file_fpga( src_name )
    elif sys.argv[1] == 'burn':
      src_name = hp.verify_filename( sys.argv[2] )
      if src_name is None:
        print( 'File name ' + sys.argv[2] + ' does not exist' )
        sys.exit()

      bbconv = bit_brv_conv()
      if bbconv.is_bit_file( src_name ):
        bstream = bbconv.get_brv_stream( src_name )
        hp.write_stream_fpga_to_flash( bstream )
      else:
        hp.write_file_fpga_to_flash( src_name )
    elif sys.argv[1] == 'fx3s':
      hp.write_firmware_to_flash( sys.argv[2] )
    else:
      print( 'Unknown command ' + sys.argv[1] )

