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


module fir_tb;
	localparam	total_data = 1000, clk_toggle_period = 5;

	reg [15:0] in_data[0:total_data-1];		// Sampling data
	wire [15:0] dout;
	reg [15:0] din;

	reg [17:0] coef[0:10];
	reg rst, clk;
	
	integer out_file, cycle_count = 0;
	
	initial
	begin
		$readmemh( "data.hex", in_data );
		out_file = $fopen("output.hex"); // open file
		$fmonitor(out_file, "%04X", dout);
		//$monitor("%d : %016X,%b,%b", d_out, trigged, rst);
		rst = 1; #clk_toggle_period rst = 0;
		// Coefficients for bandpass at 25kHz with "window" + "hamming" method (from Matlab)
		coef[0] = 18'h00000;
		coef[1] = 18'h00444;
		coef[2] = 18'h00dcc;
		coef[3] = 18'h0208e;
		coef[4] = 18'h03e33;
		coef[5] = 18'h0658f;
		coef[6] = 18'h092c8;
		coef[7] = 18'h0c00c;
		coef[8] = 18'h0e6bc;
		coef[9] = 18'h100c9;
		coef[10] = 18'h109f9;
		din = 0;
	end
	
	// Clk gen
	always
	begin
		clk = 1'b1; 
		#clk_toggle_period; // high for clk_toggle_period

		clk = 1'b0;
		#clk_toggle_period; // low for clk_toggle_period
	end
	
	// Apply sample data every clock edge
	always @(negedge clk)
	begin
		din = in_data[cycle_count];
	end

	// stop the simulation total_data and close the file
	// i.e. store only total_data values in file
	always @(posedge clk)
	begin
		if (cycle_count == total_data) 
		begin
			$fclose(out_file);  // close the file
			$stop;
		end
		else
		begin
			if(rst)
				cycle_count = 0;
			else
				cycle_count = cycle_count + 1;
		end
	end

	zeabus_fir fir( .coef_1_21( coef[0] ), .coef_2_20( coef[1] ), .coef_3_19( coef[2] ),
					.coef_4_18( coef[3] ), .coef_5_17( coef[4] ), .coef_6_16( coef[5] ),
					.coef_7_15( coef[6] ), .coef_8_14( coef[7] ), .coef_9_13( coef[8] ),
 					.coef_10_12( coef[9] ), .coef_11( coef[10] ),
					.din( din ), .dout( dout ), .rst( rst ), .clk( clk ) );
                             
endmodule
