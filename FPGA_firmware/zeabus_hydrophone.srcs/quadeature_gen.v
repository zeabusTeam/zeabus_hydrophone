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
 * Pinger frequency in Robosub can be set to 25kHz - 40kHz with 1kHz step.
 * Threfore, there are 16 total frequencies. This module always generates outputs
 * regardless of resetting state.
 *
 * The algorithm is derived from https://zipcpu.com/blog/2017/06/02/generating-timing.html
 */

module q_wave_gen( 
	input [3:0] freq_select,  	// Select the frequency of choice 0 = 25kHz ... 15 = 40kHz
	input clk_64MHz,			// 64 MHz system clock
	output reg i_clk,			// In-phase clock output
	output reg q_clk 			// Quadrature clock output
	);
	
	// Look-up table for counter
	localparam counter_25kHz = 32'd6710886;
	localparam counter_26kHz = 32'd6979322;
	localparam counter_27kHz = 32'd7247757;
	localparam counter_28kHz = 32'd7516193;
	localparam counter_29kHz = 32'd7784628;
	localparam counter_30kHz = 32'd8053064;
	localparam counter_31kHz = 32'd8321499;
	localparam counter_32kHz = 32'd8589935;
	localparam counter_33kHz = 32'd8858370;
	localparam counter_34kHz = 32'd9126806;
	localparam counter_35kHz = 32'd9395241;
	localparam counter_36kHz = 32'd9663676;
	localparam counter_37kHz = 32'd9932112;
	localparam counter_38kHz = 32'd10200547;
	localparam counter_39kHz = 32'd10468983;
	localparam counter_40kHz = 32'd10737418;

	reg clk_strb;					// Strobe signal
	reg [31:0] counter;				// clock counter for divider
	reg [31:0] counter_step[0:15];	// a value from the table above
	
	initial
	begin
		clk_strb <= #1 0;
		counter <= #1 32'b0;
		counter_step[0] <= #1 counter_25kHz;
		counter_step[1] <= #1 counter_26kHz;
		counter_step[2] <= #1 counter_27kHz;
		counter_step[3] <= #1 counter_28kHz;
		counter_step[4] <= #1 counter_29kHz;
		counter_step[5] <= #1 counter_30kHz;
		counter_step[6] <= #1 counter_31kHz;
		counter_step[7] <= #1 counter_32kHz;
		counter_step[8] <= #1 counter_33kHz;
		counter_step[9] <= #1 counter_34kHz;
		counter_step[10] <= #1 counter_35kHz;
		counter_step[11] <= #1 counter_36kHz;
		counter_step[12] <= #1 counter_37kHz;
		counter_step[13] <= #1 counter_38kHz;
		counter_step[14] <= #1 counter_39kHz;
		counter_step[15] <= #1 counter_40kHz;
	end

	// Strobe control
	always @(posedge clk_64MHz)
		{ clk_strb, counter } <= #1 counter + counter_step[freq_select];
	
	// Output control
	always @(posedge clk_64MHz)
	begin
		if( clk_strb )
		begin
			case( {i_clk, q_clk} )
				2'b11 : {i_clk, q_clk} <= #1 2'b10;
				2'b10 : {i_clk, q_clk} <= #1 2'b00;
				2'b00 : {i_clk, q_clk} <= #1 2'b01;
				2'b01 : {i_clk, q_clk} <= #1 2'b11;
			endcase
		end
	end
endmodule
