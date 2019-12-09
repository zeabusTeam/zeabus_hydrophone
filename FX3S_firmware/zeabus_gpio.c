/****************************************************************************
 * zeabus_gpio.c
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
#include <cyu3gpio.h>

#include "zeabus.h"

bool zeabus_gpioread( uint8_t io_num )
{
  CyBool_t val;
  CyU3PReturnStatus_t status;

  status = CyU3PGpioSimpleGetValue( io_num, &val );
  if ( ( status != CY_U3P_SUCCESS ) || ( val == CyFalse ) )
    return false;
  else
    return true;
}

bool zeabus_gpiowrite( uint8_t io_num, bool value )
{
  CyU3PReturnStatus_t status;

  if( value )
    status = CyU3PGpioSimpleSetValue( io_num, CyTrue );
  else
    status = CyU3PGpioSimpleSetValue( io_num, CyFalse );

  if ( status != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}

bool zeabus_configgpio_output( uint8_t io_num, bool init_value )
{
  CyU3PGpioSimpleConfig_t cfg;

  if( init_value )
    cfg.outValue    = CyTrue;
  else
    cfg.outValue    = CyFalse;
  cfg.driveLowEn  = CyTrue;
  cfg.driveHighEn = CyTrue;
  cfg.inputEn     = CyFalse;
  cfg.intrMode    = CY_U3P_GPIO_NO_INTR;

  if( CyU3PGpioSetSimpleConfig( io_num, &cfg) != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}

bool zeabus_configgpio_opendrain( uint8_t io_num, bool init_value )
{
  CyU3PGpioSimpleConfig_t cfg;

  if( init_value )
    cfg.outValue    = CyTrue;
  else
    cfg.outValue    = CyFalse;
  cfg.driveLowEn  = CyTrue;
  cfg.driveHighEn = CyFalse;
  cfg.inputEn     = CyFalse;
  cfg.intrMode    = CY_U3P_GPIO_NO_INTR;

  if( CyU3PGpioSetSimpleConfig( io_num, &cfg) != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}

bool zeabus_configgpio_opensource( uint8_t io_num, bool init_value )
{
  CyU3PGpioSimpleConfig_t cfg;

  if( init_value )
    cfg.outValue    = CyTrue;
  else
    cfg.outValue    = CyFalse;
  cfg.driveLowEn  = CyFalse;
  cfg.driveHighEn = CyTrue;
  cfg.inputEn     = CyFalse;
  cfg.intrMode    = CY_U3P_GPIO_NO_INTR;

  if( CyU3PGpioSetSimpleConfig( io_num, &cfg) != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}

bool zeabus_configgpio_input( uint8_t io_num )
{
  CyU3PGpioSimpleConfig_t cfg;

  cfg.outValue    = CyFalse;
  cfg.driveLowEn  = CyFalse;
  cfg.driveHighEn = CyFalse;
  cfg.inputEn     = CyTrue;
  cfg.intrMode    = CY_U3P_GPIO_NO_INTR;

  if( CyU3PGpioSetSimpleConfig( io_num, &cfg) != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}

bool zeabus_gpio_initialize( void ) 
{
  CyU3PGpioClock_t cfg;

  /*
   * GPIO modules have 3 clocks:
   *  - SYS_CLK is automatically set to 416 MHz as the ZTEX board uses 26 MHz xtal
   *  - FAST_CLK (Master clock) derived from SYS_CLK
   *  - SLOW_CLK derived from FAST_CLK
   *  - SIMPLE_CLK deried from FAST_CLK
   *
   * All settings here push the speeds to the allowable maximum which are:
   *  - FAST_CLK = SYS_CLK / 2 = 208 MHz
   *  - SIMPLE_CLK = FAST_CLK / 2 = 104 MHz
   */
  cfg.fastClkDiv = 2;                           /* FAST_CLK = SYS_CLK / 2 (max. freq.) */
  cfg.slowClkDiv = 0;                           /* Disable SLOW_CLK */
  cfg.simpleDiv  = CY_U3P_GPIO_SIMPLE_DIV_BY_2; /* Simple clock = FAST_CLK / 2 (max. freq.) */
  cfg.clkSrc     = CY_U3P_SYS_CLK;              /* Use SYS_CLK as input */
  cfg.halfDiv    = 0;                           /* Disable 0.5 fraction */

  if( CyU3PGpioInit(&cfg, NULL) != CY_U3P_SUCCESS )
    return false;
  else
    return true;
}
