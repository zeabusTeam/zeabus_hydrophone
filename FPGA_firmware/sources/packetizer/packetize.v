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

module packetizer #(
	parameter	SAMPLING_PER_PACKET = 1000	// Total sampling in a packet (max 1020)
    ) (
	// Debug output
	//output [4:0] debug_main_state,
	//output debug_strb_d,
	//output [15:0] pkt_size_counter,
	//output reg sending,		// Packetizer is in the middle of sending data

	// Input ports
	input [63:0] d_in,		// Data input from each channel
	input trigged,			// Indicates that the system can detect valid data
	input in_strobe,		// Clock to latch the input data (at logic 1 + posedge clk)

	// Output ports
	output reg [15:0] d_out,// Output data
	output reg pkt_end,		// 0 = nothing, 1 = current data is the last word
	output reg out_strobe,	// Clock to latch the output data (at each posedge)

	// Feedback from output buffer
	input out_full,			// Output buffer is almost full

	// Control ports
	input rst,				// System reset (active high)
	input clk			// System clock
);

/*
 ADC-stream packet format:
	2 bytes: ID (fixed as 0xDCB0)
	2 bytes sequence: packet counter value. Maximum value is wrapped to 0 when counted.
	4 bytes time stamp: time since the system starts in milli-second. The maximum
        value is wrapped to 0 when counted. (It takes 46 days of continuous running to
        overflow!!!)
	n * 8 bytes: stream of "n" sampled data that satisfied the trigger
*/

	localparam MAX_PKT_SIZE = 4 + (SAMPLING_PER_PACKET * 4);  // Maximum size of a packet

	// States
	localparam STATE_IDLE = 5'b00000;				// Waiting for trigged and posedge in_strobe
	localparam STATE_SEND_HEADER_SEQ = 5'b00001; 	// Sending header data (Sequence)
	localparam STATE_SEND_HEADER_TIME_H = 5'b00010; // Sending header data (Timestamp MSB)
	localparam STATE_SEND_HEADER_TIME_L = 5'b00011; // Sending header data (Timestamp LSB)
	localparam STATE_SEND_DATA_CH1 = 5'b00100; 		// Sending the following data (Channel 1)
	localparam STATE_SEND_DATA_CH2 = 5'b00101; 		// Sending the following data (Channel 2)
	localparam STATE_SEND_DATA_CH3 = 5'b00110; 		// Sending the following data (Channel 3)
	localparam STATE_SEND_DATA_CH4 = 5'b00111; 		// Sending the following data (Channel 4)
	localparam STATE_LATCH_LAST_WORD = 5'b01000;		// Latching CH4 to the output
	localparam STATE_WAIT_STROBE = 5'b01001;		// Waiting for input strobe signal

	// Output data selection
	localparam OUT_ID = 3'b000;				// d_out contains signature ID (0xDCB0)
	localparam OUT_SEQ = 3'b001;			// d_out contains packet sequence number
	localparam OUT_TIME_L = 3'b010;			// d_out contains low_word of time stamp
	localparam OUT_TIME_H = 3'b011;			// d_out contains high_word of time stamp
	localparam OUT_CH1 = 3'b100;			// d_out contains data from channel 1
	localparam OUT_CH2 = 3'b101;			// d_out contains data from channel 1
	localparam OUT_CH3 = 3'b110;			// d_out contains data from channel 1
	localparam OUT_CH4 = 3'b111;			// d_out contains data from channel 1

	reg [4:0] main_state;

	reg [31:0] timer;
	reg [15:0] seq_cnt;

	reg [2:0] out_sel;     	// Output data selection
	reg in_strb_d;
	
	reg [15:0] current_pkt_size;	// size of current packet
	
	//assign debug_main_state = main_state;
	//assign debug_strb_d = in_strb_d;
	//assign pkt_size_counter = current_pkt_size;

	initial
	begin
		out_sel <= OUT_ID;
		pkt_end <= 0;
		//sending <= 0;
		seq_cnt <= 16'b0;
		timer <= 32'b0;
		out_strobe <= 0;
		in_strb_d <= 0;
		main_state <= STATE_IDLE;
	end

	// Time counter
	reg [15:0] time_cnt;
	initial
	begin
		time_cnt <= 16'b0;
	end
	always @(posedge clk)
	begin
		time_cnt <= time_cnt + 1;
		if( time_cnt == 16'd64000 )
		begin
			time_cnt <= 16'b0;
			timer <= timer + 32'b1;
		end
	end

	// Edge detector and input latch
	always @(negedge clk)
	begin
		in_strb_d <= in_strobe;
	end

	// Data are latched at the middle of strobe signal
	reg [63:0] latched_input;
	initial
	begin
		latched_input <= 64'b0;
	end
	always @(posedge clk)
	begin
		if( in_strobe == 1 && in_strb_d == 0 && trigged )
			latched_input <= d_in;
	end

	// Select the output
	always @(*)
	begin
		case( out_sel )
			OUT_ID:
			begin
				d_out <= 16'hDCB0;
			end
			OUT_SEQ:
			begin
				d_out <= seq_cnt;
			end
			OUT_TIME_L:
			begin
				d_out <= timer[15:0];
			end
			OUT_TIME_H:
			begin
				d_out <= timer[31:16];
			end
			OUT_CH1:
			begin
				d_out <= latched_input[15:0];
			end
			OUT_CH2:
			begin
				d_out <= latched_input[31:16];
			end
			OUT_CH3:
			begin
				d_out <= latched_input[47:32];
			end
			OUT_CH4:
			begin
				d_out <= latched_input[63:48];
			end
		endcase
	end

	// Main process
	always @(negedge clk)
	begin
		if( rst )
		begin
			out_sel <= OUT_ID;
			pkt_end <= 0;
			//sending <= 0;
			out_strobe <= 0;
			main_state <= #1 STATE_IDLE;
		end
		else
		begin
			case( main_state )
				STATE_IDLE:
				begin
					current_pkt_size <= 16'b0;
					if( ( trigged && in_strb_d == 0 && in_strobe == 1 ) && !out_full )
					begin
						current_pkt_size <= 16'd4;
						seq_cnt <= seq_cnt + 1;
						//sending <= 1;
						out_strobe <= 1;
						out_sel <= OUT_ID;		// out header ID
						main_state <= STATE_SEND_HEADER_SEQ;
					end
				end
				// Slave FIFO has clock speed at 64MHz which is much faster than data sending rate.
				// Therefore, we only save 1 backlog for header sending.
				// Each sub-state macro requires 3 clk_64MHz.
				STATE_SEND_HEADER_SEQ:
				begin
					out_sel <= OUT_SEQ;		// out packet sequence, latch ID
					main_state <= STATE_SEND_HEADER_TIME_H;
				end
				STATE_SEND_HEADER_TIME_H:
				begin
					out_sel <= OUT_TIME_H;		// out timestamp (MSB), latch seq
					main_state <= STATE_SEND_HEADER_TIME_L;
				end
				STATE_SEND_HEADER_TIME_L:
				begin
					out_sel <= OUT_TIME_L;		// out timestamp (LSB), latch ts(msb)
					main_state <= STATE_SEND_DATA_CH1;
				end
				STATE_SEND_DATA_CH1:
				begin
					out_strobe <= 1;		// Redundant for data sending loop
					current_pkt_size <= current_pkt_size + 16'd4;
					out_sel <= OUT_CH1;		// out CH1 sampling, latch ts(lsb), or xxx
					main_state <= STATE_SEND_DATA_CH2;
				end
				STATE_SEND_DATA_CH2:
				begin
					out_sel <= OUT_CH2;		// out CH2 sampling, latch ch1
					main_state <= STATE_SEND_DATA_CH3;
				end
				STATE_SEND_DATA_CH3:
				begin
					out_sel <= OUT_CH3;		// out CH3 sampling, latch ch2
					main_state <= STATE_SEND_DATA_CH4;
				end
				STATE_SEND_DATA_CH4:
				begin
					out_sel <= OUT_CH4;		// out CH4 sampling, latch ch3
					if( ( current_pkt_size >= MAX_PKT_SIZE ) || !trigged || out_full )
					begin
						// Still have data but packet size reached max.
						// Close current packet and start new packet
					   	pkt_end <= 1;
					end
					main_state <= STATE_LATCH_LAST_WORD;
				end
				STATE_LATCH_LAST_WORD:
				begin
					out_strobe <= 0;
					pkt_end <= 0;
					if( ( current_pkt_size >= MAX_PKT_SIZE ) || !trigged )
					begin
						//sending <= 0;
						main_state <= STATE_IDLE;
					end
					else
					begin
						main_state <= STATE_WAIT_STROBE;
					end
				end
				STATE_WAIT_STROBE:
				begin
					if( !trigged )
					begin
						//sending <= 0;
						main_state <= STATE_IDLE;
					end
					else
					begin
						if( in_strobe == 1 && in_strb_d == 0 )
						begin
							main_state <= STATE_SEND_DATA_CH1;
						end
					end
				end

                default:        // Error!!! We should not be here
                begin
					out_sel <= OUT_ID;
					pkt_end <= 0;
					//sending <= 0;
					out_strobe <= 0;
					main_state <= #1 STATE_IDLE;
				end
			endcase
		end
	end
endmodule
