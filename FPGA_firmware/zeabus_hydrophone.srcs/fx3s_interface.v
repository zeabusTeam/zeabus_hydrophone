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

module fx3s_interface #(
	parameter	FX3S_DMA_Size = 4096,	// Size of FX3S receiving DMA buffer (in 16-bit words)
	
	// Address value
	localparam addr_write = 1'b1,
	localparam addr_read = 1'b0,

	// State value
	localparam state_idle = 4'b0000,
	
	localparam state_start_read = 4'b0001,
	localparam state_read_pre1 = 4'b0010,
	localparam state_read_pre2 = 4'b0011,
	localparam state_read_pre3 = 4'b0100,
	localparam state_read_loop = 4'b0101,
	
	localparam state_start_write = 4'b1000,
	localparam state_write_wait1 = 4'b1001,
	localparam state_write_wait2 = 4'b1010,
	localparam state_write_wait3 = 4'b1011,

	localparam state_zlp = 4'b1100,
	localparam state_zlp_wait1 = 4'b1101,
	localparam state_zlp_wait2 = 4'b1110,
	localparam state_zlp_wait3 = 4'b1111
	
	) (
	// Debug signals
	output [3:0] state,
	output TxEmpty, TxFull, RxEmpty, RxFull,
	output TxWrRstBusy, TxRdRstBusy, RxWrRstBusy, RxRdRstBusy,
	output TxWrEn, TxRdEn, RxWrEn, RxRdEn,
	output [15:0] d_data,
	output d_clk, dd_clk,
	output sending,
	
	// Device pins
	output ifclk_out,				// Communication clock from FPGA -> FX3S (FPGA controlled)
	inout [15:0] DQ,				// Data bus
	output [1:0] A,					// Address to specified DMA channels
	output reg SLCS,				// Chip select signal to FX3S (Active low)
	output reg SLWR, SLRD,	        // Read/Write flag (Active low)
	output reg SLOE, 				// Enable FX3S -> FPGA data direction (Active low)
	output reg PKTEND,				// Writing a short packet or zero-length packet (Used to indicate end of data) (Active low)
	input FLAGA, FLAGB,				// Flags from FX3S use to indicates almost full or empty of DMA buffer. (Active Low)
									// FLAGA : indicates that FX3S has some data to read. (0 = Empty)
									// FLAGB : indicates that FX3S has some spacce to accept more data (1 = Available)
									// Important Note: FLAGB has 3-clock delay. Thus, it must indicate "almost" full to aviod overrun.

	// Control signal
	input clk_64MHz,				// Master clock for this module (64 MHz 0-degree)
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
	input  output_d_clk				// Clocking for data reading
	);

	// This module use FIFO to store incoming and outgoing data
	// The FIFO size for arrival data is 32 16-bit words.
	// The FIFO size for departure data is 1024 64-bit words.
	wire	tx_wr_rst_busy, tx_rd_rst_busy, rx_wr_rst_busy, rx_rd_rst_busy;
	wire	[15:0] tx_data;
	wire	[15:0] rx_data;
	wire	rx_empty, rx_full, tx_empty;	// Full and empty FIFO flag
	wire	rx_rd_en;
	wire	tx_wr_en;
	reg		rx_wr_en, tx_rd_en;		// FIFO write and read enable controlled by state machine
	reg		is_sending;				// Indicate current data direction: 0 = FX3S -> FPGA, 1 = FPGA -> FX3S
	reg 	[3:0] master_state;		// State of the interface
	reg		is_writing;				// Indicate whether the writing process has started
	reg		[15:0] rx_buf_d;
	reg     [15:0] rx_buf_dd;	     // pre-buffer for reading as FLAGA has 2 clocks delay.
	reg		input_d_clk_d;
	integer u32WrCounter;			// Counter for DMA sending words

	//************************************************************
	// Combination logic
	//************************************************************
	assign state = master_state;
	assign TxFull = input_full;
	assign TxEmpty = tx_empty;
	assign RxFull = rx_full;
	assign RxEmpty = rx_empty;
	assign TxWrRstBusy = tx_wr_rst_busy;
	assign TxRdRstBusy = tx_rd_rst_busy;
	assign RxWrRstBusy = rx_wr_rst_busy;
	assign RxRdRstBusy = rx_rd_rst_busy;
	assign TxWrEn = tx_wr_en;
	assign TxRdEn = tx_rd_en;
	assign RxWrEn = rx_wr_en;
	assign RxRdEn = rx_rd_en;
	assign d_data = tx_data;
	assign d_clk = input_d_clk;
	assign dd_clk = input_d_clk_d;
	assign sending = is_sending;

	assign ifclk_out = clk_64MHz;		// Slave FIFO interface operates at 64 MHz

	// Reset and ready signals
	assign A[1] = 0;				// A[1] is always 0. We use only A[0] bit
	assign A[0] = is_sending;		// Data direction bit is designed to be equal to A[0]
	assign rdy = ~( tx_wr_rst_busy | tx_rd_rst_busy | rx_wr_rst_busy | rx_rd_rst_busy );
	assign tx_wr_en = input_valid & ~tx_wr_rst_busy & ( ~input_d_clk_d & input_d_clk );
	assign output_valid = ~rx_empty & ~rx_rd_rst_busy;
	assign rx_rd_en = output_d_oe & ~rx_rd_rst_busy;

	// MUX and DEMUX DQ pins with 2 internal sub-systems
	assign rx_data = (!is_sending) ? DQ : 16'b0;
	assign DQ = (is_sending) ? tx_data : 16'bz;

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
		rx_wr_en <= 0;
		tx_rd_en <= 0;
		input_d_clk_d <= 0;
		is_writing <= 0;
		master_state <= state_idle;
		u32WrCounter <= FX3S_DMA_Size;
	end

	//************************************************************
	// Behavioral blocks
	//************************************************************
	// Clock synchronizer
	always @(posedge clk_64MHz)
	begin
		input_d_clk_d <= input_d_clk;
	end
	
	// Main process
	/*
	 * State transition table (FLAGA and FLAGB are active low)
	 * ------------------------------------------------------------------------------------
	 *     State     | Input condition                 |  Next State | Action
	 * ------------------------------------------------------------------------------------
	 *     idle      | is_writing && FLAGB && tx_empty |             |
	 *               |                 && !input_valid | zlp         | is_sending = 1, SLCS = 0, PEND = 0
	 * 	             | !rx_full && FLAGA               | start_read  | is_sending = 0, SLCS = 0, SLOE = 0
	 *               | !tx_empty && FLAGB              | start_write | is_sending = 1, SLCS = 0, SLWR = 0, tx_rd_en = 1, is_writing = 1
	 * ------------------------------------------------------------------------------------
	 *  start_read   | 1                               | read_pre1   | SLRD = 0
	 * ------------------------------------------------------------------------------------
	 *  read_pre1    | 1                               | read_pre2   |
	 * ------------------------------------------------------------------------------------
	 *  read_pre2    | !FLAGA                          | idle        | SLCS = 1, SLRD = 1, SLOE = 1
	 *               | else                            | read_pre3   | rx_buf_dd = rx_data
	 * ------------------------------------------------------------------------------------
	 *  read_pre3    | !FLAGA                          | idle        | SLCS = 1, SLRD = 1, SLOE = 1
	 *               | else                            | read_loop   | rx_buf_d = rx_data, rx_wr_en = 1
	 * ------------------------------------------------------------------------------------
	 *  read_loop    | !FLAGA || rx_full               | idle        | SLCS = 1, SLRD = 1, SLOE = 1, rx_wr_en = 0
	 *               | else                            | read_loop   | rx_buf_dd = rx_buf_d, rx_buf_d = rx_data
	 * ------------------------------------------------------------------------------------
	 *  start_write  | !FLAGB || tx_empty              | idle        | SLCS = 1, SLWR = 1, tx_rd_en = 0, is_sending = 0
	 *               | else { u32WrCounter == 0 }      | write_wait1 | SLCS = 1, SLWR = 1, tx_rd_en = 0 (then wait 3 clocks)
	 *               | else { else }                   | start_write | u32WrCounter = u32WrCounter - 1
	 * ------------------------------------------------------------------------------------
	 *  write_wait1  | 1                               | write_wait2 |
	 * ------------------------------------------------------------------------------------
	 *  write_wait2  | 1                               | write_wait3 |
	 * ------------------------------------------------------------------------------------
	 *  write_wait3  | 1                               | idle        | is_sending = 0, u32WrCounter = FX3S_DMA_Size
	 * ------------------------------------------------------------------------------------
	 *  zlp          | 1                               | zlp_wait1   | PEND = 1 (then wait 3 clocks)
	 * ------------------------------------------------------------------------------------
	 *  zlp_wait1    | 1                               | zlp_wait2   |
	 * ------------------------------------------------------------------------------------
	 *  zlp_wait2    | 1                               | zlp_wait3   |
	 * ------------------------------------------------------------------------------------
	 *  zlp_wait3    | 1                               | idle        | SLCS = 1, is_sending = 0, is_writing = 0, u32WrCounter = FX3S_DMA_Size
	 * ------------------------------------------------------------------------------------
	 * ------------------------------------------------------------------------------------

	 */
	always @(posedge clk_64MHz)
	begin
		if( rst )
		begin
			SLCS <= 1;
			SLWR <= 1;
			SLRD <= 1;
			SLOE <= 1;
			PKTEND <= 1;
			is_sending <= 0;
			is_writing <= 0;
			rx_wr_en <= 0;
			tx_rd_en <= 0;
			master_state <= state_idle;
		end
		else
		begin
			case( master_state )
				state_idle:
				begin
					if( is_writing && FLAGB && tx_empty && !input_valid )
					begin
						is_sending <= 1;
						SLCS <= 0;
						PKTEND <= 0;
						master_state <= state_zlp;
					end

					if( !rx_full && FLAGA )
					begin
						is_sending <= 0;
						SLCS <= 0;
						SLOE <= 0;
						master_state <= state_start_read;
					end
					
					if( !tx_empty && FLAGB )
					begin
						is_sending <= 1;
						SLCS <= 0;
						SLWR <= 0;
						tx_rd_en <= 1;
						is_writing <= 1;
						master_state <= state_start_write;
					end
				end

				// FX3S -> FPGA states
				state_start_read:
				begin
					SLRD <= 0;
					master_state <= state_read_pre1;
				end
				
				state_read_pre1:
				begin
					master_state <= state_read_pre2;
				end
				
				state_read_pre2:
				begin
					if( !FLAGA )
					begin
						SLCS <= 1;
						SLRD <= 1;
						SLOE <= 1;
						master_state <= state_idle;
					end
					else
					begin
						rx_buf_dd <= rx_data;
						master_state <= state_read_pre3;
					end
				end

				state_read_pre3:
				begin
					if( !FLAGA )
					begin
						SLCS <= 1;
						SLRD <= 1;
						SLOE <= 1;
						rx_wr_en <= 0;
						master_state <= state_idle;
					end
					else
					begin
						rx_buf_d <= rx_data;
						rx_wr_en <= 1;
						master_state <= state_read_loop;
					end
				end

				state_read_loop:
				begin
					if( !FLAGA || rx_full )
					begin
						SLCS <= 1;
						SLRD <= 1;
						SLOE <= 1;
						rx_wr_en <= 0;
						master_state <= state_idle;
					end
					else
					begin
						rx_buf_dd <= rx_buf_d;
						rx_buf_d <= rx_data;
						/* stay at state_read_loop */
					end
				end

				// FPGA -> FX3S states
				state_start_write:
				begin
					if( !FLAGB || tx_empty )
					begin
						SLCS <= 1;
						SLWR <= 1;
						tx_rd_en <= 0;
						is_sending <= 0;
						master_state <= state_idle;
					end
					else
					begin
						if( u32WrCounter == 0 )	/* End of a chunk */
						begin
							SLCS <= 1;
							SLWR <= 1;
							tx_rd_en <= 0;
							master_state <= state_write_wait1;
						end
						else
						begin
							u32WrCounter = u32WrCounter - 1;
							/* stay at state_writing */
						end
					end
				end

				state_write_wait1:
				begin
					master_state <= state_write_wait2;
				end

				state_write_wait2:
				begin
					master_state <= state_write_wait3;
				end

				state_write_wait3:
				begin
					u32WrCounter <= FX3S_DMA_Size;
					master_state <= state_idle;
				end

				// FPGA -> FX3S with zero-length packet states
				state_zlp:
				begin
					PKTEND <= 1;
					master_state <= state_zlp_wait1;
				end

				state_zlp_wait1:
				begin
					master_state <= state_zlp_wait2;
				end

				state_zlp_wait2:
				begin
					master_state <= state_zlp_wait3;
				end

				state_zlp_wait3:
				begin
					SLCS <= 1;
					is_writing <= 0;
					is_sending <= 0;
					u32WrCounter <= FX3S_DMA_Size;
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
					is_writing <= 0;
					rx_wr_en <= 0;
					tx_rd_en <= 0;
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
		.wr_clk(clk_64MHz),       	// input wire wr_clk
		.rd_clk(!clk_64MHz),		// input wire rd_clk : Data must be ready on the bus by the next clock posedge
		.din(d_in),                 // input wire [63 : 0] din
		.wr_en(tx_wr_en),    		// input wire wr_en
		.rd_en(tx_rd_en),    		// input wire rd_en
		.dout(tx_data),      		// output wire [15 : 0] dout
		.full(input_full),          // output wire full
		.empty(tx_empty),    		// output wire empty
		.wr_rst_busy(tx_wr_rst_busy), // output wire wr_rst_busy
		.rd_rst_busy(tx_rd_rst_busy)  // output wire rd_rst_busy
	);

	fifo_arrival_64x16b fifo_arrival (
		.rst(rst),                  // input wire rst
		.wr_clk(clk_64MHz),         // input wire wr_clk
		.rd_clk(output_d_clk),      // input wire rd_clk
		.din(rx_buf_dd),         	// input wire [15 : 0] din
		.wr_en(rx_wr_en),      		// input wire wr_en
		.rd_en(rx_rd_en),      		// input wire rd_en
		.dout(d_out),               // output wire [15 : 0] dout
		.full(rx_full),        		// output wire full
		.empty(rx_empty),      		// output wire empty
		.wr_rst_busy(rx_wr_rst_busy), // output wire wr_rst_busy
		.rd_rst_busy(rx_rd_rst_busy)  // output wire rd_rst_busy
	);
endmodule