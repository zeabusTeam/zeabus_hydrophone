#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>

int main(void)
{
    int in, out;
    int count;
    uint8_t data, rev_data;
    ssize_t s;

    in = open( "lightshow.bin", O_RDONLY );
    if( in < 0 )
        return -1;
    out = open( "lightshow.brv", O_WRONLY | O_CREAT );
    if( out < 0 )
    {
        close( in );
        return -1;
    }

    do
    {
        s = read(in, &data, 1);
        if(s > 0)
        {
            rev_data = data;
            count = 7;
            data >>= 1;  
            while( data != 0 ) 
            { 
                rev_data <<= 1;        
                rev_data |= data & 1; 
                data >>= 1; 
                count--; 
            } 
            rev_data <<= count; 

            write(out, &rev_data, 1);            
        }
    }while( s > 0 );

    close(in);
    close(out);
    return 0;
}