/****************************************************************************
 * zeabus_error.c
 *
 * Zeabus firmware for EZ-USB FX3 Microcontrollers
 * Copyright (C) 2019-2020 Zeabus Term, Kasetsart University.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name NuttX nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/
#include <cyu3system.h>
#include <cyu3os.h>
#include <cyu3dma.h>
#include <cyu3usb.h>
#include <cyu3utils.h>
#include <cyu3externcend.h>

#include "zeabus.h"
#include "zeabus_error.h"
#include "zeabus_gpio.h"
#include "zeabus_usb.h"

// For output formatting
#define PAD_RIGHT 1
#define PAD_ZERO 2

#define BUF_SIZE    16
/************************************************************************************
 * Private Data
 ************************************************************************************/
static char tbuf[BUF_SIZE];
static uint32_t tbuf_p = 0;
/************************************************************************************
 * Private Functions
 ************************************************************************************/
// Flush the log output buffer to USB
static void zeabus_app_flushc( void )
{
    if( tbuf_p > 0 )
    {
        zeabus_usb_debug_send( (uint8_t*)tbuf, tbuf_p );
        tbuf_p = 0;
    }
}

/* Add an output character to the output buffer and send it to USB if full
 * This function is required by printf library.
 */
void _putchar( char c )
{
    tbuf[tbuf_p] = c;
    tbuf_p++;
    if( tbuf_p >= BUF_SIZE )
        zeabus_app_flushc();
}

/************************************************************************************
 * Public API Functions
 ************************************************************************************/
void zeabus_app_err_vlog( const char *pre, char *fmt, va_list ap )
{
    printf( "%s : ", pre );
    vprintf( fmt, ap );
    zeabus_app_flushc();
}

void zeabus_app_err_log( const char *pre, char *fmt, ... )
{
  va_list ap;

  /* Then let zeabus_app_err_vlog do the real work */
  va_start( ap, fmt );
  zeabus_app_err_vlog( pre, fmt, ap );
  va_end( ap );
}

void zeabus_app_err_handler( uint32_t error )
{
    /* Application failed with the error code apiRetStatus */

    /* Add custom debug or recovery actions here */
    /* Loop Indefinitely */
    for (;;)
    {
        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, true);
        /* Thread sleep : 100 ms */
        CyU3PThreadSleep (250);
        (void)zeabus_gpiowrite(ZEABUS_GPIO_LED, false);
        /* Thread sleep : 100 ms */
        CyU3PThreadSleep (200);
    }
}
