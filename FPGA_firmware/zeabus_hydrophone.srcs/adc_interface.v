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

module sort(
	input [13:0] din_0,
	input [13:0] din_1,
	output [13:0] dout_0,	// The small
	output [13:0] dout_1	// The big
);

	assign dout_0 = ($signed(din_0) > $signed(din_1)) ? din_1 : din_0;
	assign dout_1 = ($signed(din_0) > $signed(din_1)) ? din_0 : din_1;
endmodule
	

module median_filter(
	input clk,			// System clock (each rising edge indicates new data is ready)
	input rst,			// Synchronous reset (active high)
	input [13:0] d_in,	// Input valid at clock rising edge
	output [13:0] d_out	// Data output
);
	reg [13:0] d[0:4];	// We have 5 backlog
	
	initial
	begin
		d[0] <= 0; d[1] <= 0; d[2] <= 0; d[3] <= 0; d[4] <= 0;
	end
	// data delay line
	always @(posedge clk)
	begin
		if( rst )
		begin
			d[0] <= 0; d[1] <= 0; d[2] <= 0; d[3] <= 0; d[4] <= 0;
		end
		else
		begin
			d[0] <= #1 d[1];
			d[1] <= #1 d[2];
			d[2] <= #1 d[3];
			d[3] <= #1 d[4];
			d[4] <= #1 d_in;
		end
	end

	// We use bubble-sort stages to find the median.
	// Since we have 5 items, we need 4 full bubble sort stages plus 1 partial sort
	wire [13:0] stage1[0:4];
	wire [13:0] stage2[0:4];
	wire [13:0] stage3[0:4];
	wire [13:0] stage4[0:4];
	
	// Stage1
	sort s1_0( d[0], d[1], stage1[0], stage1[1] );
	sort s1_1( d[2], d[3], stage1[2], stage1[3] );
	assign stage1[4] = d[4];
	
	// Stage2
	assign stage2[0] = stage1[0];
	sort s2_0( stage1[1], stage1[2], stage2[1], stage2[2] );
	sort s2_1( stage1[3], stage1[4], stage2[3], stage2[4] );
	
	// Stage3
	sort s3_0( stage2[0], stage2[1], stage3[0], stage3[1] );
	sort s3_1( stage2[2], stage2[3], stage3[2], stage3[3] );
	assign stage3[4] = stage2[4];

	// Stage4
	assign stage4[0] = stage3[0];
	sort s4_0( stage3[1], stage3[2], stage4[1], stage4[2] );
	sort s4_1( stage3[3], stage3[4], stage4[3], stage4[4] );
	
	// Finally we got the median
	wire [13:0] unused;
	sort s5( stage4[2], stage4[3], d_out, unused );
endmodule

//===============================================================
module avg64_binning(
	input [13:0] d_in,			// Data input
	
	output reg [19:0] d_out,	// Data output in format Q13.6
	
	input rst,					// Synchronous reset (active high)
	input clk_64MHz				// System 64 MHz clock
);

	reg [19:0] d_acc;		// Accumulator
	
	reg [5:0] counter_q;
		
	initial 
	begin
		counter_q <= #1 0;
		d_acc <= #1 0;
		d_out <= #1 0;
	end
	
	// Main operation
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			d_acc <= #1 0;
			counter_q <= #1 0;
		end
		else
		begin
			if( counter_q == 0 )
			begin
				d_out <= #1 d_acc;
				d_acc <= #1 { {6{d_in[13]}}, d_in[13:0] };
			end
			else
			begin
				d_acc <= #1 d_acc + { {6{d_in[13]}}, d_in[13:0] };
			end
			counter_q <= #1 counter_q + 1;
		end
	end
endmodule

//===============================================================
// Abstract module for 1 ADC chip. We need 2 instances for each chip.
// Because each chip connects to different FPGA block, separating 
// interface instances allows synthesizer to plce each in corresponding block.
//
// 3 stages pipeline
//
module adc_interface(
	// Interface to hardware
	input [13:0] d_in,		// Data channel from ADC chip
	input overflow,			// overflow flag from ADC chip
	output clk_a, clk_b,	// ADC clock. Both are identical
	
	// Control signals
	input clk_64MHz,		// System clock.
	input rst,				// Synchronous reset (active high)
	
	// Output data
	output [19:0] d0_out,	// Output from each ADC channel in Q13.6
	output [19:0] d1_out
);

	wire [13:0] d0_raw;
	wire [13:0] d1_raw;
	wire OTR_1, OTR_2;

	wire [13:0] d0;
	wire [13:0] d1;
	
	wire [13:0] d0_mean;
	wire [13:0] d1_mean;
	
	assign clk_a = clk_64MHz;
	assign clk_b = clk_64MHz;

	// Sequence of signal elements
	
	// Input interface and de-multiplexer (Verify the channel order before real implementation!!!)
	ADC_interface adc
	(
		.data_in_from_pins( { overflow, d_in } ), 				// input [14:0] data_in_from_pins
//		.data_in_to_device( { OTR_2, d1_raw, OTR_1, d0_raw } ), // output [29:0] data_in_to_device
		.data_in_to_device( { OTR_1, d0_raw, OTR_2, d1_raw } ), // output [29:0] data_in_to_device
		.clk_in( clk_64MHz ), 									// input clk_in                            
		.io_reset( rst ) 										// input io_reset
	); 

	// Pre-processing to cover overflow signal
	assign d0 = (!OTR_1) ? d0_raw : ( (d0_raw[13]) ? 14'h2000 : 14'h1FFF );
	assign d1 = (!OTR_2) ? d1_raw : ( (d1_raw[13]) ? 14'h2000 : 14'h1FFF );

	// Input filter 64 MS/s.
	median_filter m_filter1( .clk(clk_64MHz), .rst(rst), .d_in(d0), .d_out(d0_mean) );
	median_filter m_filter2( .clk(clk_64MHz), .rst(rst), .d_in(d1), .d_out(d1_mean) );
	
	// Down sampling 64 MS/s => 1 MS/s. Also increasing the resolution from 14 bits to 16 bits.
	avg64_binning avg_binning1( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d0_mean), .d_out(d0_out) ); 
	avg64_binning avg_binning2( .clk_64MHz(clk_64MHz), .rst(rst), .d_in(d1_mean), .d_out(d1_out) ); 
endmodule
