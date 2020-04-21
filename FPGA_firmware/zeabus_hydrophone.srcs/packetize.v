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

module packetizer (
	// Input ports
	input [127:0] d_in,		// Data input in 8x Q.15 format
	input in_valid,			// Data valid signal
	input in_strobe,		// Clock to latch the input data (at each posedge)
	
	// Output ports
	output [127:0] d_out,	// Output data
	output reg out_valid,	// Output data is valid
	output reg out_strobe,	// Clock to latch the output data (at each posedge)
	
	// Control ports
	input rst,				// System reset (active high)
	input clk_64MHz			// System clock
);

/* 
 ADC-stream packet format: 
	2 bytes: ID (fixed as 0xDCB0)
	2 bytes sequence: packet counter value. Maximum value is wrapped to 0 when counted.
	4 bytes time stamp: time since the system starts in milli-second. The maximum
        value is wrapped to 0 when counted. (It takes 46 days of continuous running to
        overflow!!!)
	n * 4 bytes: stream of "n" sampled data that satisfied the trigger
*/

	// States
	// Sub-state
	localparam SUBSTATE_SEND_DATA = 2'b00;
	localparam SUBSTATE_WAIT_1 = 2'b01;
	localparam SUBSTATE_SET_STROBE = 2'b10;
	localparam SUBSTATE_WAIT_2 = 2'b11;
	
	// Main state
	localparam STATE_IDLE = 3'b000;			// Waiting for in_valid and posedge in_strobe
	localparam STATE_SEND_HEADER = 3'b001; 	// Sending header data
	localparam STATE_SEND_FIRSTDATA = 3'b010; // Sending the first block of data
	localparam STATE_WAIT_STROBE = 3'b011;	// Waiting for input strobe signal
	localparam STATE_SEND_TAILING = 3'b111;	// Sending remaining data
	
	reg [1:0] sub_state;
	reg [2:0] main_state;

	reg [31:0] timer;
	reg [15:0] seq_cnt;
	reg [15:0] id;
	reg out_sel;							// Select whether d_out is data(1) or header(0)
	wire [127:0] pkt_header;
	
	assign pkt_header = { id, seq_cnt, timer, 64'b0 };

	initial
	begin
		id <= #1 16'hDCB0;
		out_sel <= #1 0;
		seq_cnt <= #1 16'b0;
		timer <= #1 32'b0;
		out_valid <= #1 0;
		out_strobe <= #1 0;
		sub_state <= #1 SUBSTATE_SEND_DATA;
		main_state <= #1 STATE_IDLE;
	end
	
	// Time counter
	reg [15:0] time_cnt;
	initial
	begin
		time_cnt <= #1 16'b0;
	end
	always @(posedge clk_64MHz)
	begin
		time_cnt <= #1 time_cnt + 1;
		if( time_cnt == 16'd64000 )
		begin
			time_cnt <= #1 16'b0;
			timer <= #1 timer + 32'b1;
		end
	end
	
	// Edge detector and input latch
	// 5-delay stage to avoid race condition.
	reg in_strb_ddddd, in_strb_dddd, in_strb_ddd, in_strb_dd, in_strb_d;
	always @(posedge clk_64MHz)
	begin
		in_strb_ddddd <= #1 in_strb_dddd;
		in_strb_dddd <= #1 in_strb_ddd;
		in_strb_ddd <= #1 in_strb_dd;
		in_strb_dd <= #1 in_strb_d;
		in_strb_d <= #1 in_strobe;
	end

	// Data are latched at the third clock and processed at the fourth clock.
	// This delay allow all combinational circuits in Biquad filter to stabilized.
	reg [127:0] latched_input;
	always @(posedge clk_64MHz)
	begin
		if( in_strb_ddd == 1 && in_strb_dddd == 0 )
			latched_input <= #1 d_in;
	end

	// Select the output
	assign d_out = (out_sel) ? latched_input : pkt_header;

	/*
	 * Sending data to SlaveFIFO requires 4 steps for each datum.
	 * 1. Send the output and reset strobe signal
	 * 2. Wait for 1 clock
	 * 3. set strobe signal
	 * 4. wait for 1 clock
	 * All steps are impements into a macro below
	 */ 
	`define sending(next_state, is_data) \
		case( sub_state ) \
			SUBSTATE_SEND_DATA: \
			begin \
				out_sel <= #1 is_data; \
				out_strobe <= #1 0; \
				sub_state <= #1 SUBSTATE_WAIT_1; \
			end \
			SUBSTATE_WAIT_1: \
			begin \
				sub_state <= #1 SUBSTATE_SET_STROBE; \
			end \
			SUBSTATE_SET_STROBE: \
			begin \
				out_strobe <= #1 1; \
				sub_state = #1 SUBSTATE_WAIT_2; \
			end \
			SUBSTATE_WAIT_2: \
			begin \
				main_state <= #1 next_state; \
				sub_state <= #1 SUBSTATE_SEND_DATA; \
			end \
		endcase
	
	// Main process
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			out_sel <= #1 0;
			out_valid <= #1 0;
			out_strobe <= #1 0;
			sub_state <= #1 SUBSTATE_SEND_DATA;
			main_state <= #1 STATE_IDLE;
		end
		else
		begin
			case( main_state )
				STATE_IDLE:
				begin
					if( in_valid && in_strb_dd == 0 && in_strb_d == 1 )
					begin
						seq_cnt <= #1 seq_cnt + 1;
						out_valid <= #1 1;
						main_state <= #1 STATE_SEND_HEADER;
					end
				end
				// Slave FIFO has clock speed at 64MHz which is much faster than data sending rate.
				// Therefore, we only save 1 backlog for header sending.
				// Each sub-state macro requires 4 clk_64MHz.
				STATE_SEND_HEADER:
				begin
					`sending( STATE_SEND_FIRSTDATA, 0 )
				end
				STATE_SEND_FIRSTDATA:
				begin
					`sending( STATE_WAIT_STROBE, 1 )
				end
				STATE_WAIT_STROBE:
				begin
					if( !in_valid )
					begin
						out_valid <= #1 0;
						main_state <= #1 STATE_IDLE;
					end
					else
						if( in_strb_dddd == 1 && in_strb_ddddd == 0 )
							main_state <= #1 STATE_SEND_TAILING;
				end
				STATE_SEND_TAILING:
				begin
					`sending( STATE_WAIT_STROBE, 1 )
				end
			endcase
		end
	end
endmodule
