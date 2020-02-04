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

	reg [13:0] d_in;		// Data input
	
	wire [15:0] d_out;		// Data output in format Q13.2
	
	reg clk_64M;			// System 64 MHz clock
	wire clk_out;			// Output clock. Data is updated at the rising edge. The propagation delay of output FF should be considered.
	
	// Additional variables
	integer outfile, cycle_count;

	// Module under test
	avg64_filter filter( .d_in(d_in), .d_out(d_out), .clk_64M(clk_64M), .clk_out(clk_out), .rst(0) );

	// Initialization
	initial
	begin
		$readmemh( "hp_data.hex", in_data );
		outfile = $fopen( "hp_output.hex" ); // open file
		$fmonitor(outfile, "%X,%04X", clk_out, d_out);
		clk_64M <= 0;
		cycle_count <= 0;
	end
	
	// System clock generator
	always 
	begin
		#8 clk_64M = !clk_64M;
	end
	
	// stop the simulation total_data and close the file
	// i.e. store only total_data values in file
	always @(posedge clk_64M)
	begin
		if (cycle_count == total_data) 
		begin
			$fclose(outfile);  // close the file
			$stop;
		end
		else
		begin
			cycle_count = cycle_count + 1;
		end
	end
	
	// Main event
	always @(posedge clk_64M)
	begin
		d_in = in_data[cycle_count];
	end
	
endmodule