/*
 * common.h
 *
 *  Created on: May 30, 2018
 *      Author: Vasut
 */

#ifndef COMMON_H_
#define COMMON_H_

#include <stdio.h>

#define __SECTION_AXIRAM __attribute__((section(".RAM_AXI"))) /* AXI SRAM (D1 domain): */

#define __SECTION_RAM_D2 __attribute__((section(".RAM_D2"))) /* AHB SRAM (D2 domain): */

#define __SECTION_RAM_D3 __attribute__((section(".RAM_D3"))) /* AHB SRAM (D3 domain): */

#define BUFFER_SIZE 2048

#define ANALOG_OFFSET 32768

extern __SECTION_RAM_D2 uint32_t g_adc1_2_buffer[];
extern __SECTION_RAM_D2 uint32_t g_adc3_4_buffer[];
extern __SECTION_AXIRAM uint32_t g_adc_1_h[];
extern uint32_t g_adc_2_h[];
extern uint32_t g_adc_3_h[];
extern uint32_t g_adc_4_h[];
extern uint32_t g_circular_buffer[][BUFFER_SIZE];
extern uint16_t g_i2c_dev_addr;
extern uint8_t g_i2c_val[];
extern uint32_t i;

#endif /* COMMON_H_ */
