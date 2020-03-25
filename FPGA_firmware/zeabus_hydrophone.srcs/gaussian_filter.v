`timescale 1ns / 10ps

// --------------------------------------------------------------------------------
// Copyright 2019-2020 Akrapong Patchararungruang.
// --------------------------------------------------------------------------------
// This file is a part of Zeabus hydrophone subsystem. It was built for the Zeabus
// autonomous underwater vehicle (AUV). The AUV project is funded by the Faculty
// of Engineering, Kasetsart University.
// --------------------------------------------------------------------------------
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// 3. Neither the name of the copyright holder nor the names of its contributors
//    may be used to endorse or promote products derived from this software without
//    specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
// OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// --------------------------------------------------------------------------------

/*
 * Filtering concepts
 *
 * The filter operates in the similar way as Enhanced Resolution (ERES) filter in LeCroy oscilloscope.
 * The original idea came from https://teledynelecroy.com/doc/differences-between-eres-and-hires
 * The key concept is the Gaussian FIR filter. The implementation algorithm is actually "weighted
 * averaging" where the current position has highest weight. The two samples which were acquired
 * one sample period previous and one sample period after that time are given less weight,
 * the two samples that were acquired at +2 and -2 sample periods are given even less weight in
 * computing the new sample and so forth for the length of the filter. Because we need "future"
 * samples according to the current position, the "current" sample cannot be the latest sample but
 * rather a "past" sample. Therefore, the filter is a lagging where some starting points are lost.
 *
 * The Teledyne document also states the effect of the filter upon the bandwidth of the signal and
 * the resolution of the output data. We chose to increase the resolution by 2 bits. Hence, we
 * should peocess 25 samples (12 "past" samples, 12 "future" samples, and 1 current sample).
 * The document does not state anything about the values of weights. We decided to follow
 * the concept of averaging. A key principle of averaging is that when all sample data
 * are same, the averaged result equal to the value of a sample. For example, if each datum is
 * 1, the average result is 1.
 *
 * Weights for each sample are chosen to optimize the processing resources according to digital
 * circuit mathematics. The "current" sample has the weight of 1.0. The +1 and -1 samples both
 * have the weight of 0.5 (i.e., 1/2). Then, the +2 and -2 samples have the weight of 0.25
 * (i.e., 1/4) and so on. With these sequence of weights, suppose that all sample data have
 * the value of 1, the summation of all weighted samples are 2.9995117. Hence, the final result
 * of the averaging process is the summation divided by 2.9995117. However, to make the process
 * simple, we just divide the summation by 3 instead.
 *
 * Implementing divide-by-3 is another challenge. Digital circuits operate with binary numbers.
 * All data should be represented in binary. Therefore, dividing with 3 does not normally fit
 * with the general basics of binary data. However, there is a very interesting information at
 * https://babbage.cs.qc.cuny.edu/courses/cs345/divideby3.xhtml showing the method of implementing
 * divide-by-3 in fixed-point number format. We chose to go on this way. This method based on
 * the representation of a fixed-point number, which is basically a scaling number. Dividing a
 * number by 3 can be said as multiplying that number by 1/3. Representing 1/3 in fixed-point
 * binary number becomes "0.010101....". This representation actually requires infinite number
 * of bits to represent the exact value (surprisingly the radix-10 representation of 1/3 is 0.3333...).
 * Therefore, a finite number of bits used in this case depends on required resolution.
 * In our case, we choose 0.01011, which is 0.34375. Multiplying this value with 2.9995117 yields
 * aproximately 1.0311, which is good enough. Implementing Z x 0.01011 is basically the calculation
 * of (Z / 4) + (Z / 16) + (Z / 32), which can be impemented as bit shifting and adding.
 *
 * Note: The concept of ERES may be patiented by Teledyne company. However, the official document
 * has not yet found at the time of this implementation. It is actually a general Gaussian FIR filter.
 * Hence, our implementation along with coefficent selection should be fine without any law violation.
 *
 */

module gaussian_filter(
	input clk,			// System clock (each rising edge indicates new data is ready)
	input rst,			// Synchronous reset (active high)
	input [13:0] d_in,	// Input valid at clock rising edge
	output [15:0] d_out	// Data output
);

	reg [13:0] d [0:24];	// 25 samples of data

	// Starting
	initial
	begin
		d[0] <= 0;	d[1] <= 0;	d[2] <= 0;	d[3] <= 0;	d[4] <= 0;
		d[5] <= 0;	d[6] <= 0;	d[7] <= 0;	d[8] <= 0;	d[9] <= 0;
		d[10] <= 0;	d[11] <= 0;	d[12] <= 0;	d[13] <= 0;	d[14] <= 0;
		d[15] <= 0;	d[16] <= 0;	d[17] <= 0;	d[18] <= 0;	d[19] <= 0;
		d[20] <= 0;	d[21] <= 0;	d[22] <= 0;	d[23] <= 0;	d[24] <= 0;
	end

	// Propagate data
	always @(posedge clk)
	begin
		if( rst )
		begin
			d[0] <= 0;	d[1] <= 0;	d[2] <= 0;	d[3] <= 0;	d[4] <= 0;
			d[5] <= 0;	d[6] <= 0;	d[7] <= 0;	d[8] <= 0;	d[9] <= 0;
			d[10] <= 0;	d[11] <= 0;	d[12] <= 0;	d[13] <= 0;	d[14] <= 0;
			d[15] <= 0;	d[16] <= 0;	d[17] <= 0;	d[18] <= 0;	d[19] <= 0;
			d[20] <= 0;	d[21] <= 0;	d[22] <= 0;	d[23] <= 0;	d[24] <= 0;
		end
		else
		begin
			d[0] <= d[1];	d[1] <= d[2];	d[2] <= d[3];	d[3] <= d[4];	d[4] <= d[5];
			d[5] <= d[6];	d[6] <= d[7];	d[7] <= d[8];	d[8] <= d[9];	d[9] <= d[10];
			d[10] <= d[11];	d[11] <= d[12];	d[12] <= d[13];	d[13] <= d[14];	d[14] <= d[15];
			d[15] <= d[16];	d[16] <= d[17];	d[17] <= d[18];	d[18] <= d[19];	d[19] <= d[20];
			d[20] <= d[21];	d[21] <= d[22];	d[22] <= d[23];	d[23] <= d[24];	d[24] <= d_in;
		end
	end

	// Filter steps
	// As the operations are in form of shifting and adding, we implement it combinationally.

	// 1. Multiply each data with corresponding weights. Multiplying is actually shifting.
	//    We just arrange the bits. The original data is 14 bits long. We need to divide
	//    the most distance samples with 2^12, equivalent to add 12 more bits to the right
	//    of data. The weighted samples are summarized together which requires 1 more bit
	//    in the MSB (all 1s add up to 2'b11). Therefore, we need 1 + 14 + 12 = 27 bits in total.
	//    The output format is Q15.12
	wire [26:0] weighted_data[0:24];

	assign weighted_data[0] = { {13{d[0][13]}}, d[0][13:0] };
	assign weighted_data[1] = { {12{d[1][13]}}, d[1][13:0], 1'b0 };
	assign weighted_data[2] = { {11{d[2][13]}}, d[2][13:0], 2'b0 };
	assign weighted_data[3] = { {10{d[3][13]}}, d[3][13:0], 3'b0 };
	assign weighted_data[4] = { {9{d[4][13]}}, d[4][13:0], 4'b0 };
	assign weighted_data[5] = { {8{d[5][13]}}, d[5][13:0], 5'b0 };
	assign weighted_data[6] = { {7{d[6][13]}}, d[6][13:0], 6'b0 };
	assign weighted_data[7] = { {6{d[7][13]}}, d[7][13:0], 7'b0 };
	assign weighted_data[8] = { {5{d[8][13]}}, d[8][13:0], 8'b0 };
	assign weighted_data[9] = { {4{d[9][13]}}, d[9][13:0], 9'b0 };
	assign weighted_data[10] = { {3{d[10][13]}}, d[10][13:0], 10'b0 };
	assign weighted_data[11] = { {2{d[11][13]}}, d[11][13:0], 11'b0 };
	assign weighted_data[12] = { {1{d[12][13]}}, d[12][13:0], 12'b0 };
	assign weighted_data[13] = { {2{d[13][13]}}, d[13][13:0], 11'b0 };
	assign weighted_data[14] = { {3{d[14][13]}}, d[14][13:0], 10'b0 };
	assign weighted_data[15] = { {4{d[15][13]}}, d[15][13:0], 9'b0 };
	assign weighted_data[16] = { {5{d[16][13]}}, d[16][13:0], 8'b0 };
	assign weighted_data[17] = { {6{d[17][13]}}, d[17][13:0], 7'b0 };
	assign weighted_data[18] = { {7{d[18][13]}}, d[18][13:0], 6'b0 };
	assign weighted_data[19] = { {8{d[19][13]}}, d[19][13:0], 5'b0 };
	assign weighted_data[20] = { {9{d[20][13]}}, d[20][13:0], 4'b0 };
	assign weighted_data[21] = { {10{d[21][13]}}, d[21][13:0], 3'b0 };
	assign weighted_data[22] = { {11{d[22][13]}}, d[22][13:0], 2'b0 };
	assign weighted_data[23] = { {12{d[23][13]}}, d[23][13:0], 1'b0 };
	assign weighted_data[24] = { {13{d[24][13]}}, d[24][13:0] };

	// 2. Sum all weighted samples
	//    The output format is Q15.12
	wire [26:0] weighted_sum;

	assign weighted_sum = weighted_data[0] + weighted_data[1] + weighted_data[2] + weighted_data[3] + weighted_data[4] +
						weighted_data[5] + weighted_data[6] + weighted_data[7] + weighted_data[8] + weighted_data[9] +
						weighted_data[10] + weighted_data[11] + weighted_data[12] + weighted_data[13] + weighted_data[14] +
						weighted_data[15] + weighted_data[16] + weighted_data[17] + weighted_data[18] + weighted_data[19] +
						weighted_data[20] + weighted_data[21] + weighted_data[22] + weighted_data[23] + weighted_data[24];

	// 3. Generate partial division for 0.01011. Here, we need more 5 bits on the right for division.
	//    Therefore, total data bits is now 27 + 5 = 32
	//    The output format is Q15.17

	wire [31:0]p1;
	wire [31:0]p2;
	wire [31:0]p3;

	assign p1 = { {2{weighted_sum[26]}}, weighted_sum[26:0], 3'b0 };
	assign p2 = { {4{weighted_sum[26]}}, weighted_sum[26:0], 1'b0 };
	assign p3 = { {5{weighted_sum[26]}}, weighted_sum[26:0] };

	// 4. Sum the partial division terms
	//    The output format is Q15.17
	wire [31:0] result;

	assign result = p1 + p2 + p3;

	// Extract the final data and round the result.
	//    The input format is Q15.17
	assign d_out = result[31:16] + { 15'b0, result[15] };
endmodule
