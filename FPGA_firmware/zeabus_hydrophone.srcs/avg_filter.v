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

module avg64_filter(
	input [13:0] d_in,		// Data input
	
	output reg [15:0] d_out,	// Data output in format Q13.2
	
	input rst,				// Synchronous reset (active high)
	input clk_64MHz,			// System 64 MHz clock
	output reg clk_out			// Output clock. Data is updated at the rising edge. The propagation delay of output FF should be considered.
);

	reg [19:0] d_acc;		// Accumulator for channel 0
	
	wire [5:0] counter_q;
	
	// Counter instance
	c_counter_binary_0 avg_counter (
		.CLK(clk_64MHz),  // input wire CLK
		.Q(counter_q),  // output wire [5 : 0] Q
		.SCLR(rst)		// Synchronous clear
	);
	
	initial 
	begin
		d_acc <= 0;
		d_out <= 0;
		clk_out <= 1;
	end
	
	// Main operation
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			d_acc = 0;
		end
			
		if( counter_q == 0 )
		begin
			clk_out = 0;
			d_out = d_acc[19:4];
			d_acc = { d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13:0] };
		end
		else
		begin
			clk_out = 1;
			d_acc = d_acc + { d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13:0] };
		end
	end
endmodule