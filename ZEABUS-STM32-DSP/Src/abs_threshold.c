/*
 * abs_threshold.c
 *
 *  Created on: Jun 2, 2018
 *      Author: Vasut
 */
#include <stdlib.h>
#include "common.h"
#include "abs_threshold.h"

#define NUM_SAMPLE	50
#define AVG_SAMPLE	4

//static uint16_t Filtered_data[4][NUM_SAMPLE+AVG_SAMPLE];

// Process the signal using feedback noise filtering from
// https://www.electronicdesign.com/analog/use-software-filters-reduce-adc-noise
int abs_threshold_CFAR()
{
	uint32_t plevel[4];
	int32_t pseudo_adc[4];
	int32_t i, k;
	uint8_t ch_status = 0x00;

	// Initialize
	pseudo_adc[0] = g_adc_offset[0];
	pseudo_adc[1] = g_adc_offset[1];
	pseudo_adc[2] = g_adc_offset[2];
	pseudo_adc[3] = g_adc_offset[3];

	// Calculate average of "num_samples" further from "avg_sample"
	plevel[0] = 0;
	plevel[1] = 0;
	plevel[2] = 0;
	plevel[3] = 0;

	for (i = ( NUM_SAMPLE * 2 ); i > 0 ; i -= 2)
	{
		k = (int32_t)g_raw_data_index - i;
		if (k < 0 )
		{
			k = RAW_DATA_BUFFER_SIZE + k;
		}

		pseudo_adc[0] += ( ( (int32_t)g_adc1_2_buffer[k] - pseudo_adc[0] ) / AVG_SAMPLE );
		pseudo_adc[1] += ( ( (int32_t)g_adc1_2_buffer[k + 1] - pseudo_adc[1] ) / AVG_SAMPLE );
		pseudo_adc[2] += ( ( (int32_t)g_adc3_4_buffer[k] - pseudo_adc[2] ) / AVG_SAMPLE );
		pseudo_adc[3] += ( ( (int32_t)g_adc3_4_buffer[k + 1] - pseudo_adc[3] ) / AVG_SAMPLE );

		plevel[0] += abs( ADC_OFFSET( pseudo_adc[0], g_adc_offset[0] ) ); // ADC1
		plevel[1] += abs( ADC_OFFSET( pseudo_adc[1], g_adc_offset[1] ) ); // ADC2
		plevel[2] += abs( ADC_OFFSET( pseudo_adc[2], g_adc_offset[2] ) ); // ADC3
		plevel[3] += abs( ADC_OFFSET( pseudo_adc[3], g_adc_offset[3] ) ); // ADC4
	}
	plevel[0] /= NUM_SAMPLE;
	plevel[1] /= NUM_SAMPLE;
	plevel[2] /= NUM_SAMPLE;
	plevel[3] /= NUM_SAMPLE;

	// We proceed further only when all signal levels are satisfied
    if ( ( input.PowerThreshold <= abs( ADC_OFFSET( pseudo_adc[0], g_adc_offset[0] ) ) ) &&
    	 ( input.PowerThreshold <= abs( ADC_OFFSET( pseudo_adc[1], g_adc_offset[1] ) ) ) &&
		 ( input.PowerThreshold <= abs( ADC_OFFSET( pseudo_adc[2], g_adc_offset[2] ) ) ) &&
		 ( input.PowerThreshold <= abs( ADC_OFFSET( pseudo_adc[3], g_adc_offset[3] ) ) ) )
    {

    	LED_BLUE_ON();
    	// Check the conditions of Fronthreshold
		if (plevel[0] < input.FrontThreshold * pseudo_adc[0])
		{
			ch_status |= 1;
		}
		if (plevel[1] < input.FrontThreshold * pseudo_adc[1])
		{
			ch_status |= 2;
		}
		if (plevel[2] < input.FrontThreshold * pseudo_adc[2])
		{
			ch_status |= 4;
		}
		if (plevel[3] < input.FrontThreshold * pseudo_adc[3])
		{
			ch_status |= 8;
		}
		LED_BLUE_OFF();
		// If all CFAR is satisfied
		if(ch_status & 0xf)
		{
			g_pulse_detect_index = g_raw_data_index;
			return 1;
		}
    }
    return 0;

}

/*inline float32_t signal_power( float32_t signal )
{
	// The power is calculated on the basis of that the input impedances are all 1
	return( signal * signal ); // P = V^2 / R
}

int abs_threshold_CFAR()
{
	float32_t temp[4];
	float32_t power[4];
	int i,k;
	static const int avg_samples = 10;
	static const int num_samples = 50;
	static const float32_t f_num_samples = (float32_t)num_samples;
	uint8_t ch_status = 0x00;

	// Calculate current signal power of each ADC
	power[0] = signal_power( ADC_NORMALIZE( g_adc1_2_buffer[g_raw_data_index], g_adc_offset[0] ) ); // ADC1
	power[1] = signal_power( ADC_NORMALIZE( g_adc1_2_buffer[g_raw_data_index + 1], g_adc_offset[1] ) ); // ADC2
	power[2] = signal_power( ADC_NORMALIZE( g_adc3_4_buffer[g_raw_data_index], g_adc_offset[2] ) ); // ADC3
	power[3] = signal_power( ADC_NORMALIZE( g_adc3_4_buffer[g_raw_data_index + 1], g_adc_offset[3] ) ); // ADC4

	for (i = 2; i < (avg_samples * 2) ; i += 2)
	{
		k = (int)g_raw_data_index - i;
		if (k < 0 )
		{
			k = RAW_DATA_BUFFER_SIZE + k ;
		}

		power[0] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k], g_adc_offset[0] ) );
		power[1] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k + 1], g_adc_offset[1] ) );
		power[2] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k], g_adc_offset[2] ) );
		power[3] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k + 1], g_adc_offset[3] ) );
	}
	power[0] /= avg_samples;
	power[1] /= avg_samples;
	power[2] /= avg_samples;
	power[3] /= avg_samples;

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

		for (i = 0; i < ( num_samples * 2 ) ; i += 2)
		{
			k = (int)g_raw_data_index - i - (avg_samples * 2);
			if (k < 0 )
			{
				k = RAW_DATA_BUFFER_SIZE + k ;
			}

			temp[0] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k], g_adc_offset[0] ) );
			temp[1] += signal_power( ADC_NORMALIZE( g_adc1_2_buffer[k + 1], g_adc_offset[1] ) );
			temp[2] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k], g_adc_offset[2] ) );
			temp[3] += signal_power( ADC_NORMALIZE( g_adc3_4_buffer[k + 1], g_adc_offset[3] ) );
		}

		temp[0] /= f_num_samples;
		temp[1] /= f_num_samples;
		temp[2] /= f_num_samples;
		temp[3] /= f_num_samples;

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

}*/
