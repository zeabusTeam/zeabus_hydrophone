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

float time = BUFFER_SIZE / SAMPLE_RATE * 1000; // multiple 1000 for change to ms


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

void demod(float*in1, float*in2, float*in3, float*in4,
		float*out1_re, float*out1_im, float*out2_re, float*out2_im,
		float*out3_re, float*out3_im, float*out4_re, float*out4_im,
		float fo){

	int i = 0,n = 0;
	float wt = 0 , sin_wt, cos_wt;
	const float w = (2 * PI * (fo / 1000) * time) / DATA_SIZE;
	for (i = 0; i < DATA_SIZE; i++) {
		wt = ((float)i * w);
		sin_wt = arm_sin_f32(x);
		cos_wt = arm_cos_f32(x);
		out1_re[i] = cos_wt * in1[i];
		out1_im[i] = sin_wt * in1[i];
		out2_re[i] = cos_wt * in1[i];
		out2_im[i] = sin_wt * in1[i];
		out3_re[i] = cos_wt * in1[i];
		out3_im[i] = sin_wt * in1[i];
		out4_re[i] = cos_wt * in1[i];
		out4_im[i] = sin_wt * in1[i];
	}

}


void processing(){

}

