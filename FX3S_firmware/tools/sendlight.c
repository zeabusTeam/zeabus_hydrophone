#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

int main(void)
{
    int in, out;
    int count;
    uint8_t data[4096], buf[4096];
    ssize_t s, u;
    int i;

    in = open( "lightshow.brv", O_RDONLY );
    if( in < 0 )
        return -1;
    printf("Phase1\n");
    out = open( "/dev/cu.usbmodem14601", O_RDWR | O_NOCTTY );
    if( out < 0 )
    {
        printf("Unable to open USB\n");
        close( in );
        return -1;
    }

    i = 1;
    printf("Start\n");
    do
    {
        s = read(in, data, 4096);
        if(s > 0)
        {
            write(out, data, s);
            printf("%d Write %zd bytes\n", i, s);
        }
    }while( s > 0 );
    do
    {
        // Wait for response
        s = read(out, buf, 4096);
        if( s <= 0 )
        {
            printf("Error\n");
        }
        else
        {
            printf("%s", buf);
        }

    }while(s > 0);

    close(in);
    close(out);
}
