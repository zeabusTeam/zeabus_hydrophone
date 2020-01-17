`timescale 1ns / 1ps

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

module avg64_filter(
	input [13:0] d0_in,		// Data input channel 0
	input [13:0] d1_in,		// Data input channel 1
	input [13:0] d2_in,		// Data input channel 2
	input [13:0] d3_in,		// Data input channel 3
	
	output reg [15:0] d0_out,	// Data output channle 0 in format Q13.2
	output reg [15:0] d1_out,	// Data output channle 1 in format Q13.2
	output reg [15:0] d2_out,	// Data output channle 2 in format Q13.2
	output reg [15:0] d3_out,	// Data output channle 3 in format Q13.2
	
	input clk_64M,			// System 64 MHz clock
	output reg clk_out			// Output clock. Data is updated at the rising edge. The propagation delay of output FF should be considered.
);

	reg [19:0] d0_acc;		// Accumulator for channel 0
	reg [19:0] d1_acc;		// Accumulator for channel 1
	reg [19:0] d2_acc;		// Accumulator for channel 2
	reg [19:0] d3_acc;		// Accumulator for channel 3
	
	wire [5:0] counter_q;
	
	// Counter instance
	c_counter_binary_0 avg_counter (
		.CLK(clk_64M),  // input wire CLK
		.Q(counter_q)   // output wire [5 : 0] Q
	);
	
	initial 
	begin
		d0_acc <= 0;
		d1_acc <= 0;
		d2_acc <= 0;
		d3_acc <= 0;
		d0_out <= 0;
		d1_out <= 0;
		d2_out <= 0;
		d3_out <= 0;
	end
	
	// Main operation
	always @(posedge clk_64M)
	begin
		if( counter_q == 0 )
		begin
			clk_out = 1;
			d0_out = d0_acc[19:4];
			d1_out = d1_acc[19:4];
			d2_out = d2_acc[19:4];
			d3_out = d3_acc[19:4];
			d0_acc = { d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13:0] };
			d1_acc = { d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13:0] };
			d2_acc = { d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13:0] };
			d3_acc = { d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13:0] };
		end
		else
		begin
			clk_out = 0;
			d0_acc = d0_acc + { d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13], d0_in[13:0] };
			d1_acc = d1_acc + { d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13], d1_in[13:0] };
			d2_acc = d2_acc + { d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13], d2_in[13:0] };
			d3_acc = d3_acc + { d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13], d3_in[13:0] };
		end
	end
endmodule