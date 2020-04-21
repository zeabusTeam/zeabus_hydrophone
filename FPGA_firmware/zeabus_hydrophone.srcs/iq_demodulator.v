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

// Since we use square-wave clock, the modulation is just switch between the input and its inverse.
module IQ_demod_unit( 
	input [19:0] signal, 		// Input signal in Q13.6
	input i_clk, 				// In-phase (cos) clock
	input q_clk, 				// Quadrature-phase (sin) clock
	output [19:0] i_signal, 	// Modulated signal with In-phase clock
	output [19:0] q_signal 		// Modulated signal with Quadrature-phase clock
	);

	assign i_signal = (i_clk) ? signal : -signal;
	assign q_signal = (q_clk) ? signal : -signal;
endmodule

/*
 * The demodulation process consists of just selection. Therefore, we don't need a pipeline here.
 * We implement it as a combinational logic block
 */
module IQ_demodulator( 
	input i_clk, 				// In-phase (cos) clock
	input q_clk, 				// Modulated signal with In-phase clock
	input trigged, 				// Trigger signal to activate the demodulation
	input [79:0] din, 			// Data input connects directly to trigger FIFO
	output [159:0] dout 		// Data output. It does not have any pipeline stage
	);

	// Modulate only the when "trigged"
	wire [19:0] i_dmod1;
	wire [19:0] i_dmod2;
	wire [19:0] i_dmod3;
	wire [19:0] i_dmod4;
	wire [19:0] q_dmod1;
	wire [19:0] q_dmod2;
	wire [19:0] q_dmod3;
	wire [19:0] q_dmod4;
	
	IQ_demod_unit u1( .signal( din[79:60] ), .i_clk( i_clk ), .q_clk( q_clk ), .i_signal( i_dmod1 ), .q_signal( q_dmod_out1 ) );
	IQ_demod_unit u2( .signal( din[59:40] ), .i_clk( i_clk ), .q_clk( q_clk ), .i_signal( i_dmod2 ), .q_signal( q_dmod_out2 ) );
	IQ_demod_unit u3( .signal( din[39:20] ), .i_clk( i_clk ), .q_clk( q_clk ), .i_signal( i_dmod3 ), .q_signal( q_dmod_out3 ) );
	IQ_demod_unit u4( .signal( din[19:00] ), .i_clk( i_clk ), .q_clk( q_clk ), .i_signal( i_dmod4 ), .q_signal( q_dmod_out4 ) );
	
	assign dout = (trigged) ? { i_dmod1, q_dmod1, i_dmod2, q_dmod2, i_dmod3, q_dmod3, i_dmod4, q_dmod4 } : 80'b0;
endmodule
