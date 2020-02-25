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

module slavefifo_verify_tb;
	parameter	FX3S_DMA_Size = 4096;	// Size of FX3S receiving DMA buffer (in 16-bit words)

	integer out_file, cycle_count = 0, counter_ifclk = 0, conf_index = 0, DMA_Counter = 0, DMA_Wait = 0;
	reg [15:0] conf_data[0:15];				// Configuration data

	// Status LEDs
	wire LED_RED_n;
	
	// Master clock input (26 MHz)
	reg clk_in;
	
	// FX3S Interface
	wire ifclk_out;			// Interface clock to FX3S
	wire [15:0] DQ;			// Data bus
	wire [1:0] A;			// Address bus
	wire SLCS;				// Chip select (Active Low)
	wire SLWR, SLRD, SLOE;	// Read/Write and incoming data enable (Active Low)
	wire PKTEND;			// Short packet or zero-length packet (Active Low)
	reg  FLAGA, FLAGB;		// Flags to indicates DMA is ready (Active Low) (A = FX3S->FPGA, B = FPGA->FX3S)
	reg  RST;

	// Temp for bidirectional bus
	wire [15:0] DQ_Out;
	reg  [15:0] DQ_In;

	// Some unused signals for debug
	wire adc_clkout;
	wire [15:0] trigger_level;
	wire inf_rdy;
	wire [3:0] if_state;
	wire [63:0] debug_d, debug_r;
	wire [15:0] debug_t;
	
    assign DQ_Out = DQ;
	assign DQ = (!SLOE)?DQ_In:16'bz;

	// System clock generator (26MHz)
	always 
	begin
		#19 clk_in = ~clk_in;
	end
	initial
	begin
		clk_in = 0;
	end

	always @(posedge ifclk_out)
	begin
		cycle_count = cycle_count + 1;
		if (cycle_count == 10000) 
		begin
			$stop;
		end
	end

	// FX3S behavior
	initial
	begin
		conf_data[0] = 16'hDCB0;
		conf_data[1] = 16'b1000_0000_0000_0000;
		conf_data[2] = 16'h1000;
		conf_data[3] = 16'hDCB0;
		conf_data[4] = 16'b0100_0000_0000_0000;
		conf_data[5] = 16'h01AA;
		conf_data[6] = 16'h0255;
		conf_data[7] = 16'h03DC;
		conf_data[8] = 16'h04B0;
		conf_data[9] = 16'h0008;
		conf_data[10] = 16'h0009;
		conf_data[11] = 16'h0101;
		conf_data[12] = 16'h0102;
		conf_data[13] = 16'h0103;
		conf_data[14] = 16'h0104;
		conf_data[15] = 16'h0105;
		counter_ifclk = 0;
		conf_index = 0;
		cycle_count = 0;
		FLAGA = 0;
		FLAGB = 0;
		RST = 0;
	end

	always @(posedge ifclk_out)
	begin
		counter_ifclk = counter_ifclk + 1;
		if(counter_ifclk == 20)
			FLAGB = 1;		// Enable FPGA->FX3S (Buffer not full)
		if(counter_ifclk == 32)
			FLAGA = 1;		// Enable FX3S->FPGA (Buffer not empty)
		
		if( DMA_Wait > 0 && counter_ifclk > 20)
			DMA_Wait = DMA_Wait - 1;
		else
			FLAGB = 1;
			
		if( FLAGB && !SLWR )
		begin
			DMA_Counter = DMA_Counter + 1;
			if( DMA_Counter == FX3S_DMA_Size )
			begin
				DMA_Counter = 0;
				DMA_Wait = 5;
				FLAGB = 0;
			end
		end
		
		if( FLAGA && !SLOE && !SLRD )
		begin
			if(conf_index > 15)
				if(conf_index > 17 )
					FLAGA = 0;
				else
					conf_index = conf_index + 1;
			else
			begin
				DQ_In = conf_data[conf_index];
				conf_index = conf_index + 1;
			end
		end
	end

	fifo_verify fp( .ifclk_out(ifclk_out), .DQ(DQ), .A(A), .SLCS(SLCS), .SLWR(SLWR),
					.SLRD(SLRD), .SLOE(SLOE), .PKTEND(PKTEND), .FLAGA(FLAGA), .FLAGB(FLAGB),
					.LED_RED_n(LED_RED_n), .clk_in(clk_in), .RST(RST) );

endmodule