import numpy as np
import _thread
import sys
from hydrophone_usb import hydrophone_usb, bit_brv_conv
import usb.core
import time
import ctypes

def logging_thread( id ):
    # Open log files
    dbg_file = open( 'hydrophone.log', 'ab' )
    dbg_incoming = open( '/dev/tty.usbmodemAKP2020011', 'rb' )

    while( True ):
        data = dbg_incoming.read(1)
        dbg_file.write( data )

    # Shuold not be here
    dbg_file.close()
    dbg_incoming.close()

# Main part
if __name__ == '__main__':
    hp = hydrophone_usb()
    if not hp.is_ready():
        print( 'Unable to open hydrophone device' )
        sys.exit()

    # Check whether a file name is provided
    if len( sys.argv ) == 2:
        # Then write that file to FPGA
        src_name = hp.verify_filename( sys.argv[1] )
        if src_name is None:
            print( 'File name ' + sys.argv[1] + ' does not exist' )
            sys.exit()

        bbconv = bit_brv_conv()
        if bbconv.is_bit_file( src_name ):
            bstream = bbconv.get_brv_stream( src_name )
            print(len(bstream))
            hp.program_stream_fpga( bstream )
        else:
            hp.program_file_fpga( src_name )

    # Start logging thread
    #_thread.start_new_thread( logging_thread, (0,) )

    # Main data acquisition loop
    # We record only the first MaxRec trigs packet to the file
    MaxRec = 1
    reccount = 0
    print( 'Start acquisition' )
    f = open( 'data.bin', 'wb' )
    hp.release_soft_reset()
    hp.sent_dsp_param( 0.0001, 0.1)
    hp.set_function_enable_pin()
    while( True ):
        try:
            seq, timestamp, sig = hp.get_pulse_data( 5000 )
            if( len(sig) == 0):
                print( 'Unable to get valid data for a while' )
            else:
                print( f'Got sequence {seq} with time {timestamp} and data length {len(sig)}' )
                if reccount < MaxRec:
                    for item in sig:
                        f.write( ctypes.c_ushort(item) )
                    f.flush()
                    reccount = reccount + 1
        except usb.core.USBTimeoutError:
            print( 'Missing a pulse for 5 seconds now' )
        except KeyboardInterrupt:
            hp.arm_soft_reset()
            f.close()
            sys.exit()
        except BaseException as err:
            hp.arm_soft_reset()
            print( f'Unexpected {err=}, {type(err)=}' )
            sys.exit()
            #
