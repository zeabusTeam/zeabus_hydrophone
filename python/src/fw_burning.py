import numpy as np
import _thread
import sys
from hydrophone_usb import hydrophone_usb

# Main part
if __name__ == '__main__':
    hp = hydrophone_usb()
    if not hp.is_ready():
        print( 'Unable to open hydrophone device' )
        sys.exit()

    # Check whether a file name is provided
    if len( sys.argv ) == 2:
        # Then write that file to FPGA
        hp.write_firmware_to_flash( sys.argv[1] )
    else:
        print( 'Usage: python fw_buring.py filename.img')
