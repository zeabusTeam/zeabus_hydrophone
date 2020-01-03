`timescale 1ns / 1ps

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

module fx3s_interface #(
	// Address value
	localparam addr_write = 1'b1,
	localparam addr_read = 1'b0,

	// State value
	localparam state_idle = 4'b0000,
	localparam state_start_read = 4'b0001,
	localparam state_enable_read = 4'b0010,
	localparam state_read_wait_1 = 4'b0011,
	localparam state_reading = 4'b0100,
	localparam state_reading_fin = 4'b0101,
	localparam state_start_write = 4'b0110,
	localparam state_write_wait_1 = 4'b0111,
	localparam state_writing = 4'b1000,
	localparam state_write_wait_2 = 4'b1001,
	localparam state_write_ZLP = 4'b1010,
	localparam state_write_fin = 4'b1011
	) (
	// Device pins
	output ifclk_out,				// Communication clock from FPGA -> FX3S (FPGA controlled)
	inout [15:0] DQ,				// Data bus
	output [1:0] A,					// Address to specified DMA channels
	output reg SLCS,				// Chip select signal to FX3S (Active low)
	output reg SLWR, SLRD,	        // Read/Write flag (Active low)
	output reg SLOE, 				// Enable FX3S -> FPGA data direction (Active low)
	output reg PKTEND,				// Writing a short packet or zero-length packet (Used to indicate end of data) (Active low)
	input FLAGA, FLAGB, FLAGD,		// Flags from FX3S use to indicates almost full or empty of DMA buffer. (Active Low)
									// FLAGA : indicates that FX3S has some data to read.
									// FLAGB : indicates that FX3S has some spacce to accept more data
									// FLAGD : unused
									// Important Note: FLAGB has 3-clock delay. Thus, it must indicate "almost" full to aviod overrun.

	// Control signal
	input clk_64M,					// Master clock for this module (64 MHz 0-degree)
	input rst,						// Synchronous reset (active high)
	output rdy,						// Indicate that the system is ready for data

	// Data to send out (FPGA -> FX3S)
	input [63:0] d_in,				// Input data to send to FX3S
	input input_valid,				// Indicates that the d_in value is valid
	input input_d_clk,				// Clocking for data input (data valid at posedge)
	output input_full,				// Flag to indicate that the buffer for departure data is full

	// Arrival data (FX3S -> FPGA)
	output [15:0] d_out,			// Output data
	output output_valid,			// Indicate that there are some available data to read
	input  output_d_oe,				// Enable read-out data
	input  output_d_clk			// Clocking for data reading
	);

	// This module use FIFO to store incoming and outgoing data
	// The FIFO size for arrival data is 32 16-bit words.
	// The FIFO size for departure data is 1024 64-bit words.
	wire	dep_wr_rst_busy, dep_rd_rst_busy, arr_wr_rst_busy, arr_rd_rst_busy;
	wire	[15:0] departure_data;
	wire	[15:0] arrival_data;
	wire	arrival_empty, arrival_full, departure_empty;	// Full and empty FIFO flag
	wire	arrival_rd_en;
	wire	departure_wr_en;
	reg		arrival_wr_en, departure_rd_en;	// FIFO write and read enable controlled by state machine
	reg		is_sending;				// Indicate current data direction: 0 = FX3S -> FPGA, 1 = FPGA -> FX3S
	reg [3:0] master_state;			// State of the interface

	//************************************************************
	// Combination logic
	//************************************************************
	assign ifclk_out = clk_64M;		// Slave FIFO interface operates at 64 MHz

	// Reset and ready signals
	assign A[1] = 0;				// A[1] is always 0. We use only A[0] bit
	assign A[0] = is_sending;		// Data direction bit is designed to be equal to A[0]
	assign rdy = !( dep_wr_rst_busy | dep_rd_rst_busy | arr_wr_rst_busy | arr_rd_rst_busy );
	assign departure_wr_en = input_valid & !dep_wr_rst_busy;
	assign output_valid = !arrival_empty & !arr_rd_rst_busy;
	assign arrival_rd_en = output_d_oe & !arr_rd_rst_busy;

	// MUX and DEMUX DQ pins with 2 internal sub-systems
	assign arrival_data = (!is_sending) ? DQ : 16'b0;
	assign DQ = (is_sending) ? departure_data : 16'bz;

	//************************************************************
	// Initialization
	//************************************************************
	initial begin
		SLCS <= 1;
		SLWR <= 1;
		SLRD <= 1;
		SLOE <= 1;
		PKTEND <= 1;
		is_sending <= 0;
		arrival_wr_en <= 0;
		departure_rd_en <= 0;
		master_state <= state_idle;
	end

	//************************************************************
	// Behavioral blocks
	//************************************************************
	// Main process
	/*
	 * State transition table (FLAGA and FLAGB are active low)
	 * ------------------------------------------------------------------------------------
	 *  State | Meaning      | Input condition                 |  Next State | Action
	 * ------------------------------------------------------------------------------------
	 * 	 0000 | Idle         | !arrival_full && !FLAGA         | 0001        |
	 *        |              | !departure_empty && !FLAGB      | 0110        |
	 * ------------------------------------------------------------------------------------
	 *   0001 | Start read   | 1                               | 0010        | SLCS = 0, is_sending = 0 (3 cycles delay)
	 * ------------------------------------------------------------------------------------
	 *   0010 | Enable read  | 1                               | 0011        | SLOE = 0, SLRD = 0
	 * ------------------------------------------------------------------------------------
	 *   0011 | Read wait 1  | 1                               | 0100        | arrival_wr_en = 1
	 * ------------------------------------------------------------------------------------
	 *   0100 | Reading      | FLAGA || arrival_full           | 0101        | arrival_wr_en = 0, SLRD = 1, SLOE = 1, SLCS = 1
	 * ------------------------------------------------------------------------------------
	 *   0101 | Reading Fin  | 1                               | 0000        |
	 * ------------------------------------------------------------------------------------
	 *   0110 | Start write  | 1                               | 0111        | SLCS = 1, is_sending = 1
	 * ------------------------------------------------------------------------------------
	 *   0111 | Write wait 1 | 1                               | 1000        | departure_rd_en = 1, SLWR = 0
	 * ------------------------------------------------------------------------------------
	 *   1000 | Writing      | departure_empty && !input_valid | 1010        | departure_rd_en = 0, SLWR = 1, PKTEND = 0, is_sending = 0 (Finish)
	 *        |              | FLAGB                           | 1001        | departure_rd_en = 0, SLWR = 1 (FX3S buffer is full)
	 * ------------------------------------------------------------------------------------
	 *   1001 | Write wait 2 | !FLAGB                          | 1000        | departure_rd_en = 1, SLWR = 0 (Wait for FX3S to ready again)
	 * ------------------------------------------------------------------------------------
	 *   1010 | Write ZLP    | 1                               | 1011        | PKTEND = 1, SLCS = 1
	 * ------------------------------------------------------------------------------------
	 *   1011 | Write Fin    | 1                               | 0000        |
	 * ------------------------------------------------------------------------------------
	 * ------------------------------------------------------------------------------------

	 */
	always @(posedge clk_64M)
	begin
		if( rst )
		begin
			SLCS <= 1;
			SLWR <= 1;
			SLRD <= 1;
			SLOE <= 1;
			PKTEND <= 1;
			is_sending <= 0;
			arrival_wr_en <= 0;
			departure_rd_en <= 0;
			master_state <= state_idle;
		end
		else
		begin
			case( master_state )
				state_idle:
				begin
					SLCS <= 1;
					SLWR <= 1;
					SLRD <= 1;
					SLOE <= 1;
					PKTEND <= 1;
					is_sending <= 0;
					arrival_wr_en <= 0;
					departure_rd_en <= 0;
					if( !arrival_full && !FLAGA )				// Rx buffer has some space and FX3S has some data
					begin
						master_state = state_start_read;
					end
					else
					begin
						if( !departure_empty && !FLAGB )				// Tx buffer has some data and FX3S has some space
						begin
							master_state = state_start_write;
						end
					end
				end

				// FX3S -> FPGA states
				state_start_read:
				begin
					SLCS <= 0;
					is_sending <= 0;
					master_state <= state_enable_read;
				end

				state_enable_read:
				begin
					SLOE <= 0;
					SLRD <= 0;
					master_state <= state_read_wait_1;
				end

				state_read_wait_1:
				begin
					arrival_wr_en <= 1;
					master_state <= state_reading;
				end

				state_reading:
				begin
					// If done, then change state. Otherwise, stay at this state.
					if( FLAGA || arrival_full )	// Either end-of-data or the Rx buffer is full.
					begin
						arrival_wr_en <= 0;
						SLRD <= 1;
						SLOE <= 1;
						SLCS <= 1;
						master_state <= state_reading_fin;
					end
				end

				state_reading_fin:
				begin
					master_state <= state_idle;
				end

				// FPGA -> FX3S states
				state_start_write:
				begin
					SLCS <= 1;
					is_sending <= 1;
					master_state <= state_write_wait_1;
				end

				state_write_wait_1:
				begin
					departure_rd_en <= 1;
					SLWR <= 0;
					master_state <= state_writing;
				end

				state_writing:
				begin
					if( departure_empty && !input_valid ) 	// All data are sent out
					begin
						departure_rd_en <= 0;
						SLWR <= 1;
						PKTEND <= 0;
						is_sending <= 0;
						master_state <= state_write_ZLP;
					end
					else
					begin
						if( FLAGB )							// FX3S buffer is full
						begin
							departure_rd_en <= 0;
							SLWR <= 1;
							PKTEND <= 0;
							master_state <= state_write_wait_2;
						end
					end
				end

				state_write_wait_2:
				begin
					if( !FLAGB )
					begin
						departure_rd_en <= 1;
						SLWR <= 0;
						master_state <= state_writing;
					end
				end

				state_write_ZLP:
				begin
					PKTEND <= 1;
					SLCS <= 1;
					master_state <= state_write_fin;
				end

				state_write_fin:
				begin
					master_state <= state_idle;
				end
				
				default:		// Error!!! We should not be here
				begin
					SLCS <= 1;
					SLWR <= 1;
					SLRD <= 1;
					SLOE <= 1;
					PKTEND <= 1;
					is_sending <= 0;
					arrival_wr_en <= 0;
					departure_rd_en <= 0;
					master_state <= state_idle;	// Go back to idle
				end
			endcase
		end
	end

	//************************************************************
	// IP Instances
	//************************************************************
	fifo_departure_1024x64b fifo_departure (
		.rst(rst),                  // input wire rst
		.wr_clk(input_d_clk),       // input wire wr_clk
		.rd_clk(!clk_64M),          // input wire rd_clk : Data must be ready on the bus by the next clock posedge
		.din(d_in),                 // input wire [63 : 0] din
		.wr_en(departure_wr_en),    // input wire wr_en
		.rd_en(departure_rd_en),    // input wire rd_en
		.dout(departure_data),      // output wire [15 : 0] dout
		.full(input_full),          // output wire full
		.empty(departure_empty),    // output wire empty
		.wr_rst_busy(dep_wr_rst_busy), // output wire wr_rst_busy
		.rd_rst_busy(dep_rd_rst_busy)  // output wire rd_rst_busy
	);

	fifo_arrival_64x16b fifo_arrival (
		.rst(rst),                  // input wire rst
		.wr_clk(clk_64M),           // input wire wr_clk
		.rd_clk(output_d_clk),      // input wire rd_clk
		.din(arrival_data),         // input wire [15 : 0] din
		.wr_en(arrival_wr_en),      // input wire wr_en
		.rd_en(arrival_rd_en),      // input wire rd_en
		.dout(d_out),               // output wire [15 : 0] dout
		.full(arrival_full),        // output wire full
		.empty(arrival_empty),      // output wire empty
		.wr_rst_busy(arr_wr_rst_busy), // output wire wr_rst_busy
		.rd_rst_busy(arr_rd_rst_busy)  // output wire rd_rst_busy
	);
endmodule