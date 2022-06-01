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

// Implementation is based on https://opencores.org/projects/i2c/
// We strip-off wishbone bus and interface to i2c_master_byte directly

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
	input clk,		// System clock.
	input start_update,	// Activation bit. Rising edge of this bit means starting of sending data to poten
	
	// Potentiometer data
	input [7:0] p0_val,
	input [7:0] p1_val,
	input [7:0] p2_val,
	input [7:0] p3_val
);
	// Command bits
	localparam CMD_GEN_START = 4'b1000;		// Generate START or REPEAT_START along with the next data
	localparam CMD_GEN_STOP  = 4'b0100;		// Generate STOP along with the next data
	localparam CMD_READ      = 4'b0010;		// Perform READ
	localparam CMD_WRITE     = 4'b0001;		// Perform WRITE
	
	// States
	// Sub-state
	localparam SUBSTATE_SEND_SLAVE_ADDR = 2'b00;
	localparam SUBSTATE_SEND_POTEN_ADDR = 2'b01;
	localparam SUBSTATE_SEND_POTEN_VAL = 2'b10;
	
	// Main state
	localparam STATE_IDLE = 3'b000;
	localparam STATE_SET_POTEN1 = 3'b001;
	localparam STATE_SET_POTEN2 = 3'b010;
	localparam STATE_SET_POTEN3 = 3'b011;
	localparam STATE_SET_POTEN4 = 3'b100;

	// internal i2c signals
	wire scl_pad_i, scl_pad_o, scl_padoen_o;
	wire sda_pad_i, sda_pad_o, sda_padoen_o;
	
	// local variables
	reg start_dd, start_d;		// Registers for edge detection of start_update
	reg rst_dd, rst_d;			// Registers for edge detection of rst
	reg core_en;				// Enable I2C core
	reg [3:0] cmd;				// Command register
	reg  [ 7:0] txr;  			// transmit register
	wire [ 7:0] rxr;  			// receive register
	reg  txack;					// acknowledge value to send to slave
	wire rxack;       			// received aknowledge from slave
	wire i2c_busy;    			// bus busy (start signal detected)
	wire i2c_al;      			// i2c bus arbitration lost
		
	// done signal: command completed, clear command register
	wire done;
	wire inprogress;			// i2c operation is inprogress
	
	// State variables
	reg cmd_phase;				// Phase of I2C byte operation (0 = activate, 1 = wait for complete)
	reg [1:0] sub_state;
	reg [2:0] main_state;

	// Combination circuit for device pins
	assign SCL = scl_padoen_o ? 1'bz : scl_pad_o;
	assign SDA = sda_padoen_o ? 1'bz: sda_pad_o;
	assign scl_pad_i = SCL;
	assign sda_pad_i = SDA;
	assign inprogress = ( cmd[1] | cmd[0] );
	
	// i2c instantiation
	// hookup byte controller block
	i2c_master_byte_ctrl byte_controller (
		.clk      ( clk    ),		// Master clock
		.rst      ( rst     	 ),		// Synchronous reset
		.nReset   ( 1'b1       	 ),		// Asynchronous reset (Active Low) (unused, tied to negate)
		.ena      ( core_en      ),
		.clk_cnt  ( i2c_clk_prescaler ),// Clock prescaler
		
		// Command bits (Setting these command bits starts the operation)
		.start    ( cmd[3]       ),		// Generate START or REPEAT_START along with the next data
		.stop     ( cmd[2]       ),		// Generate STOP along with the next data
		.read     ( cmd[1]       ),		// Perform READ
		.write    ( cmd[0]       ),		// Perform WRITE
		
		// Data
		.ack_in   ( txack        ),		// ACK value when received a byte
		.din      ( txr          ),		// Data to send
		.dout     ( rxr          ),		// Received data
		
		// Status 
		.cmd_ack  ( done         ),		// The command is done
		.ack_out  ( rxack        ),		// ACK value from slave device from previous sending
		.i2c_busy ( i2c_busy     ),		// Bus is busy
		.i2c_al   ( i2c_al       ),		// Arbitration lost
		
		// I2C pads
		.scl_i    ( scl_pad_i    ),
		.scl_o    ( scl_pad_o    ),
		.scl_oen  ( scl_padoen_o ),
		.sda_i    ( sda_pad_i    ),
		.sda_o    ( sda_pad_o    ),
		.sda_oen  ( sda_padoen_o )
	);
		
	initial
	begin
		core_en <= 0;
		cmd_phase <= 0;
		cmd <= 0;
	end
	
	// Shifting for edge detection
	always @(posedge clk)
	begin
		start_dd <= start_d;
		start_d <= start_update;
		rst_dd <= rst_d;
		rst_d <= rst;
	end
	
	// Reset and enable the i2c core
	always @(posedge clk)
	begin
		if( rst )
		begin
			core_en <= 0;
		end
		else
			core_en <= #2 1;
	end

	/*
	 * The I2C subsystem used in this project operates as a byte sender/receiver with modifiers.
	 * The modifiers indicate the I2C bus operation along with the travelling byte, such as
	 * initiate START, STOP, or REPEAT-START conditions. After getting the command, the subsystem
	 * operates on its own until finish sending or receiving. There is an output flag to check
	 * the completeness of this operation.
	 * Commanding 4 external potentiometers requires the system to send a sequence of commands 
	 * to each potentiometer. Hence, repeating the subsystem byte command for several times.
	 * Therefore, we define 2 macros to aggregate relevant steps.
	 *
	 * The first macro (activate_i2c) manage byte transferring and wait until that transfer to finish.
	 *
	 * The second macro (poten_sub) manage transferring a sequence of potentiometer setting by 
	 * utilizing the "activate_i2c" macro for each byte in the sequence.
	 * 
	 * Finally, the main process has to activate the "poten_sub" macro for each potentiometer.
	 *
	 */
	// Main process
	`define activate_i2c(next_state, command) \
		if( !cmd_phase ) \
		begin \
			cmd <= #1 command; \
			cmd_phase <= #1 1; \
		end \
		else \
		begin \
			if( !inprogress ) \
			begin \
				cmd_phase <= #1 0; \
				sub_state <= #1 next_state; \
			end \
		end
	
	`define poten_sub(next_state, s_addr, p_addr, p_value) \
		case( sub_state ) \
			SUBSTATE_SEND_SLAVE_ADDR: \
			begin \
				txr <= #1 s_addr; \
				`activate_i2c( SUBSTATE_SEND_POTEN_ADDR, (CMD_GEN_START | CMD_WRITE) ) \
			end \
			SUBSTATE_SEND_POTEN_ADDR: \
			begin \
				txr <= #1 p_addr; \
				`activate_i2c( SUBSTATE_SEND_POTEN_VAL, CMD_WRITE ) \
			end \
			SUBSTATE_SEND_POTEN_VAL: \
			begin \
				txr <= #1 p_value; \
				`activate_i2c( SUBSTATE_SEND_SLAVE_ADDR, (CMD_GEN_STOP | CMD_WRITE) ) \
				if( sub_state == SUBSTATE_SEND_SLAVE_ADDR ) \
					main_state <= #1 next_state; \
			end \
		endcase
	
	always @(posedge clk)
	begin
		if( rst )
		begin
			cmd_phase <= #1 0;
			sub_state <= #1 SUBSTATE_SEND_SLAVE_ADDR;
			main_state <= #1 STATE_IDLE;
			cmd <= #1 4'b0;
		end
		else
		begin
	        if(done | i2c_al)
				cmd <= #1 4'b0;    // clear command bits when done or when aribitration lost
			
			case( main_state )
				STATE_IDLE:
				begin
					if( !start_dd && start_d )	// rising edge
						main_state <= #1 STATE_SET_POTEN1;
				end
				
				STATE_SET_POTEN1: /* Update poten 1 channel 1 */
				begin
					`poten_sub( STATE_SET_POTEN2, i2c_address_1, 8'h11, p0_val )
				end
				
				STATE_SET_POTEN2: /* Update poten 1 channel 2 */
				begin
					`poten_sub( STATE_SET_POTEN3, i2c_address_1, 8'h12, p1_val )
				end
				
				STATE_SET_POTEN3: /* Update poten 2 channel 1 */
				begin
					`poten_sub( STATE_SET_POTEN4, i2c_address_2, 8'h11, p2_val )
				end
				
				STATE_SET_POTEN4: /* Update poten 2 channel 2 */
				begin
					`poten_sub( STATE_IDLE, i2c_address_2, 8'h12, p3_val )
				end
			endcase
		end
	end	
endmodule
	