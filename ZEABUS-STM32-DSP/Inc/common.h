/*
 * common.h
 *
 *  Created on: May 30, 2018
 *      Author: Vasut
 */

#ifndef COMMON_H_
#define COMMON_H_

#include <stdio.h>
#define ARM_MATH_CM4
#include "arm_math.h"
#include "arm_const_structs.h"
#include "stm32h7xx_hal.h"

#define __SECTION_AXIRAM __attribute__((section(".RAM_AXI"))) /* AXI SRAM (D1 domain): */

#define __SECTION_RAM_D2 __attribute__((section(".RAM_D2"))) /* AHB SRAM (D2 domain): */

#define __SECTION_RAM_D3 __attribute__((section(".RAM_D3"))) /* AHB SRAM (D3 domain): */

#define LED_BLUE_ON()					HAL_GPIO_WritePin(GPIOB,GPIO_PIN_7,GPIO_PIN_SET)
#define LED_BLUE_OFF()					HAL_GPIO_WritePin(GPIOB,GPIO_PIN_7,GPIO_PIN_RESET)
#define LED_RED_ON()					HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_SET)
#define LED_RED_OFF()					HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET)

#define SAMPLE_RATE 					((float)191930.0)

#define BUFFER_SIZE 					2048
#define RAW_DATA_BUFFER_SIZE			(BUFFER_SIZE * 18)
#define PULSE_FRAME_SIZE				BUFFER_SIZE
#define PULSE_HEADER_SIZE				1200
//#define PULSE_HEADER_SIZE				1000
#define PULSE_BODY_SIZE					(PULSE_FRAME_SIZE - PULSE_HEADER_SIZE)
#define FFT_SIZE						1024
#define SCALE_DOWN						5
#define DOWN_SAMPLING_SIZE				(BUFFER_SIZE / SCALE_DOWN)
#define DEMOD_SCALE_SIZE				DOWN_SAMPLING_SIZE + 25
#define UART_TX_BUFFER_SIZE				(2 + 2 + 4 + 2 + 2 + 2 + 8 + (4 * BUFFER_SIZE * 4))
//#define UART_TX_BUFFER_SIZE				(2 + 2 + 4 + 2 + 2 + 2 + 8 + (4 * ((100))))
#define UART_RX_BUFFER_SIZE				(28 + 4)
#define PROCESS_PULSE_SIZE				100

// Mask to reduce ADC resolution in case of high noise
// Currently we mask out the data as it is has the resolution of 12 bits
#define ADC_MASK						0xFFF0u
// DC offset of ADC (got from measuring. (1.5V for current board)
#define ADC_OFFSET						29790.0f
#define ADC_NORMALIZE(d)				(((float32_t)(d & ADC_MASK) - ADC_OFFSET) / 65535.0f)

typedef struct ProcessParameter {
	float32_t FrontThreshold;
	float32_t PowerThreshold;
	float32_t h;
	uint32_t Frequency;
	uint32_t MinFrequency;
	uint32_t MaxFrequency;
	uint32_t DelayObserve;
	float32_t LNA_Gain;
} InputParam;

typedef struct Outputdata {
	uint16_t seq_num;
	uint32_t Detect_Frequency;
	float32_t power;
	float32_t output_re[4 * PROCESS_PULSE_SIZE];
	float32_t output_im[4 * PROCESS_PULSE_SIZE];
	uint32_t time_between_pulse;
	uint32_t process_time;
} OutputParam;

typedef union CovfloatTobyte {
	float32_t f;
	char b[sizeof(float32_t)];
} float2bytes;

typedef union Covuint32Tobyte{
	uint32_t u32t;
	char b[sizeof(uint32_t)];
} uint322bytes;


extern __SECTION_AXIRAM uint32_t g_adc1_2_buffer[]; 	// Raw data form ADC 1 use dma1 to get data
extern __SECTION_AXIRAM uint32_t g_adc3_4_buffer[];		// Raw data form ADC 3 use dma2 to get data
extern float32_t g_adc_1_f[];
extern float32_t g_adc_2_f[];
extern float32_t g_adc_3_f[];
extern float32_t g_adc_4_f[];
extern float32_t g_out_re[];
extern float32_t g_out_im[];
extern uint32_t g_raw_data_index;
extern uint32_t g_pulse_detect_index;
extern InputParam input;
extern OutputParam output;

#endif /* COMMON_H_ */
