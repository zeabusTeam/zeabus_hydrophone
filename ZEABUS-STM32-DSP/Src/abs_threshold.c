/*
 * abs_threshold.c
 *
 *  Created on: Jun 2, 2018
 *      Author: Vasut
 */
#include "common.h"
#include "abs_threshold.h"



inline float32_t signal_power( float32_t signal )
{
	/* The power is calculated on the basis of that the input impedances are all 1 */
	return( signal * signal ); // P = V^2 / R
}

int abs_threshold_CFAR() {

	float32_t temp[4];
	float32_t power[4];
	int i,k;
	static const int num_samples = 50;
	static const float32_t f_num_samples = (float32_t)num_samples;
	uint8_t ch_status = 0x00;

	// Calculate current signal power of each ADC
	power[0] = signal_power( ADC_NORMALIZE( g_adc1_2_buffer[g_raw_data_index] ) ); // ADC1
	power[1] = signal_power( ADC_NORMALIZE( g_adc1_2_buffer[g_raw_data_index + 1] ) ); // ADC2
	power[2] = signal_power( ADC_NORMALIZE( g_adc3_4_buffer[g_raw_data_index] ) ); // ADC3
	power[3] = signal_power( ADC_NORMALIZE( g_adc3_4_buffer[g_raw_data_index + 1] ) ); // ADC4

	// If the power is greater or equal to threshold
    if ( ( input.PowerThreshold <= power[0] ) &&
    	 ( input.PowerThreshold <= power[1] ) &&
		 ( input.PowerThreshold <= power[2] ) &&
		 ( input.PowerThreshold <= power[3] ) )
    {
    	// Calculate average signal power of the previous num_samples samplings
		temp[0] = 0;
		temp[1] = 0;
		temp[2] = 0;
		temp[3] = 0;

		for (i = 2; i <= ( num_samples * 2 ) ; i += 2)
		{
			k = (int)g_raw_data_index - i;
			if (k < 0 )
			{
				k = RAW_DATA_BUFFER_SIZE + k ;
			}

			temp[0] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k] ) );
			temp[1] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k + 1] ) );
			temp[2] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k] ) );
			temp[3] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k + 1] ) );
		}

		temp[0] /= f_num_samples ;
		temp[1] /= f_num_samples ;
		temp[2] /= f_num_samples ;
		temp[3] /= f_num_samples ;

		// Check whether the current power is greater than the averaged previous power by a factor
		if (temp[0] < input.FrontThreshold * power[0])
		{
			ch_status |= 1;
		}
		if (temp[1] < input.FrontThreshold * power[1])
		{
			ch_status |= 2;
		}
		if (temp[2] < input.FrontThreshold * power[2])
		{
			ch_status |= 4;
		}
		if (temp[3] < input.FrontThreshold * power[3])
		{
			ch_status |= 8;
		}

		// If all CFAR is satisfied
		if(ch_status & 0xf)
		{
			g_pulse_detect_index = g_raw_data_index;
			return 1;
		}
	}

	return 0;

}
