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

module avg_filter_tb;
	localparam	total_data = 6400;

	reg [15:0] in_data[0:total_data-1];		// Sampling data

	// Device pins
	reg [13:0] D_1;	// Data channel 0+1 from ADC 1
	wire CLKA_1, CLKB_1;	// ADC Clocks all are identical
	reg OTR_1;	// Data overflow flags from ADC 1 and ADC 2
	
	// Control signals
	reg clk_64MHz;	// System clock.
	reg clk_64MHz_90;	// Identical of system clock with 90-degree phase lag
	
	// Output data
	wire [15:0] d0_out;
	wire [15:0] d1_out;
	
	// Additional variables
	integer outfile, cycle_count;

	// Module under test
	adc_interface adc( .d_in(D_1), .clk_a(CLKA_1), .clk_b(CLKB_1), .overflow(0),
						 .d0_out(d0_out), .d1_out(d1_out),
						 .clk_64MHz(clk_64MHz), .rst(0) );

	// Initialization
	initial
	begin
		$readmemh( "hp_data.hex", in_data );
		outfile = $fopen( "hp_output.hex" ); // open file
		$fmonitor(outfile, "%X,%04X,%04X", clk_64MHz, d0_out, d1_out);
		clk_64MHz <= 0;
		clk_64MHz_90 <= 0;
		cycle_count <= 0;
		OTR_1 <= 0;
	end
	
	// System clock generator
	always 
	begin
		#8 clk_64MHz = !clk_64MHz;
	end
	always @(posedge clk_64MHz)
	begin
		#4 clk_64MHz_90 = 1;
	end
	always @(negedge clk_64MHz)
	begin
		#4 clk_64MHz_90 = 0;
	end
	
	// stop the simulation total_data and close the file
	// i.e. store only total_data values in file
	always @(negedge clk_64MHz)
	begin
		if (cycle_count == total_data) 
		begin
			$fclose(outfile);  // close the file
			$stop;
		end
	end
	
	// Main event
	always @(posedge CLKA_1)
	begin
		D_1 = in_data[cycle_count];
	end
	always @(negedge CLKA_1)
	begin
		D_1 = in_data[cycle_count];
		cycle_count = cycle_count + 1;
	end
	
endmodule
