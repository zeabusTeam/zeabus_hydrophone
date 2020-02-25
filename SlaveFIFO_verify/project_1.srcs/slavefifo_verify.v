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

// Important note on PLL module setting. Please refer to
// https://forums.xilinx.com/t5/Implementation/Drc-23-20-Rule-violation-REQP-1712-Input-clock-driver/td-p/586641

module fifo_verify (
	/* Device pins */
	// FX3S Interface
	output ifclk_out,		// Slave FIFO clock
	inout [15:0]DQ,			// Data bus
	output SLCS, SLWR, SLRD, SLOE, PKTEND,	// Slave FIFO control
	output [1:0]A,			// Slave FIFO address bus
	input FLAGA, FLAGB,		// Socket flags
	input RST,				// Soft-reset

	// Status LEDs
	output LED_RED_n,
	
	// Master clock input (26 MHz)
	input clk_in	
	
	// debug
	//output [3:0] fifo_state,
	//output rx_full
);
	wire rst;
	// Wires that connects modules
	wire clk_64MHz_raw, clk_64MHz_90_raw;		// raw system clocks
	wire clk_64MHz, clk_64MHz_90, clk_in_buf;	// clocks from BUFG that can distributes through out the chip
	wire pll_locked;							// Output PLL clock is ready
	reg adc_clkout_d, adc_clkout_dd, adc_clkout_ddd;
	wire trigger_upd;
	
	// Simulation data
	reg [15:0] simdata;
	initial
	begin
		simdata <= 0;
	end
	always @(posedge clk_64MHz)
	begin
		simdata <= simdata + 1;
	end
	
	// Event tick
	reg tick;
	
	// ADC clk
	reg clk_1MHz;
	reg [8:0] clk_1M_cnt;
	initial
	begin
		clk_1M_cnt <= 0;
		clk_1MHz <= 0;
	end
	always @(posedge clk_64MHz)
	begin
		clk_1M_cnt = clk_1M_cnt + 1;
		if( clk_1M_cnt >= 64 )
			clk_1M_cnt = 0;
			
		if( clk_1M_cnt == 0 )
			clk_1MHz = 1;
		else
			clk_1MHz = 0;
	end
		
	// Event clk
	reg [17:0]clkcnt;
	initial
	begin
		clkcnt <= 0;
		tick <= 0;
	end
	always @(posedge clk_1MHz)
	begin
		clkcnt = clkcnt + 1;
		if( clkcnt >= 30 )
			clkcnt = 0;
		
		if( clkcnt < 10 )
			tick = 1;
		else
			tick = 0;
	end
	
	// signals for departure
	wire [63:0] trigged_out;					// Data-out from trigger circuit
	wire trigged;								// Trigger signal (active high)
	wire tx_full;
	wire adc_clkout;
	
	// signals for arrival
	wire [15:0] rx_data;						// Incoming data from FX3S
	wire rx_valid, rx_clk, rx_oe;				// Incoming data FIFO controls
	
	// Combination logic
	assign LED_RED_n = ~tx_full;
	assign #(0,308) rst = ( RST | ~pll_locked );
	assign trigger_upd = ~( ( ~adc_clkout_dd & adc_clkout_d ) | ( ~adc_clkout_ddd & adc_clkout_dd ) );
	
	// Event generator
	assign trigged_out = (tick)?{ simdata, 16'b0, simdata, 16'hAAAA }:64'b0;
	assign adc_clkout = clk_1MHz;
	assign trigged = tick;
	assign rx_clk = clk_64MHz;
	
	// Clk-edge detection
	always @(posedge clk_64MHz)
	begin
		adc_clkout_ddd <= adc_clkout_dd;
		adc_clkout_dd <= adc_clkout_d;
		adc_clkout_d <= adc_clkout;
	end

	// Instances
	fx3s_interface slave_fifo(
		// Device pins
		.ifclk_out(ifclk_out),			// Communication clock from FPGA -> FX3S (FPGA controlled)
		.DQ(DQ),						// Data bus
		.A(A),							// Address to specified DMA channels
		.SLCS(SLCS),					// Chip select signal to FX3S (Active low)
		.SLWR(SLWR), .SLRD(SLRD),	    // Read/Write flag (Active low)
		.SLOE(SLOE), 					// Enable FX3S -> FPGA data direction (Active low)
		.PKTEND(PKTEND),				// Writing a short packet or zero-length packet (Used to indicate end of data) (Active low)
		.FLAGA(FLAGA), .FLAGB(FLAGB),	// Flags from FX3S use to indicates almost full or empty of DMA buffer. (Active Low)
										// FLAGA : indicates that FX3S has some data to read. (0 = Empty)
										// FLAGB : indicates that FX3S has some spacce to accept more data (1 = Available)
										// Important Note: FLAGB has 3-clock delay. Thus, it must indicate "almost" full to aviod overrun.

		// Control signal
		.clk_64MHz(clk_64MHz),			// Master clock for this module (64 MHz 0-degree)
		.rst(rst),						// Synchronous reset (active high)
		.rdy(),							// Indicate that the system is ready for data (unused)

		// Data to send out (FPGA -> FX3S)
		.d_in(trigged_out),				// Input data to send to FX3S
		.input_valid(trigged),			// Indicates that the d_in value is valid
		.input_d_clk(trigger_upd),		// Clocking for data input (data valid at posedge)
		.input_full(tx_full),			// Flag to indicate that the buffer for departure data is full

		// Arrival data (FX3S -> FPGA)
		.d_out(rx_data),				// Output data
		.output_valid(rx_valid),		// Indicate that there are some available data to read
		.output_d_oe(rx_oe),			// Enable read-out data
		.output_d_clk(rx_clk),			// Clocking for data reading
		
		// Debug
		.state(fifo_state), .RxFull(rx_full)
	);

    BUFG sysclk_buf(
		.I(clk_in),
		.O(clk_in_buf) 
    );
 
    BUFG clk_64MHz_buf(  		// sometimes it is generated automatically, sometimes not ...
		.I(clk_64MHz_raw),
		.O(clk_64MHz) 
    );
 
    BUFG clk_64MHz_90_buf(
		.I(clk_64MHz_90_raw),
		.O(clk_64MHz_90) 
    );
	
	clk_wiz_0 clk_gen(
		// Clock out ports
		.clk_64(clk_64MHz_raw),     	// output clk_64mhz
		.clk_64_90(clk_64MHz_90_raw),// output clk_64mhz_90
									// Status and control signals
		.reset(RST), 				// input reset
		.locked(pll_locked),       		// output locked
		// Clock in ports
		.clk_in(clk_in_buf)     		// input clk_in
	);
endmodule
