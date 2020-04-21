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
 * Implementation of Biquad IIR filter operates as low-pass filter with the 
 * minimum pass-band frequency. From Matlab, Biquad filter is unstable with
 * the cut-off frequency less than or equal to 0.01 times the sampling rate.
 * Therefore, this implementation has the cut-off frequency just above this
 * unstable band. Hence, it is the minimum posible cut-off frequency.
 *
 * Digital filter has the frequency response related to the sampling frequency.
 * The cut-off frequencies usually speficied relatively to the sampling such as
 * 0.01 x fs.
 */

// This module decimates the input data at the rate of 1:5 and then applys a low-pass filter upon them.
// The cut-off frequency is fixed at 0.01 times of data sampling rate, now 200kHz. 
// The coefficients are:
//   Numerator : b0 = 0.25, b1 = 0.5, b2 = 0.25
//   Denominator : a0 = 1 (always), a1 = -1.91, a2 = 0.93
//   Gain : 0.01 (Original gain given by Matlab is 0.005 but later changed by the author)
//
// All IP modules here are combinational implementation. Therefore, the final result
// runs directly from the computaion stage to the next stage without any pipeline.
// Therefore, further synchronization should be performed in the packetizer module.
module biquad_lp_filter( 
	input clk_200kHz, 		// 200 kHz sampling clock
	input [19:0] din, 		// Input from IQ demod. This input connects to trigger's FIFO output through some IQ-demod logic
							// The input data is actually in the form of Q13.6. However, we pretend to divide it by 2^13 to be Q.19
							// This pretending does not cause any extra operation as we just scale it with the same bit length.
	output [15:0] dout 	// Output of the filter in the format of Q.15
	);

	// Numerators and denominators are represented in 18-bit fixed point number (Q1.16) 
	// Data input to multipliers are in the form of Q.24
	// Therefore, the output from each multiplier is in the form Q2.40.
	// The result from DSP48E1 multiplier is signed extended to become Q7.40 for further addition
	parameter coef_minus_a1 = 18'b01_1110_1000_1111_0110;		// 1.91 in Q1.16
	parameter coef_minus_a2 = 18'b11_0001_0001_1110_1100;		// -0.93 in Q1.16			

	// Since all nominators are in the form of 2^n (n = -1 and -2). We can use shifting instead of multiplication.
	// The common factor is -2 Therefore, we can pre-divide the data before entering the process
	// The coefficients aree [0.25 0.5 0.25] = [2^-2 2^-1 2^-2]
	reg [47:0] din_by_minus_2;
	reg [47:0] din_by_minus_2_d;
	reg [47:0] din_by_minus_2_dd;
	wire [47:0] din_by_minus_4;
	wire [47:0] din_dd_by_minus_4;
	
	initial
	begin
		din_by_minus_2 <= #1 48'b0;
		din_by_minus_2_d <= #1 48'b0;
		din_by_minus_2_dd <= #1 48'b0;
	end
	
	// Forward part (Numerator). This part can be performed by combinational logic.
	assign din_by_minus_4 = { din_by_minus_2[47], din_by_minus_2[47:1] };
	assign din_dd_by_minus_4 = { din_by_minus_2_dd[47], din_by_minus_2_dd[47:1] };

	always @(posedge clk_200kHz)
	begin
		din_by_minus_2_dd <= #1 din_by_minus_2_d;
		din_by_minus_2_d <= #1 din_by_minus_2;
		din_by_minus_2 <= #1 { {9{din[19]}}, din[18:0], 20'b0 };	// Change from Q.19	into Q7.40 and scale by 1/2
	end
	
	// Sum the forward part
	wire [47:0] FIR_part;
	assign FIR_part = din_by_minus_4 + din_by_minus_2_d + din_dd_by_minus_4;

	// Backward part (Denominator). This part must be perform by DSP slices or actual multiplication.
	// The DSP slice require input with length of 25 bits. The denominator coefficients are not in the form of 2^n
	// Therefore, we must perform actual multiplication here.
	// "out" is the result from 5 additions; thus, its value may be greater than 1.0. This is correct here.
	// The true output will be gained by 0.005 later. Hence, the rounded stage here will be from Q7.40 to Q5.24
	// As "out" is from adding 5 numbers together, Therefore, 3 bits addition is enough.
	wire [47:0] out;		// Final summation Q7.40
	wire [29:0] round_out;	// Rounded to Q5.24 of final 
	reg [29:0] out_d;		// Q5.24
	reg [29:0] out_dd;		// Q5.24
	
	initial
	begin
		out_d <= #1 30'b0;
		out_dd <= #1 30'b0;
	end
	
	assign round_out = { out[47], out[44:16] } + { 29'b0, out[15] };	// Rounding Q7.40 to Q5.24
	always @(posedge clk_200kHz)
	begin
		out_dd <= #1 out_d;
		out_d <= #1 (round_out === 30'bX) ? 30'b0 : round_out;
	end
	
	// IP module for multiply-add
	wire [47:0] mul1_out;		// Result from mul_minus_a2 Q7.40
	wire [47:0] mul2_out;		// Result from mul_minus_a2 Q7.40
	mult_30b_18b mul_minus_a2 (
		.A(out_dd),           	// input wire [29 : 0] A (Q5.24)
		.B(coef_minus_a2),    	// input wire [17 : 0] B (Q1.16)
		.P(mul1_out)      		// output wire [47 : 0] P (Q7.40)
	);
	mult_30b_18b mul_minus_a1 (
		.A(out_d),            	// input wire [29 : 0] A (Q5.24)
		.B(coef_minus_a1),    	// input wire [17 : 0] B (Q1.16)
		.P(mul2_out)           // output wire [47 : 0] P (Q7.40)
	);
	assign out = mul1_out + mul2_out + FIR_part;

	// Finally, the filter output is multiply by filter gain. This gain is stored in Q.17 format
	// 0.01 = +0.0000_0010_1000_1111_0101_1100_0010_1000
	//      = +1_0100_0111_1010_1110 (Q.17 * 2^-6)
	//      = { 1'b0, 17'd83886 } (Q.17 * 2^-6)
	// Data input is already rounded to the form Q5.24. Hence, the multiplication yields Q6.41 * 2^-6 (48 bits)
	// However, since the MSB of the gain is 0 (+ sign). The IP generator already truncates the extra MSB automatically.
	// Hence, the "raw_output" is in form (Q5.41 * 2^-5)
	wire [46:0] raw_output;
	gain0_005_mult gmult (
		.A(round_out),  		// input wire [29 : 0] A (Q5.24)
		.P(raw_output)  		// output wire [46 : 0] P (Q5.41 * 2^-5)
	);

	// Rounding the final result "out" to Q.15 format.
	// However, the "raw_output" should be multiplied by 2^-5 first. Considering the "raw_output" format,
	// which is Q5.41, the rounded result is just the normal rounding without any further shifting. 
	assign dout = raw_output[46:31] + { 15'b0, out[30] };	// Rounding Q5.41 to Q.15
endmodule
