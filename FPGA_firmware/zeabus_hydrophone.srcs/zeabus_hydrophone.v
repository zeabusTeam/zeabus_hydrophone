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

module zeabus_hydrophone #(
	parameter trigger_head = 1000,	// Number of sampling preceded of the trigged points
	parameter trigger_tail = 1000	// Number of sampling include in a valid data packet after the trigger level is not satisfied
	)(
	/* Device pins */
	// ADC-1 pins
	input OTR_1,			// Overflow
	input [13:0]D_1,		// Data input
	output CLKA_1, CLKB_1,	// ADC Clocks
	
	// ADC-2 pins
	input OTR_2,			// Overflow
	input [13:0]D_2,		// Data input
	output CLKA_2, CLKB_2,	// ADC Clocks
	
	// Potentiometers pins
	inout SCL, SDA,			// I2C functions
	
	// FIR control pins
	input FIR_EN,			// Enable FIR function
	
	// FX3S Interface
	output ifclk_out,		// Slave FIFO clock
	inout [15:0]DQ,			// Data bus
	output SLCS, SLWR, SLRD, SLOE, PKTEND,	// Slave FIFO control
	output [1:0]A,			// Slave FIFO address bus
	input FLAGA, FLAGB,		// Socket flags
	input RST,				// Soft-reset

	// Status LEDs
	output LED_BLUE, LED_GREEN, LED_RED_n,
	
	// Debug LEDs
	output LED_RED_1,
	output LED_YELLOW_1,
	output LED_GREEN_1,
	output LED_RED_2,
	output LED_YELLOW_2,		// trigged
	output LED_GREEN_2,			// p_data_valid
	output LED_RED_3,			// RST
	output LED_YELLOW_3,		// rst
	output LED_GREEN_3,			// Slave FIFO ready
	
	// Master clock input (26 MHz)
	input clk_in	
);

	wire rst;
	// Wires that connects modules
	wire clk_64MHz_raw, clk_64MHz_90_raw;		// raw system clocks
	wire clk_64MHz, clk_in_buf;					// clocks from BUFG that can distributes through out the chip
	wire pll_locked;							// Output PLL clock is ready
	wire [15:0] adc1_1_out,  adc1_2_out, adc2_1_out, adc2_2_out;	// Data output from ADC modules
	wire [15:0] trigger_level;					// Defined trigger level
	wire [63:0] trigged_out;					// Data-out from trigger circuit
	wire trigged;								// Trigger signal (active high)
	wire [63:0] packetize_out;					// Data-out from packetize circuit
	wire p_data_valid;							// Trigger signale (active high) from packetizer
	wire p_data_clk;							// Output strobe clock from packetizer
	wire poten_update_start;					// Rising edge indicates starting of updating poten values
	wire [7:0] poten0, poten1, poten2, poten3;	// Values of potentiometers (aka. amplifier gain)
	wire [15:0] rx_data;						// Incoming data from FX3S
	wire rx_valid, rx_clk, rx_oe;				// Incoming data FIFO controls
	wire tx_full;
	
	// Combination logic
	assign LED_BLUE = p_data_valid;
	assign LED_GREEN = ~rst;
	assign LED_RED_n = ~tx_full;
	
	// Debug LED
	assign LED_RED_3 = RST;
	assign LED_YELLOW_3 = rst;
	assign LED_RED_2 = 0;
	assign LED_YELLOW_2 = trigged;
	assign LED_GREEN_2 = p_data_valid;
	assign LED_RED_1 = 0;
	assign LED_YELLOW_1 = 0;
	assign LED_GREEN_1 = 0;
	
	assign #(0,308) rst = ( RST | ~pll_locked );
	
	// ADC output clock  (1MHz) generator
	reg adc_d_clk;
	reg [4:0] adc_clk_cnt;
	initial
	begin
		adc_clk_cnt <= 0;
		adc_d_clk <= 0;
	end
	always @(posedge clk_64MHz)
	begin
		adc_clk_cnt = adc_clk_cnt + 1;
		if( adc_clk_cnt == 5'd10)	// Add phase delay to avoid race condition between avg64 and trigger
			// Toggle every counter wrapping
			adc_d_clk = ~adc_d_clk;
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
		.rdy(LED_GREEN_3),				// Indicate that the system is ready for data (unused)

		// Data to send out (FPGA -> FX3S)
		.d_in(packetize_out),			// Input data to send to FX3S
		.input_valid(p_data_valid),		// Indicates that the d_in value is valid
		.input_d_clk(p_data_clk),		// Clocking for data input (data valid at posedge)
		.input_full(tx_full),			// Flag to indicate that the buffer for departure data is full

		// Arrival data (FX3S -> FPGA)
		.d_out(rx_data),				// Output data
		.output_valid(rx_valid),		// Indicate that there are some available data to read
		.output_d_oe(rx_oe),			// Enable read-out data
		.output_d_clk(rx_clk)			// Clocking for data reading
	);
	hydrophone_config_manager config_man(
		// Interface to slave fifo output buffer
		.d_in(rx_data),					// Data from slave FIFO
		.data_valid(rx_valid),			// Indicate that there are some available config data to read
		.config_d_clk(rx_clk),			// Clocking for data reading
		.config_d_oe(rx_oe),			// Enable read-out data
	
		// Control
		.clk_64MHz(clk_64MHz),			// Master clock
		.rst(rst),						// Master reset (active high)
		.update_poten(poten_update_start), // Trigger for potentiometer register updating. (rising edge)
	
		// Register
		.trigger_level(trigger_level),	// hydrophone signal level
		.poten1_value(poten0),			// Value of potentiometer 1 (defines gain of channel 1)
		.poten2_value(poten1),			// Value of potentiometer 2 (defines gain of channel 2)
		.poten3_value(poten2),			// Value of potentiometer 3 (defines gain of channel 3)
		.poten4_value(poten3)			// Value of potentiometer 4 (defines gain of channel 4)
	);

	poten_interface poten_i2c(
		// Device pins
		.SDA(SDA),						// I2C Data
		.SCL(SCL),						// I2C Clock
	
		// Control signals
		.rst(rst),						// Synchronous reset (active high)
		.clk_64MHz(clk_64MHz),			// System clock.
		.start_update(poten_update_start),// Activation bit. Rising edge of this bit means starting of sending data to poten
	
	// Potentiometer data
		.p0_val(poten0),
		.p1_val(poten1),
		.p2_val(poten2),
		.p3_val(poten3)
	);

	packetizer packetizer_inst(
		.rst(rst),						// System reset (active high)
		.clk_64MHz(clk_64MHz),			// Master clock
		
		.d_in(trigged_out),				// Data from trigger
		.in_valid(trigged),				// Data-valid signal from trigger
		.in_strobe(adc_d_clk),			// Input data clock (latch at posedge)
		
		.d_out(packetize_out),			// Output data
		.out_valid(p_data_valid),		// Data-valid signal to FX3 interface
		.out_strobe(p_data_clk)		// Output data clock (latch at posedge)
	);
	
	hydrophone_trigger #( .header(trigger_head), .trigged_tailed(trigger_tail) ) trigger(
		.rst(rst),						// system reset (active high)
		.clk(adc_d_clk),				// signal clock (1 MHz)
		.d_in( { adc1_1_out, adc1_2_out, adc2_1_out, adc2_2_out } ),// data input (concatenation of 4 16-bit data with channel 1 first)
		.trigger_level(trigger_level),	// level of the trigger in 16-bit signed integer
		.d_out(trigged_out),			// data output 
		.trigged(trigged)				// indicates that the data is part of packet of trigged signal
	);

	adc_interface adc1(
		// Interface to hardware
		.d_in(D_1),						// Data channel from ADC chip
		.overflow(OTR_1),				// overflow flag from ADC chip
		.clk_a(CLKA_1),
		.clk_b(CLKB_1),					// ADC clock. Both are identical
	
		// Control signals
		.clk_64MHz(clk_64MHz),			// System clock.
		.rst(rst),						// Synchronous reset (active high)
	
		// Output data
		.d0_out(adc1_1_out),			// Output from each ADC channel
		.d1_out(adc1_2_out)
	);

	adc_interface adc2(
		// Interface to hardware
		.d_in(D_2),						// Data channel from ADC chip
		.overflow(OTR_2),				// overflow flag from ADC chip
		.clk_a(CLKA_2),
		.clk_b(CLKB_2),					// ADC clock. Both are identical
	
		// Control signals
		.clk_64MHz(clk_64MHz),			// System clock.
		.rst(rst),						// Synchronous reset (active high)
	
		// Output data
		.d0_out(adc2_1_out),			// Output from each ADC channel
		.d1_out(adc2_2_out)
	);

	clk_pll clk_gen(
		// Clock out ports
		.clk_64mhz(clk_64MHz),     		// output clk_64mhz
								// Status and control signals
		.reset(RST), 			// input reset
		.locked(pll_locked),    // output locked
		// Clock in ports
		.clk_in(clk_in)     	// input clk_in
	);
endmodule
