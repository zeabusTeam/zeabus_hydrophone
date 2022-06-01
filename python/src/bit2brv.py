#!/usr/bin/python3

import os
import sys

def gen_in_out_filename( inputfile ):
    # check whether inputfile has extension.
    x = inputfile.rfind( '.', 1 )
    if x > 0:
        # If yes, out1 = inputfile, out2 = extension-stripped inputfile + .brv
        out1 = inputfile
        out2 = inputfile[0:x] +'.brv'
    else:
        # If no, out1 = inputfile + .bit, out2 = inputfile + .brv
        out1 = inputfile + '.bit'
        out2 = inputfile + '.brv'

    return out1, out2 

def reverse_bit( in_dat ):
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

    return bytes( [rev] )

def skip_a_header( in_file ):
    raw = in_file.read( 2 )     # Reading header size
    if raw:
        len = int( raw[0] )
        len <<= 8 
        len += int( raw[1] )
        print( 'Skip header with size ', len )
        raw = in_file.read( len )

def convert_file( src_name ):
    in_file_name, out_file_name = gen_in_out_filename( src_name )
    in_file = open( in_file_name, 'rb' )
    if in_file is None:
        raise ValueError( 'Unable to open input file' )
    out_file = open( out_file_name, 'wb' )
    if out_file is None:
        in_file.close()
        raise ValueError( 'Unable to create output file' )

    # Field 1
    skip_a_header( in_file )
    # Field 2
    skip_a_header( in_file )
    # Field 3
    skip_a_header( in_file )
    # Field 4
    sig = in_file.read( 1 )
    if( sig != b'b' ):
        in_file.close()
        out_file.close()
        raise ValueError( 'Invalid file format signature "b" becomes ', chr(sig) )
    skip_a_header( in_file )
    # Field 5
    sig = in_file.read( 1 )
    if( sig != b'c' ):
        in_file.close()
        out_file.close()
        raise ValueError( 'Invalid file format signature "c" becomes ', chr(sig) )
    skip_a_header( in_file )
    # Field 6
    sig = in_file.read( 1 )
    if( sig != b'd' ):
        in_file.close()
        out_file.close()
        raise ValueError( 'Invalid file format signature "d" becomes ', chr(sig) )
    skip_a_header( in_file )
    # Field 7
    sig = in_file.read( 1 )
    if( sig != b'e' ):
        in_file.close()
        out_file.close()
        raise ValueError( 'Invalid file format signature "e" becomes ', chr(sig) )
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
    extra = 0
    byte = in_file.read( 1 )
    while byte:
        rev = reverse_bit( byte )
        out_file.write( rev )
        byte = in_file.read( 1 )
        if bitlen > 0:
            bitlen -= 1
        else:
            extra += 1
    in_file.close()
    out_file.close()

    # Print final report
    print( 'Length value remaining ', bitlen, ' bytes and extra length ', extra, ' bytes' )

# Main part
if __name__ == '__main__':

    # Check argument
    if len( sys.argv ) != 2:
        print( 'Usage: python3 bit2brv.py filename[.bit]' )
        sys.exit()
    
    convert_file( sys.argv[1] )
