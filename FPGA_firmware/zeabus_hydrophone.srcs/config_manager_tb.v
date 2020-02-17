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

/* Module to store and manage all settings such as trigger level and poten value.
 * It also parse the configuration setting data from host through FX3S slave FIFO.
 * The configuration packet from host has the format as:
 *    word no. (16-bit word)        value/meaning
 *       1                          16'hDCB0 (prefix)
 *       2                          Bit fileds indicates what config is included
 *										bit 15 : indicates inclusion of trigger level
 *                                      bit 14 : indicates inclusion of potentiometer values
 *                                      bit 13 - 0 : reserved
 *       3                          ADC trigger level (if included)
 *     4 - 5                        Potentiometer values (if included) in the order of 1, 2, 3, and 4. (each is 8 bits)
 */
 
 module hydrophone_config_manager_tb;
	// Interface to slave fifo output buffer
	wire  [15:0] d_in;				// Data from slave FIFO
	wire  data_valid;				// Indicate that there are some available config data to read
	wire config_d_clk;			// Clocking for data reading
	wire config_d_oe;			// Enable read-out data
	
	// Control
	reg clk_64MHz;				// Master clock
	reg rst;						// Master reset (active high)
	wire update_trigger;		// Trigger for register updating. (rising edge)
	
	// output register
	wire [15:0] trigger_level;// hydrophone signal level
	wire [7:0] poten1_value;	// Value of potentiometer 1 (defines gain of channel 1)
	wire [7:0] poten2_value;	// Value of potentiometer 2 (defines gain of channel 2)
	wire [7:0] poten3_value;	// Value of potentiometer 3 (defines gain of channel 3)
	wire [7:0] poten4_value;	// Value of potentiometer 4 (defines gain of channel 4)
	
	// Operation signal
	reg [15:0] d_config;		// FIFO incoming data
	reg wr_en;					// FIFO write enable
	wire full, empty;			// FIFO full and empty flags
	wire rd_busy, wr_busy;		// FIFO busy signals for reading and writing circuits
	
	// Clock counter
	integer counter;
	
	// Combination logic
	assign data_valid = ~empty & ~rd_busy;
	
	// Behavioral logic
	always @(posedge clk_64MHz)
	begin
		if( !wr_busy && counter < 30 )
		begin
			wr_en = 1;
			d_config = counter[15:0];
		end
		
		if( !wr_busy && counter == 30 )
		begin
			wr_en = 1;
			d_config = 16'hDCB0;
		end
		if( !wr_busy && counter == 31 )
		begin
			d_config = 16'b1000_0000_0000_0000;
		end
		if( !wr_busy && counter == 32 )
		begin
			d_config = 16'hB0DC;
		end
		if( !wr_busy && counter == 33 )
		begin
			d_config = 16'hB0DC;
		end
		if( !wr_busy && counter == 34 )
		begin
			d_config = 16'hB0DC;
		end
		if( !wr_busy && counter == 35 )
		begin
			wr_en = 0;
		end
		
		if( !wr_busy && counter == 40 )
		begin
			wr_en = 1;
			d_config = 16'hDCB0;
		end
		if( !wr_busy && counter == 41 )
		begin
			d_config = 16'b1100_0000_0000_0000;
		end
		if( !wr_busy && counter == 42 )
		begin
			d_config = 16'h55AA;
		end
		if( !wr_busy && counter == 43 )
		begin
			d_config = 16'hDCB0;
		end
		if( !wr_busy && counter == 44 )
		begin
			d_config = 16'hDCB0;
		end
		if( !wr_busy && counter == 45 )
		begin
			wr_en = 0;
		end
		
		if( !wr_busy && counter == 50 )
		begin
			wr_en = 1;
			d_config = 16'hDCB0;
		end
		if( !wr_busy && counter == 51 )
		begin
			d_config = 16'b0100_0000_0000_0000;
		end
		if( !wr_busy && counter == 52 )
		begin
			d_config = 16'hAA55;
		end
		if( !wr_busy && counter == 53 )
		begin
			d_config = 16'hAA55;
		end
		if( !wr_busy && counter == 54 )
		begin
			d_config = 16'h55AA;
		end
		if( !wr_busy && counter == 55 )
		begin
			wr_en = 0;
		end
		
		if( counter >= 200 )
		begin
			$finish;
		end
	end

	// Initialization
	initial begin
		clk_64MHz <= 0;
		wr_en <= 0;
		counter <= 0;
		rst = 1; #8 rst = 0;
	end
	
	// Clk counter
	always @(posedge clk_64MHz)
	begin
		counter = counter + 1;
	end
	
	// Clk gen
	always 
	begin
		#8 clk_64MHz = !clk_64MHz; 
	end
	
	// Device under test
	fifo_arrival_64x16b fifo_arrival (
		.rst(rst),                  // input wire rst
		.wr_clk(clk_64MHz),         // input wire wr_clk
		.rd_clk(config_d_clk),      // input wire rd_clk
		.din(d_config),         // input wire [15 : 0] din
		.wr_en(wr_en),      // input wire wr_en
		.rd_en(config_d_oe),      // input wire rd_en
		.dout(d_in),               // output wire [15 : 0] dout
		.full(full),        // output wire full
		.empty(empty),      // output wire empty
		.wr_rst_busy(wr_busy), // output wire wr_rst_busy
		.rd_rst_busy(rd_busy)  // output wire rd_rst_busy
	);
	
	hydrophone_config_manager cf(
		.d_in( d_in ),						// Data from slave FIFO
		.data_valid( data_valid) ,			// Indicate that there are some available config data to read
		.config_d_clk( config_d_clk ),		// Clocking for data reading
		.config_d_oe( config_d_oe ),		// Enable read-out data
	
		// Control
		.clk_64MHz( clk_64MHz ),			// Master clock
		.rst( rst ),						// Master reset (active high)
		.update_poten( update_trigger ),	// Trigger for register updating. (rising edge)
	
		// Register
		.trigger_level( trigger_level ),	// hydrophone signal level
		.poten1_value( poten1_value ),		// Value of potentiometer 1 (defines gain of channel 1)
		.poten2_value( poten2_value ),		// Value of potentiometer 2 (defines gain of channel 2)
		.poten3_value( poten3_value ),		// Value of potentiometer 3 (defines gain of channel 3)
		.poten4_value( poten4_value )		// Value of potentiometer 4 (defines gain of channel 4)
	);

endmodule