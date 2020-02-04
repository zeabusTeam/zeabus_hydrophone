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

// Implementation is based on https://opencores.org/projects/i2c/

`include "i2c_wishbone/i2c_master_defines.v"

//===============================================================
module poten_interface #(
	parameter i2c_address_1 = 8'b0101_1100,	// I2C Address of poten1 (r/~w flag is always 0)
	parameter i2c_address_2 = 8'b0101_1110,	// I2C Address of poten2 (r/~w flag is always 0)
	
	/* Prescaler for I2C clock generation (16 bits)
	   The prescaler value is calculate as:
	   ( Master_clk / ( 5 * SCL_clk ) ) - 1
	   Example (master_clk = 64MHz):
	     100kHz => 127
		 200kHz => 63
		 300kHz (approx) => 42
		 320kHz => 39
		 400kHz => 31
	*/
	parameter i2c_clk_prescaler = 16'd63
	) (
	// Device pins
	inout SDA,			// I2C Data
	inout SCL,			// I2C Clock
	
	// Control signals
	input rst,			// Synchronous reset (active high)
	input clk_64MHz,	// System clock.
	input start_update,	// Activation bit. Rising edge of this bit means starting of sending data to poten
	
	// Potentiometer data
	output [7:0] p0_val,
	output [7:0] p1_val,
	output [7:0] p2_val,
	output [7:0] p3_val
);

	// wishbone register address for i2c
	localparam PRER_LO = 3'b000;	// clock prescaler (low byte)
	localparam PRER_HI = 3'b001;	// clock prescaler (high byte)
	localparam CTR     = 3'b010;	// control register (bit7: en/~dis i2c core, bit6: en/~dis interrupt)
	localparam RXR     = 3'b011;	// receive register (when read)
	localparam TXR     = 3'b011;	// transmitt register (when write)
	localparam CR      = 3'b100;	// command register
	localparam SR      = 3'b100;	// status register

	// internal i2c signals
	wire scl_pad_o, scl_padoen_oe;
	wire sda_pad_o, sda_padoen_oe;
	
	// Wishbone signals
	wire [2:0] 	wb_addr;
	wire [7:0] 	wb_dat_i, wb_dat_o;
	wire wb_we, wb_cyc, wb_ack, wb_stb, wb_inta;
 
	// local variables
	reg start_dd, start_d;		// Registers for edge detection of start_update
	reg rst_dd, rst_d;			// Registers for edge detection of rst
	reg [7:0] q;				// Temp register
	
	// Combination circuit for device pins
	assign SCL = scl_padoen_oe ? 1'bz : scl_pad_o;
	assign SDA = sda_padoen_oe ? 1'bz: sda_pad_o;
	
	// Wishbone bus operation model
	wb_master_model #( .dwidth(8), .awidth(3) ) wb (
		.clk( clk_64MHz ),
		.rst( ~rst ),
		.adr( wb_addr ),
		.din( wb_dat_i ),
		.dout( wb_dat_o ),
		.cyc( wb_cyc ),
		.stb( wb_stb ),
		.we( wb_we ),
		.sel(),
		.ack( wb_ack ),
		.err( 1'b0 ),
		.rty( 1'b0 )
	);
	
	// i2c instantiation
	i2c_master_top #( .ARST_LVL( 1'b1 ) ) i2c_top  (
		// wishbone interface
		.wb_clk_i( clk_64MHz ),
		.wb_rst_i( 1'b0 ),	// Unused. Must be 0
		.arst_i( rst ),		// Master reset (active high)
		.wb_adr_i( wb_addr ),
		.wb_dat_i( wb_dat_o ),	// d_in and d_out should be in reverse from wb_master_model
		.wb_dat_o( wb_dat_i ),
		.wb_we_i( wb_we ),
		.wb_stb_i( wb_stb ),
		.wb_cyc_i( wb_cyc ),
		.wb_ack_o( wb_ack ),
		.wb_inta_o( wb_inta ),
 
		// i2c signals
		.scl_pad_i( SCL ),
		.scl_pad_o( scl_pad_o ),
		.scl_padoen_o( scl_padoen_o ),
		.sda_pad_i( SDA ),
		.sda_pad_o( sda_pad_o ),
		.sda_padoen_o( sda_padoen_o )
	);
	
	// Initialization
	initial
	begin
		// Set i2c prescaler
		wb.wb_write( 1, PRER_LO, i2c_clk_prescaler[7:0] );
		wb.wb_write( 1, PRER_HI, i2c_clk_prescaler[15:8] );
		wb.wb_write( 1, CTR, 8'h80 ); 	// enable core
	end

	// Shifting for edge detection
	always @(posedge clk_64MHz)
	begin
		start_dd <= start_d;
		start_d <= start_update;
		rst_dd <= rst_d;
		rst_d <= rst;
	end
	
	// Main process
	always @(posedge clk_64MHz)
	begin
		if( !start_dd && start_d && !rst )	// rising edge
		begin
			/* Update poten 1 channel 1 */
			// Drive slave address
			wb.wb_write( 1, TXR, i2c_address_1 ); 	// present slave address, set write-bit
			wb.wb_write( 0, CR, 8'h90 ); 			// set command (start, write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set channel 1
			wb.wb_write( 1, TXR, 8'h11 ); 		
			wb.wb_write( 0, CR, 8'h10 ); 			// set command (write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set poten value
			wb.wb_write( 1, TXR, p0_val ); 				
			wb.wb_write( 0, CR, 8'h50 ); 			// set command (write, stop)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			/* Update poten 1 channel 2 */
			// Drive slave address
			wb.wb_write( 1, TXR, i2c_address_1 ); 	// present slave address, set write-bit
			wb.wb_write( 0, CR, 8'h90 ); 			// set command (start, write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set channel 1
			wb.wb_write( 1, TXR, 8'h12 ); 		
			wb.wb_write( 0, CR, 8'h10 ); 			// set command (write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set poten value
			wb.wb_write( 1, TXR, p1_val ); 				
			wb.wb_write( 0, CR, 8'h50 ); 			// set command (write, stop)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			/* Update poten 2 channel 1 */
			// Drive slave address
			wb.wb_write( 1, TXR, i2c_address_2 ); 	// present slave address, set write-bit
			wb.wb_write( 0, CR, 8'h90 ); 			// set command (start, write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set channel 1
			wb.wb_write( 1, TXR, 8'h11 ); 		
			wb.wb_write( 0, CR, 8'h10 ); 			// set command (write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set poten value
			wb.wb_write( 1, TXR, p2_val ); 				
			wb.wb_write( 0, CR, 8'h50 ); 			// set command (write, stop)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			/* Update poten 2 channel 2 */
			// Drive slave address
			wb.wb_write( 1, TXR, i2c_address_2 ); 	// present slave address, set write-bit
			wb.wb_write( 0, CR, 8'h90 ); 			// set command (start, write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set channel 1
			wb.wb_write( 1, TXR, 8'h12 ); 		
			wb.wb_write( 0, CR, 8'h10 ); 			// set command (write)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero

			// Set poten value
			wb.wb_write( 1, TXR, p3_val ); 				
			wb.wb_write( 0, CR, 8'h50 ); 			// set command (write, stop)
			
			wb.wb_read(1, SR, q);					// check tip bit
			while(q[1])
				wb.wb_read(0, SR, q); 				// poll it until it is zero
		end
		else
		begin
			if( rst_dd && !rst_d )	// Falling edge
			begin
				// Set i2c prescaler
				wb.wb_write( 1, PRER_LO, i2c_clk_prescaler[7:0] );
				wb.wb_write( 1, PRER_HI, i2c_clk_prescaler[15:8] );
				wb.wb_write( 1, CTR, 8'h80 ); 	// enable core
			end
		end
	end	
endmodule
	