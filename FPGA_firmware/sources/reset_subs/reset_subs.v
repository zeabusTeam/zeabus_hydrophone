`timescale 1ns / 1ns

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

/* Mudule to control timing of reset signal. After a reset event, either power-on
 * or RST asserted, the reset signal output remains active for 16 clock cycles
 */
module reset_subs(
	// Control input
	input clk,			// Master clock
	input rst_in,		// Master reset (active high)
	input pll_locked, 	// Flag indicates that PLL module for clock gen is locked
	
	// Ouput
	output rst_out
);

	localparam reset_hold_time = 16;
	
	reg [7:0] hold_counter;
	wire is_ready;
	reg rst;
	
	assign is_ready = pll_locked & ~rst_in;	// 0 = System is not ready (rst_out must be active)
	assign rst_out = rst | ~is_ready;
	
	initial begin
		hold_counter <= reset_hold_time;
		rst <= 1;
	end

	// Main sequencer
	always @(posedge clk)
	begin
		if( !is_ready )
		begin
			hold_counter <= reset_hold_time;
			rst <= 1;
		end
		else
		begin
			if( hold_counter > 0 )
			begin
				hold_counter <= hold_counter - 1;
				rst <= 1;
			end
			else
			begin
				rst <= 0;
			end
		end
	end
endmodule
