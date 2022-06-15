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

module i2c_slave_model (scl, sda);
 
	//
	// parameters
	//
	parameter I2C_ADR = 7'b001_0000;
 
	//
	// input && outpus
	//
	input scl;
	inout sda;
 
	//
	// Variable declaration
	//
	wire debug = 1'b1;
 
	reg [7:0] mem [7:0]; // initiate memory
	reg [7:0] mem_adr;   // memory address
	reg [7:0] mem_do;    // memory data output
 
	reg sta, d_sta;
	reg sto, d_sto;
 
	reg [7:0] sr;        // 8bit shift register
	reg       rw;        // read/write direction
 
	wire      my_adr;    // my address called ??
	wire      i2c_reset; // i2c-statemachine reset
	reg [2:0] bit_cnt;   // 3bit downcounter
	wire      acc_done;  // 8bits transfered
	reg       ld;        // load downcounter
 
	reg       sda_o;     // sda-drive level
	wire      sda_dly;   // delayed version of sda
 
	// statemachine declaration
	parameter idle        = 3'b000;
	parameter slave_ack   = 3'b001;
	parameter get_mem_adr = 3'b010;
	parameter gma_ack     = 3'b011;
	parameter data        = 3'b100;
	parameter data_ack    = 3'b101;
 
	reg [2:0] state; // synopsys enum_state
 
	//
	// module body
	//
 
	initial
	begin
	   sda_o = 1'b1;
	   state = idle;
	end
 
	// generate shift register
	always @(posedge scl)
	  sr <= #1 {sr[6:0],sda};
 
	//detect my_address
	assign my_adr = (sr[7:1] == I2C_ADR);
	// FIXME: This should not be a generic assign, but rather
	// qualified on address transfer phase and probably reset by stop
 
	//generate bit-counter
	always @(posedge scl)
	  if(ld)
	    bit_cnt <= #1 3'b111;
	  else
	    bit_cnt <= #1 bit_cnt - 3'h1;
 
	//generate access done signal
	assign acc_done = !(|bit_cnt);
 
	// generate delayed version of sda
	// this model assumes a hold time for sda after the falling edge of scl.
	// According to the Phillips i2c spec, there s/b a 0 ns hold time for sda
	// with regards to scl. If the data changes coincident with the clock, the
	// acknowledge is missed
	// Fix by Michael Sosnoski
	assign #1 sda_dly = sda;
 
 
	//detect start condition
	always @(negedge sda)
	  if(scl)
	    begin
	        sta   <= #1 1'b1;
		d_sta <= #1 1'b0;
		sto   <= #1 1'b0;
 
	        if(debug)
	          $display("DEBUG i2c_slave; start condition detected at %t", $time);
	    end
	  else
	    sta <= #1 1'b0;
 
	always @(posedge scl)
	  d_sta <= #1 sta;
 
	// detect stop condition
	always @(posedge sda)
	  if(scl)
	    begin
	       sta <= #1 1'b0;
	       sto <= #1 1'b1;
 
	       if(debug)
	         $display("DEBUG i2c_slave; stop condition detected at %t", $time);
	    end
	  else
	    sto <= #1 1'b0;
 
	//generate i2c_reset signal
	assign i2c_reset = sta || sto;
 
	// generate statemachine
	always @(negedge scl or posedge sto)
	  if (sto || (sta && !d_sta) )
	    begin
	        state <= #1 idle; // reset statemachine
 
	        sda_o <= #1 1'b1;
	        ld    <= #1 1'b1;
	    end
	  else
	    begin
	        // initial settings
	        sda_o <= #1 1'b1;
	        ld    <= #1 1'b0;
 
	        case(state) // synopsys full_case parallel_case
	            idle: // idle state
	              if (acc_done && my_adr)
	                begin
	                    state <= #1 slave_ack;
	                    rw <= #1 sr[0];
	                    sda_o <= #1 1'b0; // generate i2c_ack
 
	                    #2;
	                    if(debug && rw)
	                      $display("DEBUG i2c_slave; command byte received (read) at %t", $time);
	                    if(debug && !rw)
	                      $display("DEBUG i2c_slave; command byte received (write) at %t", $time);
 
	                    if(rw)
	                      begin
	                          mem_do <= #1 mem[mem_adr];
 
	                          if(debug)
	                            begin
	                                #2 $display("DEBUG i2c_slave; data block read %x from address %x (1)", mem_do, mem_adr);
	                                #2 $display("DEBUG i2c_slave; memcheck [0]=%x, [1]=%x, [2]=%x", mem[4'h0], mem[4'h1], mem[4'h2]);
	                            end
	                      end
	                end
 
	            slave_ack:
	              begin
	                  if(rw)
	                    begin
	                        state <= #1 data;
	                        sda_o <= #1 mem_do[7];
	                    end
	                  else
	                    state <= #1 get_mem_adr;
 
	                  ld    <= #1 1'b1;
	              end
 
	            get_mem_adr: // wait for memory address
	              if(acc_done)
	                begin
	                    state <= #1 gma_ack;
	                    mem_adr <= #1 sr; // store memory address
	                    sda_o <= #1 !(sr <= 255); // generate i2c_ack, for valid address
 
	                    if(debug)
	                      #1 $display("DEBUG i2c_slave; address received. adr=%x, ack=%b", sr, !(sr <= 255));
	                end
 
	            gma_ack:
	              begin
	                  state <= #1 data;
	                  ld    <= #1 1'b1;
	              end
 
	            data: // receive or drive data
	              begin
	                  if(rw)
	                    sda_o <= #1 mem_do[7];
 
	                  if(acc_done)
	                    begin
	                        state <= #1 data_ack;
	                        mem_adr <= #2 mem_adr + 8'h1;
	                        sda_o <= #1 (rw && (mem_adr <= 255) ); // send ack on write, receive ack on read
 
	                        if(rw)
	                          begin
	                              #3 mem_do <= mem[mem_adr];
 
	                              if(debug)
	                                #5 $display("DEBUG i2c_slave; data block read %x from address %x (2)", mem_do, mem_adr);
	                          end
 
	                        if(!rw)
	                          begin
	                              mem[ mem_adr ] <= #1 sr; // store data in memory
 
	                              if(debug)
	                                #2 $display("DEBUG i2c_slave; data block write %x to address %x", sr, mem_adr);
	                          end
	                    end
	              end
 
	            data_ack:
	              begin
	                  ld <= #1 1'b1;
 
	                  if(rw)
	                    if(sr[0]) // read operation && master send NACK
	                      begin
	                          state <= #1 idle;
	                          sda_o <= #1 1'b1;
	                      end
	                    else
	                      begin
	                          state <= #1 data;
	                          sda_o <= #1 mem_do[7];
	                      end
	                  else
	                    begin
	                        state <= #1 data;
	                        sda_o <= #1 1'b1;
	                    end
	              end
 
	        endcase
	    end
 
	// read data from memory
	always @(posedge scl)
	  if(!acc_done && rw)
	    mem_do <= #1 {mem_do[6:0], 1'b1}; // insert 1'b1 for host ack generation
 
	// generate tri-states
	assign sda = sda_o ? 1'bz : 1'b0;
 
 
	//
	// Timing checks
	//
 
	wire tst_sto = sto;
	wire tst_sta = sta;
 
/*	specify
	  specparam normal_scl_low  = 4700,
	            normal_scl_high = 4000,
	            normal_tsu_sta  = 4700,
	            normal_thd_sta  = 4000,
	            normal_tsu_sto  = 4000,
	            normal_tbuf     = 4700,
 
	            fast_scl_low  = 1300,
	            fast_scl_high =  600,
	            fast_tsu_sta  = 1300,
	            fast_thd_sta  =  600,
	            fast_tsu_sto  =  600,
	            fast_tbuf     = 1300;
 
	  $width(negedge scl, normal_scl_low);  // scl low time
	  $width(posedge scl, normal_scl_high); // scl high time
 
	  $setup(posedge scl, negedge sda &&& scl, normal_tsu_sta); // setup start
	  $setup(negedge sda &&& scl, negedge scl, normal_thd_sta); // hold start
	  $setup(posedge scl, posedge sda &&& scl, normal_tsu_sto); // setup stop
 
	  $setup(posedge tst_sta, posedge tst_sto, normal_tbuf); // stop to start time
	endspecify
 */
endmodule

//=========================================================================================================
module zeabus_hydrphone_tb;
	parameter	FX3S_DMA_Size = 4096;	// Size of FX3S receiving DMA buffer (in 16-bit words)
	localparam	total_data = 10000;
	
	//integer out_file;
	integer cycle_count = 0, counter_ifclk = 0, conf_index = 0, DMA_Counter = 0, DMA_Wait = 0;

	reg [63:0] in_data[0:total_data-1];		// Sampling data
	reg [15:0] conf_data[0:15];				// Configuration data
	
	//wire [63:0] ADC_abs_Value;
    //wire [15:0] Trigger_lvl;
	//wire Trig_Out_Strobe, Ch1_Strobe, Ch2_Strobe, Ch3_Strobe, Ch4_Strobe;
	//wire [63:0] abs_data;
	//wire [15:0] abs_trig;
	//wire [15:0] conf_read_din;

	/* Device pins */
	// ADC-1 pins
	reg OTR_1;				// Overflow
	reg [13:0]D_1;		// Data input
	wire CLKA_1, CLKB_1;	// ADC Clocks
	
	// ADC-2 pins
	reg OTR_2;			// Overflow
	reg [13:0]D_2;		// Data input
	wire CLKA_2, CLKB_2;	// ADC Clocks
	
	// Potentiometers pins
	wire SCL, SDA;			// I2C functions
	
	// Status LEDs
	wire [0:0]LED_RED_n;
	wire [0:0]LED_GREEN;
	wire LED_BLUE;

	wire LED_GREEN_1;
	wire [0:0]LED_GREEN_2;
	wire [0:0]LED_GREEN_3;
	wire LED_RED_1;
	wire [0:0]LED_RED_2;
	wire [0:0]LED_RED_3;
	wire LED_YELLOW_1;
	wire LED_YELLOW_2;
	wire [0:0]LED_YELLOW_3;
	wire [15:0] Config_data;
	
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

	// wire adc_clkout;
	// wire [15:0] trigger_level;
	// wire inf_rdy;
	// wire [3:0] if_state;
	// wire [63:0] debug_d, debug_r;
	// wire [15:0] debug_t;
	
    assign DQ_Out = DQ;
	assign DQ = (!SLOE)?DQ_In:16'bz;
	
	// FX3S behavior
	initial
	begin
		$readmemh( "data.hex", in_data );
		$display("Done reading");
		conf_data[0] = 16'hDC0C;  // Enable Trigger and Poten settings
		conf_data[1] = 16'h0100;  // Trigger level (Signed integer)
		conf_data[2] = 16'h2040;  // Poten 1 and 2
		conf_data[3] = 16'h3050;  // Poten 3 and 4
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
		//out_file = $fopen("output.hex"); // open file
		//$fmonitor(out_file, "%d : %016X,%b,%b", input_cycle_count, t_d_out, trigged, rst);
		//$monitor("%d : %016X,%b,%b", d_out, trigged, rst);
		counter_ifclk = 0;
		conf_index = 0;
		cycle_count = 0;
		FLAGA = 0;
		FLAGB = 0;
		RST = 0;
		OTR_1 = 0;
		OTR_2 = 0;
	end

	reg [1:0] post_rd;
	reg [1:0] pre_rd;
	initial
	begin
	   post_rd <= 2'b0;
	   pre_rd <= 2'b0;
	end

	always @(posedge ifclk_out)
	begin
		counter_ifclk = counter_ifclk + 1;
		if(counter_ifclk == 20)
			FLAGB = 1;		// Enable FPGA->FX3S (Buffer not full)
		//if(counter_ifclk == 32)
		//	FLAGA = 1;		// Enable FX3S->FPGA (Buffer not empty)
		
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
		
		if( FLAGA )
		begin
		  if( !SLRD )
		  begin
		      post_rd = 2'b0;
		      if( pre_rd == 2'd1 )
		      begin
		          DQ_In = conf_data[conf_index];
		          conf_index = conf_index + 1;
		      end
		      else
		          pre_rd = pre_rd + 1;
		  end
		  else
		  begin
		      pre_rd = 2'b0;
		      if(post_rd >= 2'd1)
		      begin
		          if(conf_index > 5)
		              FLAGA = 0;
		      end
		      else
		          post_rd = post_rd + 1;
		  end
		end
		else
		begin
		  pre_rd = 2'b0;
		  post_rd = 2'b0;
		end

	end
			
	// ADC event
	always @(posedge CLKA_1)
	begin
		if (cycle_count == total_data) 
		begin
			//$fclose(out_file);  // close the file
			$stop;
		end
	
		D_1 = in_data[cycle_count][15:2];
	end
	always @(negedge CLKA_1)
	begin
		D_1 = in_data[cycle_count][31:18];
		cycle_count = cycle_count + 1;
	end
	always @(posedge CLKA_2)
	begin
		D_2 = in_data[cycle_count][47:34];
	end
	always @(negedge CLKA_2)
	begin
		D_2 = in_data[cycle_count][63:50];
	end

	// System clock generator (26MHz)
	always 
	begin
		#19 clk_in = ~clk_in;
	end
	initial
	begin
		clk_in = 0;
	end

	// Poten-to-be
	pullup p1(SCL); // pullup scl line
	pullup p2(SDA); // pullup sda line
	
	// module under test
	i2c_slave_model #( .I2C_ADR(7'b0101_110) ) poten1 ( .scl(SCL), .sda(SDA) );
	i2c_slave_model #( .I2C_ADR(7'b0101_111) ) poten2 ( .scl(SCL), .sda(SDA) );
	zeabus_hydrophone hp( .OTR_1(OTR_1), .D_1(D_1), .CLKA_1(CLKA_1), .CLKB_1(CLKB_1),
						.OTR_2(OTR_2), .D_2(D_2), .CLKA_2(CLKA_2), .CLKB_2(CLKB_2),
						.SCL(SCL), .SDA(SDA), 
						.ifclk_out(ifclk_out), .DQ(DQ), .A(A), .SLCS(SLCS), .SLWR(SLWR),
						.SLRD(SLRD), .SLOE(SLOE), .PKTEND(PKTEND), .FLAGA(FLAGA), .FLAGB(FLAGB),
						.LED_BLUE(LED_BLUE), .LED_GREEN(LED_GREEN), .LED_RED_n(LED_RED_n),
						.LED_RED_1(LED_RED_1), .LED_YELLOW_1(LED_YELLOW_1), .LED_GREEN_1(LED_GREEN_1),
						.LED_RED_2(LED_RED_2), .LED_YELLOW_2(LED_YELLOW_2), .LED_GREEN_2(LED_GREEN_2),
						.LED_RED_3(LED_RED_3), .LED_YELLOW_3(LED_YELLOW_3), .LED_GREEN_3(LED_GREEN_3),
						//.ADC_Value(ADC_Value),
						//.Trig_Out_Strobe(Trig_Out_Strobe), .Ch1_Strobe(Ch1_Strobe), .Ch2_Strobe(Ch2_Strobe), 
						//.Ch3_Strobe(Ch3_Strobe), .Ch4_Strobe(Ch4_Strobe), 
						//.abs_data(abs_data), .abs_trig(abs_trig), .trigger_level_set(Trigger_lvl),
						//.conf_read_din(conf_read_din),
						//.Config_data(Config_data),
						.clk_in(clk_in), .RST(RST) );
endmodule

