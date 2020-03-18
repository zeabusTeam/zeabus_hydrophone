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

	reg [13:0] d;
	reg [13:0] dd;
	reg [13:0] ddd;	// Data propagation register
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
module avg64_filter(
	input [13:0] d_in,			// Data input
	
	output reg [15:0] d_out,		// Data output in format Q13.2
	
	input rst,					// Synchronous reset (active high)
	input clk_64MHz,			// System 64 MHz clock
	input clk_1MHz
);

	reg [19:0] d_acc;		// Accumulator for channel 0
	
	reg [5:0] counter_q;
		
	initial 
	begin
		counter_q <= 0;
		d_acc <= 0;
		d_out <= 0;
	end
	
	// Main operation
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			d_acc <= 0;
			counter_q <= 0;
		end
		else
		begin
			if( counter_q == 0 )
			begin
				d_out = d_acc[19:4];
				d_acc = { d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13:0] };
			end
			else
			begin
				d_acc = d_acc + { d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13], d_in[13:0] };
			end
			counter_q = counter_q + 1;
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
	input rst,				// Synchronous reset (active high)
	
	// Output data
	output [15:0] d0_out,	// Output from each ADC channel
	output [15:0] d1_out
);

	wire [13:0] d0;
	wire [13:0] d1;
	wire [13:0] d0_raw;
	wire [13:0] d1_raw;
	wire [13:0] d0_mean;
	wire [13:0] d1_mean;
	wire OTR_1, OTR_2;
	
	// Combination logic
	assign clk_a = clk_64MHz;
	assign clk_b = clk_64MHz;
	assign d0 = (!OTR_1) ? d0_raw : ( (d0_raw[13]) ? 14'h2000 : 14'h1FFF );
	assign d1 = (!OTR_1) ? d1_raw : ( (d1_raw[13]) ? 14'h2000 : 14'h1FFF );

	// Instantiation
	ADC_interface adc
	(
		.data_in_from_pins( { overflow, d_in } ), 				// input [14:0] data_in_from_pins
		.data_in_to_device( { OTR_2, d1_raw, OTR_1, d0_raw } ), // output [29:0] data_in_to_device
		.clk_in( clk_64MHz ), 									// input clk_in                            
		.io_reset( rst ) 										// input io_reset
	); 

	median_filter m_filter1( .clk(clk_64MHz), .rst(rst), .d_in(d0), .d_out(d0_mean) );
	median_filter m_filter2( .clk(clk_64MHz), .rst(rst), .d_in(d1), .d_out(d1_mean) );
	avg64_filter avg_filter1( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d0_mean), .d_out(d0_out) ); 
	avg64_filter avg_filter2( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d1_mean), .d_out(d1_out) ); 
endmodule
