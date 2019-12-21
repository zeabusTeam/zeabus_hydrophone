/*
 * Simple libusb-1.0 test programm
 * It openes an USB device, expects two Bulk endpoints,
 *   EP1 should be IN
 *   EP2 should be OUT
 * It alternates between reading and writing a packet to the Device.
 * It uses Synchronous device I/O
 *
 * Compile:
 *   gcc -lusb-1.0 -o test test.c
 * Run:
 *   ./test
 * Thanks to BertOS for the example:
 *   http://www.bertos.org/use/tutorial-front-page/drivers-usb-device
 *
 * For Documentation on libusb see:
 *   http://libusb.sourceforge.net/api-1.0/modules.html
 */
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

#include <signal.h>

//change if your libusb.h is located elswhere
#include <libusb-1.0/libusb.h>
//or uncomment this line:
//#include <libusb.h>
//and compile with:
//gcc -lusb-1.0 -o test -I/path/to/libusb-1.0/ test.c

#include "../zeabus_usb_cmd.h"

#define USB_ENDPOINT_IN     (LIBUSB_ENDPOINT_IN  | 3)   /* endpoint address */
#define USB_ENDPOINT_OUT    (LIBUSB_ENDPOINT_OUT | 3)   /* endpoint address */
#define USB_TIMEOUT         3000        /* Connection timeout (in ms) */

static libusb_context *ctx = NULL;
static libusb_device_handle *handle;

static uint8_t receiveBuf[64];

uint16_t counter=0;

/*
 * Read a packet
 */
static int usb_read(void)
{
    int nread, ret;
    ret = libusb_bulk_transfer(handle, USB_ENDPOINT_IN, receiveBuf, sizeof(receiveBuf),
            &nread, USB_TIMEOUT);
    if (ret){
        printf("ERROR in bulk read: %d\n", ret);
        return -1;
    }
    else{
        printf("%d receive %d bytes from device: %s\n", ++counter, nread, receiveBuf);
        //printf("%s", receiveBuf);  //Use this for benchmarking purposes
        return 0;
    }
}

static uint32_t c = 0;

/*
 * write a few bytes to the device
 *
 */
static int usb_write(uint8_t* buf, uint32_t len)
{
    int n, ret;
    //write transfer
    //probably unsafe to use n twice...
    ret = libusb_bulk_transfer(handle, USB_ENDPOINT_OUT, buf, len,
            &n, USB_TIMEOUT);
    //Error handling
    switch(ret){
        case 0:
            c++;
            printf("seq %u send %d bytes to device\n", c, n);
            return n;
        case LIBUSB_ERROR_TIMEOUT:
            printf("ERROR in bulk write: %d Timeout\n", ret);
            break;
        case LIBUSB_ERROR_PIPE:
            printf("ERROR in bulk write: %d Pipe\n", ret);
            break;
        case LIBUSB_ERROR_OVERFLOW:
            printf("ERROR in bulk write: %d Overflow\n", ret);
            break;
        case LIBUSB_ERROR_NO_DEVICE:
            printf("ERROR in bulk write: %d No Device\n", ret);
            break;
        default:
            printf("ERROR in bulk write: %d\n", ret);
            break;

    }
    return -1;

}

/*
 * on SIGINT: close USB interface
 * This still leads to a segfault on my system...
 */
static void sighandler(int signum)
{
    printf( "\nInterrupt signal received\n" );
    if (handle){
        libusb_release_interface (handle, 0);
        printf( "\nInterrupt signal received1\n" );
        libusb_close(handle);
        printf( "\nInterrupt signal received2\n" );
    }
    printf( "\nInterrupt signal received3\n" );
    libusb_exit(NULL);
    printf( "\nInterrupt signal received4\n" );

    exit(0);
}

int main(int argc, char **argv)
{
    int in;
    uint8_t data[4096];
    ssize_t s;
    uint32_t size;
    int n;

    //Pass Interrupt Signal to our handler
    signal(SIGINT, sighandler);

    libusb_init(&ctx);
    libusb_set_debug(ctx, 3);

    //Open Device with VendorID and ProductID
    handle = libusb_open_device_with_vid_pid(ctx,
                ZEABUS_VENDOR_ID, ZEABUS_PRODUCT_ID);
    if (!handle) {
        perror("device not found");
        return 1;
    }

    //Claim Interface 0 from the device
    n = libusb_claim_interface(handle, 2);
    if (n < 0) {
        fprintf(stderr, "usb_claim_interface error %d\n", n);
        return 2;
    }
    printf("Interface claimed\n");

    in = open( "lightshow.brv", O_RDONLY );
    if( in < 0 )
        return -1;
    printf("Phase1\n");

    size = lseek( in, 0, SEEK_END );
    lseek( in, 0, SEEK_SET );
    libusb_control_transfer(handle,
        LIBUSB_ENDPOINT_OUT | LIBUSB_REQUEST_TYPE_VENDOR | LIBUSB_RECIPIENT_DEVICE,
        ZEABUS_USB_REQ_PROG_BITSTREAM, size >> 16, size & 0xFFFF,
        (unsigned char*)data, 0, 1000);

    n = 0;
    do
    {
        s = read(in, data, 4096);
        if(s > 0)
        {
            n += usb_write(data, s);
            printf("Sum sent %d\n", n);
        }
    }while( s > 0 );
    n = libusb_release_interface(handle, 2);
    if (n < 0) {
        fprintf(stderr, "usb_release_interface error %d\n", n);
        return 2;
    }

//    while (1){
//        usb_read();
//      usb_write();
//    }
    //never reached
    libusb_close(handle);
    libusb_exit(NULL);

    return 0;
}