/*
 * abs_threshold.c
 *
 *  Created on: Jun 2, 2018
 *      Author: Vasut
 */
#include "common.h"
#include "abs_threshold.h"

int abs_threshold (){

	if(g_adc3_4_buffer[g_raw_data_index] > g_raw_front_thres){
		g_pulse_detect_index = g_raw_data_index;
		return 1;
	}

	return 0;
}

