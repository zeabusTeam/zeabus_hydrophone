`timescale 1ns / 1ns

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

// Important note on PLL module setting. Please refer to
// https://forums.xilinx.com/t5/Implementation/Drc-23-20-Rule-violation-REQP-1712-Input-clock-driver/td-p/586641

module zeabus_hydrophone #(
    parameter trigger_head = 64,// Number of sampling preceded of the trigged points
    parameter trigger_tail = 64 // Number of sampling include in a valid data packet after the trigger level is not satisfied
    )(
    // Debug signals
    //output [15:0] trigger_level_set,
    //output [63:0] abs_data,
    //output [15:0] abs_trig,
    //output [15:0] conf_read_din,

    /* Device pins */
    // ADC-1 pins
    input OTR_1,            // Overflow
    input [13:0]D_1,        // Data input
    output CLKA_1, CLKB_1,  // ADC Clocks

    // ADC-2 pins
    input OTR_2,            // Overflow
    input [13:0]D_2,        // Data input
    output CLKA_2, CLKB_2,  // ADC Clocks

    // Potentiometers pins
    inout SCL, SDA,         // I2C functions

    // FX3S Interface
    output ifclk_out,       // Slave FIFO clock
    inout [15:0]DQ,         // Data bus
    output SLCS, SLWR, SLRD, SLOE, PKTEND,  // Slave FIFO control
    output [1:0]A,          // Slave FIFO address bus
    input FLAGA, FLAGB,     // Socket flags
    input RST,              // Soft-reset from FX3S
	input FUNC_EN,			// Soft enable of a particular function

    // Status LEDs
    output LED_BLUE,        // Packetizer strobe (A packet is sending)
    output LED_GREEN,       // System is running (no rst)
    output LED_RED_n,       // FPGA -> FX3S buffer is full

    // Debug LEDs
    output LED_RED_1,       // External RST (ie. RST from FX3S)
    output LED_YELLOW_1,    // Trigged
    output LED_GREEN_1,     // FPGA -> FX3S interface is ready
    output LED_RED_2,       // Config FIFO read enable
    output LED_YELLOW_2,    // Packetizer is sending data to slave FIFO module
    output LED_GREEN_2,     // New configuration from FX3S is available
    output LED_RED_3,       // Signal to start potentiometer updating
    output LED_YELLOW_3,    // FIFO in trigger module is ready
    output LED_GREEN_3,     // Trigger module is ready

    // Master clock input (26 MHz)
    input clk_in
);

    wire rst;
    // Wires that connects modules
    wire sys_clk, clk_in_buf;                   // clocks from BUFG that can distributes through out the chip
    wire pll_locked;                            // Output PLL clock is ready
    wire adc_clk;                               // Clock for ADC chip. It leads the sys_clk by 90 degree
    wire [15:0] adc1_1_out;
    wire [15:0] adc1_2_out;
    wire [15:0] adc2_1_out;
    wire [15:0] adc2_2_out;                     // Data output from ADC modules in Q13.2 format
    wire [15:0] trigger_level;                  // Defined trigger level Q13.2
    wire [63:0] trigged_out;                    // Data-out from trigger circuit Q13.6
    wire trigged;                               // Trigger signal (active high)
    wire trigger_strobe;                        // Strobe signal to read a datum from trigger FIFO
    wire [15:0] packetize_out;                  // Data-out from packetize circuit
    wire p_data_strobe;                         // Strobe signal (active high) from packetizer
    wire pkt_end;                               // Next data word from packetizer is the last word of current packet
    wire poten_update_start;                    // Rising edge indicates starting of updating poten values
    wire [7:0] poten0, poten1, poten2, poten3;  // Values of potentiometers (aka. amplifier gain)
    wire [15:0] rx_data;                        // Incoming data from FX3S
    wire rx_valid, rx_oe;                       // Incoming data FIFO controls
    wire tx_full;
    wire trigger_fifo_rdy, trigger_rdy;         // Ready signals from trigger module
    wire adc_strb_1, adc_strb_2, adc_strb_3, adc_strb_4;    // Strobe signal from ADC interfaces
	wire slave_fifo_rdy;						// Ready signal from FX3S slave FIFO module
	wire [8:0] dbg;

    wire [63:0] abs_data;
    wire [15:0] abs_trig;
    //assign trigger_level_set = trigger_level;
    //assign conf_read_din = rx_data;

    assign dbg = abs_trig[7:0];

    // Combination logic
    assign LED_BLUE = p_data_strobe;
    assign LED_GREEN = ~rst;
    assign LED_RED_n = ~tx_full;

    // Debug LED
    //assign LED_RED_1 = dbg[0];
    //assign LED_YELLOW_1 = dbg[1];
    //assign LED_GREEN_1 = dbg[2];
	
    //assign LED_RED_2 = dbg[3];
    //assign LED_YELLOW_2 = dbg[4];
    //assign LED_GREEN_2 = dbg[5];
	
    //assign LED_RED_3 = dbg[6];
    //assign LED_YELLOW_3 = dbg[7];
	//assign LED_GREEN_3 = trigged;
	
    assign LED_RED_1 = RST;
    assign LED_YELLOW_1 = trigged;
    assign LED_GREEN_1 = slave_fifo_rdy;
	
    assign LED_RED_2 = rx_oe;
    assign LED_YELLOW_2 = pkt_end;
    assign LED_GREEN_2 = rx_valid;
	
    assign LED_RED_3 = poten_update_start;
    assign LED_YELLOW_3 = trigger_fifo_rdy;
    assign LED_GREEN_3 = FUNC_EN;

    // Clock distribution
    assign CLKA_1 = adc_clk;
    assign CLKB_1 = adc_clk;
    assign CLKA_2 = adc_clk;
    assign CLKB_2 = adc_clk;

    // Instances
    reset_subs reset_inst(
        .clk(sys_clk),                  // Main system clock
        .pll_locked(pll_locked),        // Clock subsystem ready
        .rst_in(RST),                   // Soft-reset from FX3S
        .rst_out(rst)                   // Reset signal for the whole system
    );

    fx3s_interface slave_fifo(
        // Device pins
        .ifclk_out(ifclk_out),          // Communication clock from FPGA -> FX3S (FPGA controlled)
        .DQ(DQ),                        // Data bus
        .A(A),                          // Address to specified DMA channels
        .SLCS(SLCS),                    // Chip select signal to FX3S (Active low)
        .SLWR(SLWR), .SLRD(SLRD),       // Read/Write flag (Active low)
        .SLOE(SLOE),                    // Enable FX3S -> FPGA data direction (Active low)
        .PKTEND(PKTEND),                // Writing a short packet or zero-length packet (Used to indicate end of data) (Active low)
        .FLAGA(FLAGA), .FLAGB(FLAGB),   // Flags from FX3S use to indicates almost full or empty of DMA buffer. (Active Low)
                                        // FLAGA : indicates that FX3S has some data to read. (0 = Empty)
                                        // FLAGB : indicates that FX3S has some spacce to accept more data (1 = Available)
                                        // Important Note: FLAGB has 3-clock delay. Thus, it must indicate "almost" full to aviod overrun.

        // Control signal
        .clk(sys_clk),                  // Master clock for this module (64 MHz)
        .rst(rst),                      // Synchronous reset (active high)
        .rdy(slave_fifo_rdy),           // Indicate that the system is ready for data (unused)

        // Data to send out (FPGA -> FX3S)
        .d_in(packetize_out),           // Input data to send to FX3S
        .input_strobe(p_data_strobe),   // Rising edge indicates that the d_in value is valid
        .input_full(tx_full),           // Flag to indicate that the buffer for departure data is full
        .pkt_end_in(pkt_end),           // Current data word is the last word of current packet
        .trigged(trigged),              // Signal is still in the middle of sending mode

        // Arrival data (FX3S -> FPGA)
        .d_out(rx_data),                // Output data
        .output_rdy(rx_valid),          // Indicate that there are some available data to read
        .output_strobe(rx_oe)           // Enable read-out data
    );

    hydrophone_config_manager config_man(
        // Interface to slave fifo output buffer
        .d_in(rx_data),                 // Data from slave FIFO
        .data_valid(rx_valid),          // Indicate that there are some available config data to read
        .config_d_oe(rx_oe),            // Enable read-out data

        // Control
        .clk(sys_clk),                  // Master clock
        .rst(rst),                      // Master reset (active high)
        .update_poten(poten_update_start), // Trigger for potentiometer register updating. (rising edge)

        // Register
        .trigger_level(trigger_level),  // hydrophone signal level
        .poten1_value(poten0),          // Value of potentiometer 1 (defines gain of channel 1)
        .poten2_value(poten1),          // Value of potentiometer 2 (defines gain of channel 2)
        .poten3_value(poten2),          // Value of potentiometer 3 (defines gain of channel 3)
        .poten4_value(poten3)           // Value of potentiometer 4 (defines gain of channel 4)
    );

    poten_interface poten_i2c(
        // Device pins
        .SDA(SDA),                      // I2C Data
        .SCL(SCL),                      // I2C Clock

        // Control signals
        .rst(rst),                      // Synchronous reset (active high)
        .clk(sys_clk),                  // System clock.
        .start_update(poten_update_start),// Activation bit. Rising edge of this bit means starting of sending data to poten

    // Potentiometer data
        .p0_val(poten0),
        .p1_val(poten1),
        .p2_val(poten2),
        .p3_val(poten3)
    );

    packetizer packetizer_inst(
        .rst(rst),                      // System reset (active high)
        .clk(sys_clk),                  // Master clock

        .d_in(trigged_out),             // Data from trigger detection
        .trigged(trigged),              // Data-valid signal from trigger
        .in_strobe(trigger_strobe),     // Strobe to read a datum from trigger FIFO

        .d_out(packetize_out),          // Output data
        .out_strobe(p_data_strobe),     // Data-valid signal to FX3 interface
        .out_full(tx_full),             // Buffer is almost full
        .pkt_end(pkt_end)               // Current data word is the end of current packet
    );

    hydrophone_trigger #( .header(trigger_head), .trigged_tailed(trigger_tail) ) trigger(
        .rst(rst),                      // system reset (active high)
        .clk(sys_clk),                  // Master clock
		.enable(FUNC_EN),				// Enable trigger module

        .rdy(trigger_rdy),              // Debug signal
        .fifo_rdy(trigger_fifo_rdy),    // Debug signal
        .abs_data(abs_data),            // Debug signal
        .abs_trig(abs_trig),            // Debug signal

        .d_in( { adc2_2_out, adc2_1_out, adc1_2_out, adc1_1_out } ),// data input (concatenation of 4 16-bit data with channel 1 first)
        .trigger_level(trigger_level),  // level of the trigger in 16-bit signed integer
        .strb_ch1(adc_strb_1), .strb_ch2(adc_strb_2), .strb_ch3(adc_strb_3), .strb_ch4(adc_strb_4), // Strobe from ADC

        .d_out(trigged_out),            // data output
        .output_strobe(trigger_strobe), // Strobe to read from trigger FIFO
        .trigged(trigged)               // indicates that the data is part of packet of trigged signal
    );

    //
    // 3 stages pipeline
    //
    adc_interface adc1(
        // Interface to hardware
        .d_in(D_1),                     // Data channel from ADC chip
        .overflow(OTR_1),               // overflow flag from ADC chip

        // Control signals
        .clk(sys_clk),                  // System clock.
        .rst(rst),                      // Synchronous reset (active high)

        // Output data
        .d0_out(adc1_1_out),            // Output from each ADC channel
        .strobe_0(adc_strb_1),
        .d1_out(adc1_2_out),
        .strobe_1(adc_strb_2)
    );

    //
    // 3 stages pipeline
    //
    adc_interface adc2(
        // Interface to hardware
        .d_in(D_2),                     // Data channel from ADC chip
        .overflow(OTR_2),               // overflow flag from ADC chip

        // Control signals
        .clk(sys_clk),                  // System clock.
        .rst(rst),                      // Synchronous reset (active high)

        // Output data
        .d0_out(adc2_1_out),            // Output from each ADC channel
        .strobe_0(adc_strb_3),
        .d1_out(adc2_2_out),
        .strobe_1(adc_strb_4)
    );

    // Clock synthesizer
    BUFG clock_buf (
        .I(clk_in),
        .O(clk_in_buf)
    );
    // PLLE2_BASE: Base Phase Locked Loop (PLL)
    // 7 Series
    // Xilinx HDL Language Template, version 2021.2
    wire pll_fb;
    PLLE2_BASE #(
        .BANDWIDTH("OPTIMIZED"),        // OPTIMIZED, HIGH, LOW
        .CLKFBOUT_MULT(32),             // Multiply value for all CLKOUT, (2-64)
        .CLKFBOUT_PHASE(0.0),           // Phase offset in degrees of CLKFB, (-360.000-360.000).
        .CLKIN1_PERIOD(38.462),         // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
        // CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
        .CLKOUT0_DIVIDE(13),            // 26 MHz * 32 / 13 = 64MHz
        .CLKOUT1_DIVIDE(13),            // 26 MHz * 32 / 13 = 64MHz
        .CLKOUT2_DIVIDE(1),
        .CLKOUT3_DIVIDE(1),
        .CLKOUT4_DIVIDE(1),
        .CLKOUT5_DIVIDE(1),
        // CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
        .CLKOUT0_DUTY_CYCLE(0.5),
        .CLKOUT1_DUTY_CYCLE(0.5),
        .CLKOUT2_DUTY_CYCLE(0.5),
        .CLKOUT3_DUTY_CYCLE(0.5),
        .CLKOUT4_DUTY_CYCLE(0.5),
        .CLKOUT5_DUTY_CYCLE(0.5),
        // CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
        .CLKOUT0_PHASE(-140.0),          // ADC clock is 140 degree leading to compensate 6ns(max) ADC output transition time
        .CLKOUT1_PHASE(0.0),
        .CLKOUT2_PHASE(0.0),
        .CLKOUT3_PHASE(0.0),
        .CLKOUT4_PHASE(0.0),
        .CLKOUT5_PHASE(0.0),
        .DIVCLK_DIVIDE(1),              // Master division value, (1-56)
        .REF_JITTER1(0.0),              // Reference input jitter in UI, (0.000-0.999).
        .STARTUP_WAIT("FALSE") // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
    )
    PLLE2_BASE_inst (
        // Clock Outputs: 1-bit (each) output: User configurable clock outputs
        .CLKOUT0(adc_clk),              // 1-bit output: CLKOUT0
        .CLKOUT1(sys_clk),              // 1-bit output: CLKOUT1
        .CLKOUT2(),                     // 1-bit output: CLKOUT2
        .CLKOUT3(),                     // 1-bit output: CLKOUT3
        .CLKOUT4(),                     // 1-bit output: CLKOUT4
        .CLKOUT5(),                     // 1-bit output: CLKOUT5
        // Feedback Clocks: 1-bit (each) output: Clock feedback ports
        .CLKFBOUT(pll_fb),              // 1-bit output: Feedback clock
        .LOCKED(pll_locked),            // 1-bit output: LOCK
        .CLKIN1(clk_in_buf),            // 1-bit input: Input clock
        // Control Ports: 1-bit (each) input: PLL control ports
        .PWRDWN(1'b0),                  // 1-bit input: Power-down
        .RST(RST),                      // 1-bit input: Reset
        // Feedback Clocks: 1-bit (each) input: Clock feedback ports
        .CLKFBIN(pll_fb)                // 1-bit input: Feedback clock
    );
    // End of PLLE2_BASE_inst instantiation
endmodule
