import numpy as np
import _thread
import sys
from hydrophone_usb import hydrophone_usb

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
        hp.program_fpga( sys.argv[1] )
    
    # Start logging thread
    #_thread.start_new_thread( logging_thread, (0,) )

    # Main data acquisition loop
    #f = open( 'data.bin', 'wb' )
    hp.release_soft_reset()
    while( True ):
        sig = hp.get_pulse_data( 5000 )
        #f.write( sig )
        #f.flush()

    #f.close()
