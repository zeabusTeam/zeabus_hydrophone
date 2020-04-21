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
module absolute( input [19:0] in, output [19:0] out );
	assign out = in[19] ? -in : in;
endmodule

// Main trigger module
// Outut data is valid at the rising edge of the next clock after the "trigged" signal
module hydrophone_trigger
	#(
	parameter header = 64,		// Number of d_in samples preceded of the trigged points
	parameter trigged_tailed = 64,	// Number of d_in samples include in a valid data packet after the trigger level is not satisfied
	
	localparam total_tail = (header+trigged_tailed)	// Total tailling is the deisred tail plus the backlog in the buffer.
	) (
	input rst,					// system reset (active high)
	input clk,					// signal clock (1 MHz)
	input [79:0] d_in,			// data input (concatenation of 4 16-bit data) all in format Q13.6
	input [15:0] trigger_level,	// level of the trigger in 16-bit signed integer in format Q13.2
	output [79:0] d_out,		// data output  all in format Q13.6
	output reg trigged			// indicates that the data is part of packet of trigged signal
);

	// Variables
	reg [15:0] h_counter;		// Fifo backlog data counter
	reg [15:0] t_counter;		// Counter for packet tailing
	reg rd_en, wr_en;			// FIFO read and write enables
	
	wire [79:0] abs_d_in;		// Magnetude (aka. absolute) values of d_in
	wire [19:0] abs_trigger;	// Magnetude of trigger level
	
	// Absolute implementation
	absolute abs1( .in(d_in[19:0]), .out(abs_d_in[19:0]) );
	absolute abs2( .in(d_in[39:20]), .out(abs_d_in[39:20]) );
	absolute abs3( .in(d_in[59:40]), .out(abs_d_in[59:40]) );
	absolute abs4( .in(d_in[79:60]), .out(abs_d_in[79:60]) );
	absolute abs5( .in( { trigger_level, 4'b0 } ), .out(abs_trigger) );
	
	// Initial block
	initial
	begin
		h_counter <= #1 16'b0;
		t_counter <= #1 16'b0;
		trigged <= #1 0;
		rd_en <= #1 0;
		wr_en <= #1 0;
	end
	
	// Main state machine
	always @(posedge clk)
	begin
		if( rst )
		begin
			// Reset signal asserted. Just initialize state
			h_counter <= #1 16'b0;
			t_counter <= #1 16'b0;
			trigged <= #1 0;
			wr_en <= #1 0;
			rd_en <= #1 0;
		end
		else
		begin
		    wr_en = #1 1;
			
			// For FIFO-thread safety we need to fill it with some data first
			// FIFO is configured in First-Word-Fall-Through mode which has 1-clock delay latency
			// The input data at the very beginning after reset should not be used though
			if( h_counter < header )
			begin
				h_counter <= #1 h_counter + 1;
			end
			else
			begin
				rd_en <= #1 1;
				if( ( abs_d_in[19:0] >= abs_trigger ) ||
					( abs_d_in[39:20] >= abs_trigger ) ||
					( abs_d_in[59:40] >= abs_trigger ) ||
					( abs_d_in[79:60] >= abs_trigger ) )
				begin
					// Trigged
					trigged <= #1 1;
					rd_en <= #1 1;
					t_counter <= trigged_tailed;
				end
				else
				begin
					if( t_counter == 0 )
					begin
						trigged <= #1 0;
					end
					else
					begin
						// Still retain the "trigged" condition
						t_counter <= #1 t_counter - 1;
					end
				end
			end
		end
	end

	// IP Instance 
	fifo_1024x64b_bram backlog_fifo (
		.srst(rst),		// input wire rst
		.clk(clk),  	// input wire clk
		.din(d_in),     // input wire [79 : 0] din
		.wr_en(wr_en),  // input wire wr_en
		.rd_en(rd_en),  // input wire rd_en
		.dout(d_out),   // output wire [79 : 0] dout
		.full(),    	// output wire full
		.empty()   		// output wire empty
	);

endmodule