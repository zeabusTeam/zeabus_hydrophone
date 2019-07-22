
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * This notice applies to any and all portions of this file
  * that are not between comment pairs USER CODE BEGIN and
  * USER CODE END. Other portions of this file, whether 
  * inserted by the user or by software development tools
  * are owned by their respective copyright owners.
  *
  * Copyright (c) 2018 STMicroelectronics International N.V. 
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without 
  * modification, are permitted, provided that the following conditions are met:
  *
  * 1. Redistribution of source code must retain the above copyright notice, 
  *    this list of conditions and the following disclaimer.
  * 2. Redistributions in binary form must reproduce the above copyright notice,
  *    this list of conditions and the following disclaimer in the documentation
  *    and/or other materials provided with the distribution.
  * 3. Neither the name of STMicroelectronics nor the names of other 
  *    contributors to this software may be used to endorse or promote products 
  *    derived from this software without specific written permission.
  * 4. This software, including modifications and/or derivative works of this 
  *    software, must execute solely and exclusively on microcontroller or
  *    microprocessor devices manufactured by or for STMicroelectronics.
  * 5. Redistribution and use of this software other than as permitted under 
  *    this license is void and will automatically terminate your rights under 
  *    this license. 
  *
  * THIS SOFTWARE IS PROVIDED BY STMICROELECTRONICS AND CONTRIBUTORS "AS IS" 
  * AND ANY EXPRESS, IMPLIED OR STATUTORY WARRANTIES, INCLUDING, BUT NOT 
  * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
  * PARTICULAR PURPOSE AND NON-INFRINGEMENT OF THIRD PARTY INTELLECTUAL PROPERTY
  * RIGHTS ARE DISCLAIMED TO THE FULLEST EXTENT PERMITTED BY LAW. IN NO EVENT 
  * SHALL STMICROELECTRONICS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
  * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
  * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING 
  * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32h7xx_hal.h"
#include "adc.h"
#include "dma.h"
#include "i2c.h"
#include "mdma.h"
#include "tim.h"
#include "usart.h"
#include "usb_device.h"
#include "gpio.h"

/* USER CODE BEGIN Includes */
#include <stdlib.h>
#include "common.h"
#include "abs_threshold.h"
#include "time.h"

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/
__SECTION_RAM_D2 uint32_t g_adc1_2_buffer[RAW_DATA_BUFFER_SIZE];
__SECTION_RAM_D2 uint32_t g_adc3_4_buffer[RAW_DATA_BUFFER_SIZE];
__SECTION_AXIRAM uint32_t g_adc_1_h[BUFFER_SIZE];
__SECTION_AXIRAM uint32_t g_adc_2_h[BUFFER_SIZE];
__SECTION_AXIRAM uint32_t g_adc_3_h[BUFFER_SIZE];
__SECTION_AXIRAM uint32_t g_adc_4_h[BUFFER_SIZE];
float32_t g_adc_1_f[BUFFER_SIZE];
float32_t g_adc_2_f[BUFFER_SIZE];
float32_t g_adc_3_f[BUFFER_SIZE];
float32_t g_adc_4_f[BUFFER_SIZE];
float32_t g_fft_f32[FFT_SIZE * 2];
float32_t g_fft_f32_out[FFT_SIZE];
uint32_t g_raw_data_index;
uint32_t g_pulse_detect_index;
uint8_t uart_rx_buffer[UART_RX_BUFFER_SIZE];
int g_uart_ready;

// Frequency range of each FFT output datum (i.e. FFT bin size)
const float32_t g_fft_bin_size = SAMPLE_RATE / (float32_t)FFT_SIZE;

// FFT bin index that contains the frequency we are looking for
uint32_t g_desired_fft_bin;
uint32_t g_lowest_considered_fft_bin;
uint32_t g_highest_considered_fft_bin;

// USB Data
InputParam input;
OutputParam output;

// Marked out as it is deprecated
arm_cfft_radix4_instance_f32  FFT_F32_struct;


/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

int ADC_Start(){
	if(HAL_ADC_Start_DMA(&hadc1,(uint32_t*)g_adc1_2_buffer,RAW_DATA_BUFFER_SIZE) != HAL_OK){
		  HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		  // Reset LD3 (RED) if start fail
		  return 0;
	  }

	  if(HAL_ADC_Start_DMA(&hadc3,(uint32_t*)g_adc3_4_buffer,RAW_DATA_BUFFER_SIZE) != HAL_OK){
		  HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		  // Reset LD3 (RED) if start fail
		  return 0;
	  }

	  return 1;
}

int TIMER_Start(){
	if(HAL_TIM_Base_Start(&htim2) != HAL_OK){
		  HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		  // Reset LD3 (RED) if start fail
		  return 0;
	 }

	return 1;
}

int Set_LNA_Gain(){

	uint16_t i2c_dev_addr = 0x5D; // MAX 5387 Address
	uint8_t i2c_val[2];
	i2c_val[0] = 0x13; // Set both CH
	i2c_val[1] = (input.LNA_Gain * 255);  // VGain = 1.1 * ( g_i2c_val / 255 )

	// Set gain for channel 1 and 2
	if(HAL_I2C_Master_Transmit(&hi2c1, i2c_dev_addr, i2c_val,2,100) != HAL_OK){
		HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		// Reset LD3 (RED) if can not set gain value
		return 0;
	}

	// Set gain for channel 3 and 4
	if(HAL_I2C_Master_Transmit(&hi2c1, (i2c_dev_addr + 2), i2c_val,2,100) != HAL_OK){
		HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		// Reset LD3 (RED) if can not set gain value
		return 0;
	}

	return 1;

}

uint32_t Get_Max_FFT_Bin( float32_t* sig )
{
	float32_t maxVal;
	uint32_t freq_index;
	uint32_t i, k;

	// Translate a part of raw signal data into complex numbers with 0 imaginary magnitude
	for( ( i = 0 ), ( k = PULSE_HEADER_SIZE ) ; i < FFT_SIZE * 2 ; ( i += 2 ), (k++) )
	{
		g_fft_f32[ i ] = 0;		// Initialize real part with 0
		g_fft_f32[ i + 1 ] = 0;	// Imaginary part is always 0

		if(k < PULSE_FRAME_SIZE)
		{
			g_fft_f32[ i ] = sig[ k ];
		}
	}

	/**** These lines are replaced with "arm_cfft_f32" as they are deprecated
	****/
	// Perform complex FFT over "g_fft_f32". The result is stored back into "g_fft_f32"
	//arm_cfft_radix4_init_f32( &FFT_F32_struct, FFT_SIZE, 0, 1 );
	//arm_cfft_radix4_f32( &FFT_F32_struct, g_fft_f32 );

	// New function to replace 2 functions above
	/* Process the data through the CFFT/CIFFT module with 1024 points */
	arm_cfft_f32( &arm_cfft_sR_f32_len1024, g_fft_f32, 0, 1 );

	/* Process the data through the Complex Magnitude Module for
  		calculating the magnitude at each bin */
	arm_cmplx_mag_f32( g_fft_f32, g_fft_f32_out, FFT_SIZE );

	/* Mask the FFT to only the considered frequency */
	for( i = 0; i < g_lowest_considered_fft_bin; i++ )
		g_fft_f32_out[i] = 0;
	for( i = g_highest_considered_fft_bin; i < FFT_SIZE; i++ )
		g_fft_f32_out[i] = 0;

	/* Looking for the bin that has highest magnitude */
	arm_max_f32( g_fft_f32_out, FFT_SIZE, &maxVal, &freq_index );

	return( freq_index );
}

uint32_t Bin2Freq( uint32_t bin )
{
	float32_t freq;

	freq = (float32_t)(bin) * g_fft_bin_size / 1000.0f; // Frequency in KHz

	float32_t dec;
	float32_t dot = modff(freq, &dec);


	// Rounding the frequency to the nearest 500Hz step (raw frequency is in KHz)
	if( dot >= 0.75f )
	{
		dec = dec + 1.0f;
	}
	else
	{
		if( dot >= 0.25f )
			dec = dec + 0.5f;
	}

	// Convert frequency back to Hz
	freq = dec * 1000.0f;

	return ( (uint32_t)freq );	// Convert the final result to integer
}

void Wait_DMA(DMA_HandleTypeDef *hdma, int eot,int next_round){

	if(next_round == 0){
		while((RAW_DATA_BUFFER_SIZE - (uint16_t)(((DMA_Stream_TypeDef   *)hdma->Instance)->NDTR)) <= eot);
	} else if(next_round == 1) {
		while((uint16_t)(((DMA_Stream_TypeDef   *)hdma->Instance)->NDTR) == 0);
		while((RAW_DATA_BUFFER_SIZE - (uint16_t)(((DMA_Stream_TypeDef   *)hdma->Instance)->NDTR)) <= eot);
	}

}

void Get_Pulse_Frame(){

	 int start_transfer_index = 0;
	 int end_transfer_index = 0;
	 int size_remain = 0;					//size of data that remain to transfer
	 int size_forward_transfer = 0;			//size of data can forward transfer before last address of raw data buffer
	 int next_round = 0;

	 // Case 1 ; some header is at the end of buffer
	 if ((g_pulse_detect_index * 2)  < PULSE_HEADER_SIZE - 1) {
		 size_forward_transfer = PULSE_HEADER_SIZE - (g_pulse_detect_index / 2);
		 start_transfer_index = RAW_DATA_BUFFER_SIZE - (size_forward_transfer * 2); 	// start transfer at bottom of raw data
	 }
	 // Case 2 ; some body is at the next start of buffer
	 else if (((RAW_DATA_BUFFER_SIZE) - (g_pulse_detect_index) - 1) < ((int)PULSE_BODY_SIZE * 2)) {
		 size_forward_transfer = PULSE_HEADER_SIZE + (((int)(RAW_DATA_BUFFER_SIZE) - g_pulse_detect_index ) / 2 ) - 1;
		 start_transfer_index = g_pulse_detect_index - (int)((PULSE_HEADER_SIZE) * 2);
	 }
	 // Case 3 ; all frame is in this buffer length
	 else {
		 size_forward_transfer = (int) PULSE_FRAME_SIZE;
		 start_transfer_index = g_pulse_detect_index - (int)(PULSE_HEADER_SIZE * 2);
	 }

	 size_remain = PULSE_FRAME_SIZE - size_forward_transfer;

	 if (size_remain == 0) {
		 end_transfer_index = start_transfer_index + (int)(PULSE_FRAME_SIZE * 2);
	 }
	 else {
		 end_transfer_index = (size_remain * 2);
	 }

	 Wait_DMA(&hdma_adc1,end_transfer_index,next_round);  		 // wait until frame is fill up

	 HAL_MDMA_Start(&hmdma_mdma_channel0_sw_0,(uint32_t)&g_adc1_2_buffer[start_transfer_index],(uint32_t)&g_adc_1_h,4,size_forward_transfer);
	 HAL_MDMA_Start(&hmdma_mdma_channel1_sw_0,(uint32_t)&g_adc1_2_buffer[start_transfer_index + 1],(uint32_t)&g_adc_2_h,4,size_forward_transfer);
	 HAL_MDMA_Start(&hmdma_mdma_channel2_sw_0,(uint32_t)&g_adc3_4_buffer[start_transfer_index],(uint32_t)&g_adc_3_h,4,size_forward_transfer);
	 HAL_MDMA_Start(&hmdma_mdma_channel3_sw_0,(uint32_t)&g_adc3_4_buffer[start_transfer_index + 1],(uint32_t)&g_adc_4_h,4,size_forward_transfer);

	 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel0_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
	 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel1_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
	 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel2_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
	 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel3_sw_0,HAL_MDMA_FULL_TRANSFER,1000);

	 HAL_MDMA_Abort(&hmdma_mdma_channel0_sw_0);
	 HAL_MDMA_Abort(&hmdma_mdma_channel1_sw_0);
	 HAL_MDMA_Abort(&hmdma_mdma_channel2_sw_0);
	 HAL_MDMA_Abort(&hmdma_mdma_channel3_sw_0);

	 if(size_remain > 0){

		 HAL_MDMA_Start(&hmdma_mdma_channel0_sw_0,(uint32_t)&g_adc1_2_buffer,(uint32_t)&g_adc_1_h[size_forward_transfer],4,size_forward_transfer);
		 HAL_MDMA_Start(&hmdma_mdma_channel1_sw_0,(uint32_t)&g_adc1_2_buffer[1],(uint32_t)&g_adc_2_h[size_forward_transfer],4,size_forward_transfer);
		 HAL_MDMA_Start(&hmdma_mdma_channel2_sw_0,(uint32_t)&g_adc3_4_buffer,(uint32_t)&g_adc_3_h[size_forward_transfer],4,size_forward_transfer);
		 HAL_MDMA_Start(&hmdma_mdma_channel3_sw_0,(uint32_t)&g_adc3_4_buffer[1],(uint32_t)&g_adc_4_h[size_forward_transfer],4,size_forward_transfer);

		 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel0_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
		 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel1_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
		 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel2_sw_0,HAL_MDMA_FULL_TRANSFER,1000);
		 HAL_MDMA_PollForTransfer(&hmdma_mdma_channel3_sw_0,HAL_MDMA_FULL_TRANSFER,1000);

	 	 HAL_MDMA_Abort(&hmdma_mdma_channel0_sw_0);
		 HAL_MDMA_Abort(&hmdma_mdma_channel1_sw_0);
		 HAL_MDMA_Abort(&hmdma_mdma_channel2_sw_0);
		 HAL_MDMA_Abort(&hmdma_mdma_channel3_sw_0);
	 }

	 // Raw ADC data is 16-bit unsigned integer value (0 - 65535 representing 0V - 3.3V)
	 // The following conversion loop convert each datum to floating point format ranging from 0 - 1.0
	 for(int i = 0 ; i < BUFFER_SIZE ; i++) {
		 g_adc_1_f[i] = ADC_NORMALIZE( g_adc_1_h[i] );
		 g_adc_2_f[i] = ADC_NORMALIZE( g_adc_2_h[i] );
		 g_adc_3_f[i] = ADC_NORMALIZE( g_adc_3_h[i] );
		 g_adc_4_f[i] = ADC_NORMALIZE( g_adc_4_h[i] );
	 }
 }

float2bytes f2b;

int UART_Sent(){

	uint8_t uart_tx_buffer[UART_TX_BUFFER_SIZE];
	uint322bytes u32t2b;
	float2bytes f2b;
	int k;

	// Sync
	uart_tx_buffer[0] = 0xFF;
	uart_tx_buffer[1] = 0xFF;

	// Header
	uart_tx_buffer[2] = (char) output.seq_num;
	uart_tx_buffer[3] = (char) output.seq_num >> 8;

	u32t2b.u32t = output.Detect_Frequency;

	uart_tx_buffer[4] = u32t2b.b[0];
	uart_tx_buffer[5] = u32t2b.b[1];
	uart_tx_buffer[6] = u32t2b.b[2];
	uart_tx_buffer[7] = u32t2b.b[3];

	u32t2b.u32t = output.time_between_pulse;

	uart_tx_buffer[8] = u32t2b.b[0];
	uart_tx_buffer[9] = u32t2b.b[1];
	uart_tx_buffer[10] = u32t2b.b[2];
	uart_tx_buffer[11] = u32t2b.b[3];

	u32t2b.u32t = output.process_time;

	uart_tx_buffer[12] = u32t2b.b[0];
	uart_tx_buffer[13] = u32t2b.b[1];
	uart_tx_buffer[14] = u32t2b.b[2];
	uart_tx_buffer[15] = u32t2b.b[3];

	// ==== Data ====
	uart_tx_buffer[16] = 0x11;
	uart_tx_buffer[17] = 0x11;

	k = 18;

	for(int i = 0;i < BUFFER_SIZE ;i++){
		f2b.f = g_adc_1_f[i];
		for(int d = 0;d < 4;d++){
			uart_tx_buffer[k + d] = f2b.b[d];
		}
		k += 4;
	}

	for(int i = 0;i < BUFFER_SIZE ;i++){
			f2b.f = g_adc_2_f[i];
			for(int d = 0;d < 4;d++){
				uart_tx_buffer[k + d] = f2b.b[d];
			}
			k += 4;
		}

	uart_tx_buffer[k] = 0x22;
	k++;
	uart_tx_buffer[k] = 0x22;
	k++;

	for(int i = 0;i < BUFFER_SIZE ;i++){
			f2b.f = g_adc_3_f[i];
			for(int d = 0;d < 4;d++){
				uart_tx_buffer[k + d] = f2b.b[d];
			}
			k += 4;
		}

	for(int i = 0;i < BUFFER_SIZE ;i++){
			f2b.f = g_adc_4_f[i];
			for(int d = 0;d < 4;d++){
				uart_tx_buffer[k + d] = f2b.b[d];
			}
			k += 4;
		}

	uart_tx_buffer[k] = 0x33;
	k++;
	uart_tx_buffer[k] = 0x33;
	k++;

	if(k != UART_TX_BUFFER_SIZE){
		return 0;
	}

//	while(!g_uart_ready);

	g_uart_ready = 0;

	HAL_Delay(10);
	if(HAL_UART_Transmit(&huart3,uart_tx_buffer,UART_TX_BUFFER_SIZE,10000) != HAL_OK){
		return 0;
	}

	LED_BLUE_OFF();

	output.seq_num++;

	return 1;
}

/* USER CODE END PFP */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  *
  * @retval None
  */
int main(void)
{
  /* USER CODE BEGIN 1 */
	uint32_t frame_bin;
	uint32_t temp_time_stamp;
	uint32_t pulse_time_stamp;
	uint32_t process_time_stamp;

  /* USER CODE END 1 */

  /* MCU Configuration----------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_DMA_Init();
  MX_MDMA_Init();
  MX_ADC1_Init();
  MX_ADC3_Init();
  MX_I2C1_Init();
  MX_TIM2_Init();
  MX_USART3_UART_Init();
  MX_USB_DEVICE_Init();
  /* USER CODE BEGIN 2 */

  LED_BLUE_ON();
  LED_RED_ON();

  input.MinFrequency = 20000;
  input.MaxFrequency = 45000;
  input.Frequency = 37500;
  input.FrontThreshold = 0.3;
  input.PowerThreshold = 0.02;
  input.DelayObserve = 2000;
  input.LNA_Gain = 0.1;

  TIMER_Start(); 	// Start Timer

  ADC_Start();		// Start ADC with DMA

  Set_LNA_Gain();	// Set LNA GAIN

  g_raw_data_index = 0;

  g_desired_fft_bin = (uint32_t)( input.Frequency / g_fft_bin_size ); // Divide and discarding the fraction
  g_lowest_considered_fft_bin = (uint32_t)( input.MinFrequency / g_fft_bin_size ); // Divide and discarding the fraction
  g_highest_considered_fft_bin = (uint32_t)( input.MaxFrequency / g_fft_bin_size ); // Divide and discarding the fraction
  if( g_lowest_considered_fft_bin > g_desired_fft_bin )
	  g_lowest_considered_fft_bin = g_desired_fft_bin;
  if( (g_highest_considered_fft_bin <= g_desired_fft_bin) && (g_desired_fft_bin < FFT_SIZE - 1) )
	  g_lowest_considered_fft_bin = g_desired_fft_bin + 1;

  HAL_UART_Receive_IT(&huart3,uart_rx_buffer,UART_RX_BUFFER_SIZE);

  HAL_Delay(10);

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  LED_BLUE_OFF();
  LED_RED_OFF();

  output.seq_num = 0;
  g_uart_ready = 1;
  pulse_time_stamp = 0;


  while (1)
  {

  /* USER CODE END WHILE */

  /* USER CODE BEGIN 3 */

	if(abs_threshold_CFAR() == 1)
	{
		temp_time_stamp = HAL_GetTick();
		if(temp_time_stamp - pulse_time_stamp > input.DelayObserve)
		{
			output.time_between_pulse = temp_time_stamp - pulse_time_stamp;
			pulse_time_stamp = temp_time_stamp;
			process_time_stamp = temp_time_stamp;
			Get_Pulse_Frame();
			LED_RED_ON();

			frame_bin = Get_Max_FFT_Bin( g_adc_1_f );
			if( g_desired_fft_bin == frame_bin )
			{
				LED_BLUE_ON();

				output.Detect_Frequency = Bin2Freq( frame_bin );
				output.process_time = HAL_GetTick() - process_time_stamp;
				UART_Sent();
			}
			LED_RED_OFF();
		}
	}

	g_raw_data_index = g_raw_data_index + 2;

	if(g_raw_data_index > RAW_DATA_BUFFER_SIZE - 2)
	{
		g_raw_data_index = 0;
	}

  }
  /* USER CODE END 3 */

}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_PeriphCLKInitTypeDef PeriphClkInitStruct;

    /**Supply configuration update enable 
    */
  MODIFY_REG(PWR->CR3, PWR_CR3_SCUEN, 0);

    /**Configure the main internal regulator output voltage 
    */
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);

  while ((PWR->D3CR & (PWR_D3CR_VOSRDY)) != PWR_D3CR_VOSRDY) 
  {
    
  }
    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI48|RCC_OSCILLATORTYPE_HSI
                              |RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_BYPASS;
  RCC_OscInitStruct.HSIState = RCC_HSI_DIV1;
  RCC_OscInitStruct.HSICalibrationValue = 16;
  RCC_OscInitStruct.HSI48State = RCC_HSI48_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = 1;
  RCC_OscInitStruct.PLL.PLLN = 100;
  RCC_OscInitStruct.PLL.PLLP = 2;
  RCC_OscInitStruct.PLL.PLLQ = 16;
  RCC_OscInitStruct.PLL.PLLR = 2;
  RCC_OscInitStruct.PLL.PLLRGE = RCC_PLL1VCIRANGE_3;
  RCC_OscInitStruct.PLL.PLLVCOSEL = RCC_PLL1VCOWIDE;
  RCC_OscInitStruct.PLL.PLLFRACN = 0;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2
                              |RCC_CLOCKTYPE_D3PCLK1|RCC_CLOCKTYPE_D1PCLK1;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.SYSCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB3CLKDivider = RCC_APB3_DIV2;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_APB1_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_APB2_DIV2;
  RCC_ClkInitStruct.APB4CLKDivider = RCC_APB4_DIV2;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

  PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_USART3|RCC_PERIPHCLK_ADC
                              |RCC_PERIPHCLK_I2C1|RCC_PERIPHCLK_USB
                              |RCC_PERIPHCLK_CKPER;
  PeriphClkInitStruct.CkperClockSelection = RCC_CLKPSOURCE_HSI;
  PeriphClkInitStruct.Usart234578ClockSelection = RCC_USART234578CLKSOURCE_D2PCLK1;
  PeriphClkInitStruct.I2c123ClockSelection = RCC_I2C123CLKSOURCE_D2PCLK1;
  PeriphClkInitStruct.UsbClockSelection = RCC_USBCLKSOURCE_HSI48;
  PeriphClkInitStruct.AdcClockSelection = RCC_ADCCLKSOURCE_CLKP;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) != HAL_OK)
  {
    _Error_Handler(__FILE__, __LINE__);
  }

    /**Configure the Systick interrupt time 
    */
  HAL_SYSTICK_Config(SystemCoreClock/1000);

    /**Configure the Systick 
    */
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* USER CODE BEGIN 4 */

void HAL_UART_TxCpltCallback(UART_HandleTypeDef *huart)
{
	if(huart->Instance == USART3){

		  g_uart_ready = 1;
	}
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
	if(huart->Instance == USART3){
		HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_SET);
		if(uart_rx_buffer[0] == 61 && uart_rx_buffer[1] == 61 &&
				uart_rx_buffer[2] == 61 && uart_rx_buffer[3] == 61){
			uint322bytes u322b;
			float2bytes f2b;

			u322b.b[0] = uart_rx_buffer[4];
			u322b.b[1] = uart_rx_buffer[5];
			u322b.b[2] = uart_rx_buffer[6];
			u322b.b[3] = uart_rx_buffer[7];
			input.Frequency = u322b.u32t;

			u322b.b[0] = uart_rx_buffer[8];
			u322b.b[1] = uart_rx_buffer[9];
			u322b.b[2] = uart_rx_buffer[10];
			u322b.b[3] = uart_rx_buffer[11];
			input.MinFrequency = u322b.u32t;

			u322b.b[0] = uart_rx_buffer[12];
			u322b.b[1] = uart_rx_buffer[13];
			u322b.b[2] = uart_rx_buffer[14];
			u322b.b[3] = uart_rx_buffer[15];
			input.MaxFrequency = u322b.u32t;

			f2b.b[0] = uart_rx_buffer[16];
			f2b.b[1] = uart_rx_buffer[17];
			f2b.b[2] = uart_rx_buffer[18];
			f2b.b[3] = uart_rx_buffer[19];
			input.FrontThreshold = f2b.f;

			f2b.b[0] = uart_rx_buffer[20];
			f2b.b[1] = uart_rx_buffer[21];
			f2b.b[2] = uart_rx_buffer[22];
			f2b.b[3] = uart_rx_buffer[23];
			input.PowerThreshold = f2b.f;

			u322b.b[0] = uart_rx_buffer[24];
			u322b.b[1] = uart_rx_buffer[25];
			u322b.b[2] = uart_rx_buffer[26];
			u322b.b[3] = uart_rx_buffer[27];
			input.DelayObserve = u322b.u32t;

			f2b.b[0] = uart_rx_buffer[28];
			f2b.b[1] = uart_rx_buffer[29];
			f2b.b[2] = uart_rx_buffer[30];
			f2b.b[3] = uart_rx_buffer[31];
			input.LNA_Gain = f2b.f;

			Set_LNA_Gain();
			g_desired_fft_bin = (uint32_t)( input.Frequency / g_fft_bin_size ); // Divide and discarding the fraction
			g_lowest_considered_fft_bin = (uint32_t)( input.MinFrequency / g_fft_bin_size ); // Divide and discarding the fraction
			g_highest_considered_fft_bin = (uint32_t)( input.MaxFrequency / g_fft_bin_size ); // Divide and discarding the fraction
			if( g_lowest_considered_fft_bin > g_desired_fft_bin )
				g_lowest_considered_fft_bin = g_desired_fft_bin;
			if( (g_highest_considered_fft_bin <= g_desired_fft_bin) && (g_desired_fft_bin < FFT_SIZE - 1) )
				g_lowest_considered_fft_bin = g_desired_fft_bin + 1;
		}
		HAL_GPIO_WritePin(GPIOB,GPIO_PIN_14,GPIO_PIN_RESET);
		HAL_UART_Receive_IT(&huart3,uart_rx_buffer,UART_RX_BUFFER_SIZE);
	}

}

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @param  file: The file name as string.
  * @param  line: The line in file as a number.
  * @retval None
  */
void _Error_Handler(char *file, int line)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  while(1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{ 
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/**
  * @}
  */

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
