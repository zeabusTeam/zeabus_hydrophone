/*
 * processing.h
 *
 *  Created on: Jun 14, 2018
 *      Author: Vasut
 */

#ifndef PROCESSING_H_
#define PROCESSING_H_

#include <stdint.h>

void sampling(float*in1, float*in2, float*in3, float*in4,
		float*out1, float*out2, float*out3, float*out4);

extern float g_d_1_re[];
extern float g_d_1_im[];
extern float g_d_2_re[];
extern float g_d_2_im[];
extern float g_d_3_re[];
extern float g_d_3_im[];
extern float g_d_4_re[];
extern float g_d_4_im[];

#endif /* PROCESSING_H_ */
