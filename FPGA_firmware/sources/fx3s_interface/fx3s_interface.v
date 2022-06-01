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

module fx3s_interface #(
    parameter   FX3S_DMA_Size = 4096    // Size of FX3S receiving DMA buffer (in 16-bit words)
    ) (
    // Debug signals
    // output [3:0] state,
    // output TxEmpty, TxFull, RxEmpty, RxFull,
    // output TxWrEn, TxRdEn, RxWrEn, RxRdEn,
    // output [15:0] d_data,
    // output is_outgoing,
    // output [15:0] u_counter,

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
    output reg dbg,

    // Data to send out (FPGA -> FX3S)
    input [15:0] d_in,              // Input data to send to FX3S
    input input_strobe,             // Indicates that the d_in value is valid
    output input_full,              // Flag to indicate that the buffer for departure data is full
    input sending,                  // Signal is still in the middle of sending mode

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

    localparam state_start_read = 4'b0001;
    localparam state_read_pre1 = 4'b0010;
    localparam state_read_pre2 = 4'b0011;
    localparam state_read_pre3 = 4'b0100;
    localparam state_read_loop = 4'b0101;

    localparam state_start_write = 4'b1000;
    localparam state_write_wait1 = 4'b1001;
    localparam state_write_wait2 = 4'b1010;
    localparam state_write_wait3 = 4'b1011;

    localparam state_zlp = 4'b1100;
    localparam state_zlp_wait1 = 4'b1101;
    localparam state_zlp_wait2 = 4'b1110;
    localparam state_zlp_wait3 = 4'b1111;

    // This module use FIFO to store incoming and outgoing data
    // The FIFO size for arrival data is 32 16-bit words.
    // The FIFO size for departure data is 1024 64-bit words.
    wire    [15:0] tx_data;
    wire    [15:0] rx_data;
    wire    rx_empty, rx_full, tx_empty;    // Full and empty FIFO flag
    reg     tx_rd_en;
    wire    tx_wr_en;
    reg     rx_wr_en;               // FIFO write enable controlled by state machine
    reg     is_outgoing;             // Indicate current data direction: 0 = FX3S -> FPGA, 1 = FPGA -> FX3S
    reg     [3:0] master_state;     // State of the interface
    reg     is_writing;             // Indicate whether the writing process has started
    reg     [15:0] rx_buf_d;
    reg     [15:0] rx_buf_dd;        // pre-buffer for reading as FLAGA has 2 clocks delay.
    reg     [15:0] u16WrCounter;     // Counter for DMA sending words

    // Reset signals for 5 clks delay
    reg rst_d, rst_dd, rst_3d, rst_4d, rst_5d, rst_6d, rst_7d, rst_8d, rst_9d;  // Delay line for reset signal to make the internal reset time greater than 5 clk
    wire rst_internal, fifo_rst_internal;           // Internal reset signal
    wire output_strobe_internal;

    //************************************************************
    // Combination logic for debug
    //************************************************************
    // assign state = master_state;
    // assign TxFull = input_full;
    // assign TxEmpty = tx_empty;
    // assign RxFull = rx_full;
    // assign RxEmpty = rx_empty;
    // assign TxWrEn = tx_wr_en;
    // assign TxRdEn = tx_rd_en;
    // assign RxWrEn = rx_wr_en;
    // assign RxRdEn = output_strobe;
    // assign d_data = tx_data;
    // assign is_outgoing = is_outgoing;
    // assign u_counter = u16WrCounter;

    assign fifo_rst_internal = rst | rst_d | rst_dd | rst_3d | rst_4d | rst_5d;
    assign rst_internal = fifo_rst_internal | rst_6d | rst_7d | rst_8d | rst_9d;
    assign output_strobe_internal = output_strobe & ~rst_internal;

    assign ifclk_out = clk;     // Slave FIFO interface operates at 64 MHz

    // Reset and ready signals
    assign A[1] = 0;                // A[1] is always 0. We use only A[0] bit
    assign A[0] = is_outgoing;       // Data direction bit is designed to be equal to A[0]
    assign rdy = ~rst_internal;
    //assign fifo_rdy = ~fifo_rst_internal;
    assign tx_wr_en = input_strobe & ~rst_internal;
    assign output_rdy = ~rx_empty;

    // MUX and DEMUX DQ pins with 2 internal sub-systems
    assign rx_data = DQ;
    assign DQ = (is_outgoing) ? tx_data : 16'bz;

    //-- Modified on 23 March 2022 to use Xilinx primitive IOBUF

    // IOBUF: Single-ended Bi-directional Buffer
//    genvar k;
//    generate
//        for( k = 0;k <= 15;k = k + 1 )
//        begin

//            // All devices
//            // Xilinx HDL Language Template, version 2020.1_versal_lib
//            IOBUF #(
//                .DRIVE(12),                 // Specify the output drive strength
//                .IBUF_LOW_PWR("TRUE"),      // Low Power - "TRUE", High Performance = "FALSE"
//                .IOSTANDARD("LVCMOS33"),    // Specify the I/O standard
//                .SLEW("SLOW")               // Specify the output slew rate
//            ) IOBUF_inst (
//                .O(rx_data[k]),             // Buffer output
//                .IO(DQ[k]),                 // Buffer inout port (connect directly to top-level port)
//                .I(tx_data[k]),             // Buffer input
//                .T(is_outgoing)              // 3-state enable input, high=input, low=output
//            );
//            // End of IOBUF_inst instantiation

//        end
//    endgenerate

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
        is_writing <= 1'b0;
        master_state <= state_idle;
        u16WrCounter <= FX3S_DMA_Size;
        rst_9d <= 1;
        rst_8d <= 1;
        rst_7d <= 1;
        rst_6d <= 1;
        rst_5d <= 1;
        rst_4d <= 1;
        rst_3d <= 1;
        rst_dd <= 1;
        rst_d <= 1;
		dbg <= 0;
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


    // Main process
    /*
     * State transition table (FLAGA and FLAGB are active low)
     * ------------------------------------------------------------------------------------
     *     State     | Input condition                 |  Next State | Action
     * ------------------------------------------------------------------------------------
     *     idle      | !rx_full && FLAGA               | start_read  | is_outgoing = 0, SLCS = 0, SLOE = 0, A0 = 0
     * ------------------------------------------------------------------------------------
     *  start_read   | 1                               | read_pre1   | SLRD = 0
     * ------------------------------------------------------------------------------------
     *  read_pre1    | 1                               | read_pre2   | -
     * ------------------------------------------------------------------------------------
     *  read_pre2    | !FLAGA                          | idle        | SLCS = 1, SLRD = 1, SLOE = 1
     *               | else                            | read_loop   | rx_wr_en = 1
     * ------------------------------------------------------------------------------------
     *  read_loop    | !FLAGA || rx_full               | idle        | SLCS = 1, SLRD = 1, SLOE = 1, rx_wr_en = 0
     *               | else                            | read_loop   | -
     * ------------------------------------------------------------------------------------
     *  write_wait1  | 1                               | write_wait2 |
     * ------------------------------------------------------------------------------------

     *  stop_write   | 1                               | stop_write_2| PKTEND = 1, SLWR = 1 (then wait 3 clocks)
     * ------------------------------------------------------------------------------------
     *  stop_write_2 | 1                               | stop_wriet_3|
     * ------------------------------------------------------------------------------------
     *  stop_write_3 | 1                               | stop_wriet_4|
     * ------------------------------------------------------------------------------------
     *  stop_write_4 | 1                               | idle        | SLCS = 1, sending = 0, is_outgoing = 0




     *     idle      | is_writing && FLAGB && tx_empty |             |
     *               |                 && !sending     | zlp         | is_outgoing = 1, SLCS = 0, PEND = 0
     *               | 
     *               | !tx_empty && FLAGB              | start_write | is_outgoing = 1, SLCS = 0, SLWR = 0, tx_rd_en = 1, is_writing = 1
     * ------------------------------------------------------------------------------------
     *  read_pre3    | !FLAGA                          | idle        | SLCS = 1, SLRD = 1, SLOE = 1
     *               | else                            | read_loop   | rx_buf_d = rx_data, rx_wr_en = 1
     * ------------------------------------------------------------------------------------
     *  zlp          | 1                               | zlp_wait1   | PEND = 1 (then wait 3 clocks)
     * ------------------------------------------------------------------------------------
     *  zlp_wait3    | 1                               | idle        | SLCS = 1, is_outgoing = 0, is_writing = 0, u16WrCounter = FX3S_DMA_Size
     * ------------------------------------------------------------------------------------
     *  start_write  | !FLAGB || tx_empty              | idle        | SLCS = 1, SLWR = 1, tx_rd_en = 0, is_outgoing = 0
     *               | else { u16WrCounter == 0 }      | write_wait1 | u16WrCounter = u16WrCounter - 1, SLCS = 1,
     *                                                               |     SLWR = 1, tx_rd_en = 0 (then wait 3 clocks)
     * ------------------------------------------------------------------------------------
     *  write_wait1  | 1                               | write_wait2 |
     * ------------------------------------------------------------------------------------
     *  write_wait2  | 1                               | write_wait3 |
     * ------------------------------------------------------------------------------------
     *  write_wait3  | 1                               | idle        | is_outgoing = 0, u16WrCounter = FX3S_DMA_Size
     * ------------------------------------------------------------------------------------
     * ------------------------------------------------------------------------------------

     */
    always @(posedge clk)
    begin
        if( rst_internal )
        begin
            SLCS <= 1;
            SLWR <= 1;
            SLRD <= 1;
            SLOE <= 1;
            PKTEND <= 1;
            is_outgoing <= 0;
            is_writing <= 0;
            rx_wr_en <= 0;
            tx_rd_en <= 0;
            master_state <= state_idle;
        end
        else
        begin
            case( master_state )
                state_idle:
                begin
                    if( is_writing && FLAGB && tx_empty && !sending )
                    begin
                        is_outgoing <= 1;
                        SLCS <= 0;
                        PKTEND <= 0;
                        master_state <= state_zlp;
                    end

                    if( !rx_full && FLAGA )
                    begin
                        is_outgoing <= 0;
                        SLCS <= 0;
                        SLOE <= 0;
                        master_state <= state_start_read;
                    end

                    if( !tx_empty && FLAGB )
                    begin
                        is_outgoing <= 1;
                        SLCS <= 0;
                        SLWR <= 0;
                        tx_rd_en <= 1;
                        is_writing <= 1;
                        master_state <= state_start_write;
                    end
                end

                // FX3S -> FPGA states
                state_start_read:
                begin
                    SLRD <= 0;
					dbg <= 1;
                    master_state <= state_read_pre1;
                end

                state_read_pre1:
                begin
                    master_state <= state_read_pre2;
                end

                state_read_pre2:
                begin
                    if( !FLAGA )
                    begin
                        SLCS <= 1;
                        SLRD <= 1;
                        SLOE <= 1;
                        master_state <= state_idle;
                    end
                    else
                    begin
                        rx_buf_dd <= rx_data;
                        master_state <= state_read_pre3;
                    end
                end

                state_read_pre3:
                begin
                    if( !FLAGA )
                    begin
                        SLCS <= 1;
                        SLRD <= 1;
                        SLOE <= 1;
                        rx_wr_en <= 0;
                        master_state <= state_idle;
                    end
                    else
                    begin
                        rx_buf_d <= rx_data;
                        rx_wr_en <= 1;
                        master_state <= state_read_loop;
                    end
                end

                state_read_loop:
                begin
                    if( !FLAGA || rx_full )
                    begin
                        SLCS <= 1;
                        SLRD <= 1;
                        SLOE <= 1;
                        rx_wr_en <= 0;
                        master_state <= state_idle;
                    end
                    else
                    begin
                        rx_buf_dd = rx_buf_d;
                        rx_buf_d = rx_data;
                        /* stay at state_read_loop */
                    end
                end

                // FPGA -> FX3S states
                state_start_write:
                begin
                    u16WrCounter = u16WrCounter - 1;
                    if( u16WrCounter == 0 ) /* End of a chunk */
                    begin
                        SLCS <= 1;
                        SLWR <= 1;
                        tx_rd_en <= 0;
                        is_outgoing <= 0;
                        master_state <= state_write_wait1;
                    end
                    else
                    begin
                        if( !FLAGB || tx_empty )
                        begin
                            SLCS <= 1;
                            SLWR <= 1;
                            tx_rd_en <= 0;
                            is_outgoing <= 0;
                            master_state <= state_idle;
                       end
                    end
                end

                state_write_wait1:
                begin
                    master_state <= state_write_wait2;
                end

                state_write_wait2:
                begin
                    master_state <= state_write_wait3;
                end

                state_write_wait3:
                begin
                    u16WrCounter <= FX3S_DMA_Size;
                    master_state <= state_idle;
                end

                // FPGA -> FX3S with zero-length packet states
                state_zlp:
                begin
                    PKTEND <= 1;
                    master_state <= state_zlp_wait1;
                end

                state_zlp_wait1:
                begin
                    master_state <= state_zlp_wait2;
                end

                state_zlp_wait2:
                begin
                    master_state <= state_zlp_wait3;
                end

                state_zlp_wait3:
                begin
                    SLCS <= 1;
                    is_writing <= 0;
                    is_outgoing <= 0;
                    u16WrCounter <= FX3S_DMA_Size;
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
                    is_writing <= 0;
                    rx_wr_en <= 0;
                    tx_rd_en <= 0;
                    master_state <= state_idle; // Go back to idle
                end
            endcase
        end
    end

    //************************************************************
    // IP Instances
    //************************************************************
    // FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
    //           7 Series
    // Xilinx HDL Language Template, version 2021.2

    FIFO36E1 #(
        .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
        .ALMOST_FULL_OFFSET(13'd2000),     // Sets almost full threshold to 2000 entries
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
    fifo_departure (
        // ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
        .DBITERR(),                    // 1-bit output: Double bit error status
        .ECCPARITY(),                  // 8-bit output: Generated error correction parity
        .SBITERR(),                    // 1-bit output: Single bit error status
        // Read Data: 64-bit (each) output: Read output data
        .DO(tx_data),                  // 64-bit output: Data output
        .DOP(),                        // 8-bit output: Parity data output
        // Status: 1-bit (each) output: Flags and other FIFO status outputs
        .ALMOSTEMPTY(),                // 1-bit output: Almost empty flag
        .ALMOSTFULL(input_full),       // 1-bit output: Almost full flag
        .EMPTY(tx_empty),              // 1-bit output: Empty flag
        .FULL(),                       // 1-bit output: Full flag
        .RDCOUNT(),                    // 13-bit output: Read count
        .RDERR(),                      // 1-bit output: Read error
        .WRCOUNT(),                    // 13-bit output: Write count
        .WRERR(),                      // 1-bit output: Write error
        // ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
        .INJECTDBITERR(1'b0),              // 1-bit input: Inject a double bit error input
        .INJECTSBITERR(1'b0),
        // Read Control Signals: 1-bit (each) input: Read clock, enable and reset input signals
        .RDCLK(~clk),                  // 1-bit input: Read clock
        .RDEN(tx_rd_en),               // 1-bit input: Read enable
        .REGCE(1'b1),                  // 1-bit input: Clock enable
        .RST(fifo_rst_internal),       // 1-bit input: Reset
        .RSTREG(1'b0),                 // 1-bit input: Output register set/reset
        // Write Control Signals: 1-bit (each) input: Write clock and enable input signals
        .WRCLK(clk),                   // 1-bit input: Rising edge write clock.
        .WREN(tx_wr_en),               // 1-bit input: Write enable
        // Write Data: 64-bit (each) input: Write input data
        .DI(d_in),                     // 64-bit input: Data input
        .DIP(2'b0)                     // 2-bit input: Parity input
    );

    // End of FIFO36E1_inst instantiation

    // FIFO36E1: 36Kb FIFO (First-In-First-Out) Block RAM Memory
    //           7 Series
    // Xilinx HDL Language Template, version 2021.2

    FIFO36E1 #(
        .ALMOST_EMPTY_OFFSET(13'h0080),    // Sets the almost empty threshold
        .ALMOST_FULL_OFFSET(13'd2000),     // Sets almost full threshold to 2000 entries
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
        .WREN(rx_wr_en),               // 1-bit input: Write enable
        // Write Data: 64-bit (each) input: Write input data
        .DI(rx_buf_dd),                // 64-bit input: Data input
        .DIP(2'b0)                     // 2-bit input: Parity input
    );
    // End of FIFO36E1_inst instantiation

endmodule