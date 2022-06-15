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

module CascadedFIFO32bit #( parameter DEPTH = 4 ) (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [16:0] d_in,  // 17-bit data (16-bit sampling + 1-bit pktend)

    output [16:0] d_out,  // 17-bit data (16-bit sampling + 1-bit pktend)
    output is_empty,       // Fifo is empty
    output is_almost_full  // Fifo is almost full
);

    //************************************************************
    // IP Instances
    //************************************************************
    // Connecting logic
    wire [16:0] din[0:DEPTH - 1];
    wire [16:0] dout[0:DEPTH - 1];
    wire rden[0:DEPTH - 1], wren[0:DEPTH - 1];
    wire empty[0:DEPTH - 1], almost_empty[0:DEPTH - 1];
    wire full[0:DEPTH - 1], almost_full[0:DEPTH - 1];

    // Generate "DEPTH" instances and assign port connections
    genvar x;

    generate
    for( x = 0; x < DEPTH; x = x + 1 )
    begin
    // FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
    //           7 Series
    // Xilinx HDL Language Template, version 2021.2

    FIFO36E1 #(
        .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
        .ALMOST_FULL_OFFSET(13'd20),       // Sets almost full threshold to 20 available entries
        .DATA_WIDTH(36),                   // Sets data width to 4-72 (18-bit by 2k-depth) (36-bit by 1k-depth)
        .DO_REG(1),                        // Enable output register (1-0) Must be 1 if EN_SYN = FALSE
        .EN_ECC_READ("FALSE"),             // Enable ECC decoder, FALSE, TRUE
        .EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, FALSE, TRUE
        .EN_SYN("FALSE"),                  // Specifies FIFO as Asynchronous (FALSE) or Synchronous (TRUE)
        .FIFO_MODE("FIFO36"),              // Sets mode to "FIFO36" or "FIFO36_72"
        .FIRST_WORD_FALL_THROUGH("TRUE"),  // Sets the FIFO FWFT to FALSE, TRUE
        .INIT(72'h000000000000000000),     // Initial values on output port
        .SIM_DEVICE("7SERIES"),            // Must be set to "7SERIES" for simulation behavior
        .SRVAL(72'h000000000000000000)     // Set/Reset value for output port
    )
    fifo_departure_inst (
        // ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
        .DBITERR(),                    // 1-bit output: Double bit error status
        .ECCPARITY(),                  // 8-bit output: Generated error correction parity
        .SBITERR(),                    // 1-bit output: Single bit error status
        // Read Data: 64-bit (each) output: Read output data
        .DO(dout[x]),                   // 64-bit output: (Data output + pkt_end associated with that word)
        .DOP(),                        // 8-bit output: Parity data output
        // Status: 1-bit (each) output: Flags and other FIFO status outputs
        .ALMOSTEMPTY(almost_empty[x]), // 1-bit output: Almost empty flag
        .ALMOSTFULL(almost_full[x]),   // 1-bit output: Almost full flag
        .EMPTY(empty[x]),              // 1-bit output: Empty flag
        .FULL(full[x]),                // 1-bit output: Full flag
        .RDCOUNT(),                    // 13-bit output: Read count
        .RDERR(),                      // 1-bit output: Read error
        .WRCOUNT(),                    // 13-bit output: Write count
        .WRERR(),                      // 1-bit output: Write error
        // ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
        .INJECTDBITERR(1'b0),              // 1-bit input: Inject a double bit error input
        .INJECTSBITERR(1'b0),
        // Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
        .RDCLK(clk),                   // 1-bit input: Read clock
        .RDEN(rden[x]),                // 1-bit input: Read enable
        .REGCE(1'b1),                  // 1-bit input: Clock enable
        .RST(rst),                     // 1-bit input: Reset
        .RSTREG(1'b0),                 // 1-bit input: Output register set/reset
        // Write Control Signals: 1-bit (each) input: Write clock and enable input signals
        .WRCLK(clk),                   // 1-bit input: Rising edge write clock.
        .WREN(wren[x]),                // 1-bit input: Write enable
        // Write Data: 64-bit (each) input: Write input data
        .DI(din[x]),                  // 64-bit input: ( Data input + Packet ending signal)
        .DIP(2'b0)                     // 2-bit input: Parity input
    );
    // End of FIFO36E1_inst instantiation
    end
    endgenerate

    // Connect all generated FIFO instance to cascade their depth
    // Referred to UG473 in Xilinx web
    assign din[0] = d_in;
    assign wren[0] = wr_en;
    assign rden[DEPTH - 1] = rd_en;
    assign is_almost_full = almost_full[0];
    assign is_empty = empty[DEPTH - 1];
    assign d_out = dout[DEPTH - 1];

    // Input Layer
    assign rden[0] = wren[1];

    // generate middle layer fifo connection
    genvar y;
    generate
        for( y = 1; y < DEPTH - 1; y = y + 1 )
        begin
            assign din[y] = dout[y - 1];
            assign wren[y] = ~(empty[y - 1] | full[y]);
            assign rden[y] = wren[y + 1];            
        end
    endgenerate
    // Output layer
    assign din[DEPTH - 1] = dout[DEPTH - 2];
    assign wren[DEPTH - 1] = ~(empty[DEPTH - 2] | full[DEPTH - 1]);

endmodule

module fx3s_interface #(
    parameter   FX3S_DMA_Size = 4096    // Size of FX3S receiving DMA buffer (in 16-bit words)
    ) (
    // Debug signals
    //output [3:0] state,
    //output reg [2:0] decision,
    //output TxEmpty, TxFull, RxEmpty, RxFull,
    //output TxWrEn, TxRdEn, RxWrEn, RxRdEn,
    //output outgoing, pkt_end_out, is_sending,
    //output fifo_rst,

    // Device pins
    output ifclk_out,               // Communication clock from FPGA -> FX3S (FPGA controlled)
    inout [15:0] DQ,                // Data bus
    output [1:0] A,                 // Address to specified DMA channels
    output reg SLCS,                // Chip select signal to FX3S (Active low)
    output reg SLWR, SLRD,          // Read/Write flag (Active low)
    output reg SLOE,                // Enable FX3S -> FPGA data direction (Active low)
    output reg PKTEND,              // Writing a short packet or zero-length packet (Used to indicate end of data) (Active low)
    input FLAGA, FLAGB,             // Flags from FX3S use to indicates almost full or empty of DMA buffer. (Active Low)
                                    // FLAGA : indicates that FX3S has some data to read. (0 = Empty)
                                    // FLAGB : indicates that FX3S has some spacce to accept more data (1 = Available)
                                    // Important Note: FLAGB has 3-clock delay. Thus, it must indicate "almost" full to aviod overrun.

    // Control signal
    input clk,                      // Master clock for this module (64 MHz 0-degree)
    input rst,                      // Synchronous reset (active high)
    output rdy,                     // Indicate that the system is ready for data

    // Data to send out (FPGA -> FX3S)
    input [15:0] d_in,              // Input data to send to FX3S
    input input_strobe,             // Indicates that the d_in value is valid
    output input_full,              // Flag to indicate that the buffer for departure data is full
    input pkt_end_in,               // 1 = current data word is the last word of current packet
    input trigged,                  // Is on-trigged (from trigger unit)

    // Arrival data (FX3S -> FPGA)
    output [15:0] d_out,            // Output data
    output output_rdy,              // Indicate that there are some available data to read
    input  output_strobe            // Enable read-out data
    );

    // Address value
    localparam addr_write = 1'b1;
    localparam addr_read = 1'b0;

    // State value
    localparam state_idle = 4'b0000;

    localparam state_stop_write_1 = 4'b0001;
    localparam state_stop_write_2 = 4'b0010;
    localparam state_stop_write_3 = 4'b0011;
    localparam state_stop_write_4 = 4'b0100;

    localparam state_start_read = 4'b0101;
    localparam state_read_pre_1 = 4'b0110;
    localparam state_read_pre_2 = 4'b0111;
    localparam state_read_word = 4'b1000;
    localparam state_read_post_1 = 4'b1001;
    localparam state_read_post_2 = 4'b1010;

    // This module use FIFO to store incoming and outgoing data
    // The FIFO size for arrival data is 32 16-bit words.
    // The FIFO size for departure data is 1024 64-bit words.
    wire    [15:0] tx_data;
    wire    [15:0] rx_data;
    wire    rx_empty, rx_full, tx_empty, tx_full;    // Full and empty FIFO flag
    reg     tx_rd_en;
    wire    tx_wr_en;
    reg     rx_wr_en;               // FIFO write enable controlled by state machine
    reg     is_outgoing;            // Indicate current data direction: 0 = FX3S -> FPGA, 1 = FPGA -> FX3S
    reg     sending;                // Indicate whether a packet is opened (need to be closed)
    reg     [3:0] master_state;     // State of the interface
    wire    pkt_end;                 // Current data in FIFO is the last word
    reg     A0;                      // Address of the operation
    reg     [5:0] trigged_d;         // Trigged delay line
    wire    internal_trigged_line;   // Trigged with delayed end

    // Reset signals for 5 clks delay
    reg rst_d, rst_dd, rst_3d, rst_4d, rst_5d, rst_6d, rst_7d, rst_8d, rst_9d;  // Delay line for reset signal to make the internal reset time greater than 5 clk
    wire rst_internal, fifo_rst_internal;           // Internal reset signal
    wire output_strobe_internal;
    wire rx_wr_en_internal;

    //************************************************************
    // Combination logic for debug
    //************************************************************
    //assign state = master_state;
    //assign TxFull = input_full;
    //assign TxEmpty = tx_empty;
    //assign RxFull = rx_full;
    //assign RxEmpty = rx_empty;
    //assign TxWrEn = tx_wr_en;
    //assign TxRdEn = tx_rd_en;
    //assign RxWrEn = rx_wr_en;
    //assign RxRdEn = output_strobe;
    //assign outgoing = is_outgoing;
    //assign pkt_end_out = pkt_end;
    //assign is_sending = sending;
    //assign fifo_rst = fifo_rst_internal;

    assign fifo_rst_internal = rst | rst_d | rst_dd | rst_3d | rst_4d | rst_5d;
    assign rst_internal = fifo_rst_internal | rst_6d | rst_7d | rst_8d | rst_9d;
    assign output_strobe_internal = output_strobe & ~rst_internal;
    assign internal_trigged_line = trigged | trigged_d[0] | trigged_d[1] | trigged_d[2] | trigged_d[3] | trigged_d[4] | trigged_d[5];
    assign rx_wr_en_internal = rx_wr_en & FLAGA;
    assign input_full = tx_full;

    assign ifclk_out = clk;     // Slave FIFO interface operates at 64 MHz

    // Reset and ready signals
    assign A[1] = 0;            // A[1] is always 0. We use only A[0] bit
    assign A[0] = A0;           // Data direction bit is designed to be equal to A[0]
    assign rdy = ~rst_internal;
    //assign fifo_rdy = ~fifo_rst_internal;
    assign tx_wr_en = input_strobe & ~rst_internal;
    assign output_rdy = ~rx_empty;

    // MUX and DEMUX DQ pins with 2 internal sub-systems
    assign rx_data = DQ;
    assign DQ = (is_outgoing) ? tx_data : 16'bz;

    //************************************************************
    // Initialization
    //************************************************************
    initial begin
        SLCS <= 1'b1;
        SLWR <= 1'b1;
        SLRD <= 1'b1;
        SLOE <= 1'b1;
        PKTEND <= 1'b1;
        is_outgoing <= 1'b0;
        rx_wr_en <= 1'b0;
        tx_rd_en <= 1'b0;
        sending <= 1'b0;
        A0 <= addr_read;
        master_state <= state_idle;
        trigged_d[0] <= 0;
        trigged_d[1] <= 0;
        trigged_d[2] <= 0;
        trigged_d[3] <= 0;
        trigged_d[4] <= 0;
        trigged_d[5] <= 0;
        rst_9d <= 1;
        rst_8d <= 1;
        rst_7d <= 1;
        rst_6d <= 1;
        rst_5d <= 1;
        rst_4d <= 1;
        rst_3d <= 1;
        rst_dd <= 1;
        rst_d <= 1;
    end

    //************************************************************
    // Behavioral blocks
    //************************************************************
    // Reset delay time (5 clocks minimum)
    always @(posedge clk)
    begin
        rst_9d <= rst_8d;
        rst_8d <= rst_7d;
        rst_7d <= rst_6d;
        rst_6d <= rst_5d;
        rst_5d <= rst_4d;
        rst_4d <= rst_3d;
        rst_3d <= rst_dd;
        rst_dd <= rst_d;
        rst_d <= rst;
    end

    // Trigged delay line
    always @(negedge clk)
    begin
        trigged_d[5] <= trigged_d[4];
        trigged_d[4] <= trigged_d[3];
        trigged_d[3] <= trigged_d[2];
        trigged_d[2] <= trigged_d[1];
        trigged_d[1] <= trigged_d[0];
        trigged_d[0] <= trigged;
    end


    // Main process
    /*
     * Note
     *
     * Since FLAGA has 2-clock delay after the last word is read, we cannot use it to detect the
     * incoming data size. Therefore, FLAGA is used only for detecting start of data incoming.
     * Moreover, the incoming data is connected directly to RX-FIFO, operaing at clock rising edge.
     * We cannot examine information inside them. Therefore, we can only read 1 word and wait for
     * FLAGA status by 2 clocks. If thereare more incoming data, the previous steps are repeated.
     * 
     */
    /*
     * State transition table (FLAGA and FLAGB are active low)
     * ------------------------------------------------------------------------------------
     *     State     | Condition                       |  Next State | Action
     * ------------------------------------------------------------------------------------
     *     idle      | !rx_full && FLAGA               | start_read  | is_outgoing = 0, SLCS = 0, SLWR = 1, SLOE = 0, 
     *               |                                 |             |       A0 = addr_read, tx_rd_en = 0
     *               | !tx_empty && FLAGB, !pkt_end    | idle        | is_outgoing = 1, SLCS = 0, SLWR = 0, SLOE = 1, 
     *               |                                 |             |       A0 = addr_write, tx_rd_en = 1, PKTEND = 1, sending = 1
     *               | !tx_empty && FLAGB, pkt_end     | stop_write_1| is_outgoing = 1, SLCS = 0, SLWR = 0, SLOE = 1, 
     *               |                                 |             |       A0 = addr_write, tx_rd_en = 1, PKTEND = 0
     *               | (tx_empty && trigged) || !FLAGB | idle        | is_outgoing = 0, SLCS = 1, SLWR = 1, tx_rd_en = 0
     *               | tx_empty && !trigged && sending | stop_write_1| is_outgoing = 1, SLCS = 0, SLWR = 1, SLOE = 1, 
     *               |                                 |             |       A0 = addr_write, tx_rd_en = 0, PKTEND = 0
     *               | else                            | idle        | -
     * ------------------------------------------------------------------------------------
     *  start_read   | 1                               | read_pre_1  | SLRD = 0
     * ------------------------------------------------------------------------------------
     *  read_pre_1   | 1                               | read_pre_2  | SLRD = 1
     * ------------------------------------------------------------------------------------
     *  read_pre_2   | !FLAGA                          | idle        | SLCS = 1, SLRD = 1, SLOE = 1
     *               | else                            | read_word   | rx_wr_en = 1
     * ------------------------------------------------------------------------------------
     *  read_word    | 1                               | read_post_1 | rx_wr_en = 0
     * ------------------------------------------------------------------------------------
     *  read_post_1  | 1                               | read_post_2 | -
     * ------------------------------------------------------------------------------------
     *  read_post_2  | 1                               | idle        | SLCS = 1, SLOE = 1
     * ------------------------------------------------------------------------------------
     *  stop_write_1 | 1                               | stop_write_2| PKTEND = 1, tx,rd_en = 0, SLWR = 1 (then wait 3 clocks), 
     *               |                                 |             |       sending = 0
     * ------------------------------------------------------------------------------------
     *  stop_write_2 | 1                               | stop_wriet_3| -
     * ------------------------------------------------------------------------------------
     *  stop_write_3 | 1                               | stop_wriet_4| -
     * ------------------------------------------------------------------------------------
     *  stop_write_4 | 1                               | idle        | SLCS = 1, is_outgoing = 0
     * ------------------------------------------------------------------------------------
     * ------------------------------------------------------------------------------------

     */
    always @(negedge clk)
    begin
        if( rst_internal )
        begin
            SLCS <= 1;
            SLWR <= 1;
            SLRD <= 1;
            SLOE <= 1;
            PKTEND <= 1;
            sending <= 0;
            A0 <= addr_read;
            is_outgoing <= 0;
            rx_wr_en <= 0;
            tx_rd_en <= 0;
            master_state <= state_idle;
            //decision <= 3'b000;
        end
        else
        begin
            case( master_state )
                state_idle:
                begin
                    // As writing is performed by FIFO state machine, "state_idle" just setup writing states
                    if( !rx_full && FLAGA )
                    begin
                        //decision <= 3'b001;
                        // Have something to read, then read them first
                        is_outgoing <= 0;
                        SLCS <= 0;
                        SLWR <= 1;
                        SLOE <= 0;
                        A0 <= addr_read;
                        tx_rd_en = 0;
                        master_state <= state_start_read;
                    end
                    else if( tx_empty && !internal_trigged_line && sending )
                    begin
                        //decision <= 3'b100;
                        // Still in sending but nothing more to send then send ZLP
                        is_outgoing <= 1;
                        SLCS <= 0;
                        SLWR <= 1;
                        SLOE <= 1;
                        A0 <= addr_write;
                        tx_rd_en <= 0;
                        PKTEND <= 0;
                        master_state <= state_stop_write_1;
                    end
                    else if( !tx_empty && FLAGB )
                    begin
                        //decision <= 3'b010;
                        // Have something to send, then send them
                        is_outgoing <= 1;
                        SLCS <= 0;
                        SLWR <= 0;
                        SLOE <= 1;
                        A0 <= addr_write;
                        tx_rd_en <= 1;
                        if( !pkt_end )
                        begin
                            PKTEND <= 1;
                            sending <= 1;
                            master_state <= state_idle;
                        end
                        else
                        begin
                            PKTEND <= 0;
                            master_state <= state_stop_write_1;
                        end
                    end
                    else if( (tx_empty && internal_trigged_line) || !FLAGB )
                    begin
                        //decision <= 3'b011;
                        // Not ending the sending but having to wait for next data
                        is_outgoing <= 0;
                        SLCS <= 1;
                        SLWR <= 1;
                        tx_rd_en <= 0;
                        master_state <= state_idle;
                    end
                    //else
                    //    decision <= 3'b111;
                end

                // FX3S -> FPGA states
                state_start_read:
                begin
                    SLRD <= 0;
                    master_state <= state_read_pre_1;
                end

                state_read_pre_1:
                begin
                    SLRD <= 1;      // Immediately release SLRD to indicate 1 word transfer
                    master_state <= state_read_pre_2;
                end

                state_read_pre_2:
                begin
                    rx_wr_en <= 1;
                    master_state <= state_read_word;
                end

                state_read_word:
                begin
                    rx_wr_en <= 0;
                    master_state <= state_read_post_1;
                end

                state_read_post_1:
                begin
                    master_state <= state_read_post_2;
                end

                state_read_post_2:
                begin
                    SLCS <= 1;
                    SLOE <= 1;
                    master_state <= state_idle;
                end

                // FPGA -> FX3S finalizing writing process
                state_stop_write_1:
                begin
                    PKTEND <= 1;
                    tx_rd_en <= 0;
                    SLWR <= 1;
                    sending <= 0;
                    master_state <= state_stop_write_2;
                end

                state_stop_write_2:
                begin
                    master_state <= state_stop_write_3;
                end

                state_stop_write_3:
                begin
                    master_state <= state_stop_write_4;
                end

                state_stop_write_4:
                begin
                    SLCS <= 1;
                    is_outgoing <= 0;
                    master_state <= state_idle;
                end

                default:        // Error!!! We should not be here
                begin
                    SLCS <= 1;
                    SLWR <= 1;
                    SLRD <= 1;
                    SLOE <= 1;
                    PKTEND <= 1;
                    is_outgoing <= 0;
                    sending <= 0;
                    rx_wr_en <= 0;
                    tx_rd_en <= 0;
                    master_state <= state_idle; // Go back to idle
                end
            endcase
        end
    end

    // Departure FIFO is a cascaded FIFO system.
    CascadedFIFO32bit fifo_departure(
        .clk(clk), .rst(fifo_rst_internal), .wr_en(tx_wr_en), .rd_en(tx_rd_en),
        .d_out({ pkt_end, tx_data }), .d_in({pkt_end_in, d_in }),
        .is_empty(tx_empty), .is_almost_full(tx_full)
    );

    //************************************************************
    // IP Instances
    //************************************************************
    // FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
    //           7 Series
    // Xilinx HDL Language Template, version 2021.2

    FIFO36E1 #(
        .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
        .ALMOST_FULL_OFFSET(13'd20),       // Sets almost full threshold to 20 available entries
        .DATA_WIDTH(18),                   // Sets data width to 4-72 (18-bit by 2k-depth)
        .DO_REG(1),                        // Enable output register (1-0) Must be 1 if EN_SYN = FALSE
        .EN_ECC_READ("FALSE"),             // Enable ECC decoder, FALSE, TRUE
        .EN_ECC_WRITE("FALSE"),            // Enable ECC encoder, FALSE, TRUE
        .EN_SYN("FALSE"),                  // Specifies FIFO as Asynchronous (FALSE) or Synchronous (TRUE)
        .FIFO_MODE("FIFO36"),              // Sets mode to "FIFO36" or "FIFO36_72"
        .FIRST_WORD_FALL_THROUGH("TRUE"),  // Sets the FIFO FWFT to FALSE, TRUE
        .INIT(72'h000000000000000000),     // Initial values on output port
        .SIM_DEVICE("7SERIES"),            // Must be set to "7SERIES" for simulation behavior
        .SRVAL(72'h000000000000000000)     // Set/Reset value for output port
    )
    fifo_arrival (
        // ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
        .DBITERR(),                    // 1-bit output: Double bit error status
        .ECCPARITY(),                  // 8-bit output: Generated error correction parity
        .SBITERR(),                    // 1-bit output: Single bit error status
        // Read Data: 64-bit (each) output: Read output data
        .DO(d_out),                    // 64-bit output: Data output
        .DOP(),                        // 8-bit output: Parity data output
        // Status: 1-bit (each) output: Flags and other FIFO status outputs
        .ALMOSTEMPTY(),                // 1-bit output: Almost empty flag
        .ALMOSTFULL(rx_full),          // 1-bit output: Almost full flag
        .EMPTY(rx_empty),              // 1-bit output: Empty flag
        .FULL(),                       // 1-bit output: Full flag
        .RDCOUNT(),                    // 13-bit output: Read count
        .RDERR(),                      // 1-bit output: Read error
        .WRCOUNT(),                    // 13-bit output: Write count
        .WRERR(),                      // 1-bit output: Write error
        // ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
        .INJECTDBITERR(1'b0),              // 1-bit input: Inject a double bit error input
        .INJECTSBITERR(1'b0),
        // Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
        .RDCLK(clk),                   // 1-bit input: Read clock
        .RDEN(output_strobe_internal), // 1-bit input: Read enable
        .REGCE(1'b1),                  // 1-bit input: Clock enable
        .RST(fifo_rst_internal),       // 1-bit input: Reset
        .RSTREG(1'b0),                 // 1-bit input: Output register set/reset
        // Write Control Signals: 1-bit (each) input: Write clock and enable input signals
        .WRCLK(clk),                   // 1-bit input: Rising edge write clock.
        .WREN(rx_wr_en_internal),      // 1-bit input: Write enable
        // Write Data: 64-bit (each) input: Write input data
        .DI(rx_data),                   // 64-bit input: Data input
        .DIP(2'b0)                     // 2-bit input: Parity input
    );
    // End of FIFO36E1_inst instantiation

endmodule