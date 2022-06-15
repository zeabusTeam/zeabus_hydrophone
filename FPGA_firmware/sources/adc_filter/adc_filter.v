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

module sort(
    input [13:0] din_0,
    input [13:0] din_1,
    output [13:0] dout_0,   // The small
    output [13:0] dout_1    // The big
);

    assign dout_0 = ($signed(din_0) > $signed(din_1)) ? din_1 : din_0;
    assign dout_1 = ($signed(din_0) > $signed(din_1)) ? din_0 : din_1;
endmodule


module median_filter(
    input clk,          // System clock (each rising edge indicates new data is ready)
    input rst,          // Synchronous reset (active high)
    input [13:0] d_in,  // Input valid at clock rising edge
    output [13:0] d_out // Data output
);
    reg [13:0] d[0:4];  // We have 5 backlog

    initial
    begin
        d[0] <= 0; d[1] <= 0; d[2] <= 0; d[3] <= 0; d[4] <= 0;
    end
    // data delay line
    always @(posedge clk)
    begin
        if( rst )
        begin
            d[0] <= 0; d[1] <= 0; d[2] <= 0; d[3] <= 0; d[4] <= 0;
        end
        else
        begin
            d[0] <= d[1];
            d[1] <= d[2];
            d[2] <= d[3];
            d[3] <= d[4];
            d[4] <= d_in;
        end
    end

    // We use bubble-sort stages to find the median.
    // Since we have 5 items, we need 4 full bubble sort stages plus 1 partial sort
    wire [13:0] stage1[0:4];
    wire [13:0] stage2[0:4];
    wire [13:0] stage3[0:4];
    wire [13:0] stage4[0:4];
	
	// Pipeline FF to divide the whole stages into 2 pipeline-stages
	reg [13:0] pipeline1[0:4];

    // Stage1
    sort s1_0( d[0], d[1], stage1[0], stage1[1] );
    sort s1_1( d[2], d[3], stage1[2], stage1[3] );
    assign stage1[4] = d[4];

    // Stage2
    assign stage2[0] = stage1[0];
    sort s2_0( stage1[1], stage1[2], stage2[1], stage2[2] );
    sort s2_1( stage1[3], stage1[4], stage2[3], stage2[4] );
	
	// Add pipeline stage here
	initial
	begin
		pipeline1[0] <= 14'b0;
		pipeline1[1] <= 14'b0;
		pipeline1[2] <= 14'b0;
		pipeline1[3] <= 14'b0;
		pipeline1[4] <= 14'b0;
	end
	always @(posedge clk)
	begin
		pipeline1[0] <= stage2[0];
		pipeline1[1] <= stage2[1];
		pipeline1[2] <= stage2[2];
		pipeline1[3] <= stage2[3];
		pipeline1[4] <= stage2[4];
	end

    // Stage3
    sort s3_0( pipeline1[0], pipeline1[1], stage3[0], stage3[1] );
    sort s3_1( pipeline1[2], pipeline1[3], stage3[2], stage3[3] );
    assign stage3[4] = pipeline1[4];

    // Stage4
    assign stage4[0] = stage3[0];
    sort s4_0( stage3[1], stage3[2], stage4[1], stage4[2] );
    sort s4_1( stage3[3], stage3[4], stage4[3], stage4[4] );

    // Finally we got the median
    wire [13:0] unused;
    sort s5( stage4[2], stage4[3], d_out, unused );
endmodule

//===============================================================
module avg64_binning #(
    parameter is_dummy = 0,
    parameter dummy_max = 16400
) (
    input [13:0] d_in,          // Data input

    output reg [19:0] d_out,    // Data output in format Q13.6
    output reg strb,            // Strobe signal for output data (data is valid at posedge)

    input rst,                  // Synchronous reset (active high)
    input clk               // System 64 MHz clock
);

    reg [19:0] d_acc;       // Accumulator

    reg [5:0] counter_q;

    reg [15:0] dummy_counter;

    initial
    begin
        dummy_counter <= 0;
        counter_q <= 0;
        d_acc <= 0;
        d_out <= 0;
        strb <= 0;
    end

    // Main operation
    always @(posedge clk)
    begin
        if( rst )
        begin
            dummy_counter <= 0;
            d_acc <= 0;
            counter_q <= 0;
            strb <= 0;
        end
        else
        begin
            if( counter_q == 0 )
            begin
                if( is_dummy )
                begin
                    d_out <= {dummy_counter, 4'b0000};
                    dummy_counter <= dummy_counter + 1;
                    if( dummy_counter >= dummy_max )
                        dummy_counter <= 0;
                end
                else
                begin
                    d_out <= d_acc;
                end
                d_acc <= { {6{d_in[13]}}, d_in[13:0] };
            end
            else
            begin
                d_acc <= d_acc + { {6{d_in[13]}}, d_in[13:0] };

                // Trigger the strobe signal
                if( counter_q > 2 && counter_q < 5 )
                begin
                    strb <= 1;
                end
                else
                begin
                    strb <= 0;
                end
            end
            counter_q <= counter_q + 1;
        end
    end
endmodule

//===============================================================
// Abstract module for 1 ADC chip. We need 2 instances for each chip.
// Because each chip connects to different FPGA block, separating
// interface instances allows synthesizer to plce each in corresponding block.
//
// 3 stages pipeline
//
module adc_filter #(
    parameter is_dummy = 0,
    parameter dummy_max = 16400
) (
    // Interface to hardware
    input [14:0] d_in,      // Data channel from ADC chip (13 bits plus overflow bit)

    // Control signals
    input clk,          // System clock.
    input rst,              // Synchronous reset (active high)

    // Output data
    output [15:0] d_out,    // Output from each ADC channel in Q13.2
    output strobe           // Strobe signal for output data
);

    wire [13:0] data;
    wire [13:0] d_mean;
    wire [19:0] d_bin;
    wire [19:0] d_round;


    // Pre-processing to cover overflow signal
    assign data = (!d_in[14]) ? d_in[13:0] : ( (d_in[13]) ? 14'h2001 : 14'h1FFF );

    // Rounding output to 16 bits with round-to-even algorithm
    assign d_round = (d_bin + 20'b0000_0000_0000_0000_1000);
    assign d_out = d_round[19:4];

    // Input filter 64 MS/s.
    median_filter m_filter1( .clk(clk), .rst(rst), .d_in(data), .d_out(d_mean) );

    // Down sampling 64 MS/s => 1 MS/s. Also increasing the resolution from 14 bits to 16 bits.
    avg64_binning  #( .is_dummy(is_dummy), .dummy_max(dummy_max) ) avg_binning1
            ( .clk(clk), .rst(rst), .strb(strobe), .d_in(d_mean), .d_out(d_bin) );

endmodule

//===============================================================
// Abstract module for 1 ADC chip. We need 2 instances for each chip.
// Because each chip connects to different FPGA block, separating
// interface instances allows synthesizer to plce each in corresponding block.
//
// 3 stages pipeline
//
module adc_interface(
    // Interface to hardware
    input [13:0] d_in,      // Data channel from ADC chip
    input overflow,         // overflow flag from ADC chip

    // Control signals
    input clk,              // System clock (64 MHz).
    input rst,              // Synchronous reset (active high)

    // Output data
    output [15:0] d0_out,   // Output from each ADC channel in Q13.2
    output strobe_0,        // Channel strobe
    output [15:0] d1_out,
    output strobe_1
);

    wire [14:0] d0_raw;
    wire [14:0] d1_raw;
	
	// Extend rst signal 3 clocks to wait for IDDR data
	reg rst_1d, rst_2d, rst_3d;
	wire filter_rst;
	
	assign filter_rst = rst | rst_1d | rst_2d | rst_3d;
	initial
	begin
		rst_1d <= 1'b1;
		rst_2d <= 1'b1;
		rst_3d <= 1'b1;
	end
	
	always @(posedge clk)
	begin
		rst_3d <= rst_2d;
		rst_2d <= rst_1d;
		rst_1d <= rst;
	end

    // Sequence of signal elements

    // Input interface and de-multiplexer (Verify the channel order before real implementation!!!)
    // IDDR: Input Double Data Rate Input Register with Set, Reset
    // and Clock Enable.
    // 7 Series
    // Xilinx HDL Language Template, version 2020.1_versal_lib
    IDDR #(
        .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), // "OPPOSITE_EDGE", "SAME_EDGE"
        // or "SAME_EDGE_PIPELINED"
        .INIT_Q1(1'b0),     // Initial value of Q1: 1'b0 or 1'b1
        .INIT_Q2(1'b0),     // Initial value of Q2: 1'b0 or 1'b1
        .SRTYPE("SYNC")     // Set/Reset type: "SYNC" or "ASYNC"
    ) IDDR_inst (
        .Q1(d0_raw[14]),    // 1-bit output for positive edge of clock
        .Q2(d1_raw[14]),    // 1-bit output for negative edge of clock
        .C(clk),            // 1-bit clock input
        .CE(1'b1),          // 1-bit clock enable input
        .D(overflow),       // 1-bit DDR data input
        .R(rst),            // 1-bit reset
        .S(1'b0)            // 1-bit set
    );

    // Multiple instantiation for each bit
    genvar k;
    generate
        for( k = 0;k <= 13;k = k + 1 )
        begin
            IDDR #(.DDR_CLK_EDGE("SAME_EDGE_PIPELINED"), .INIT_Q1(1'b0), .INIT_Q2(1'b0), .SRTYPE("SYNC"))
                adc_data_inst( .C(clk), .CE(1'b1), .R(rst), .S(1'b0), .Q1(d0_raw[k]), .Q2(d1_raw[k]), .D(d_in[k]) );
        end
    endgenerate
    // End of IDDR_inst instantiation

    // Filtering
    adc_filter  #(.is_dummy(0), .dummy_max(680) ) filter1
        ( .d_in( d0_raw ), .clk( clk ), .rst( filter_rst ), .d_out( d0_out ), .strobe( strobe_0 ) );
    adc_filter   #(.is_dummy(0), .dummy_max(100) ) filter2
        ( .d_in( d1_raw ), .clk( clk ), .rst( filter_rst ), .d_out( d1_out ), .strobe( strobe_1 ) );
endmodule