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

module median_filter(
	input clk,			// System clock (each rising edge indicates new data is ready)
	input rst,			// Synchronous reset (active high)
	input [13:0] d_in,	// Input valid at clock rising edge
	output [13:0] d_out	// Data output
);

	reg [13:0] d, dd, ddd;	// Data propagation register
	wire [2:0] compare_res;	// Result of comparison of each pair
	
	// Combination logic
	assign compare_res[2] = ($signed(d) > $signed(dd))?1:0;
	assign compare_res[1] = ($signed(dd) > $signed(ddd))?1:0;
	assign compare_res[0] = ($signed(ddd) > $signed(d))?1:0;
	
	// Output assignment
	/* Median-of-three filter:
	      !(a > b) and !(b > c) (ignore a and c) => b 	(compare_res = 00x) => b
		  a <= b and b > c and a > c => a				(compare_res = 010) => a
		  a <= b and b > c and a <= c => c 				(compare_res = 011) => c
		  a > b and b <= c and a > c => c				(compare_res = 100) => c
		  a > b and b <= c and a <= c => a 				(compare_res = 101) => a
		  a > b and b > c (ignore a and c) => b 		(compare_res = 11x) => b
	*/
	assign d_out = ( compare_res[2:1] == 2'b11 || compare_res[2:1] == 3'b00 ) ? dd : ( compare_res == 3'b011 || compare_res == 3'b100 ) ? ddd : d;
		
	initial
	begin
		d <= 0;
		dd <= 0;
		ddd <= 0;
	end
	
	// Data delay
	always @(posedge clk)
	begin
		if( rst )
		begin
			d <= 0;
			dd <= 0;
			ddd <= 0;
		end
		else
		begin
			ddd <= dd;
			dd <= d;
			d <= d_in;
		end
	end
endmodule

//===============================================================
module adc_frontend(
	input clk,
	input overflow,				// Overflow flag
	input [13:0] d_in,			// Multiplexed data
	output reg [13:0] d0_out,	// Demultiplexed data channel 0
	output reg [13:0] d1_out	// Demultiplexed data channel 1
);
	
	initial
	begin
		d0_out <= 0;
		d1_out <= 0;
	end
	
	// Channel 0
	always @( posedge clk )
	begin
		if( overflow )
		begin
			// Overflow
			if( d_in[13] )
				d0_out <= 14'h3FFF;
			else
				d0_out <= 14'h1FFF;
		end
		else
		begin
			d0_out <= d_in;
		end
	end

	// Channel 1
	always @( negedge clk )
	begin
		if( overflow )
		begin
			// Overflow
			if( d_in[13] )
				d1_out <= 14'h2000;
			else
				d1_out <= 14'h1FFF;
		end
		else
		begin
			d1_out <= d_in;
		end
	end
endmodule

//===============================================================
// Abstract module for 1 ADC chip. We need 2 instances for each chip.
// Because each chip connects to different FPGA block, separating 
// interface instances allows synthesizer to plce each in corresponding block.
module adc_interface(
	// Interface to hardware
	input [13:0] d_in,		// Data channel from ADC chip
	input overflow,			// overflow flag from ADC chip
	output clk_a, clk_b,	// ADC clock. Both are identical
	
	// Control signals
	input clk_64MHz,		// System clock.
	input clk_64MHz_90,		// Identical of system clock with 90-degree phase lag
	input rst,				// Synchronous reset (active high)
	
	// Output data
	output [15:0] d0_out,	// Output from each ADC channel
	output [15:0] d1_out
);

	wire [13:0] d0, d1, d0_mean, d1_mean;
	
	// Combination logic
	assign clk_a = clk_64MHz;
	assign clk_b = clk_64MHz;

	// Instantiation
	adc_frontend adc( .clk(clk_64MHz_90), .overflow(overflow), .d_in(d_in), .d0_out(d0), .d1_out(d1) );
	median_filter m_filter1( .clk(clk_64MHz), .rst(rst), .d_in(d0), .d_out(d0_mean) );
	median_filter m_filter2( .clk(clk_64MHz), .rst(rst), .d_in(d1), .d_out(d1_mean) );
	avg64_filter avg_filter1( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d0_mean), .d_out(d0_out) ); 
	avg64_filter avg_filter2( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d1_mean), .d_out(d1_out) ); 
endmodule
