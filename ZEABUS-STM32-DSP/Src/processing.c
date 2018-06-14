/*
 * processing.c
 *
 *  Created on: Jun 13, 2018
 *      Author: Vasut
 */

#include "common.h"
#include "processing.h"

float g_d_1_re[DATA_SIZE];
float g_d_1_im[DATA_SIZE];
float g_d_2_re[DATA_SIZE];
float g_d_2_im[DATA_SIZE];
float g_d_3_re[DATA_SIZE];
float g_d_3_im[DATA_SIZE];
float g_d_4_re[DATA_SIZE];
float g_d_4_im[DATA_SIZE];


void sampling(float*in1, float*in2, float*in3, float*in4,
		float*out1, float*out2, float*out3, float*out4){

	int i;
	int idx;
	for(i = 0; i < DATA_SIZE; i++){
		idx = i * SCALE_DOWN; // skip some sample in input for small sampling
		out1[i] = in1[idx];
		out2[i] = in2[idx];
		out3[i] = in3[idx];
		out4[i] = in4[idx];
	}

}

void demod(){

}


void processing(){

}

