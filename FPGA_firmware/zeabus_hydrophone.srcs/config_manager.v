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
module hydrophone_config_manager #(
	// constants
	parameter config_prefix = 16'hDCB0,
	parameter rst_delay = 8,			// Total clock cycles to delay the start after reset
	// State value
	localparam state_wait_prefix = 0,	// Waiting for the prefix
	localparam state_read_prefix = 1,	// Reading the prefix and validate with the pre-defined value
	localparam state_wait_confbit = 3,	// Waiting for the configuration bit fields
	localparam state_read_confbit = 4,	// Read configuration bit fields from input
	localparam state_wait_trigger = 5,	// Waiting for trigger level from input
	localparam state_read_trigger = 6,	// Read trigger level from input
	localparam state_wait_poten1_2 = 7,	// Waiting for the values of potentiometer 1 and 2 from input
	localparam state_read_poten1_2 = 8,	// Read values of potentiometer 1 and 2 from input
	localparam state_wait_poten3_4 = 9, // Waiting for the values of potentiometer 3 and 4 from input
	localparam state_read_poten3_4 = 10 // Read values of potentiometer 3 and 4 from input
	
	) (
	// Interface to slave fifo output buffer
	input  [15:0] d_in,				// Data from slave FIFO
	input  data_valid,				// Indicate that there are some available config data to read
	output config_d_clk,			// Clocking for data reading
	output reg config_d_oe,			// Enable read-out data
	
	// Control
	input clk_64MHz,				// Master clock
	input rst,						// Master reset (active high)
	output reg update_poten,		// Trigger for potentiometer register updating. (rising edge)
	
	// Register
	output reg [15:0] trigger_level,// hydrophone signal level
	output reg [7:0] poten1_value,	// Value of potentiometer 1 (defines gain of channel 1)
	output reg [7:0] poten2_value,	// Value of potentiometer 2 (defines gain of channel 2)
	output reg [7:0] poten3_value,	// Value of potentiometer 3 (defines gain of channel 3)
	output reg [7:0] poten4_value	// Value of potentiometer 4 (defines gain of channel 4)
);

	// Variables
	integer state, counter;			// Counter is for the initialization step
	reg [15:0] config_bit, prefix_in;
	
	// combination logic
	assign config_d_clk = clk_64MHz;
	
	// Behavioral part
	initial
	begin
		state <= state_wait_prefix;
		counter <= 0;
		config_d_oe <= 0;
		update_poten <= 0;
		trigger_level <= 16'd16384;
		poten1_value <= 8'h80;
		poten2_value <= 8'h80;
		poten3_value <= 8'h80;
		poten4_value <= 8'h80;
	end

	always @( posedge clk_64MHz )
	begin
		if( rst )
		begin
			state <= state_wait_prefix;
			counter <= 0;
			config_d_oe <= 0;
			update_poten <= 0;
			trigger_level <= 16'd16384;
			poten1_value <= 8'h80;
			poten2_value <= 8'h80;
			poten3_value <= 8'h80;
			poten4_value <= 8'h80;
		end
		else
		begin
			if( counter >= rst_delay )
			begin
				case( state )
					state_wait_prefix:	// Waiting for the prefix
					begin
						update_poten = 1;
						if( data_valid )
						begin
							config_d_oe = 1;
							state = state_read_prefix;
						end
					end
					
					state_read_prefix:	// Reading the prefix and validate with the pre-defined value
					begin
						prefix_in = d_in;
						config_d_oe = 0;
						if( prefix_in == config_prefix )
						begin
							state = state_wait_confbit;
						end
						else
						begin
							state = state_wait_prefix;
						end
					end
					
					state_wait_confbit:	// Waiting for the configuration bit fields
					begin
						if( data_valid )
						begin
							config_d_oe = 1;
							state = state_read_confbit;
						end
					end

					state_read_confbit:	// Read configuration bit fields from input
					begin
						config_bit = d_in;
						config_d_oe = 0;
						if( config_bit[15] )
						begin
							state = state_wait_trigger;
						end
						else
						begin
							if( config_bit[14] )
							begin
								update_poten = 0;
								state = state_wait_poten1_2;
							end
							else
							begin
								state = state_wait_prefix;		// All reserved bits mean doing nothing
							end
						end
					end
					
					state_wait_trigger:	// Waiting for trigger level from input
					begin
						if( data_valid )
						begin
							config_d_oe = 1;
							state = state_read_trigger;
						end
					end
				
					state_read_trigger:	// Read trigger level from input
					begin
						trigger_level = d_in;
						config_d_oe = 0;
						if( config_bit[14] )
						begin
							update_poten = 0;
							state = state_wait_poten1_2;
						end
						else
						begin
							state = state_wait_prefix;			// All reserved bits mean doing nothing
						end
					end
					
					state_wait_poten1_2:	// Waiting for the values of potentiometer 1 and 2 from input
					begin
						if( data_valid )
						begin
							config_d_oe = 1;
							state = state_read_poten1_2;
						end
					end
								
					state_read_poten1_2:	// Read values of potentiometer 1 and 2 from input
					begin
						{ poten1_value, poten2_value } = d_in;
						config_d_oe = 0;
						state = state_wait_poten3_4;
					end
					
					state_wait_poten3_4: // Waiting for the values of potentiometer 3 and 4 from input
					begin
						if( data_valid )
						begin
							config_d_oe = 1;
							state = state_read_poten3_4;
						end
					end
				
					state_read_poten3_4: // Read values of potentiometer 3 and 4 from input
					begin
						{ poten3_value, poten4_value } = d_in;
						config_d_oe = 0;
						state = state_wait_prefix;
					end				
				endcase
			end
			else
			begin
				counter = counter + 1;
			end
		end
	end
endmodule
