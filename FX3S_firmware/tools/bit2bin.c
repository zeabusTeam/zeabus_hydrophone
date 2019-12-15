/* BIT file format is described at:
 * http://www.fpga-faq.com/FAQ_Pages/0026_Tell_me_about_bit_files.htm
 * as:
 * The Xilinx .bit format is pretty simple.  It uses keys and lengths to
 * divide the file.
 * Here is an example.  Below is a hex dump from the beginning of a .bit file:
 * 
 * 00000000:  00 09 0f f0 0f f0 0f f0 0f f0 00 00 01 61 00 0a  *.............a..*
 * 00000010:  78 66 6f 72 6d 2e 6e 63 64 00 62 00 0c 76 31 30  *xform.ncd.b..v10*
 * 00000020:  30 30 65 66 67 38 36 30 00 63 00 0b 32 30 30 31  *00efg860.c..2001*
 * 00000030:  2f 30 38 2f 31 30 00 64 00 09 30 36 3a 35 35 3a  *_08/10.d..06:55:*
 * 00000040:  30 34 00 65 00 0c 28 18 ff ff ff ff aa 99 55 66  *04.e..(.......Uf*
 * 
 * Field 1
 * 2 bytes          length 0x0009           (big endian)
 * 9 bytes          some sort of header
 * 
 * Field 2
 * 2 bytes          length 0x0001
 * 1 byte           key 0x61                (The letter "a")
 * 
 * Field 3
 * 2 bytes          length 0x000a           (value depends on file name length)
 * 10 bytes         string design name "xform.ncd" (including a trailing 0x00)
 * 
 * Field 4
 * 1 byte           key 0x62                (The letter "b")
 * 2 bytes          length 0x000c           (value depends on part name length)
 * 12 bytes         string part name "v1000efg860" (including a trailing 0x00)
 * 
 * Field 5
 * 1 byte           key 0x63                (The letter "c")
 * 2 bytes          length 0x000b
 * 11 bytes         string date "2001/08/10"  (including a trailing 0x00)
 * 
 * Field 6
 * 1 byte           key 0x64                (The letter "d")
 * 2 bytes          length 0x0009
 * 9 bytes          string time "06:55:04"    (including a trailing 0x00)
 * 
 * Field 7
 * 1 byte           key 0x65                 (The letter "e")
 * 4 bytes          length 0x000c9090        (value depends on device type,
 *                                            and maybe design details)
 * 8233440 bytes    raw bit stream starting with 0xffffffff aa995566 sync word
 *
 * Unlike the above data, newer Xilinx tools start the bit-stream with 
 * bus-width detection pattern preceeding the sync word. However, the forecoming
 * header fields are same. We should be noted that the multi-byte data are sotred
 * in big-endian format.
 */

/*
 * This program converts file format from BIT to BIN
 */

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

FILE* in;
FILE* out;

void skip_a_header(void)
{
    uint8_t buf[2];
    uint16_t len;

    if( fread( buf, 1, 2, in ) != 2 )
        return;

    len = (uint16_t)buf[0] << 8;
    len |= (uint16_t)buf[1];
    printf("Skip header length %u bytes : ", len);
    while( len > 0 )
    {
        fread( buf, 1, 1, in );
        printf("%c", buf[0]);
        len--;
    }
    printf("\n");
}

int main(void)
{
    uint8_t s[10];
    uint32_t bitlen, extra;

    if( ( in = fopen( "lightshow.bit", "rb" ) ) == NULL )
        return -1;
    if( ( out = fopen( "lightshow.bin", "wb" ) ) == NULL )
    {
        fclose( in );
        return -1;
    }

    // Field 1
    skip_a_header();
    // Field 2
    skip_a_header();
    // Field 3
    skip_a_header();
    // Field 4
    fread( s, 1, 1, in );
    if( s[0] != 'b' )
    {
        printf("Invalid BIT sig '%c' should be 'b'\n", s[0]);
        fclose(in);
        fclose(out);
        return -1;
    }
    skip_a_header();
    // Field 5
    fread( s, 1, 1, in );
    if( s[0] != 'c' )
    {
        printf("Invalid BIT sig '%c' should be 'c'\n", s[0]);
        fclose(in);
        fclose(out);
        return -1;
    }
    skip_a_header();
    // Field 6
    fread( s, 1, 1, in );
    if( s[0] != 'd' )
    {
        printf("Invalid BIT sig '%c' should be 'd'\n", s[0]);
        fclose(in);
        fclose(out);
        return -1;
    }
    skip_a_header();
    // Field 7
    fread( s, 1, 1, in );
    if( s[0] != 'e' )
    {
        printf("Invalid BIT sig '%c' should be 'e'\n", s[0]);
        fclose(in);
        fclose(out);
        return -1;
    }
    fread( s, 1, 4, in );
    bitlen = (uint32_t)s[0] << 24;
    bitlen |= ((uint32_t)s[1] << 16);
    bitlen |= ((uint32_t)s[2] << 8);
    bitlen |= (uint32_t)s[3];
   
    printf("BitStream length = %u bytes\n", bitlen);

    extra = 0;
    while( !feof(in)  )
    {
        if( fread( s, 1, 1, in ) == 1 )
        {
            fwrite( s, 1, 1, out );
            if(bitlen > 0)
                bitlen--;
            else
                extra++;
        }
    }
    fclose(in);
    fclose(out);

    printf("Length value remaining %u bytes and extra length %u bytes\n", bitlen, extra);

    return 0;
}
