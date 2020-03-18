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
	input [63:0] d_in,		// Data input in 4x Q13.2 format
	input in_valid,			// Data valid signal
	input in_strobe,		// Clock to latch the input data (at each posedge)
	
	// Output ports
	output reg [63:0] d_out,	// Output data
	output reg out_valid,		// Output data is valid
	output reg out_strobe,		// Clock to latch the output data (at each posedge)
	
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
	wire [63:0] pkt_header;
	
	assign pkt_header = { id, seq_cnt, timer };
	
	initial
	begin
		id <= 16'hDCB0;
		d_out <= 0;
		seq_cnt <= 0;
		timer <= 0;
		out_valid <= 0;
		out_strobe <= 0;
		sub_state <= SUBSTATE_SEND_DATA;
		main_state <= STATE_IDLE;
	end
	
	// Time counter
	reg [15:0] time_cnt;
	initial
	begin
		time_cnt <= 0;
	end
	always @(posedge clk_64MHz)
	begin
		time_cnt = time_cnt + 1;
		if( time_cnt == 16'd64000 )
		begin
			time_cnt = 0;
			timer = timer + 1;
		end
	end
	
	// Edge detector and input latch
	// 3-delay stage to avoid race condition.
	// Data are latched at the frist clock and processed at the second clock.
	reg in_strb_ddd, in_strb_dd, in_strb_d;
	reg [63:0] latched_input;
	always @(posedge clk_64MHz)
	begin
		in_strb_ddd <= in_strb_dd;
		in_strb_dd <= in_strb_d;
		in_strb_d <= in_strobe;
		if( in_strb_d == 1 && in_strb_dd == 0 )
			latched_input = d_in;
	end

	/*
	 * Sending data to SlaveFIFO requires 4 steps for each datum.
	 * 1. Send the output and reset strobe signal
	 * 2. Wait for 1 clock
	 * 3. set strobe signal
	 * 4. wait for 1 clock
	 * All steps are impements into a macro below
	 */ 
	`define sending(next_state, data) \
		case( sub_state ) \
			SUBSTATE_SEND_DATA: \
			begin \
				d_out = data; \
				out_strobe = 0; \
				sub_state = SUBSTATE_WAIT_1; \
			end \
			SUBSTATE_WAIT_1: \
			begin \
				sub_state = SUBSTATE_SET_STROBE; \
			end \
			SUBSTATE_SET_STROBE: \
			begin \
				out_strobe = 1; \
				sub_state = SUBSTATE_WAIT_2; \
			end \
			SUBSTATE_WAIT_2: \
			begin \
				main_state = next_state; \
				sub_state = SUBSTATE_SEND_DATA; \
			end \
		endcase
	
	// Main process
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			out_valid <= 0;
			out_strobe <= 0;
			sub_state <= SUBSTATE_SEND_DATA;
			main_state <= STATE_IDLE;
		end
		else
		begin
			case( main_state )
				STATE_IDLE:
				begin
					if( in_valid && in_strb_dd == 0 && in_strb_d == 1 )
					begin
						seq_cnt = seq_cnt + 1;
						out_valid = 1;
						main_state = STATE_SEND_HEADER;
					end
				end
				// Slave FIFO has clock speed at 64MHz which is much faster than data sending rate.
				// Therefore, we only save 1 backlog for header sending.
				STATE_SEND_HEADER:
				begin
					`sending( STATE_SEND_FIRSTDATA, pkt_header )
				end
				STATE_SEND_FIRSTDATA:
				begin
					`sending( STATE_WAIT_STROBE, latched_input )
				end
				STATE_WAIT_STROBE:
				begin
					if( !in_valid )
					begin
						out_valid = 0;
						main_state = STATE_IDLE;
					end
					else
						if( in_strb_dd == 1 && in_strb_ddd == 0 )
							main_state = STATE_SEND_TAILING;
				end
				STATE_SEND_TAILING:
				begin
					`sending( STATE_WAIT_STROBE, latched_input )
				end
			endcase
		end
	end
endmodule
