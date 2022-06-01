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

/* Module to store and manage all settings such as trigger level and poten value.
 * It also parse the configuration setting data from host through FX3S slave FIFO.
 * The input data have the format as
 *  1 bytes: ID (fixed as 0xDC)
 *  1 bytes: Configuration fields
 *      The configuraton fields are Bit-fields indicates which configuration to set.
 *      This field also indicates what data would follow. Each bit has meaning as:
 *          bit 7 - 4: (Reserved)
 *          bit 3: 1 = enable trigger level setting
 *          bit 2: 1 = enable amplifier gains setting
 *          bit 1 - bit 0: (Reserved)
 *  2 bytes: New trigger level. (Exists only when the 3rd bit of the prefix is set)
 *  4 bytes: New amplifier gain for each channel. Each channel can have it gain different
 *      from others. (Thie field exists only when 2nd bit of the prefix is set)
 *
 */
module hydrophone_config_manager #(
	// constants
	parameter config_prefix = 8'hDC,
	parameter rst_delay = 8			// Total clock cycles to delay the start after reset
	) (
	// Interface to slave fifo output buffer
	input  [15:0] d_in,				// Data from slave FIFO
	input  data_valid,				// Indicate that there are some available config data to read
	output reg config_d_oe,			// Enable read-out data
	
	// Control
	input clk,					// Master clock
	input rst,						// Master reset (active high)
	output reg update_poten,		// Trigger for potentiometer register updating. (rising edge)
	
	// Register
	output reg [15:0] trigger_level,// hydrophone signal level
	output reg [7:0] poten1_value,	// Value of potentiometer 1 (defines gain of channel 1)
	output reg [7:0] poten2_value,	// Value of potentiometer 2 (defines gain of channel 2)
	output reg [7:0] poten3_value,	// Value of potentiometer 3 (defines gain of channel 3)
	output reg [7:0] poten4_value,	// Value of potentiometer 4 (defines gain of channel 4)
	
	output reg [8:0]dbg
);

	// State value
	localparam state_wait_prefix = 0;	// Waiting for the prefix
	localparam state_read_prefix = 1;	// Reading the prefix and validate with the pre-defined value
	localparam state_wait_trigger = 2;	// Waiting for trigger level from input
	localparam state_read_trigger = 3;	// Read trigger level from input
	localparam state_wait_poten1_2 = 4;	// Waiting for the values of potentiometer 1 and 2 from input
	localparam state_read_poten1_2 = 5;	// Read values of potentiometer 1 and 2 from input
	localparam state_wait_poten3_4 = 6; // Waiting for the values of potentiometer 3 and 4 from input
	localparam state_read_poten3_4 = 7; // Read values of potentiometer 3 and 4 from input
	
	// Variables
	integer state, counter;			// Counter is for the initialization step
	reg [15:0] prefix;

	// Behavioral part
	initial
	begin
		state <= state_wait_prefix;
		counter <= 0;
		config_d_oe <= 1'b0;
		update_poten <= 1'b0;
		trigger_level <= 16'd16383;
		poten1_value <= 8'd25;
		poten2_value <= 8'd25;
		poten3_value <= 8'd25;
		poten4_value <= 8'd25;
	end

	always @( negedge clk )
	begin
		if( rst )
		begin
			state <= state_wait_prefix;
			counter <= 0;
			config_d_oe <= 1'b0;
			update_poten <= 1'b0;
			trigger_level <= 16'd16383;
			poten1_value <= 8'd25;
			poten2_value <= 8'd25;
			poten3_value <= 8'd25;
			poten4_value <= 8'd25;
			dbg <= 9'b0;
		end
		else
		begin
			if( counter >= rst_delay )
			begin
				case( state )
					state_wait_prefix:	// Waiting for the prefix
					begin
						update_poten <= 1'b1;
						prefix <= d_in;		// FIFO is in first-word-fall-through. The prefix is in sent out immediately 
						dbg[7:0] <= prefix[15:8];
						if( data_valid && prefix[15:8] == config_prefix )
						begin
						    dbg[8] <= 1'b1;
							$display("Config : Start config");
							config_d_oe <= 1'b1;		// Read next value
							if( prefix[3] )
							begin
								state <= state_read_trigger;
							end
							else
							begin
								if( prefix[2] )
								begin
									update_poten <= 1'b0;
									state <= state_read_poten1_2;
								end
							end
						end
					end
								
					state_read_trigger:	// Read trigger level from input
					begin
						if( data_valid )
						begin
							trigger_level <= d_in;
							if( prefix[2] )
							begin
								update_poten <= 1'b0;
								state <= state_read_poten1_2;
							end
							else
							begin
								config_d_oe <= 1'b0;
								state <= state_wait_prefix;			// All reserved bits mean doing nothing
							end
						end
					end
					
					state_read_poten1_2:	// Read values of potentiometer 1 and 2 from input
					begin
						if( data_valid )
						begin
							{ poten1_value, poten2_value } <= d_in;
							state <= state_wait_poten3_4;
						end
					end
					
					state_read_poten3_4: // Read values of potentiometer 3 and 4 from input
					begin
						if( data_valid )
						begin
							{ poten3_value, poten4_value } <= d_in;
							config_d_oe <= 1'b0;
							state <= state_wait_prefix;
						end
					end				
				endcase
			end
			else
			begin
				counter <= counter + 1;
			end
		end
	end
endmodule
