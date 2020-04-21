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

module FIR_Cell(
	input [17:0] coefficient,			// FIR coefficient of this cell. (integer value)
	input [29:0] forward_input,			// Signal input into main chain
	output [29:0] forward_output,		// Signal output to cascade with the next forward_input
	input [29:0] flipped_input,			// Signal input along the flipping chain
	
	input [47:0] partial_input,			// Input from the previous node for cascading the result
	
	// The following outputs must be chosen only one valid.
	output [47:0] partial_output,		// Output of the node result used only for cascading
	output [47:0] output_main,			// Main output used only in the right-most node
	
	input clk,							// Master clock
	input rst							// Reset (active high)
	);

	// DSP48E1: 48-bit Multi-Functional Arithmetic Block
	//          Artix-7
	// Xilinx HDL Language Template, version 2019.2

	DSP48E1 #(
		// Feature Control Attributes: Data Path Selection
		.A_INPUT("DIRECT"),               // Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
		.B_INPUT("DIRECT"),               // Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
		.USE_DPORT("TRUE"),               // Select D port usage (TRUE or FALSE)
		.USE_MULT("MULTIPLY"),            // Select multiplier usage ("MULTIPLY", "DYNAMIC", or "NONE")
		.USE_SIMD("ONE48"),               // SIMD selection ("ONE48", "TWO24", "FOUR12")
		
		// Pattern Detector Attributes: Pattern Detection Configuration (Unused in Zeabus_hydrophone)
		.AUTORESET_PATDET("NO_RESET"),    // "NO_RESET", "RESET_MATCH", "RESET_NOT_MATCH"
		.MASK(48'h3fffffffffff),          // 48-bit mask value for pattern detect (1=ignore)
		.PATTERN(48'h000000000000),       // 48-bit pattern match for pattern detect
		.SEL_MASK("MASK"),                // "C", "MASK", "ROUNDING_MODE1", "ROUNDING_MODE2"
		.SEL_PATTERN("PATTERN"),          // Select pattern value ("PATTERN" or "C")
		.USE_PATTERN_DETECT("NO_PATDET"), // Enable pattern detect ("PATDET" or "NO_PATDET")
		
		// Register Control Attributes: Pipeline Register Configuration
		.ACASCREG(1),                     // Number of pipeline stages between A/ACIN and ACOUT (0, 1 or 2)
		.ADREG(1),                        // Number of pipeline stages for pre-adder (0 or 1)
		.ALUMODEREG(1),                   // Number of pipeline stages for ALUMODE (0 or 1)
		.AREG(2),                         // Number of pipeline stages for A (0, 1 or 2)
		.BCASCREG(1),                     // Number of pipeline stages between B/BCIN and BCOUT (0, 1 or 2)
		.BREG(1),                         // Number of pipeline stages for B (0, 1 or 2)
		.CARRYINREG(0),                   // Number of pipeline stages for CARRYIN (0 or 1)
		.CARRYINSELREG(1),                // Number of pipeline stages for CARRYINSEL (0 or 1)
		.CREG(1),                         // Number of pipeline stages for C (0 or 1)
		.DREG(1),                         // Number of pipeline stages for D (0 or 1)
		.INMODEREG(1),                    // Number of pipeline stages for INMODE (0 or 1)
		.MREG(1),                         // Number of multiplier pipeline stages (0 or 1)
		.OPMODEREG(1),                    // Number of pipeline stages for OPMODE (0 or 1)
		.PREG(1)                          // Number of pipeline stages for P (0 or 1)
	)
	DSP48E1_inst (
		// Cascade: 30-bit (each) output: Cascade Ports
		.ACOUT(forward_output),             // 30-bit output: A port cascade output
		.BCOUT(),                   		// 18-bit output: B port cascade output
		.CARRYCASCOUT(),     				// 1-bit output: Cascade carry output
		.MULTSIGNOUT(),       				// 1-bit output: Multiplier sign cascade output
		.PCOUT(partial_output),             // 48-bit output: Cascade output
		
		// Control: 1-bit (each) output: Control Inputs/Status Bits
		.OVERFLOW(),             			// 1-bit output: Overflow in add/acc output
		.PATTERNBDETECT(), 					// 1-bit output: Pattern bar detect output
		.PATTERNDETECT(),   				// 1-bit output: Pattern detect output
		.UNDERFLOW(),           			// 1-bit output: Underflow in add/acc output
		
		// Data: 4-bit (each) output: Data Ports
		.CARRYOUT(),             			// 4-bit output: Carry output
		.P(output_main),                    // 48-bit output: Primary data output
		
		// Cascade: 30-bit (each) input: Cascade Ports
		.ACIN(),                    		// 30-bit input: A cascade data input
		.BCIN(),                     		// 18-bit input: B cascade input
		.CARRYCASCIN(),       				// 1-bit input: Cascade carry input
		.MULTSIGNIN(),         				// 1-bit input: Multiplier sign input
		.PCIN(partial_input),               // 48-bit input: P cascade input
		
		// Control: 4-bit (each) input: Control Inputs/Status Bits
		.ALUMODE(4'b0),               		// 4-bit input: ALU control input
		.CARRYINSEL(3'b0),         			// 3-bit input: Carry select input
		.CLK(clk),                       	// 1-bit input: Clock input
		.INMODE(5'b10100),                 	// 5-bit input: INMODE control input
		.OPMODE(7'b0010101),                // 7-bit input: Operation mode input
		
		// Data: 30-bit (each) input: Data Ports
		.A(forward_input),                  // 30-bit input: A data input
		.B(coefficient),                    // 18-bit input: B data input
		.C(48'b0),                          // 48-bit input: C data input
		.CARRYIN(1'b0),               		// 1-bit input: Carry input signal
		.D(flipped_input[24:0]),            // 25-bit input: D data input
		// Reset/Clock Enable: 1-bit (each) input: Reset/Clock Enable Inputs
		.CEA1(1'b1),                     	// 1-bit input: Clock enable input for 1st stage AREG
		.CEA2(1'b1),                     	// 1-bit input: Clock enable input for 2nd stage AREG
		.CEAD(1'b1),                     	// 1-bit input: Clock enable input for ADREG
		.CEALUMODE(1'b1),           		// 1-bit input: Clock enable input for ALUMODE
		.CEB1(1'b1),                     	// 1-bit input: Clock enable input for 1st stage BREG
		.CEB2(1'b0),                     	// 1-bit input: Clock enable input for 2nd stage BREG
		.CEC(1'b0),                       	// 1-bit input: Clock enable input for CREG
		.CECARRYIN(1'b0),           		// 1-bit input: Clock enable input for CARRYINREG
		.CECTRL(1'b1),                 		// 1-bit input: Clock enable input for OPMODEREG and CARRYINSELREG
		.CED(1'b1),                       	// 1-bit input: Clock enable input for DREG
		.CEINMODE(1'b1),             		// 1-bit input: Clock enable input for INMODEREG
		.CEM(1'b1),                       	// 1-bit input: Clock enable input for MREG
		.CEP(1'b1),                       	// 1-bit input: Clock enable input for PREG
		.RSTA(rst),                     	// 1-bit input: Reset input for AREG
		.RSTALLCARRYIN(rst),   				// 1-bit input: Reset input for CARRYINREG
		.RSTALUMODE(rst),         			// 1-bit input: Reset input for ALUMODEREG
		.RSTB(rst),                     	// 1-bit input: Reset input for BREG
		.RSTC(rst),                     	// 1-bit input: Reset input for CREG
		.RSTCTRL(rst),               		// 1-bit input: Reset input for OPMODEREG and CARRYINSELREG
		.RSTD(rst),                     	// 1-bit input: Reset input for DREG and ADREG
		.RSTINMODE(rst),           			// 1-bit input: Reset input for INMODEREG
		.RSTM(rst),                     	// 1-bit input: Reset input for MREG
		.RSTP(rst)                      	// 1-bit input: Reset input for PREG
	);

	// End of DSP48E1_inst instantiation
endmodule

/* 
 * Main zeabus FIR
 * The implementation is odd-symetric linear phase FIR with order 21
 *
 * The input coefficients are 18-bit integer values
 *
 * From FIR designing method, all coefficients should have values in rage (-1.0, 1.0).
 * The integer coefficients used in this module is actually scaled values of
 * the actual value. This scaling process is same as transformation process between
 * floating-point value into fixed-point format. Hence, we can call the format of 
 * scaled coefficients as Q0.17.
 *
 * The input signal, in the form of Q13.2, is signed extended into Q27.2 (30 bits)
 * Therefore, the final calculation has the result length of 48 bits with the Q-format
 * as Q28.19. The final output is converted back to Q13.2 again.
 *
 */
module zeabus_fir(
	// Coefficents
	input [17:0] coef_1_21,
	input [17:0] coef_2_20,
	input [17:0] coef_3_19,
	input [17:0] coef_4_18,
	input [17:0] coef_5_17,
	input [17:0] coef_6_16,
	input [17:0] coef_7_15,
	input [17:0] coef_8_14,
	input [17:0] coef_9_13,
	input [17:0] coef_10_12,
	input [17:0] coef_11,

	// input signal
	input [15:0] din,
	
	// output signal
	output [15:0] dout,
	
	// control signal
	input rst,			// System reset (active high)
	input clk			// Data clock
	);
	
	// Connecting wires
	wire [29:0] f_out[0:10];
	wire [47:0] p_out[0:9];
	wire [47:0] out;
	
	// Snapshot the output with rounding
	assign dout = out[32:17] + { 15'b0, out[16] };
	
	// FIR network
	FIR_Cell cell_1_21( .coefficient( coef_1_21 ), .forward_input( { {14{din[15]}}, din } ),
						.forward_output( f_out[0] ), .flipped_input( f_out[10] ),
						.partial_input( 48'b0 ), .partial_output( p_out[0] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_2_20( .coefficient( coef_2_20 ), .forward_input( f_out[0] ),
						.forward_output( f_out[1] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[0] ), .partial_output( p_out[1] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_3_19( .coefficient( coef_3_19 ), .forward_input( f_out[1] ),
						.forward_output( f_out[2] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[1] ), .partial_output( p_out[2] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_4_18( .coefficient( coef_4_18 ), .forward_input( f_out[2] ),
						.forward_output( f_out[3] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[2] ), .partial_output( p_out[3] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_5_18( .coefficient( coef_5_17 ), .forward_input( f_out[3] ),
						.forward_output( f_out[4] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[3] ), .partial_output( p_out[4] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_6_17( .coefficient( coef_6_16 ), .forward_input( f_out[4] ),
						.forward_output( f_out[5] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[4] ), .partial_output( p_out[5] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_7_16( .coefficient( coef_7_15 ), .forward_input( f_out[5] ),
						.forward_output( f_out[6] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[5] ), .partial_output( p_out[6] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
		
	FIR_Cell cell_8_14( .coefficient( coef_8_14 ), .forward_input( f_out[6] ),
						.forward_output( f_out[7] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[6] ), .partial_output( p_out[7] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_9_13( .coefficient( coef_9_13 ), .forward_input( f_out[7] ),
						.forward_output( f_out[8] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[7] ), .partial_output( p_out[8] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_10_12( .coefficient( coef_10_12 ), .forward_input( f_out[8] ),
						.forward_output( f_out[9] ), .flipped_input( f_out[10] ),
						.partial_input( p_out[8] ), .partial_output( p_out[9] ), .output_main(),
						.clk(clk), .rst(rst)
					  );
	
	FIR_Cell cell_11( .coefficient( coef_11 ), .forward_input( f_out[9] ),
						.forward_output( f_out[10] ), .flipped_input( 30'b0 ),
						.partial_input( p_out[9] ), .partial_output(), .output_main( out ),
						.clk(clk), .rst(rst)
					  );
endmodule