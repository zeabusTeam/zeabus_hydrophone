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

// Helper module to get absolute value
module absolute( input [15:0] in, output [15:0] out );
	assign out = in[15] ? -in : in;
endmodule

// Main trigger module
// Outut data is valid at the rising edge of the next clock after the "trigged" signal
module hydrophone_trigger
	#(
	parameter header = 64,		// Number of d_in samples preceded of the trigged points
	parameter trigged_tailed = 64	// Number of d_in samples include in a valid data packet after the trigger level is not satisfied
	) (
	// Debug
	output rdy, fifo_rdy,		// Debug signals
	output [63:0] abs_data,
	output [15:0] abs_trig,

	input rst,					// system reset (active high)
	input clk,					// signal clock (64 MHz)
	input enable,				// enable trigger funtion (aka. start of the capture function)
	input [63:0] d_in,			// data input (concatenation of 4 16-bit data) all in format Q13.6
	input [15:0] trigger_level,	// level of the trigger in 16-bit signed integer in format Q13.2
	input strb_ch1, strb_ch2, strb_ch3, strb_ch4,	// Strobe signal from each channel
	output [63:0] d_out,		// data output  all in format Q13.6
	output output_strobe,		// Combined strobe signal from all channels plus edge detected
	output reg trigged			// indicates that the data is part of packet of trigged signal
);

	// Variables
	reg [15:0] h_counter;		// Fifo backlog data counter
	reg [15:0] t_counter;		// Counter for packet tailing
	reg rd_en;					// backlog read enable according to states
	reg strb_d, strb_dd;		// Delay line of strobe signal to detect rising edge
	reg rst_d, rst_dd, rst_3d, rst_4d, rst_5d, rst_6d, rst_7d, rst_8d;	// Delay line for reset signal to make the internal reset time greater than 5 clk
	
	wire strb_all;				// Combined strobe from all channels
	wire rst_internal;			// Internal reset signal
	wire fifo_rst_internal;		// Internal reset for fifo module
	wire almost_full;			// FIFO is almost full
	wire strobe_all;			// Combined strobe signals
	wire fifo_rd_en, fifo_wr_en;	// Combined read and write enable of all signal
	
	wire [63:0] abs_d_in;		// Magnetude (aka. absolute) values of d_in
	wire [15:0] abs_trigger;	// Magnetude of trigger level
	
	// Combine all strobe signals
	assign fifo_rst_internal = rst | rst_d | rst_dd | rst_3d | rst_4d | rst_5d;
	assign rst_internal = fifo_rst_internal | rst_6d | rst_7d | rst_8d;
	assign strb_all = strb_ch1 & strb_ch2 & strb_ch3 & strb_ch4;
	assign output_strobe = strb_d & ~strb_dd & ~rst_internal;
	assign fifo_wr_en = output_strobe & ~rst_internal;
	assign fifo_rd_en = (rd_en | almost_full) & output_strobe & ~rst_internal ;		// Enable read when FIFO almost full too.
	
	assign rdy = ~rst_internal;
	assign fifo_rdy = rd_en;
	//assign abs_data = abs_d_in;
	assign abs_data = d_in;
	assign abs_trig = abs_trigger;
	
	// Absolute implementation
	absolute abs1( .in(d_in[15:0]), .out(abs_d_in[15:0]) );
	absolute abs2( .in(d_in[31:16]), .out(abs_d_in[31:16]) );
	absolute abs3( .in(d_in[47:32]), .out(abs_d_in[47:32]) );
	absolute abs4( .in(d_in[63:48]), .out(abs_d_in[63:48]) );
	absolute abs5( .in(trigger_level), .out(abs_trigger) );
	
	// Initial block
	initial
	begin
		h_counter <= 16'b0;
		t_counter <= 16'b0;
		trigged <= 0;
		rd_en <= 0;
		strb_d <= 0;
		strb_dd <= 0;
		rst_8d <= 1;
		rst_7d <= 1;
		rst_6d <= 1;
		rst_5d <= 1;
		rst_4d <= 1;
		rst_3d <= 1;
		rst_dd <= 1;
		rst_d <= 1;
	end
	
	// Delay line for reset
	always @(posedge clk)
	begin
		rst_8d <= rst_7d;
		rst_7d <= rst_6d;
		rst_6d <= rst_5d;
		rst_5d <= rst_4d;
		rst_4d <= rst_3d;
		rst_3d <= rst_dd;
		rst_dd <= rst_d;
		rst_d <= rst;
	end
	
	// Delay line for edge detection
	always @(negedge clk)
	begin
		if( rst_internal )
		begin
			strb_d <= 0;
			strb_dd <= 0;
		end
		else
		begin
			strb_dd <= strb_d;
			strb_d <= strb_all;
		end
	end
	
	// Main state machine
	always @(negedge clk)
	begin
		if( rst_internal )
		begin
			// Reset signal asserted. Just initialize state
			h_counter <= 16'b0;
			t_counter <= 16'b0;
			trigged <= 0;
			rd_en <= 0;
		end
		else
		begin
			if( output_strobe )	// clk freq. is higher than data rate, so we use the Strobe signal indicates each datum
			begin
				// For FIFO-thread safety we need to fill it with some data first
				// FIFO is configured in First-Word-Fall-Through mode which has 1-clock delay latency
				// The input data at the very beginning after reset should not be used though
				if( h_counter < header )
				begin
					h_counter <= h_counter + 1;
				end
				else
				begin
					rd_en <= 1;		// Enable FIFO reading after having enough backlog
					if( enable && ( ( abs_d_in[15:0] >= abs_trigger ) ||
						( abs_d_in[31:16] >= abs_trigger ) ||
						( abs_d_in[47:32] >= abs_trigger ) ||
						( abs_d_in[63:48] >= abs_trigger ) )
					  )
				    begin
					   // Trigged
					   trigged <= 1;
					   t_counter <= trigged_tailed;
					end
					else
					begin
						if( t_counter == 0 )
						begin
							trigged <= 0;
						end
						else
						begin
							// Still retain the "trigged" condition
							t_counter <= t_counter - 1;
						end
					end
				end
			end
		end
	end

	// FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
	//           7 Series
	// Xilinx HDL Language Template, version 2021.2

	FIFO36E1 #(
		.ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
		.ALMOST_FULL_OFFSET(13'h01F4),     // Sets almost full threshold to 500 entries
		.DATA_WIDTH(72),                   // Sets data width to 4-72
		.DO_REG(1),                        // Enable output register (1-0) Must be 1 if EN_SYN = FALSE
		.EN_ECC_READ("FALSE"),             // Enable ECC decoder, FALSE, TRUE
		.EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, FALSE, TRUE
		.EN_SYN("FALSE"),                  // Specifies FIFO as Asynchronous (FALSE) or Synchronous (TRUE)
		.FIFO_MODE("FIFO36_72"),              // Sets mode to "FIFO36" or "FIFO36_72"
		.FIRST_WORD_FALL_THROUGH("TRUE"),  // Sets the FIFO FWFT to FALSE, TRUE
		.INIT(72'h000000000000000000),     // Initial values on output port
		.SIM_DEVICE("7SERIES"),            // Must be set to "7SERIES" for simulation behavior
		.SRVAL(72'h000000000000000000)     // Set/Reset value for output port
	)
	FIFO36E1_inst (
		// ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
		.DBITERR(),             	   // 1-bit output: Double bit error status
		.ECCPARITY(),         		   // 8-bit output: Generated error correction parity
		.SBITERR(),             	   // 1-bit output: Single bit error status
		// Read Data: 64-bit (each) output: Read output data
		.DO(d_out),                    // 64-bit output: Data output
		.DOP(),                        // 8-bit output: Parity data output
		// Status: 1-bit (each) output: Flags and other FIFO status outputs
		.ALMOSTEMPTY(),     	   	   // 1-bit output: Almost empty flag
		.ALMOSTFULL(almost_full),      // 1-bit output: Almost full flag
		.EMPTY(),                 	   // 1-bit output: Empty flag
		.FULL(),                   	   // 1-bit output: Full flag
		.RDCOUNT(),             	   // 13-bit output: Read count
		.RDERR(),                 	   // 1-bit output: Read error
		.WRCOUNT(),             	   // 13-bit output: Write count
		.WRERR(),                 	   // 1-bit output: Write error
		// ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
		.INJECTDBITERR(1'b0), 			   // 1-bit input: Inject a double bit error input
		.INJECTSBITERR(1'b0),
		// Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
		.RDCLK(clk),                   // 1-bit input: Read clock
		.RDEN(fifo_rd_en),             // 1-bit input: Read enable
		.REGCE(1'b1),             	   // 1-bit input: Clock enable
		.RST(fifo_rst_internal),       // 1-bit input: Reset
		.RSTREG(1'b0),                 // 1-bit input: Output register set/reset
		// Write Control Signals: 1-bit (each) input: Write clock and enable input signals
		.WRCLK(clk),                   // 1-bit input: Rising edge write clock.
		.WREN(fifo_wr_en),             // 1-bit input: Write enable
		// Write Data: 64-bit (each) input: Write input data
		.DI(d_in),                     // 64-bit input: Data input
		.DIP(8'h00)                    // 8-bit input: Parity input
	);

	// End of FIFO36E1_inst instantiation
endmodule