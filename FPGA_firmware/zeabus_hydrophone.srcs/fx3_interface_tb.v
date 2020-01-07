`timescale 1ns / 1ps

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

module fx3_interface_tb;
	localparam	total_data = 10000;
	
	integer out_file, input_cycle_count = 0, counter_64MHz = 0, conf_index = 0;

	reg [63:0] in_data[0:total_data-1];		// Sampling data
	reg [15:0] conf_data[0:15];				// Configuration data
	reg clk_64MHz;			// System clock
	reg clk_1MHz;			// Data clock

	// Trigger signals
	reg [63:0] d_in;		// Input data
	wire [63:0] t_d_out;	// Trigger Output data
	reg [15:0] level;		// Trigger level
	reg rst;				// Reset (active high)
	wire trigged;			// Trigger armed status
	
	// Interface signals
	wire if_ready;			// Interface engine is ready
	wire if_input_full;		// Interface input is full
	wire [15:0] i_d_out;	// Incoming data output
	wire i_output_valid;	// Incoming data available
	reg	 i_oe;				// Enable incoming-data fetch
	
	// Pin signal
	wire ifclk;				// Interface clock to FX3S
	wire [15:0] DQ;			// Data bus
	wire [1:0] A;			// Address bus
	wire SLCS;				// Chip select (Active Low)
	wire SLWR, SLRD, SLOE;	// Read/Write and incoming data enable (Active Low)
	wire PKTEND;			// Short packet or zero-length packet (Active Low)
	reg  FLAGA, FLAGB;		// Flags to indicates DMA is ready (Active Low) (A = FX3S->FPGA, B = FPGA->FX3S)
	
	// Temp for bidirectional bus
	wire [15:0] DQ_Out;
	reg  [15:0] DQ_In;
	
	wire [3:0] state;
	wire tx_empty, tx_full, rx_empty, rx_full;
	wire tx_wr_rst_busy, tx_rd_rst_busy, rx_wr_rst_busy, rx_rd_rst_busy;
	wire tx_wr_en, tx_rd_en, rx_wr_en, rx_rd_en;
	wire [15:0] d_data;
	wire d_clk, dd_clk;
	wire is_sending;
	
	assign DQ_Out = DQ;
	assign DQ = (!SLOE)?DQ_In:16'bz;

	// Module under test
	hydrophone_trigger ht( .rst(rst), .clk(clk_1MHz), .trigger_level(level), .d_out(t_d_out), .d_in(d_in), .trigged(trigged) );
	fx3s_interface fx3i( .clk_64M(clk_64MHz), .rst(rst), .rdy(if_ready), 
						.d_in(t_d_out), .input_valid(trigged), .input_d_clk(clk_1MHz), .input_full(if_input_full),
						.d_out(i_d_out), .output_valid(i_output_valid), .output_d_oe(i_oe), .output_d_clk(clk_64MHz),
						.ifclk_out(ifclk), .DQ(DQ), .A(A), .SLCS(SLCS), .SLWR(SLWR), .SLRD(SLRD), .SLOE(SLOE), .PKTEND(PKTEND),
						.FLAGA(FLAGA), .FLAGB(FLAGB), 
						.state(state), .TxEmpty(tx_empty), .TxFull(tx_full), .RxEmpty(rx_empty), .RxFull(rx_full),
						.TxWrRstBusy(tx_wr_rst_busy), .TxRdRstBusy(tx_rd_rst_busy), .RxWrRstBusy(rx_wr_rst_busy), .RxRdRstBusy(rx_rd_rst_busy),
						.TxWrEn(tx_wr_en), .TxRdEn(tx_rd_en), .RxWrEn(rx_wr_en), .RxRden(rx_rd_en), .d_data(d_data), .d_clk(d_clk), .dd_clk(dd_clk),
						.sending(is_sending)
	);

	initial
	begin
		$readmemh( "data.hex", in_data );
		conf_data[0] = 16'h4A43;
		conf_data[1] = 16'd2000;
		conf_data[2] = 16'h0001;
		conf_data[3] = 16'h0002;
		conf_data[4] = 16'h0003;
		conf_data[5] = 16'h0004;
		conf_data[6] = 16'h0005;
		conf_data[7] = 16'h0006;
		conf_data[8] = 16'h0007;
		conf_data[9] = 16'h0008;
		conf_data[10] = 16'h0009;
		conf_data[11] = 16'h0101;
		conf_data[12] = 16'h0102;
		conf_data[13] = 16'h0103;
		conf_data[14] = 16'h0104;
		conf_data[15] = 16'h0105;
		//out_file = $fopen("output.hex"); // open file
		//$fmonitor(out_file, "%d : %016X,%b,%b", input_cycle_count, t_d_out, trigged, rst);
		//$monitor("%d : %016X,%b,%b", d_out, trigged, rst);
		clk_64MHz = 0;
		clk_1MHz = 0;
		counter_64MHz = 0;
		conf_index = 0;
		level = 16'd2000; // 0x07D0
		FLAGA = 1;
		FLAGB = 1;
		i_oe = 0;
		rst = 1; #8 rst = 0;
	end
	
	// Clk gen
	always 
	begin
		#500 clk_1MHz = !clk_1MHz;
	end
	
	always 
	begin
		#8 clk_64MHz = !clk_64MHz; 
	end
	
	always @(posedge clk_64MHz)
	begin
		counter_64MHz = counter_64MHz + 1;
	end

	// stop the simulation total_data and close the file
	// i.e. store only total_data values in file
	always @(posedge clk_1MHz)
	begin
		if (input_cycle_count == total_data) 
		begin
			//$fclose(out_file);  // close the file
			$stop;
		end
		else
		begin
			if(rst)
				input_cycle_count = 0;
			else
				input_cycle_count = input_cycle_count + 1;
		end
	end

	// Trigger circuit
	always @(posedge clk_1MHz)
	begin
		d_in = in_data[input_cycle_count];
	end
	
	// FX3S behavior
	always @(posedge ifclk)
	begin
		if(counter_64MHz == 20)
			FLAGB = 0;		// Enable FPGA->FX3S
		if(counter_64MHz == 32'h3ebca)
			FLAGA = 0;
		
		if( !FLAGA && !SLOE && !SLRD )
		begin
			if(conf_index > 15)
				FLAGA = 1;
			else
			begin
				DQ_In = conf_data[conf_index];
				conf_index = conf_index + 1;
			end
		end
	end
	
	// FPGA config logic
	always @(posedge clk_64MHz)
	begin
		if( i_output_valid )
			i_oe = 1;
		else
			i_oe = 0;
	end
	

endmodule
