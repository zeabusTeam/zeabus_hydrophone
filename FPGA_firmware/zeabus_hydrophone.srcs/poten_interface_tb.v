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
module poten_interface_tb ;
	// Device pins
	wire SDA;			// I2C Data
	wire SCL;			// I2C Clock
	
	// Control signals
	reg rst;			// Synchronous reset (active high)
	reg clk_64MHz;	// System clock.
	reg start_update;	// Activation bit. Rising edge of this bit means starting of sending data to poten
	
	// Potentiometer data
	reg [7:0] p0_val;
	reg [7:0] p1_val;
	reg [7:0] p2_val;
	reg [7:0] p3_val;
	
	pullup p1(SCL); // pullup scl line
	pullup p2(SDA); // pullup sda line

	
	// module under test
	i2c_slave_model #( .I2C_ADR(7'b0101_110) ) poten1 ( .scl(SCL), .sda(SDA) );
	i2c_slave_model #( .I2C_ADR(7'b0101_111) ) poten2 ( .scl(SCL), .sda(SDA) );
	poten_interface poten( .SDA(SDA), .SCL(SCL), .rst(rst), .clk_64MHz(clk_64MHz), .start_update(start_update),
							.p0_val(p0_val), .p1_val(p1_val), .p2_val(p2_val), .p3_val(p3_val) );
	
	initial
	begin
		p0_val = 8'hAA;
		p1_val = 8'h55;
		p2_val = 8'hDC;
		p3_val = 8'hB0;
		clk_64MHz = 0;
		rst = 1; #16 rst = 0;
		#192 start_update = 0; #24 start_update = 1; #24 start_update = 0;
		#1000000; // wait 10000us
	    $display("\n\nstatus: %t Testbench done", $time);
	    $finish;

	end
	
	// Clk gen
	always 
	begin
		#8 clk_64MHz = !clk_64MHz; 
	end

endmodule