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

#define BUFFER_SIZE 					2048
#define RAW_DATA_BUFFER_SIZE			BUFFER_SIZE * 100
#define PULSE_FRAME_SIZE				BUFFER_SIZE
#define PULSE_HEADER_SIZE				1200
#define PULSE_BODY_SIZE					PULSE_FRAME_SIZE - PULSE_HEADER_SIZE

#define ANALOG_OFFSET 32768		// offset for ADC 16 bit value (GND Level)

extern __SECTION_RAM_D2 uint32_t g_adc1_2_buffer[]; 	// Raw data form ADC 1 use dma1 to get data
extern __SECTION_RAM_D2 uint32_t g_adc3_4_buffer[];		// Raw data form ADC 3 use dma2 to get data
extern __SECTION_AXIRAM uint32_t g_adc_1_h[];
extern __SECTION_AXIRAM uint32_t g_adc_2_h[];
extern __SECTION_AXIRAM uint32_t g_adc_3_h[];
extern __SECTION_AXIRAM uint32_t g_adc_4_h[];
extern uint32_t g_raw_data_index;

#endif /* COMMON_H_ */
