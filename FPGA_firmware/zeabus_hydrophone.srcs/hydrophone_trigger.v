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

// Helper module to get absolute value
module absolute( input [15:0] in, output [15:0] out );
	assign out = in[15] ? -in : in;
endmodule

// Main trigger module
module hydrophone_trigger
	#(
	parameter header = 1000,		// Number of d_in samples preceded of the trigged points
	parameter trigged_tailed = 1000,	// Number of d_in samples include in a valid data packet after the trigger level is not satisfied
	
	localparam total_tail = (header+trigged_tailed)	// Total tailling is the deisred tail plus the backlog in the buffer.
	) (
	input rst,					// system reset (active high)
	input clk,					// signal clock (1 MHz)
	input [63:0] d_in,			// data input (concatenation of 4 16-bit data)
	input [15:0] trigger_level,	// level of the trigger in 16-bit signed integer
	output [63:0] d_out,		// data output 
	output reg trigged,			// indicates that the data is part of packet of trigged signal
	
	// Debug
	output [63:0] debug_d, debug_r,
	output [15:0] debug_t
);

	// Variables
	reg [15:0] counter;			// Arbitary counter used in many states
	reg [1:0] trig_state;		// State of the trigger
	reg rd_en, wr_en;			// FIFO read and write enables
	
	wire [63:0] abs_d_in;		// Magnetude (aka. absolute) values of d_in
	wire [15:0] abs_trigger;	// Magnetude of trigger level
	
	assign debug_d = abs_d_in;
	assign debug_t = abs_trigger;
	assign debug_r = d_in;
	
	// Absolute implementation
	absolute abs1( .in(d_in[15:0]), .out(abs_d_in[15:0]) );
	absolute abs2( .in(d_in[31:16]), .out(abs_d_in[31:16]) );
	absolute abs3( .in(d_in[47:32]), .out(abs_d_in[47:32]) );
	absolute abs4( .in(d_in[63:48]), .out(abs_d_in[63:48]) );
	absolute abs5( .in(trigger_level), .out(abs_trigger) );
	
	// Helper function to compare trigger level with the signal
	function [0:0] trigger_compare( input [63:0] signal, input [15:0] trigger );
		if( trigger[15] )
		begin
			// trigger_level is negative
			if( ( $signed(signal[15:0]) <= $signed(trigger) ) ||
				( $signed(signal[31:16]) <= $signed(trigger) ) ||
				( $signed(signal[47:32]) <= $signed(trigger) ) ||
				( $signed(signal[63:48]) <= $signed(trigger) ) )
				trigger_compare = 1;
			else
				trigger_compare = 0;
		end
		else
		begin
			// trigger_level is positive
			if( ( signal[15:0] >= trigger ) ||
				( signal[31:16] >= trigger ) ||
				( signal[47:32] >= trigger ) ||
				( signal[63:48] >= trigger ) )
				trigger_compare = 1;
			else
				trigger_compare = 0;
		end
	endfunction
	
	// Initial block
	initial
	begin
		counter <= 16'b0;
		trig_state <= 2'b0;
		trigged <= 0;
		rd_en <= 0;
		wr_en <= 0;
	end
	
	// Main state machine
	always @(posedge clk)
	begin
		if( rst )
		begin
			// Reset signal asserted. Just initialize state
			counter <= 16'b0;
			trig_state <= 2'b0;
			trigged <= 0;
			wr_en <= 0;
			rd_en <= 0;
		end
		else
		begin
		    wr_en = 1;
			case (trig_state)
				2'b00:	// Fill the FIFO for "header" samples without reading out.
				begin
					counter = counter + 1;
					if( counter > header )
					begin
						rd_en <= 1'b1;
						trig_state <= 2'b01;
					end
				end
				2'b01:	// Waiting for trigger level.
				begin
					if( trigger_compare( abs_d_in, abs_trigger ) == 1 )
					begin
						trig_state <= 2'b10;	// Trigger found
						trigged <= 1;
						counter <= 16'b0;
					end
				end
				2'b10:	// Trigger found. gives the output
				begin
					if( trigger_compare( abs_d_in, abs_trigger ) == 1 )
					begin
						counter <= 16'b0;
					end
					else
					begin
						// If trigger level is no longer satisfied, count for packet tailing.
						counter = counter + 1;
						if( counter > total_tail )
						begin
							trig_state <= 2'b01;	// Back to trigger level waiting
							trigged <= 0;
						end
					end
				end
				2'b11:	// Error!!! We should not be here
				begin
					trigged <= 0;
					trig_state <= 2'b01;	// Go back to find trigger again
				end
			endcase
		end
	end

	// IP Instance 
	fifo_1024x64b_bram backlog_fifo (
		.srst(rst),		// input wire rst
		.clk(clk),  	// input wire clk
		.din(d_in),     // input wire [63 : 0] din
		.wr_en(wr_en),  // input wire wr_en
		.rd_en(rd_en),  // input wire rd_en
		.dout(d_out),   // output wire [63 : 0] dout
		.full(),    	// output wire full
		.empty()   		// output wire empty
	);

endmodule