// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Tue Jun 14 14:59:35 2022
// Host        : Seapup-dell running 64-bit Ubuntu 20.04.4 LTS
// Command     : write_verilog -mode funcsim -nolib -force -file
//               /home/stp/seapup/zeabus_hydrophone/FPGA_firmware/hydrophone_dsp.sim/sim_trigger/synth/func/xsim/hydrophone_trigger_tb_func_synth.v
// Design      : zeabus_hydrophone
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a15tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module adc_filter
   (\counter_q_reg[5] ,
    O,
    \d_out_reg[12] ,
    \d_out_reg[16] ,
    \d_out_reg[19] ,
    E,
    \d_out_reg[10] ,
    \d_out_reg[19]_0 ,
    \d_out_reg[4] ,
    \d_out_reg[16]_0 ,
    strb_reg,
    strb_reg_0,
    ifclk_out_OBUF_BUFG,
    SR,
    rst_3d,
    rst_d,
    rst_2d,
    rst,
    t_counter3_carry,
    t_counter3_carry_0,
    t_counter3_carry_1,
    t_counter3_carry_2,
    t_counter3_carry_3,
    t_counter3_carry_4,
    t_counter3_carry_5,
    t_counter3_carry_6,
    t_counter3_carry__0,
    t_counter3_carry__0_0,
    t_counter3_carry__0_1,
    t_counter3_carry__0_2,
    t_counter3_carry__0_3,
    t_counter3_carry__0_4,
    adc_strb_2,
    adc_strb_1,
    adc_strb_4,
    rst_internal);
  output \counter_q_reg[5] ;
  output [2:0]O;
  output [3:0]\d_out_reg[12] ;
  output [3:0]\d_out_reg[16] ;
  output [2:0]\d_out_reg[19] ;
  output [0:0]E;
  output [3:0]\d_out_reg[10] ;
  output [15:0]\d_out_reg[19]_0 ;
  output [0:0]\d_out_reg[4] ;
  output [2:0]\d_out_reg[16]_0 ;
  output strb_reg;
  output strb_reg_0;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input rst_3d;
  input rst_d;
  input rst_2d;
  input rst;
  input t_counter3_carry;
  input t_counter3_carry_0;
  input t_counter3_carry_1;
  input t_counter3_carry_2;
  input t_counter3_carry_3;
  input t_counter3_carry_4;
  input t_counter3_carry_5;
  input [0:0]t_counter3_carry_6;
  input t_counter3_carry__0;
  input t_counter3_carry__0_0;
  input t_counter3_carry__0_1;
  input t_counter3_carry__0_2;
  input t_counter3_carry__0_3;
  input t_counter3_carry__0_4;
  input adc_strb_2;
  input adc_strb_1;
  input adc_strb_4;
  input rst_internal;

  wire [0:0]E;
  wire [2:0]O;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire adc_strb_4;
  wire \counter_q_reg[5] ;
  wire [3:0]\d_out_reg[10] ;
  wire [3:0]\d_out_reg[12] ;
  wire [3:0]\d_out_reg[16] ;
  wire [2:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[19] ;
  wire [15:0]\d_out_reg[19]_0 ;
  wire [0:0]\d_out_reg[4] ;
  wire ifclk_out_OBUF_BUFG;
  wire rst;
  wire rst_2d;
  wire rst_3d;
  wire rst_d;
  wire rst_internal;
  wire strb_reg;
  wire strb_reg_0;
  wire t_counter3_carry;
  wire t_counter3_carry_0;
  wire t_counter3_carry_1;
  wire t_counter3_carry_2;
  wire t_counter3_carry_3;
  wire t_counter3_carry_4;
  wire t_counter3_carry_5;
  wire [0:0]t_counter3_carry_6;
  wire t_counter3_carry__0;
  wire t_counter3_carry__0_0;
  wire t_counter3_carry__0_1;
  wire t_counter3_carry__0_2;
  wire t_counter3_carry__0_3;
  wire t_counter3_carry__0_4;

  avg64_binning avg_binning1
       (.E(E),
        .O(O),
        .SR(SR),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .adc_strb_4(adc_strb_4),
        .\counter_q_reg[5]_0 (\counter_q_reg[5] ),
        .\d_out_reg[10]_0 (\d_out_reg[10] ),
        .\d_out_reg[12]_0 (\d_out_reg[12] ),
        .\d_out_reg[16]_0 (\d_out_reg[16] ),
        .\d_out_reg[16]_1 (\d_out_reg[16]_0 ),
        .\d_out_reg[19]_0 (\d_out_reg[19] ),
        .\d_out_reg[19]_1 (\d_out_reg[19]_0 ),
        .\d_out_reg[4]_0 (\d_out_reg[4] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .rst(rst),
        .rst_2d(rst_2d),
        .rst_3d(rst_3d),
        .rst_d(rst_d),
        .rst_internal(rst_internal),
        .strb_reg_0(strb_reg),
        .strb_reg_1(strb_reg_0),
        .t_counter3_carry(t_counter3_carry),
        .t_counter3_carry_0(t_counter3_carry_0),
        .t_counter3_carry_1(t_counter3_carry_1),
        .t_counter3_carry_2(t_counter3_carry_2),
        .t_counter3_carry_3(t_counter3_carry_3),
        .t_counter3_carry_4(t_counter3_carry_4),
        .t_counter3_carry_5(t_counter3_carry_5),
        .t_counter3_carry_6(t_counter3_carry_6),
        .t_counter3_carry__0(t_counter3_carry__0),
        .t_counter3_carry__0_0(t_counter3_carry__0_0),
        .t_counter3_carry__0_1(t_counter3_carry__0_1),
        .t_counter3_carry__0_2(t_counter3_carry__0_2),
        .t_counter3_carry__0_3(t_counter3_carry__0_3),
        .t_counter3_carry__0_4(t_counter3_carry__0_4));
endmodule

(* ORIG_REF_NAME = "adc_filter" *) 
module adc_filter_1
   (\counter_q_reg[5] ,
    adc_strb_1,
    O,
    \d_out_reg[12] ,
    \d_out_reg[16] ,
    \d_out_reg[19] ,
    \d_out_reg[10] ,
    \d_out_reg[19]_0 ,
    \d_out_reg[4] ,
    \d_out_reg[16]_0 ,
    strb_reg,
    ifclk_out_OBUF_BUFG,
    SR,
    \t_counter4_inferred__0/i__carry ,
    \t_counter4_inferred__0/i__carry_0 ,
    \t_counter4_inferred__0/i__carry_1 ,
    \t_counter4_inferred__0/i__carry_2 ,
    \t_counter4_inferred__0/i__carry_3 ,
    \t_counter4_inferred__0/i__carry_4 ,
    \t_counter4_inferred__0/i__carry_5 ,
    \t_counter4_inferred__0/i__carry_6 ,
    \t_counter4_inferred__0/i__carry__0 ,
    \t_counter4_inferred__0/i__carry__0_0 ,
    \t_counter4_inferred__0/i__carry__0_1 ,
    \t_counter4_inferred__0/i__carry__0_2 ,
    \t_counter4_inferred__0/i__carry__0_3 ,
    \t_counter4_inferred__0/i__carry__0_4 ,
    adc_strb_2,
    E);
  output \counter_q_reg[5] ;
  output adc_strb_1;
  output [2:0]O;
  output [3:0]\d_out_reg[12] ;
  output [3:0]\d_out_reg[16] ;
  output [2:0]\d_out_reg[19] ;
  output [3:0]\d_out_reg[10] ;
  output [15:0]\d_out_reg[19]_0 ;
  output [0:0]\d_out_reg[4] ;
  output [2:0]\d_out_reg[16]_0 ;
  output strb_reg;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input \t_counter4_inferred__0/i__carry ;
  input \t_counter4_inferred__0/i__carry_0 ;
  input \t_counter4_inferred__0/i__carry_1 ;
  input \t_counter4_inferred__0/i__carry_2 ;
  input \t_counter4_inferred__0/i__carry_3 ;
  input \t_counter4_inferred__0/i__carry_4 ;
  input \t_counter4_inferred__0/i__carry_5 ;
  input [0:0]\t_counter4_inferred__0/i__carry_6 ;
  input \t_counter4_inferred__0/i__carry__0 ;
  input \t_counter4_inferred__0/i__carry__0_0 ;
  input \t_counter4_inferred__0/i__carry__0_1 ;
  input \t_counter4_inferred__0/i__carry__0_2 ;
  input \t_counter4_inferred__0/i__carry__0_3 ;
  input \t_counter4_inferred__0/i__carry__0_4 ;
  input adc_strb_2;
  input [0:0]E;

  wire [0:0]E;
  wire [2:0]O;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire \counter_q_reg[5] ;
  wire [3:0]\d_out_reg[10] ;
  wire [3:0]\d_out_reg[12] ;
  wire [3:0]\d_out_reg[16] ;
  wire [2:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[19] ;
  wire [15:0]\d_out_reg[19]_0 ;
  wire [0:0]\d_out_reg[4] ;
  wire ifclk_out_OBUF_BUFG;
  wire strb_reg;
  wire \t_counter4_inferred__0/i__carry ;
  wire \t_counter4_inferred__0/i__carry_0 ;
  wire \t_counter4_inferred__0/i__carry_1 ;
  wire \t_counter4_inferred__0/i__carry_2 ;
  wire \t_counter4_inferred__0/i__carry_3 ;
  wire \t_counter4_inferred__0/i__carry_4 ;
  wire \t_counter4_inferred__0/i__carry_5 ;
  wire [0:0]\t_counter4_inferred__0/i__carry_6 ;
  wire \t_counter4_inferred__0/i__carry__0 ;
  wire \t_counter4_inferred__0/i__carry__0_0 ;
  wire \t_counter4_inferred__0/i__carry__0_1 ;
  wire \t_counter4_inferred__0/i__carry__0_2 ;
  wire \t_counter4_inferred__0/i__carry__0_3 ;
  wire \t_counter4_inferred__0/i__carry__0_4 ;

  avg64_binning_4 avg_binning1
       (.E(E),
        .O(O),
        .SR(SR),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .\counter_q_reg[5]_0 (\counter_q_reg[5] ),
        .\d_out_reg[10]_0 (\d_out_reg[10] ),
        .\d_out_reg[12]_0 (\d_out_reg[12] ),
        .\d_out_reg[16]_0 (\d_out_reg[16] ),
        .\d_out_reg[16]_1 (\d_out_reg[16]_0 ),
        .\d_out_reg[19]_0 (\d_out_reg[19] ),
        .\d_out_reg[19]_1 (\d_out_reg[19]_0 ),
        .\d_out_reg[4]_0 (\d_out_reg[4] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg_0(strb_reg),
        .\t_counter4_inferred__0/i__carry (\t_counter4_inferred__0/i__carry ),
        .\t_counter4_inferred__0/i__carry_0 (\t_counter4_inferred__0/i__carry_0 ),
        .\t_counter4_inferred__0/i__carry_1 (\t_counter4_inferred__0/i__carry_1 ),
        .\t_counter4_inferred__0/i__carry_2 (\t_counter4_inferred__0/i__carry_2 ),
        .\t_counter4_inferred__0/i__carry_3 (\t_counter4_inferred__0/i__carry_3 ),
        .\t_counter4_inferred__0/i__carry_4 (\t_counter4_inferred__0/i__carry_4 ),
        .\t_counter4_inferred__0/i__carry_5 (\t_counter4_inferred__0/i__carry_5 ),
        .\t_counter4_inferred__0/i__carry_6 (\t_counter4_inferred__0/i__carry_6 ),
        .\t_counter4_inferred__0/i__carry__0 (\t_counter4_inferred__0/i__carry__0 ),
        .\t_counter4_inferred__0/i__carry__0_0 (\t_counter4_inferred__0/i__carry__0_0 ),
        .\t_counter4_inferred__0/i__carry__0_1 (\t_counter4_inferred__0/i__carry__0_1 ),
        .\t_counter4_inferred__0/i__carry__0_2 (\t_counter4_inferred__0/i__carry__0_2 ),
        .\t_counter4_inferred__0/i__carry__0_3 (\t_counter4_inferred__0/i__carry__0_3 ),
        .\t_counter4_inferred__0/i__carry__0_4 (\t_counter4_inferred__0/i__carry__0_4 ));
endmodule

(* ORIG_REF_NAME = "adc_filter" *) 
module adc_filter__parameterized0
   (adc_strb_4,
    \d_out_reg[4] ,
    \d_out_reg[12] ,
    \d_out_reg[16] ,
    \d_out_reg[19] ,
    DI,
    Q,
    S,
    \d_out_reg[16]_0 ,
    \dummy_counter_reg[9] ,
    \dummy_counter_reg[0] ,
    \dummy_counter_reg[0]_0 ,
    ifclk_out_OBUF_BUFG,
    SR,
    strb_reg,
    t_counter2_carry,
    t_counter2_carry_0,
    t_counter2_carry_1,
    t_counter2_carry_2,
    t_counter2_carry_3,
    t_counter2_carry_4,
    t_counter2_carry_5,
    t_counter2_carry_6,
    t_counter2_carry__0,
    t_counter2_carry__0_0,
    t_counter2_carry__0_1,
    t_counter2_carry__0_2,
    t_counter2_carry__0_3,
    t_counter2_carry__0_4,
    E);
  output adc_strb_4;
  output [2:0]\d_out_reg[4] ;
  output [3:0]\d_out_reg[12] ;
  output [3:0]\d_out_reg[16] ;
  output [2:0]\d_out_reg[19] ;
  output [3:0]DI;
  output [15:0]Q;
  output [0:0]S;
  output [2:0]\d_out_reg[16]_0 ;
  output \dummy_counter_reg[9] ;
  input \dummy_counter_reg[0] ;
  input \dummy_counter_reg[0]_0 ;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input strb_reg;
  input t_counter2_carry;
  input t_counter2_carry_0;
  input t_counter2_carry_1;
  input t_counter2_carry_2;
  input t_counter2_carry_3;
  input t_counter2_carry_4;
  input t_counter2_carry_5;
  input [0:0]t_counter2_carry_6;
  input t_counter2_carry__0;
  input t_counter2_carry__0_0;
  input t_counter2_carry__0_1;
  input t_counter2_carry__0_2;
  input t_counter2_carry__0_3;
  input t_counter2_carry__0_4;
  input [0:0]E;

  wire [3:0]DI;
  wire [0:0]E;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_4;
  wire [3:0]\d_out_reg[12] ;
  wire [3:0]\d_out_reg[16] ;
  wire [2:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[19] ;
  wire [2:0]\d_out_reg[4] ;
  wire \dummy_counter_reg[0] ;
  wire \dummy_counter_reg[0]_0 ;
  wire \dummy_counter_reg[9] ;
  wire ifclk_out_OBUF_BUFG;
  wire strb_reg;
  wire t_counter2_carry;
  wire t_counter2_carry_0;
  wire t_counter2_carry_1;
  wire t_counter2_carry_2;
  wire t_counter2_carry_3;
  wire t_counter2_carry_4;
  wire t_counter2_carry_5;
  wire [0:0]t_counter2_carry_6;
  wire t_counter2_carry__0;
  wire t_counter2_carry__0_0;
  wire t_counter2_carry__0_1;
  wire t_counter2_carry__0_2;
  wire t_counter2_carry__0_3;
  wire t_counter2_carry__0_4;

  avg64_binning__parameterized0 avg_binning1
       (.DI(DI),
        .E(E),
        .Q(Q),
        .S(S),
        .SR(SR),
        .adc_strb_4(adc_strb_4),
        .\d_out_reg[12]_0 (\d_out_reg[12] ),
        .\d_out_reg[16]_0 (\d_out_reg[16] ),
        .\d_out_reg[16]_1 (\d_out_reg[16]_0 ),
        .\d_out_reg[19]_0 (\d_out_reg[19] ),
        .\d_out_reg[4]_0 (\d_out_reg[4] ),
        .\dummy_counter_reg[0]_0 (\dummy_counter_reg[0] ),
        .\dummy_counter_reg[0]_1 (\dummy_counter_reg[0]_0 ),
        .\dummy_counter_reg[9]_0 (\dummy_counter_reg[9] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg_0(strb_reg),
        .t_counter2_carry(t_counter2_carry),
        .t_counter2_carry_0(t_counter2_carry_0),
        .t_counter2_carry_1(t_counter2_carry_1),
        .t_counter2_carry_2(t_counter2_carry_2),
        .t_counter2_carry_3(t_counter2_carry_3),
        .t_counter2_carry_4(t_counter2_carry_4),
        .t_counter2_carry_5(t_counter2_carry_5),
        .t_counter2_carry_6(t_counter2_carry_6),
        .t_counter2_carry__0(t_counter2_carry__0),
        .t_counter2_carry__0_0(t_counter2_carry__0_0),
        .t_counter2_carry__0_1(t_counter2_carry__0_1),
        .t_counter2_carry__0_2(t_counter2_carry__0_2),
        .t_counter2_carry__0_3(t_counter2_carry__0_3),
        .t_counter2_carry__0_4(t_counter2_carry__0_4));
endmodule

(* ORIG_REF_NAME = "adc_filter" *) 
module adc_filter__parameterized0_2
   (adc_strb_2,
    \d_out_reg[19] ,
    DI,
    Q,
    S,
    \d_out_reg[16] ,
    \dummy_counter_reg[9] ,
    \dummy_counter_reg[0] ,
    \dummy_counter_reg[0]_0 ,
    ifclk_out_OBUF_BUFG,
    SR,
    strb_reg,
    t_counter4_carry,
    t_counter4_carry_0,
    t_counter4_carry_1,
    t_counter4_carry_2,
    t_counter4_carry_3,
    t_counter4_carry_4,
    t_counter4_carry_5,
    t_counter4_carry_6,
    t_counter4_carry__0,
    t_counter4_carry__0_0,
    t_counter4_carry__0_1,
    t_counter4_carry__0_2,
    t_counter4_carry__0_3,
    t_counter4_carry__0_4,
    E);
  output adc_strb_2;
  output [13:0]\d_out_reg[19] ;
  output [3:0]DI;
  output [15:0]Q;
  output [0:0]S;
  output [2:0]\d_out_reg[16] ;
  output \dummy_counter_reg[9] ;
  input \dummy_counter_reg[0] ;
  input \dummy_counter_reg[0]_0 ;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input strb_reg;
  input t_counter4_carry;
  input t_counter4_carry_0;
  input t_counter4_carry_1;
  input t_counter4_carry_2;
  input t_counter4_carry_3;
  input t_counter4_carry_4;
  input t_counter4_carry_5;
  input [0:0]t_counter4_carry_6;
  input t_counter4_carry__0;
  input t_counter4_carry__0_0;
  input t_counter4_carry__0_1;
  input t_counter4_carry__0_2;
  input t_counter4_carry__0_3;
  input t_counter4_carry__0_4;
  input [0:0]E;

  wire [3:0]DI;
  wire [0:0]E;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_2;
  wire [2:0]\d_out_reg[16] ;
  wire [13:0]\d_out_reg[19] ;
  wire \dummy_counter_reg[0] ;
  wire \dummy_counter_reg[0]_0 ;
  wire \dummy_counter_reg[9] ;
  wire ifclk_out_OBUF_BUFG;
  wire strb_reg;
  wire t_counter4_carry;
  wire t_counter4_carry_0;
  wire t_counter4_carry_1;
  wire t_counter4_carry_2;
  wire t_counter4_carry_3;
  wire t_counter4_carry_4;
  wire t_counter4_carry_5;
  wire [0:0]t_counter4_carry_6;
  wire t_counter4_carry__0;
  wire t_counter4_carry__0_0;
  wire t_counter4_carry__0_1;
  wire t_counter4_carry__0_2;
  wire t_counter4_carry__0_3;
  wire t_counter4_carry__0_4;

  avg64_binning__parameterized0_3 avg_binning1
       (.DI(DI),
        .E(E),
        .Q(Q),
        .S(S),
        .SR(SR),
        .adc_strb_2(adc_strb_2),
        .\d_out_reg[16]_0 (\d_out_reg[16] ),
        .\d_out_reg[19]_0 (\d_out_reg[19] ),
        .\dummy_counter_reg[0]_0 (\dummy_counter_reg[0] ),
        .\dummy_counter_reg[0]_1 (\dummy_counter_reg[0]_0 ),
        .\dummy_counter_reg[9]_0 (\dummy_counter_reg[9] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg_0(strb_reg),
        .t_counter4_carry(t_counter4_carry),
        .t_counter4_carry_0(t_counter4_carry_0),
        .t_counter4_carry_1(t_counter4_carry_1),
        .t_counter4_carry_2(t_counter4_carry_2),
        .t_counter4_carry_3(t_counter4_carry_3),
        .t_counter4_carry_4(t_counter4_carry_4),
        .t_counter4_carry_5(t_counter4_carry_5),
        .t_counter4_carry_6(t_counter4_carry_6),
        .t_counter4_carry__0(t_counter4_carry__0),
        .t_counter4_carry__0_0(t_counter4_carry__0_0),
        .t_counter4_carry__0_1(t_counter4_carry__0_1),
        .t_counter4_carry__0_2(t_counter4_carry__0_2),
        .t_counter4_carry__0_3(t_counter4_carry__0_3),
        .t_counter4_carry__0_4(t_counter4_carry__0_4));
endmodule

module adc_interface
   (\counter_q_reg[5] ,
    adc_strb_1,
    adc_strb_2,
    \d_out_reg[19] ,
    O,
    \d_out_reg[12] ,
    \d_out_reg[16] ,
    \d_out_reg[19]_0 ,
    DI,
    Q,
    \d_out_reg[10] ,
    \d_out_reg[19]_1 ,
    S,
    \d_out_reg[4] ,
    \d_out_reg[16]_0 ,
    \d_out_reg[16]_1 ,
    \dummy_counter_reg[9] ,
    ifclk_out_OBUF_BUFG,
    D_1_IBUF,
    rst,
    OTR_1_IBUF,
    \dummy_counter_reg[0] ,
    SR,
    \t_counter4_inferred__0/i__carry ,
    \t_counter4_inferred__0/i__carry_0 ,
    \t_counter4_inferred__0/i__carry_1 ,
    \t_counter4_inferred__0/i__carry_2 ,
    \t_counter4_inferred__0/i__carry_3 ,
    \t_counter4_inferred__0/i__carry_4 ,
    \t_counter4_inferred__0/i__carry_5 ,
    \t_counter4_inferred__0/i__carry_6 ,
    \t_counter4_inferred__0/i__carry__0 ,
    \t_counter4_inferred__0/i__carry__0_0 ,
    \t_counter4_inferred__0/i__carry__0_1 ,
    \t_counter4_inferred__0/i__carry__0_2 ,
    \t_counter4_inferred__0/i__carry__0_3 ,
    \t_counter4_inferred__0/i__carry__0_4 ,
    E);
  output \counter_q_reg[5] ;
  output adc_strb_1;
  output adc_strb_2;
  output [13:0]\d_out_reg[19] ;
  output [2:0]O;
  output [3:0]\d_out_reg[12] ;
  output [3:0]\d_out_reg[16] ;
  output [2:0]\d_out_reg[19]_0 ;
  output [3:0]DI;
  output [15:0]Q;
  output [3:0]\d_out_reg[10] ;
  output [15:0]\d_out_reg[19]_1 ;
  output [0:0]S;
  output [0:0]\d_out_reg[4] ;
  output [2:0]\d_out_reg[16]_0 ;
  output [2:0]\d_out_reg[16]_1 ;
  output \dummy_counter_reg[9] ;
  input ifclk_out_OBUF_BUFG;
  input [13:0]D_1_IBUF;
  input rst;
  input OTR_1_IBUF;
  input \dummy_counter_reg[0] ;
  input [0:0]SR;
  input \t_counter4_inferred__0/i__carry ;
  input \t_counter4_inferred__0/i__carry_0 ;
  input \t_counter4_inferred__0/i__carry_1 ;
  input \t_counter4_inferred__0/i__carry_2 ;
  input \t_counter4_inferred__0/i__carry_3 ;
  input \t_counter4_inferred__0/i__carry_4 ;
  input \t_counter4_inferred__0/i__carry_5 ;
  input [0:0]\t_counter4_inferred__0/i__carry_6 ;
  input \t_counter4_inferred__0/i__carry__0 ;
  input \t_counter4_inferred__0/i__carry__0_0 ;
  input \t_counter4_inferred__0/i__carry__0_1 ;
  input \t_counter4_inferred__0/i__carry__0_2 ;
  input \t_counter4_inferred__0/i__carry__0_3 ;
  input \t_counter4_inferred__0/i__carry__0_4 ;
  input [0:0]E;

  wire [3:0]DI;
  wire [13:0]D_1_IBUF;
  wire [0:0]E;
  wire [2:0]O;
  wire OTR_1_IBUF;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire \counter_q_reg[5] ;
  wire [14:0]d0_raw;
  wire [14:0]d1_raw;
  wire [3:0]\d_out_reg[10] ;
  wire [3:0]\d_out_reg[12] ;
  wire [3:0]\d_out_reg[16] ;
  wire [2:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[16]_1 ;
  wire [13:0]\d_out_reg[19] ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [15:0]\d_out_reg[19]_1 ;
  wire [0:0]\d_out_reg[4] ;
  wire \dummy_counter_reg[0] ;
  wire \dummy_counter_reg[9] ;
  wire filter1_n_40;
  wire ifclk_out_OBUF_BUFG;
  wire rst;
  wire \t_counter4_inferred__0/i__carry ;
  wire \t_counter4_inferred__0/i__carry_0 ;
  wire \t_counter4_inferred__0/i__carry_1 ;
  wire \t_counter4_inferred__0/i__carry_2 ;
  wire \t_counter4_inferred__0/i__carry_3 ;
  wire \t_counter4_inferred__0/i__carry_4 ;
  wire \t_counter4_inferred__0/i__carry_5 ;
  wire [0:0]\t_counter4_inferred__0/i__carry_6 ;
  wire \t_counter4_inferred__0/i__carry__0 ;
  wire \t_counter4_inferred__0/i__carry__0_0 ;
  wire \t_counter4_inferred__0/i__carry__0_1 ;
  wire \t_counter4_inferred__0/i__carry__0_2 ;
  wire \t_counter4_inferred__0/i__carry__0_3 ;
  wire \t_counter4_inferred__0/i__carry__0_4 ;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    IDDR_inst
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(OTR_1_IBUF),
        .Q1(d0_raw[14]),
        .Q2(d1_raw[14]),
        .R(rst),
        .S(1'b0));
  adc_filter_1 filter1
       (.E(E),
        .O(O),
        .SR(SR),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .\counter_q_reg[5] (\counter_q_reg[5] ),
        .\d_out_reg[10] (\d_out_reg[10] ),
        .\d_out_reg[12] (\d_out_reg[12] ),
        .\d_out_reg[16] (\d_out_reg[16] ),
        .\d_out_reg[16]_0 (\d_out_reg[16]_1 ),
        .\d_out_reg[19] (\d_out_reg[19]_0 ),
        .\d_out_reg[19]_0 (\d_out_reg[19]_1 ),
        .\d_out_reg[4] (\d_out_reg[4] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg(filter1_n_40),
        .\t_counter4_inferred__0/i__carry (\t_counter4_inferred__0/i__carry ),
        .\t_counter4_inferred__0/i__carry_0 (\t_counter4_inferred__0/i__carry_0 ),
        .\t_counter4_inferred__0/i__carry_1 (\t_counter4_inferred__0/i__carry_1 ),
        .\t_counter4_inferred__0/i__carry_2 (\t_counter4_inferred__0/i__carry_2 ),
        .\t_counter4_inferred__0/i__carry_3 (\t_counter4_inferred__0/i__carry_3 ),
        .\t_counter4_inferred__0/i__carry_4 (\t_counter4_inferred__0/i__carry_4 ),
        .\t_counter4_inferred__0/i__carry_5 (\t_counter4_inferred__0/i__carry_5 ),
        .\t_counter4_inferred__0/i__carry_6 (\t_counter4_inferred__0/i__carry_6 ),
        .\t_counter4_inferred__0/i__carry__0 (\t_counter4_inferred__0/i__carry__0 ),
        .\t_counter4_inferred__0/i__carry__0_0 (\t_counter4_inferred__0/i__carry__0_0 ),
        .\t_counter4_inferred__0/i__carry__0_1 (\t_counter4_inferred__0/i__carry__0_1 ),
        .\t_counter4_inferred__0/i__carry__0_2 (\t_counter4_inferred__0/i__carry__0_2 ),
        .\t_counter4_inferred__0/i__carry__0_3 (\t_counter4_inferred__0/i__carry__0_3 ),
        .\t_counter4_inferred__0/i__carry__0_4 (\t_counter4_inferred__0/i__carry__0_4 ));
  adc_filter__parameterized0_2 filter2
       (.DI(DI),
        .E(E),
        .Q(Q),
        .S(S),
        .SR(SR),
        .adc_strb_2(adc_strb_2),
        .\d_out_reg[16] (\d_out_reg[16]_0 ),
        .\d_out_reg[19] (\d_out_reg[19] ),
        .\dummy_counter_reg[0] (\dummy_counter_reg[0] ),
        .\dummy_counter_reg[0]_0 (\counter_q_reg[5] ),
        .\dummy_counter_reg[9] (\dummy_counter_reg[9] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg(filter1_n_40),
        .t_counter4_carry(\t_counter4_inferred__0/i__carry ),
        .t_counter4_carry_0(\t_counter4_inferred__0/i__carry_0 ),
        .t_counter4_carry_1(\t_counter4_inferred__0/i__carry_1 ),
        .t_counter4_carry_2(\t_counter4_inferred__0/i__carry_2 ),
        .t_counter4_carry_3(\t_counter4_inferred__0/i__carry_3 ),
        .t_counter4_carry_4(\t_counter4_inferred__0/i__carry_4 ),
        .t_counter4_carry_5(\t_counter4_inferred__0/i__carry_5 ),
        .t_counter4_carry_6(\t_counter4_inferred__0/i__carry_6 ),
        .t_counter4_carry__0(\t_counter4_inferred__0/i__carry__0 ),
        .t_counter4_carry__0_0(\t_counter4_inferred__0/i__carry__0_0 ),
        .t_counter4_carry__0_1(\t_counter4_inferred__0/i__carry__0_1 ),
        .t_counter4_carry__0_2(\t_counter4_inferred__0/i__carry__0_2 ),
        .t_counter4_carry__0_3(\t_counter4_inferred__0/i__carry__0_3 ),
        .t_counter4_carry__0_4(\t_counter4_inferred__0/i__carry__0_4 ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[0].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[0]),
        .Q1(d0_raw[0]),
        .Q2(d1_raw[0]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[10].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[10]),
        .Q1(d0_raw[10]),
        .Q2(d1_raw[10]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[11].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[11]),
        .Q1(d0_raw[11]),
        .Q2(d1_raw[11]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[12].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[12]),
        .Q1(d0_raw[12]),
        .Q2(d1_raw[12]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[13].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[13]),
        .Q1(d0_raw[13]),
        .Q2(d1_raw[13]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[1].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[1]),
        .Q1(d0_raw[1]),
        .Q2(d1_raw[1]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[2].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[2]),
        .Q1(d0_raw[2]),
        .Q2(d1_raw[2]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[3].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[3]),
        .Q1(d0_raw[3]),
        .Q2(d1_raw[3]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[4].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[4]),
        .Q1(d0_raw[4]),
        .Q2(d1_raw[4]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[5].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[5]),
        .Q1(d0_raw[5]),
        .Q2(d1_raw[5]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[6].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[6]),
        .Q1(d0_raw[6]),
        .Q2(d1_raw[6]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[7].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[7]),
        .Q1(d0_raw[7]),
        .Q2(d1_raw[7]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[8].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[8]),
        .Q1(d0_raw[8]),
        .Q2(d1_raw[8]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[9].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_1_IBUF[9]),
        .Q1(d0_raw[9]),
        .Q2(d1_raw[9]),
        .R(rst),
        .S(1'b0));
endmodule

(* ORIG_REF_NAME = "adc_interface" *) 
module adc_interface_0
   (rst_2d,
    O,
    \d_out_reg[12] ,
    \d_out_reg[16] ,
    \d_out_reg[19] ,
    \d_out_reg[4] ,
    \d_out_reg[12]_0 ,
    \d_out_reg[16]_0 ,
    \d_out_reg[19]_0 ,
    DI,
    Q,
    \d_out_reg[10] ,
    \d_out_reg[19]_1 ,
    S,
    \d_out_reg[4]_0 ,
    \d_out_reg[16]_1 ,
    \d_out_reg[16]_2 ,
    \dummy_counter_reg[9] ,
    strb_reg,
    ifclk_out_OBUF_BUFG,
    D_2_IBUF,
    rst,
    OTR_2_IBUF,
    rst_d,
    \dummy_counter_reg[0] ,
    SR,
    rst_3d,
    t_counter3_carry,
    t_counter3_carry_0,
    t_counter3_carry_1,
    t_counter3_carry_2,
    t_counter3_carry_3,
    t_counter3_carry_4,
    t_counter3_carry_5,
    t_counter3_carry_6,
    t_counter3_carry__0,
    t_counter3_carry__0_0,
    t_counter3_carry__0_1,
    t_counter3_carry__0_2,
    t_counter3_carry__0_3,
    t_counter3_carry__0_4,
    adc_strb_2,
    adc_strb_1,
    rst_internal);
  output rst_2d;
  output [2:0]O;
  output [3:0]\d_out_reg[12] ;
  output [3:0]\d_out_reg[16] ;
  output [2:0]\d_out_reg[19] ;
  output [2:0]\d_out_reg[4] ;
  output [3:0]\d_out_reg[12]_0 ;
  output [3:0]\d_out_reg[16]_0 ;
  output [2:0]\d_out_reg[19]_0 ;
  output [3:0]DI;
  output [15:0]Q;
  output [3:0]\d_out_reg[10] ;
  output [15:0]\d_out_reg[19]_1 ;
  output [0:0]S;
  output [0:0]\d_out_reg[4]_0 ;
  output [2:0]\d_out_reg[16]_1 ;
  output [2:0]\d_out_reg[16]_2 ;
  output \dummy_counter_reg[9] ;
  output strb_reg;
  input ifclk_out_OBUF_BUFG;
  input [13:0]D_2_IBUF;
  input rst;
  input OTR_2_IBUF;
  input rst_d;
  input \dummy_counter_reg[0] ;
  input [0:0]SR;
  input rst_3d;
  input t_counter3_carry;
  input t_counter3_carry_0;
  input t_counter3_carry_1;
  input t_counter3_carry_2;
  input t_counter3_carry_3;
  input t_counter3_carry_4;
  input t_counter3_carry_5;
  input [0:0]t_counter3_carry_6;
  input t_counter3_carry__0;
  input t_counter3_carry__0_0;
  input t_counter3_carry__0_1;
  input t_counter3_carry__0_2;
  input t_counter3_carry__0_3;
  input t_counter3_carry__0_4;
  input adc_strb_2;
  input adc_strb_1;
  input rst_internal;

  wire [3:0]DI;
  wire [13:0]D_2_IBUF;
  wire [2:0]O;
  wire OTR_2_IBUF;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire adc_strb_4;
  wire [14:0]d0_raw;
  wire [14:0]d1_raw;
  wire [3:0]\d_out_reg[10] ;
  wire [3:0]\d_out_reg[12] ;
  wire [3:0]\d_out_reg[12]_0 ;
  wire [3:0]\d_out_reg[16] ;
  wire [3:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[16]_1 ;
  wire [2:0]\d_out_reg[16]_2 ;
  wire [2:0]\d_out_reg[19] ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [15:0]\d_out_reg[19]_1 ;
  wire [2:0]\d_out_reg[4] ;
  wire [0:0]\d_out_reg[4]_0 ;
  wire \dummy_counter_reg[0] ;
  wire \dummy_counter_reg[9] ;
  wire filter1_n_0;
  wire filter1_n_15;
  wire filter1_n_41;
  wire ifclk_out_OBUF_BUFG;
  wire rst;
  wire rst_2d;
  wire rst_3d;
  wire rst_d;
  wire rst_internal;
  wire strb_reg;
  wire t_counter3_carry;
  wire t_counter3_carry_0;
  wire t_counter3_carry_1;
  wire t_counter3_carry_2;
  wire t_counter3_carry_3;
  wire t_counter3_carry_4;
  wire t_counter3_carry_5;
  wire [0:0]t_counter3_carry_6;
  wire t_counter3_carry__0;
  wire t_counter3_carry__0_0;
  wire t_counter3_carry__0_1;
  wire t_counter3_carry__0_2;
  wire t_counter3_carry__0_3;
  wire t_counter3_carry__0_4;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    IDDR_inst
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(OTR_2_IBUF),
        .Q1(d0_raw[14]),
        .Q2(d1_raw[14]),
        .R(rst),
        .S(1'b0));
  adc_filter filter1
       (.E(filter1_n_15),
        .O(O),
        .SR(SR),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .adc_strb_4(adc_strb_4),
        .\counter_q_reg[5] (filter1_n_0),
        .\d_out_reg[10] (\d_out_reg[10] ),
        .\d_out_reg[12] (\d_out_reg[12] ),
        .\d_out_reg[16] (\d_out_reg[16] ),
        .\d_out_reg[16]_0 (\d_out_reg[16]_2 ),
        .\d_out_reg[19] (\d_out_reg[19] ),
        .\d_out_reg[19]_0 (\d_out_reg[19]_1 ),
        .\d_out_reg[4] (\d_out_reg[4]_0 ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .rst(rst),
        .rst_2d(rst_2d),
        .rst_3d(rst_3d),
        .rst_d(rst_d),
        .rst_internal(rst_internal),
        .strb_reg(strb_reg),
        .strb_reg_0(filter1_n_41),
        .t_counter3_carry(t_counter3_carry),
        .t_counter3_carry_0(t_counter3_carry_0),
        .t_counter3_carry_1(t_counter3_carry_1),
        .t_counter3_carry_2(t_counter3_carry_2),
        .t_counter3_carry_3(t_counter3_carry_3),
        .t_counter3_carry_4(t_counter3_carry_4),
        .t_counter3_carry_5(t_counter3_carry_5),
        .t_counter3_carry_6(t_counter3_carry_6),
        .t_counter3_carry__0(t_counter3_carry__0),
        .t_counter3_carry__0_0(t_counter3_carry__0_0),
        .t_counter3_carry__0_1(t_counter3_carry__0_1),
        .t_counter3_carry__0_2(t_counter3_carry__0_2),
        .t_counter3_carry__0_3(t_counter3_carry__0_3),
        .t_counter3_carry__0_4(t_counter3_carry__0_4));
  adc_filter__parameterized0 filter2
       (.DI(DI),
        .E(filter1_n_15),
        .Q(Q),
        .S(S),
        .SR(SR),
        .adc_strb_4(adc_strb_4),
        .\d_out_reg[12] (\d_out_reg[12]_0 ),
        .\d_out_reg[16] (\d_out_reg[16]_0 ),
        .\d_out_reg[16]_0 (\d_out_reg[16]_1 ),
        .\d_out_reg[19] (\d_out_reg[19]_0 ),
        .\d_out_reg[4] (\d_out_reg[4] ),
        .\dummy_counter_reg[0] (\dummy_counter_reg[0] ),
        .\dummy_counter_reg[0]_0 (filter1_n_0),
        .\dummy_counter_reg[9] (\dummy_counter_reg[9] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .strb_reg(filter1_n_41),
        .t_counter2_carry(t_counter3_carry),
        .t_counter2_carry_0(t_counter3_carry_0),
        .t_counter2_carry_1(t_counter3_carry_1),
        .t_counter2_carry_2(t_counter3_carry_2),
        .t_counter2_carry_3(t_counter3_carry_3),
        .t_counter2_carry_4(t_counter3_carry_4),
        .t_counter2_carry_5(t_counter3_carry_5),
        .t_counter2_carry_6(t_counter3_carry_6),
        .t_counter2_carry__0(t_counter3_carry__0),
        .t_counter2_carry__0_0(t_counter3_carry__0_0),
        .t_counter2_carry__0_1(t_counter3_carry__0_1),
        .t_counter2_carry__0_2(t_counter3_carry__0_2),
        .t_counter2_carry__0_3(t_counter3_carry__0_3),
        .t_counter2_carry__0_4(t_counter3_carry__0_4));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[0].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[0]),
        .Q1(d0_raw[0]),
        .Q2(d1_raw[0]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[10].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[10]),
        .Q1(d0_raw[10]),
        .Q2(d1_raw[10]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[11].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[11]),
        .Q1(d0_raw[11]),
        .Q2(d1_raw[11]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[12].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[12]),
        .Q1(d0_raw[12]),
        .Q2(d1_raw[12]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[13].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[13]),
        .Q1(d0_raw[13]),
        .Q2(d1_raw[13]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[1].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[1]),
        .Q1(d0_raw[1]),
        .Q2(d1_raw[1]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[2].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[2]),
        .Q1(d0_raw[2]),
        .Q2(d1_raw[2]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[3].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[3]),
        .Q1(d0_raw[3]),
        .Q2(d1_raw[3]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[4].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[4]),
        .Q1(d0_raw[4]),
        .Q2(d1_raw[4]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[5].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[5]),
        .Q1(d0_raw[5]),
        .Q2(d1_raw[5]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[6].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[6]),
        .Q1(d0_raw[6]),
        .Q2(d1_raw[6]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[7].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[7]),
        .Q1(d0_raw[7]),
        .Q2(d1_raw[7]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[8].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[8]),
        .Q1(d0_raw[8]),
        .Q2(d1_raw[8]),
        .R(rst),
        .S(1'b0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* __SRVAL = "FALSE" *) 
  IDDR #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .SRTYPE("SYNC")) 
    \genblk1[9].adc_data_inst 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(D_2_IBUF[9]),
        .Q1(d0_raw[9]),
        .Q2(d1_raw[9]),
        .R(rst),
        .S(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_2d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_d),
        .Q(rst_2d),
        .R(1'b0));
endmodule

module avg64_binning
   (\counter_q_reg[5]_0 ,
    O,
    \d_out_reg[12]_0 ,
    \d_out_reg[16]_0 ,
    \d_out_reg[19]_0 ,
    E,
    \d_out_reg[10]_0 ,
    \d_out_reg[19]_1 ,
    \d_out_reg[4]_0 ,
    \d_out_reg[16]_1 ,
    strb_reg_0,
    strb_reg_1,
    ifclk_out_OBUF_BUFG,
    SR,
    rst_3d,
    rst_d,
    rst_2d,
    rst,
    t_counter3_carry,
    t_counter3_carry_0,
    t_counter3_carry_1,
    t_counter3_carry_2,
    t_counter3_carry_3,
    t_counter3_carry_4,
    t_counter3_carry_5,
    t_counter3_carry_6,
    t_counter3_carry__0,
    t_counter3_carry__0_0,
    t_counter3_carry__0_1,
    t_counter3_carry__0_2,
    t_counter3_carry__0_3,
    t_counter3_carry__0_4,
    adc_strb_2,
    adc_strb_1,
    adc_strb_4,
    rst_internal);
  output \counter_q_reg[5]_0 ;
  output [2:0]O;
  output [3:0]\d_out_reg[12]_0 ;
  output [3:0]\d_out_reg[16]_0 ;
  output [2:0]\d_out_reg[19]_0 ;
  output [0:0]E;
  output [3:0]\d_out_reg[10]_0 ;
  output [15:0]\d_out_reg[19]_1 ;
  output [0:0]\d_out_reg[4]_0 ;
  output [2:0]\d_out_reg[16]_1 ;
  output strb_reg_0;
  output strb_reg_1;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input rst_3d;
  input rst_d;
  input rst_2d;
  input rst;
  input t_counter3_carry;
  input t_counter3_carry_0;
  input t_counter3_carry_1;
  input t_counter3_carry_2;
  input t_counter3_carry_3;
  input t_counter3_carry_4;
  input t_counter3_carry_5;
  input [0:0]t_counter3_carry_6;
  input t_counter3_carry__0;
  input t_counter3_carry__0_0;
  input t_counter3_carry__0_1;
  input t_counter3_carry__0_2;
  input t_counter3_carry__0_3;
  input t_counter3_carry__0_4;
  input adc_strb_2;
  input adc_strb_1;
  input adc_strb_4;
  input rst_internal;

  wire [0:0]E;
  wire [2:0]O;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire adc_strb_3;
  wire adc_strb_4;
  wire \counter_q_reg[5]_0 ;
  wire [3:0]\d_out_reg[10]_0 ;
  wire [3:0]\d_out_reg[12]_0 ;
  wire [3:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[16]_1 ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [15:0]\d_out_reg[19]_1 ;
  wire [0:0]\d_out_reg[4]_0 ;
  wire \dummy_counter[0]_i_1__1_n_0 ;
  wire \dummy_counter[0]_i_4__1_n_0 ;
  wire \dummy_counter[0]_i_5__1_n_0 ;
  wire \dummy_counter[0]_i_6__2_n_0 ;
  wire [15:0]dummy_counter_reg;
  wire \dummy_counter_reg[0]_i_3__0_n_0 ;
  wire \dummy_counter_reg[0]_i_3__0_n_1 ;
  wire \dummy_counter_reg[0]_i_3__0_n_2 ;
  wire \dummy_counter_reg[0]_i_3__0_n_3 ;
  wire \dummy_counter_reg[0]_i_3__0_n_4 ;
  wire \dummy_counter_reg[0]_i_3__0_n_5 ;
  wire \dummy_counter_reg[0]_i_3__0_n_6 ;
  wire \dummy_counter_reg[0]_i_3__0_n_7 ;
  wire \dummy_counter_reg[12]_i_1__1_n_1 ;
  wire \dummy_counter_reg[12]_i_1__1_n_2 ;
  wire \dummy_counter_reg[12]_i_1__1_n_3 ;
  wire \dummy_counter_reg[12]_i_1__1_n_4 ;
  wire \dummy_counter_reg[12]_i_1__1_n_5 ;
  wire \dummy_counter_reg[12]_i_1__1_n_6 ;
  wire \dummy_counter_reg[12]_i_1__1_n_7 ;
  wire \dummy_counter_reg[4]_i_1__1_n_0 ;
  wire \dummy_counter_reg[4]_i_1__1_n_1 ;
  wire \dummy_counter_reg[4]_i_1__1_n_2 ;
  wire \dummy_counter_reg[4]_i_1__1_n_3 ;
  wire \dummy_counter_reg[4]_i_1__1_n_4 ;
  wire \dummy_counter_reg[4]_i_1__1_n_5 ;
  wire \dummy_counter_reg[4]_i_1__1_n_6 ;
  wire \dummy_counter_reg[4]_i_1__1_n_7 ;
  wire \dummy_counter_reg[8]_i_1__1_n_0 ;
  wire \dummy_counter_reg[8]_i_1__1_n_1 ;
  wire \dummy_counter_reg[8]_i_1__1_n_2 ;
  wire \dummy_counter_reg[8]_i_1__1_n_3 ;
  wire \dummy_counter_reg[8]_i_1__1_n_4 ;
  wire \dummy_counter_reg[8]_i_1__1_n_5 ;
  wire \dummy_counter_reg[8]_i_1__1_n_6 ;
  wire \dummy_counter_reg[8]_i_1__1_n_7 ;
  wire [5:0]\filter2/avg_binning1/counter_q_reg ;
  wire ifclk_out_OBUF_BUFG;
  wire [5:0]p_0_in__0;
  wire rst;
  wire rst_2d;
  wire rst_3d;
  wire rst_d;
  wire rst_internal;
  wire strb_i_1__1_n_0;
  wire strb_i_2__0_n_0;
  wire strb_reg_0;
  wire strb_reg_1;
  wire t_counter3_carry;
  wire t_counter3_carry_0;
  wire t_counter3_carry_1;
  wire t_counter3_carry_2;
  wire t_counter3_carry_3;
  wire t_counter3_carry_4;
  wire t_counter3_carry_5;
  wire [0:0]t_counter3_carry_6;
  wire t_counter3_carry__0;
  wire t_counter3_carry__0_0;
  wire t_counter3_carry__0_1;
  wire t_counter3_carry__0_2;
  wire t_counter3_carry__0_3;
  wire t_counter3_carry__0_4;
  wire t_counter3_carry__0_i_10_n_0;
  wire t_counter3_carry__0_i_11_n_0;
  wire t_counter3_carry__0_i_11_n_1;
  wire t_counter3_carry__0_i_11_n_2;
  wire t_counter3_carry__0_i_11_n_3;
  wire t_counter3_carry__0_i_12_n_0;
  wire t_counter3_carry__0_i_13_n_0;
  wire t_counter3_carry__0_i_17_n_0;
  wire t_counter3_carry__0_i_18_n_0;
  wire t_counter3_carry__0_i_19_n_0;
  wire t_counter3_carry__0_i_20_n_0;
  wire t_counter3_carry__0_i_21_n_0;
  wire t_counter3_carry__0_i_22_n_0;
  wire t_counter3_carry__0_i_23_n_0;
  wire t_counter3_carry__0_i_9_n_2;
  wire t_counter3_carry__0_i_9_n_3;
  wire t_counter3_carry_i_10_n_0;
  wire t_counter3_carry_i_10_n_1;
  wire t_counter3_carry_i_10_n_2;
  wire t_counter3_carry_i_10_n_3;
  wire t_counter3_carry_i_11_n_0;
  wire t_counter3_carry_i_12_n_0;
  wire t_counter3_carry_i_12_n_1;
  wire t_counter3_carry_i_12_n_2;
  wire t_counter3_carry_i_12_n_3;
  wire t_counter3_carry_i_12_n_7;
  wire t_counter3_carry_i_13_n_0;
  wire t_counter3_carry_i_17_n_0;
  wire t_counter3_carry_i_18_n_0;
  wire t_counter3_carry_i_19_n_0;
  wire t_counter3_carry_i_20_n_0;
  wire t_counter3_carry_i_21_n_0;
  wire t_counter3_carry_i_22_n_0;
  wire t_counter3_carry_i_23_n_0;
  wire t_counter3_carry_i_24_n_0;
  wire t_counter3_carry_i_25_n_0;
  wire t_counter3_carry_i_9_n_0;
  wire [3:3]\NLW_dummy_counter_reg[12]_i_1__1_CO_UNCONNECTED ;
  wire [3:2]NLW_t_counter3_carry__0_i_9_CO_UNCONNECTED;
  wire [3:3]NLW_t_counter3_carry__0_i_9_O_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \counter_q[0]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [0]),
        .O(p_0_in__0[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_q[1]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [1]),
        .I1(\filter2/avg_binning1/counter_q_reg [0]),
        .O(p_0_in__0[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \counter_q[2]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [2]),
        .I1(\filter2/avg_binning1/counter_q_reg [0]),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \counter_q[3]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [3]),
        .I1(\filter2/avg_binning1/counter_q_reg [1]),
        .I2(\filter2/avg_binning1/counter_q_reg [0]),
        .I3(\filter2/avg_binning1/counter_q_reg [2]),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \counter_q[4]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [4]),
        .I1(\filter2/avg_binning1/counter_q_reg [3]),
        .I2(\filter2/avg_binning1/counter_q_reg [2]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [1]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \counter_q[5]_i_1__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [5]),
        .I1(\filter2/avg_binning1/counter_q_reg [1]),
        .I2(\filter2/avg_binning1/counter_q_reg [0]),
        .I3(\filter2/avg_binning1/counter_q_reg [2]),
        .I4(\filter2/avg_binning1/counter_q_reg [3]),
        .I5(\filter2/avg_binning1/counter_q_reg [4]),
        .O(p_0_in__0[5]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[0]),
        .Q(\filter2/avg_binning1/counter_q_reg [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[1]),
        .Q(\filter2/avg_binning1/counter_q_reg [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[2]),
        .Q(\filter2/avg_binning1/counter_q_reg [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[3]),
        .Q(\filter2/avg_binning1/counter_q_reg [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[4]),
        .Q(\filter2/avg_binning1/counter_q_reg [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0[5]),
        .Q(\filter2/avg_binning1/counter_q_reg [5]),
        .R(SR));
  LUT5 #(
    .INIT(32'h00000002)) 
    \d_out[19]_i_1__0 
       (.I0(\counter_q_reg[5]_0 ),
        .I1(rst_3d),
        .I2(rst_d),
        .I3(rst_2d),
        .I4(rst),
        .O(E));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[6]),
        .Q(\d_out_reg[19]_1 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[7]),
        .Q(\d_out_reg[19]_1 [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[8]),
        .Q(\d_out_reg[19]_1 [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[9]),
        .Q(\d_out_reg[19]_1 [9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[10]),
        .Q(\d_out_reg[19]_1 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[11]),
        .Q(\d_out_reg[19]_1 [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[12]),
        .Q(\d_out_reg[19]_1 [12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[13]),
        .Q(\d_out_reg[19]_1 [13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[14]),
        .Q(\d_out_reg[19]_1 [14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[15]),
        .Q(\d_out_reg[19]_1 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[0]),
        .Q(\d_out_reg[19]_1 [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[1]),
        .Q(\d_out_reg[19]_1 [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[2]),
        .Q(\d_out_reg[19]_1 [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[3]),
        .Q(\d_out_reg[19]_1 [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[4]),
        .Q(\d_out_reg[19]_1 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[5]),
        .Q(\d_out_reg[19]_1 [5]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFEAAAAA)) 
    \dummy_counter[0]_i_1__1 
       (.I0(SR),
        .I1(\dummy_counter[0]_i_4__1_n_0 ),
        .I2(dummy_counter_reg[9]),
        .I3(\dummy_counter[0]_i_5__1_n_0 ),
        .I4(\counter_q_reg[5]_0 ),
        .O(\dummy_counter[0]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \dummy_counter[0]_i_2__0 
       (.I0(\filter2/avg_binning1/counter_q_reg [5]),
        .I1(\filter2/avg_binning1/counter_q_reg [4]),
        .I2(\filter2/avg_binning1/counter_q_reg [3]),
        .I3(\filter2/avg_binning1/counter_q_reg [1]),
        .I4(\filter2/avg_binning1/counter_q_reg [0]),
        .I5(\filter2/avg_binning1/counter_q_reg [2]),
        .O(\counter_q_reg[5]_0 ));
  LUT6 #(
    .INIT(64'hFFFFEEEAAAAAAAAA)) 
    \dummy_counter[0]_i_4__1 
       (.I0(dummy_counter_reg[8]),
        .I1(dummy_counter_reg[5]),
        .I2(dummy_counter_reg[4]),
        .I3(dummy_counter_reg[3]),
        .I4(dummy_counter_reg[6]),
        .I5(dummy_counter_reg[7]),
        .O(\dummy_counter[0]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \dummy_counter[0]_i_5__1 
       (.I0(dummy_counter_reg[15]),
        .I1(dummy_counter_reg[12]),
        .I2(dummy_counter_reg[11]),
        .I3(dummy_counter_reg[13]),
        .I4(dummy_counter_reg[14]),
        .I5(dummy_counter_reg[10]),
        .O(\dummy_counter[0]_i_5__1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dummy_counter[0]_i_6__2 
       (.I0(dummy_counter_reg[0]),
        .O(\dummy_counter[0]_i_6__2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3__0_n_7 ),
        .Q(dummy_counter_reg[0]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[0]_i_3__0 
       (.CI(1'b0),
        .CO({\dummy_counter_reg[0]_i_3__0_n_0 ,\dummy_counter_reg[0]_i_3__0_n_1 ,\dummy_counter_reg[0]_i_3__0_n_2 ,\dummy_counter_reg[0]_i_3__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\dummy_counter_reg[0]_i_3__0_n_4 ,\dummy_counter_reg[0]_i_3__0_n_5 ,\dummy_counter_reg[0]_i_3__0_n_6 ,\dummy_counter_reg[0]_i_3__0_n_7 }),
        .S({dummy_counter_reg[3:1],\dummy_counter[0]_i_6__2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1__1_n_5 ),
        .Q(dummy_counter_reg[10]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1__1_n_4 ),
        .Q(dummy_counter_reg[11]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1__1_n_7 ),
        .Q(dummy_counter_reg[12]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[12]_i_1__1 
       (.CI(\dummy_counter_reg[8]_i_1__1_n_0 ),
        .CO({\NLW_dummy_counter_reg[12]_i_1__1_CO_UNCONNECTED [3],\dummy_counter_reg[12]_i_1__1_n_1 ,\dummy_counter_reg[12]_i_1__1_n_2 ,\dummy_counter_reg[12]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[12]_i_1__1_n_4 ,\dummy_counter_reg[12]_i_1__1_n_5 ,\dummy_counter_reg[12]_i_1__1_n_6 ,\dummy_counter_reg[12]_i_1__1_n_7 }),
        .S(dummy_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1__1_n_6 ),
        .Q(dummy_counter_reg[13]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1__1_n_5 ),
        .Q(dummy_counter_reg[14]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1__1_n_4 ),
        .Q(dummy_counter_reg[15]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3__0_n_6 ),
        .Q(dummy_counter_reg[1]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3__0_n_5 ),
        .Q(dummy_counter_reg[2]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3__0_n_4 ),
        .Q(dummy_counter_reg[3]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1__1_n_7 ),
        .Q(dummy_counter_reg[4]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[4]_i_1__1 
       (.CI(\dummy_counter_reg[0]_i_3__0_n_0 ),
        .CO({\dummy_counter_reg[4]_i_1__1_n_0 ,\dummy_counter_reg[4]_i_1__1_n_1 ,\dummy_counter_reg[4]_i_1__1_n_2 ,\dummy_counter_reg[4]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[4]_i_1__1_n_4 ,\dummy_counter_reg[4]_i_1__1_n_5 ,\dummy_counter_reg[4]_i_1__1_n_6 ,\dummy_counter_reg[4]_i_1__1_n_7 }),
        .S(dummy_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1__1_n_6 ),
        .Q(dummy_counter_reg[5]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1__1_n_5 ),
        .Q(dummy_counter_reg[6]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1__1_n_4 ),
        .Q(dummy_counter_reg[7]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1__1_n_7 ),
        .Q(dummy_counter_reg[8]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[8]_i_1__1 
       (.CI(\dummy_counter_reg[4]_i_1__1_n_0 ),
        .CO({\dummy_counter_reg[8]_i_1__1_n_0 ,\dummy_counter_reg[8]_i_1__1_n_1 ,\dummy_counter_reg[8]_i_1__1_n_2 ,\dummy_counter_reg[8]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[8]_i_1__1_n_4 ,\dummy_counter_reg[8]_i_1__1_n_5 ,\dummy_counter_reg[8]_i_1__1_n_6 ,\dummy_counter_reg[8]_i_1__1_n_7 }),
        .S(dummy_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1__1_n_6 ),
        .Q(dummy_counter_reg[9]),
        .R(\dummy_counter[0]_i_1__1_n_0 ));
  LUT5 #(
    .INIT(32'h00008000)) 
    strb_d_i_1
       (.I0(adc_strb_3),
        .I1(adc_strb_2),
        .I2(adc_strb_1),
        .I3(adc_strb_4),
        .I4(rst_internal),
        .O(strb_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h000CC008)) 
    strb_i_1__1
       (.I0(adc_strb_3),
        .I1(strb_i_2__0_n_0),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [2]),
        .O(strb_i_1__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h000CC008)) 
    strb_i_1__2
       (.I0(adc_strb_4),
        .I1(strb_i_2__0_n_0),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [2]),
        .O(strb_reg_1));
  LUT3 #(
    .INIT(8'h01)) 
    strb_i_2__0
       (.I0(\filter2/avg_binning1/counter_q_reg [3]),
        .I1(\filter2/avg_binning1/counter_q_reg [4]),
        .I2(\filter2/avg_binning1/counter_q_reg [5]),
        .O(strb_i_2__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    strb_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_i_1__1_n_0),
        .Q(adc_strb_3),
        .R(SR));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry__0_i_10
       (.I0(\d_out_reg[19]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [13]),
        .O(t_counter3_carry__0_i_10_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter3_carry__0_i_11
       (.CI(t_counter3_carry_i_10_n_0),
        .CO({t_counter3_carry__0_i_11_n_0,t_counter3_carry__0_i_11_n_1,t_counter3_carry__0_i_11_n_2,t_counter3_carry__0_i_11_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[16]_0 ),
        .S({t_counter3_carry__0_i_20_n_0,t_counter3_carry__0_i_21_n_0,t_counter3_carry__0_i_22_n_0,t_counter3_carry__0_i_23_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry__0_i_12
       (.I0(\d_out_reg[16]_0 [2]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [11]),
        .O(t_counter3_carry__0_i_12_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry__0_i_13
       (.I0(\d_out_reg[16]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [9]),
        .O(t_counter3_carry__0_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_17
       (.I0(\d_out_reg[19]_1 [15]),
        .O(t_counter3_carry__0_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_18
       (.I0(\d_out_reg[19]_1 [14]),
        .O(t_counter3_carry__0_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_19
       (.I0(\d_out_reg[19]_1 [13]),
        .O(t_counter3_carry__0_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry__0_i_2
       (.I0(t_counter3_carry__0),
        .I1(t_counter3_carry__0_i_10_n_0),
        .I2(\d_out_reg[19]_1 [12]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[16]_0 [3]),
        .I5(t_counter3_carry__0_0),
        .O(\d_out_reg[16]_1 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_20
       (.I0(\d_out_reg[19]_1 [12]),
        .O(t_counter3_carry__0_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_21
       (.I0(\d_out_reg[19]_1 [11]),
        .O(t_counter3_carry__0_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_22
       (.I0(\d_out_reg[19]_1 [10]),
        .O(t_counter3_carry__0_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry__0_i_23
       (.I0(\d_out_reg[19]_1 [9]),
        .O(t_counter3_carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry__0_i_3
       (.I0(t_counter3_carry__0_1),
        .I1(t_counter3_carry__0_i_12_n_0),
        .I2(\d_out_reg[19]_1 [10]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[16]_0 [1]),
        .I5(t_counter3_carry__0_2),
        .O(\d_out_reg[16]_1 [1]));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry__0_i_4
       (.I0(t_counter3_carry__0_3),
        .I1(t_counter3_carry__0_i_13_n_0),
        .I2(\d_out_reg[19]_1 [8]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[12]_0 [3]),
        .I5(t_counter3_carry__0_4),
        .O(\d_out_reg[16]_1 [0]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter3_carry__0_i_9
       (.CI(t_counter3_carry__0_i_11_n_0),
        .CO({NLW_t_counter3_carry__0_i_9_CO_UNCONNECTED[3:2],t_counter3_carry__0_i_9_n_2,t_counter3_carry__0_i_9_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_t_counter3_carry__0_i_9_O_UNCONNECTED[3],\d_out_reg[19]_0 }),
        .S({1'b0,t_counter3_carry__0_i_17_n_0,t_counter3_carry__0_i_18_n_0,t_counter3_carry__0_i_19_n_0}));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry_i_1
       (.I0(t_counter3_carry),
        .I1(t_counter3_carry_i_9_n_0),
        .I2(\d_out_reg[19]_1 [6]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[12]_0 [1]),
        .I5(t_counter3_carry_0),
        .O(\d_out_reg[10]_0 [3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter3_carry_i_10
       (.CI(t_counter3_carry_i_12_n_0),
        .CO({t_counter3_carry_i_10_n_0,t_counter3_carry_i_10_n_1,t_counter3_carry_i_10_n_2,t_counter3_carry_i_10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[12]_0 ),
        .S({t_counter3_carry_i_17_n_0,t_counter3_carry_i_18_n_0,t_counter3_carry_i_19_n_0,t_counter3_carry_i_20_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry_i_11
       (.I0(\d_out_reg[12]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [5]),
        .O(t_counter3_carry_i_11_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter3_carry_i_12
       (.CI(1'b0),
        .CO({t_counter3_carry_i_12_n_0,t_counter3_carry_i_12_n_1,t_counter3_carry_i_12_n_2,t_counter3_carry_i_12_n_3}),
        .CYINIT(t_counter3_carry_i_21_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({O,t_counter3_carry_i_12_n_7}),
        .S({t_counter3_carry_i_22_n_0,t_counter3_carry_i_23_n_0,t_counter3_carry_i_24_n_0,t_counter3_carry_i_25_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry_i_13
       (.I0(O[1]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [3]),
        .O(t_counter3_carry_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_17
       (.I0(\d_out_reg[19]_1 [8]),
        .O(t_counter3_carry_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_18
       (.I0(\d_out_reg[19]_1 [7]),
        .O(t_counter3_carry_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_19
       (.I0(\d_out_reg[19]_1 [6]),
        .O(t_counter3_carry_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry_i_2
       (.I0(t_counter3_carry_1),
        .I1(t_counter3_carry_i_11_n_0),
        .I2(\d_out_reg[19]_1 [4]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(O[2]),
        .I5(t_counter3_carry_2),
        .O(\d_out_reg[10]_0 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_20
       (.I0(\d_out_reg[19]_1 [5]),
        .O(t_counter3_carry_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_21
       (.I0(\d_out_reg[19]_1 [0]),
        .O(t_counter3_carry_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_22
       (.I0(\d_out_reg[19]_1 [4]),
        .O(t_counter3_carry_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_23
       (.I0(\d_out_reg[19]_1 [3]),
        .O(t_counter3_carry_i_23_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_24
       (.I0(\d_out_reg[19]_1 [2]),
        .O(t_counter3_carry_i_24_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter3_carry_i_25
       (.I0(\d_out_reg[19]_1 [1]),
        .O(t_counter3_carry_i_25_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter3_carry_i_3
       (.I0(t_counter3_carry_3),
        .I1(t_counter3_carry_i_13_n_0),
        .I2(\d_out_reg[19]_1 [2]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(O[0]),
        .I5(t_counter3_carry_4),
        .O(\d_out_reg[10]_0 [1]));
  LUT6 #(
    .INIT(64'h54045404FD5D5404)) 
    t_counter3_carry_i_4
       (.I0(t_counter3_carry_5),
        .I1(\d_out_reg[19]_1 [1]),
        .I2(\d_out_reg[19]_1 [15]),
        .I3(t_counter3_carry_i_12_n_7),
        .I4(\d_out_reg[19]_1 [0]),
        .I5(t_counter3_carry_6),
        .O(\d_out_reg[10]_0 [0]));
  LUT6 #(
    .INIT(64'h9099900009000999)) 
    t_counter3_carry_i_8
       (.I0(\d_out_reg[19]_1 [0]),
        .I1(t_counter3_carry_6),
        .I2(t_counter3_carry_i_12_n_7),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[19]_1 [1]),
        .I5(t_counter3_carry_5),
        .O(\d_out_reg[4]_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter3_carry_i_9
       (.I0(\d_out_reg[12]_0 [2]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [7]),
        .O(t_counter3_carry_i_9_n_0));
endmodule

(* ORIG_REF_NAME = "avg64_binning" *) 
module avg64_binning_4
   (\counter_q_reg[5]_0 ,
    adc_strb_1,
    O,
    \d_out_reg[12]_0 ,
    \d_out_reg[16]_0 ,
    \d_out_reg[19]_0 ,
    \d_out_reg[10]_0 ,
    \d_out_reg[19]_1 ,
    \d_out_reg[4]_0 ,
    \d_out_reg[16]_1 ,
    strb_reg_0,
    ifclk_out_OBUF_BUFG,
    SR,
    \t_counter4_inferred__0/i__carry ,
    \t_counter4_inferred__0/i__carry_0 ,
    \t_counter4_inferred__0/i__carry_1 ,
    \t_counter4_inferred__0/i__carry_2 ,
    \t_counter4_inferred__0/i__carry_3 ,
    \t_counter4_inferred__0/i__carry_4 ,
    \t_counter4_inferred__0/i__carry_5 ,
    \t_counter4_inferred__0/i__carry_6 ,
    \t_counter4_inferred__0/i__carry__0 ,
    \t_counter4_inferred__0/i__carry__0_0 ,
    \t_counter4_inferred__0/i__carry__0_1 ,
    \t_counter4_inferred__0/i__carry__0_2 ,
    \t_counter4_inferred__0/i__carry__0_3 ,
    \t_counter4_inferred__0/i__carry__0_4 ,
    adc_strb_2,
    E);
  output \counter_q_reg[5]_0 ;
  output adc_strb_1;
  output [2:0]O;
  output [3:0]\d_out_reg[12]_0 ;
  output [3:0]\d_out_reg[16]_0 ;
  output [2:0]\d_out_reg[19]_0 ;
  output [3:0]\d_out_reg[10]_0 ;
  output [15:0]\d_out_reg[19]_1 ;
  output [0:0]\d_out_reg[4]_0 ;
  output [2:0]\d_out_reg[16]_1 ;
  output strb_reg_0;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input \t_counter4_inferred__0/i__carry ;
  input \t_counter4_inferred__0/i__carry_0 ;
  input \t_counter4_inferred__0/i__carry_1 ;
  input \t_counter4_inferred__0/i__carry_2 ;
  input \t_counter4_inferred__0/i__carry_3 ;
  input \t_counter4_inferred__0/i__carry_4 ;
  input \t_counter4_inferred__0/i__carry_5 ;
  input [0:0]\t_counter4_inferred__0/i__carry_6 ;
  input \t_counter4_inferred__0/i__carry__0 ;
  input \t_counter4_inferred__0/i__carry__0_0 ;
  input \t_counter4_inferred__0/i__carry__0_1 ;
  input \t_counter4_inferred__0/i__carry__0_2 ;
  input \t_counter4_inferred__0/i__carry__0_3 ;
  input \t_counter4_inferred__0/i__carry__0_4 ;
  input adc_strb_2;
  input [0:0]E;

  wire [0:0]E;
  wire [2:0]O;
  wire [0:0]SR;
  wire adc_strb_1;
  wire adc_strb_2;
  wire \counter_q_reg[5]_0 ;
  wire [3:0]\d_out_reg[10]_0 ;
  wire [3:0]\d_out_reg[12]_0 ;
  wire [3:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[16]_1 ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [15:0]\d_out_reg[19]_1 ;
  wire [0:0]\d_out_reg[4]_0 ;
  wire \dummy_counter[0]_i_1_n_0 ;
  wire \dummy_counter[0]_i_4_n_0 ;
  wire \dummy_counter[0]_i_5_n_0 ;
  wire \dummy_counter[0]_i_6__0_n_0 ;
  wire [15:0]dummy_counter_reg;
  wire \dummy_counter_reg[0]_i_3_n_0 ;
  wire \dummy_counter_reg[0]_i_3_n_1 ;
  wire \dummy_counter_reg[0]_i_3_n_2 ;
  wire \dummy_counter_reg[0]_i_3_n_3 ;
  wire \dummy_counter_reg[0]_i_3_n_4 ;
  wire \dummy_counter_reg[0]_i_3_n_5 ;
  wire \dummy_counter_reg[0]_i_3_n_6 ;
  wire \dummy_counter_reg[0]_i_3_n_7 ;
  wire \dummy_counter_reg[12]_i_1_n_1 ;
  wire \dummy_counter_reg[12]_i_1_n_2 ;
  wire \dummy_counter_reg[12]_i_1_n_3 ;
  wire \dummy_counter_reg[12]_i_1_n_4 ;
  wire \dummy_counter_reg[12]_i_1_n_5 ;
  wire \dummy_counter_reg[12]_i_1_n_6 ;
  wire \dummy_counter_reg[12]_i_1_n_7 ;
  wire \dummy_counter_reg[4]_i_1_n_0 ;
  wire \dummy_counter_reg[4]_i_1_n_1 ;
  wire \dummy_counter_reg[4]_i_1_n_2 ;
  wire \dummy_counter_reg[4]_i_1_n_3 ;
  wire \dummy_counter_reg[4]_i_1_n_4 ;
  wire \dummy_counter_reg[4]_i_1_n_5 ;
  wire \dummy_counter_reg[4]_i_1_n_6 ;
  wire \dummy_counter_reg[4]_i_1_n_7 ;
  wire \dummy_counter_reg[8]_i_1_n_0 ;
  wire \dummy_counter_reg[8]_i_1_n_1 ;
  wire \dummy_counter_reg[8]_i_1_n_2 ;
  wire \dummy_counter_reg[8]_i_1_n_3 ;
  wire \dummy_counter_reg[8]_i_1_n_4 ;
  wire \dummy_counter_reg[8]_i_1_n_5 ;
  wire \dummy_counter_reg[8]_i_1_n_6 ;
  wire \dummy_counter_reg[8]_i_1_n_7 ;
  wire [5:0]\filter2/avg_binning1/counter_q_reg ;
  wire i__carry__0_i_10_n_0;
  wire i__carry__0_i_11_n_0;
  wire i__carry__0_i_11_n_1;
  wire i__carry__0_i_11_n_2;
  wire i__carry__0_i_11_n_3;
  wire i__carry__0_i_12_n_0;
  wire i__carry__0_i_13_n_0;
  wire i__carry__0_i_17_n_0;
  wire i__carry__0_i_18_n_0;
  wire i__carry__0_i_19_n_0;
  wire i__carry__0_i_20_n_0;
  wire i__carry__0_i_21_n_0;
  wire i__carry__0_i_22_n_0;
  wire i__carry__0_i_23_n_0;
  wire i__carry__0_i_9_n_2;
  wire i__carry__0_i_9_n_3;
  wire i__carry_i_10_n_0;
  wire i__carry_i_10_n_1;
  wire i__carry_i_10_n_2;
  wire i__carry_i_10_n_3;
  wire i__carry_i_11_n_0;
  wire i__carry_i_12_n_0;
  wire i__carry_i_12_n_1;
  wire i__carry_i_12_n_2;
  wire i__carry_i_12_n_3;
  wire i__carry_i_12_n_7;
  wire i__carry_i_13_n_0;
  wire i__carry_i_17_n_0;
  wire i__carry_i_18_n_0;
  wire i__carry_i_19_n_0;
  wire i__carry_i_20_n_0;
  wire i__carry_i_21_n_0;
  wire i__carry_i_22_n_0;
  wire i__carry_i_23_n_0;
  wire i__carry_i_24_n_0;
  wire i__carry_i_25_n_0;
  wire i__carry_i_9_n_0;
  wire ifclk_out_OBUF_BUFG;
  wire [5:0]p_0_in;
  wire strb_i_1_n_0;
  wire strb_i_2_n_0;
  wire strb_reg_0;
  wire \t_counter4_inferred__0/i__carry ;
  wire \t_counter4_inferred__0/i__carry_0 ;
  wire \t_counter4_inferred__0/i__carry_1 ;
  wire \t_counter4_inferred__0/i__carry_2 ;
  wire \t_counter4_inferred__0/i__carry_3 ;
  wire \t_counter4_inferred__0/i__carry_4 ;
  wire \t_counter4_inferred__0/i__carry_5 ;
  wire [0:0]\t_counter4_inferred__0/i__carry_6 ;
  wire \t_counter4_inferred__0/i__carry__0 ;
  wire \t_counter4_inferred__0/i__carry__0_0 ;
  wire \t_counter4_inferred__0/i__carry__0_1 ;
  wire \t_counter4_inferred__0/i__carry__0_2 ;
  wire \t_counter4_inferred__0/i__carry__0_3 ;
  wire \t_counter4_inferred__0/i__carry__0_4 ;
  wire [3:3]\NLW_dummy_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]NLW_i__carry__0_i_9_CO_UNCONNECTED;
  wire [3:3]NLW_i__carry__0_i_9_O_UNCONNECTED;

  LUT1 #(
    .INIT(2'h1)) 
    \counter_q[0]_i_1 
       (.I0(\filter2/avg_binning1/counter_q_reg [0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_q[1]_i_1 
       (.I0(\filter2/avg_binning1/counter_q_reg [1]),
        .I1(\filter2/avg_binning1/counter_q_reg [0]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \counter_q[2]_i_1 
       (.I0(\filter2/avg_binning1/counter_q_reg [2]),
        .I1(\filter2/avg_binning1/counter_q_reg [0]),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \counter_q[3]_i_1 
       (.I0(\filter2/avg_binning1/counter_q_reg [3]),
        .I1(\filter2/avg_binning1/counter_q_reg [1]),
        .I2(\filter2/avg_binning1/counter_q_reg [0]),
        .I3(\filter2/avg_binning1/counter_q_reg [2]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \counter_q[4]_i_1 
       (.I0(\filter2/avg_binning1/counter_q_reg [4]),
        .I1(\filter2/avg_binning1/counter_q_reg [3]),
        .I2(\filter2/avg_binning1/counter_q_reg [2]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [1]),
        .O(p_0_in[4]));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \counter_q[5]_i_2 
       (.I0(\filter2/avg_binning1/counter_q_reg [5]),
        .I1(\filter2/avg_binning1/counter_q_reg [1]),
        .I2(\filter2/avg_binning1/counter_q_reg [0]),
        .I3(\filter2/avg_binning1/counter_q_reg [2]),
        .I4(\filter2/avg_binning1/counter_q_reg [3]),
        .I5(\filter2/avg_binning1/counter_q_reg [4]),
        .O(p_0_in[5]));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[0]),
        .Q(\filter2/avg_binning1/counter_q_reg [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(\filter2/avg_binning1/counter_q_reg [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(\filter2/avg_binning1/counter_q_reg [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(\filter2/avg_binning1/counter_q_reg [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(\filter2/avg_binning1/counter_q_reg [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \counter_q_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[5]),
        .Q(\filter2/avg_binning1/counter_q_reg [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[6]),
        .Q(\d_out_reg[19]_1 [6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[7]),
        .Q(\d_out_reg[19]_1 [7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[8]),
        .Q(\d_out_reg[19]_1 [8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[9]),
        .Q(\d_out_reg[19]_1 [9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[10]),
        .Q(\d_out_reg[19]_1 [10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[11]),
        .Q(\d_out_reg[19]_1 [11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[12]),
        .Q(\d_out_reg[19]_1 [12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[13]),
        .Q(\d_out_reg[19]_1 [13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[14]),
        .Q(\d_out_reg[19]_1 [14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[15]),
        .Q(\d_out_reg[19]_1 [15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[0]),
        .Q(\d_out_reg[19]_1 [0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[1]),
        .Q(\d_out_reg[19]_1 [1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[2]),
        .Q(\d_out_reg[19]_1 [2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[3]),
        .Q(\d_out_reg[19]_1 [3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[4]),
        .Q(\d_out_reg[19]_1 [4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[5]),
        .Q(\d_out_reg[19]_1 [5]),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFEAAAAA)) 
    \dummy_counter[0]_i_1 
       (.I0(SR),
        .I1(\dummy_counter[0]_i_4_n_0 ),
        .I2(dummy_counter_reg[9]),
        .I3(\dummy_counter[0]_i_5_n_0 ),
        .I4(\counter_q_reg[5]_0 ),
        .O(\dummy_counter[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \dummy_counter[0]_i_2 
       (.I0(\filter2/avg_binning1/counter_q_reg [5]),
        .I1(\filter2/avg_binning1/counter_q_reg [4]),
        .I2(\filter2/avg_binning1/counter_q_reg [3]),
        .I3(\filter2/avg_binning1/counter_q_reg [1]),
        .I4(\filter2/avg_binning1/counter_q_reg [0]),
        .I5(\filter2/avg_binning1/counter_q_reg [2]),
        .O(\counter_q_reg[5]_0 ));
  LUT6 #(
    .INIT(64'hFFFFEEEAAAAAAAAA)) 
    \dummy_counter[0]_i_4 
       (.I0(dummy_counter_reg[8]),
        .I1(dummy_counter_reg[5]),
        .I2(dummy_counter_reg[4]),
        .I3(dummy_counter_reg[3]),
        .I4(dummy_counter_reg[6]),
        .I5(dummy_counter_reg[7]),
        .O(\dummy_counter[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \dummy_counter[0]_i_5 
       (.I0(dummy_counter_reg[12]),
        .I1(dummy_counter_reg[13]),
        .I2(dummy_counter_reg[10]),
        .I3(dummy_counter_reg[14]),
        .I4(dummy_counter_reg[15]),
        .I5(dummy_counter_reg[11]),
        .O(\dummy_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dummy_counter[0]_i_6__0 
       (.I0(dummy_counter_reg[0]),
        .O(\dummy_counter[0]_i_6__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3_n_7 ),
        .Q(dummy_counter_reg[0]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\dummy_counter_reg[0]_i_3_n_0 ,\dummy_counter_reg[0]_i_3_n_1 ,\dummy_counter_reg[0]_i_3_n_2 ,\dummy_counter_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\dummy_counter_reg[0]_i_3_n_4 ,\dummy_counter_reg[0]_i_3_n_5 ,\dummy_counter_reg[0]_i_3_n_6 ,\dummy_counter_reg[0]_i_3_n_7 }),
        .S({dummy_counter_reg[3:1],\dummy_counter[0]_i_6__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1_n_5 ),
        .Q(dummy_counter_reg[10]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1_n_4 ),
        .Q(dummy_counter_reg[11]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1_n_7 ),
        .Q(dummy_counter_reg[12]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[12]_i_1 
       (.CI(\dummy_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_dummy_counter_reg[12]_i_1_CO_UNCONNECTED [3],\dummy_counter_reg[12]_i_1_n_1 ,\dummy_counter_reg[12]_i_1_n_2 ,\dummy_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[12]_i_1_n_4 ,\dummy_counter_reg[12]_i_1_n_5 ,\dummy_counter_reg[12]_i_1_n_6 ,\dummy_counter_reg[12]_i_1_n_7 }),
        .S(dummy_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1_n_6 ),
        .Q(dummy_counter_reg[13]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1_n_5 ),
        .Q(dummy_counter_reg[14]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[12]_i_1_n_4 ),
        .Q(dummy_counter_reg[15]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3_n_6 ),
        .Q(dummy_counter_reg[1]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3_n_5 ),
        .Q(dummy_counter_reg[2]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[0]_i_3_n_4 ),
        .Q(dummy_counter_reg[3]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1_n_7 ),
        .Q(dummy_counter_reg[4]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[4]_i_1 
       (.CI(\dummy_counter_reg[0]_i_3_n_0 ),
        .CO({\dummy_counter_reg[4]_i_1_n_0 ,\dummy_counter_reg[4]_i_1_n_1 ,\dummy_counter_reg[4]_i_1_n_2 ,\dummy_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[4]_i_1_n_4 ,\dummy_counter_reg[4]_i_1_n_5 ,\dummy_counter_reg[4]_i_1_n_6 ,\dummy_counter_reg[4]_i_1_n_7 }),
        .S(dummy_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1_n_6 ),
        .Q(dummy_counter_reg[5]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1_n_5 ),
        .Q(dummy_counter_reg[6]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[4]_i_1_n_4 ),
        .Q(dummy_counter_reg[7]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1_n_7 ),
        .Q(dummy_counter_reg[8]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[8]_i_1 
       (.CI(\dummy_counter_reg[4]_i_1_n_0 ),
        .CO({\dummy_counter_reg[8]_i_1_n_0 ,\dummy_counter_reg[8]_i_1_n_1 ,\dummy_counter_reg[8]_i_1_n_2 ,\dummy_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[8]_i_1_n_4 ,\dummy_counter_reg[8]_i_1_n_5 ,\dummy_counter_reg[8]_i_1_n_6 ,\dummy_counter_reg[8]_i_1_n_7 }),
        .S(dummy_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\counter_q_reg[5]_0 ),
        .D(\dummy_counter_reg[8]_i_1_n_6 ),
        .Q(dummy_counter_reg[9]),
        .R(\dummy_counter[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry__0_i_10
       (.I0(\d_out_reg[19]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [13]),
        .O(i__carry__0_i_10_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry__0_i_11
       (.CI(i__carry_i_10_n_0),
        .CO({i__carry__0_i_11_n_0,i__carry__0_i_11_n_1,i__carry__0_i_11_n_2,i__carry__0_i_11_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[16]_0 ),
        .S({i__carry__0_i_20_n_0,i__carry__0_i_21_n_0,i__carry__0_i_22_n_0,i__carry__0_i_23_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry__0_i_12
       (.I0(\d_out_reg[16]_0 [2]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [11]),
        .O(i__carry__0_i_12_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry__0_i_13
       (.I0(\d_out_reg[16]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [9]),
        .O(i__carry__0_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_17
       (.I0(\d_out_reg[19]_1 [15]),
        .O(i__carry__0_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_18
       (.I0(\d_out_reg[19]_1 [14]),
        .O(i__carry__0_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_19
       (.I0(\d_out_reg[19]_1 [13]),
        .O(i__carry__0_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry__0_i_2
       (.I0(\t_counter4_inferred__0/i__carry__0 ),
        .I1(i__carry__0_i_10_n_0),
        .I2(\d_out_reg[19]_1 [12]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[16]_0 [3]),
        .I5(\t_counter4_inferred__0/i__carry__0_0 ),
        .O(\d_out_reg[16]_1 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_20
       (.I0(\d_out_reg[19]_1 [12]),
        .O(i__carry__0_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_21
       (.I0(\d_out_reg[19]_1 [11]),
        .O(i__carry__0_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_22
       (.I0(\d_out_reg[19]_1 [10]),
        .O(i__carry__0_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry__0_i_23
       (.I0(\d_out_reg[19]_1 [9]),
        .O(i__carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry__0_i_3
       (.I0(\t_counter4_inferred__0/i__carry__0_1 ),
        .I1(i__carry__0_i_12_n_0),
        .I2(\d_out_reg[19]_1 [10]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[16]_0 [1]),
        .I5(\t_counter4_inferred__0/i__carry__0_2 ),
        .O(\d_out_reg[16]_1 [1]));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry__0_i_4
       (.I0(\t_counter4_inferred__0/i__carry__0_3 ),
        .I1(i__carry__0_i_13_n_0),
        .I2(\d_out_reg[19]_1 [8]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[12]_0 [3]),
        .I5(\t_counter4_inferred__0/i__carry__0_4 ),
        .O(\d_out_reg[16]_1 [0]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry__0_i_9
       (.CI(i__carry__0_i_11_n_0),
        .CO({NLW_i__carry__0_i_9_CO_UNCONNECTED[3:2],i__carry__0_i_9_n_2,i__carry__0_i_9_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_i__carry__0_i_9_O_UNCONNECTED[3],\d_out_reg[19]_0 }),
        .S({1'b0,i__carry__0_i_17_n_0,i__carry__0_i_18_n_0,i__carry__0_i_19_n_0}));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry_i_1
       (.I0(\t_counter4_inferred__0/i__carry ),
        .I1(i__carry_i_9_n_0),
        .I2(\d_out_reg[19]_1 [6]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[12]_0 [1]),
        .I5(\t_counter4_inferred__0/i__carry_0 ),
        .O(\d_out_reg[10]_0 [3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry_i_10
       (.CI(i__carry_i_12_n_0),
        .CO({i__carry_i_10_n_0,i__carry_i_10_n_1,i__carry_i_10_n_2,i__carry_i_10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[12]_0 ),
        .S({i__carry_i_17_n_0,i__carry_i_18_n_0,i__carry_i_19_n_0,i__carry_i_20_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry_i_11
       (.I0(\d_out_reg[12]_0 [0]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [5]),
        .O(i__carry_i_11_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 i__carry_i_12
       (.CI(1'b0),
        .CO({i__carry_i_12_n_0,i__carry_i_12_n_1,i__carry_i_12_n_2,i__carry_i_12_n_3}),
        .CYINIT(i__carry_i_21_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({O,i__carry_i_12_n_7}),
        .S({i__carry_i_22_n_0,i__carry_i_23_n_0,i__carry_i_24_n_0,i__carry_i_25_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry_i_13
       (.I0(O[1]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [3]),
        .O(i__carry_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_17
       (.I0(\d_out_reg[19]_1 [8]),
        .O(i__carry_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_18
       (.I0(\d_out_reg[19]_1 [7]),
        .O(i__carry_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_19
       (.I0(\d_out_reg[19]_1 [6]),
        .O(i__carry_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry_i_2
       (.I0(\t_counter4_inferred__0/i__carry_1 ),
        .I1(i__carry_i_11_n_0),
        .I2(\d_out_reg[19]_1 [4]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(O[2]),
        .I5(\t_counter4_inferred__0/i__carry_2 ),
        .O(\d_out_reg[10]_0 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_20
       (.I0(\d_out_reg[19]_1 [5]),
        .O(i__carry_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_21
       (.I0(\d_out_reg[19]_1 [0]),
        .O(i__carry_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_22
       (.I0(\d_out_reg[19]_1 [4]),
        .O(i__carry_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_23
       (.I0(\d_out_reg[19]_1 [3]),
        .O(i__carry_i_23_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_24
       (.I0(\d_out_reg[19]_1 [2]),
        .O(i__carry_i_24_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_25
       (.I0(\d_out_reg[19]_1 [1]),
        .O(i__carry_i_25_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    i__carry_i_3
       (.I0(\t_counter4_inferred__0/i__carry_3 ),
        .I1(i__carry_i_13_n_0),
        .I2(\d_out_reg[19]_1 [2]),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(O[0]),
        .I5(\t_counter4_inferred__0/i__carry_4 ),
        .O(\d_out_reg[10]_0 [1]));
  LUT6 #(
    .INIT(64'h54045404FD5D5404)) 
    i__carry_i_4
       (.I0(\t_counter4_inferred__0/i__carry_5 ),
        .I1(\d_out_reg[19]_1 [1]),
        .I2(\d_out_reg[19]_1 [15]),
        .I3(i__carry_i_12_n_7),
        .I4(\d_out_reg[19]_1 [0]),
        .I5(\t_counter4_inferred__0/i__carry_6 ),
        .O(\d_out_reg[10]_0 [0]));
  LUT6 #(
    .INIT(64'h9099900009000999)) 
    i__carry_i_8
       (.I0(\d_out_reg[19]_1 [0]),
        .I1(\t_counter4_inferred__0/i__carry_6 ),
        .I2(i__carry_i_12_n_7),
        .I3(\d_out_reg[19]_1 [15]),
        .I4(\d_out_reg[19]_1 [1]),
        .I5(\t_counter4_inferred__0/i__carry_5 ),
        .O(\d_out_reg[4]_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry_i_9
       (.I0(\d_out_reg[12]_0 [2]),
        .I1(\d_out_reg[19]_1 [15]),
        .I2(\d_out_reg[19]_1 [7]),
        .O(i__carry_i_9_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h000CC008)) 
    strb_i_1
       (.I0(adc_strb_1),
        .I1(strb_i_2_n_0),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [2]),
        .O(strb_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h000CC008)) 
    strb_i_1__0
       (.I0(adc_strb_2),
        .I1(strb_i_2_n_0),
        .I2(\filter2/avg_binning1/counter_q_reg [1]),
        .I3(\filter2/avg_binning1/counter_q_reg [0]),
        .I4(\filter2/avg_binning1/counter_q_reg [2]),
        .O(strb_reg_0));
  LUT3 #(
    .INIT(8'h01)) 
    strb_i_2
       (.I0(\filter2/avg_binning1/counter_q_reg [3]),
        .I1(\filter2/avg_binning1/counter_q_reg [4]),
        .I2(\filter2/avg_binning1/counter_q_reg [5]),
        .O(strb_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    strb_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_i_1_n_0),
        .Q(adc_strb_1),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "avg64_binning" *) 
module avg64_binning__parameterized0
   (adc_strb_4,
    \d_out_reg[4]_0 ,
    \d_out_reg[12]_0 ,
    \d_out_reg[16]_0 ,
    \d_out_reg[19]_0 ,
    DI,
    Q,
    S,
    \d_out_reg[16]_1 ,
    \dummy_counter_reg[9]_0 ,
    \dummy_counter_reg[0]_0 ,
    \dummy_counter_reg[0]_1 ,
    ifclk_out_OBUF_BUFG,
    SR,
    strb_reg_0,
    t_counter2_carry,
    t_counter2_carry_0,
    t_counter2_carry_1,
    t_counter2_carry_2,
    t_counter2_carry_3,
    t_counter2_carry_4,
    t_counter2_carry_5,
    t_counter2_carry_6,
    t_counter2_carry__0,
    t_counter2_carry__0_0,
    t_counter2_carry__0_1,
    t_counter2_carry__0_2,
    t_counter2_carry__0_3,
    t_counter2_carry__0_4,
    E);
  output adc_strb_4;
  output [2:0]\d_out_reg[4]_0 ;
  output [3:0]\d_out_reg[12]_0 ;
  output [3:0]\d_out_reg[16]_0 ;
  output [2:0]\d_out_reg[19]_0 ;
  output [3:0]DI;
  output [15:0]Q;
  output [0:0]S;
  output [2:0]\d_out_reg[16]_1 ;
  output \dummy_counter_reg[9]_0 ;
  input \dummy_counter_reg[0]_0 ;
  input \dummy_counter_reg[0]_1 ;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input strb_reg_0;
  input t_counter2_carry;
  input t_counter2_carry_0;
  input t_counter2_carry_1;
  input t_counter2_carry_2;
  input t_counter2_carry_3;
  input t_counter2_carry_4;
  input t_counter2_carry_5;
  input [0:0]t_counter2_carry_6;
  input t_counter2_carry__0;
  input t_counter2_carry__0_0;
  input t_counter2_carry__0_1;
  input t_counter2_carry__0_2;
  input t_counter2_carry__0_3;
  input t_counter2_carry__0_4;
  input [0:0]E;

  wire [3:0]DI;
  wire [0:0]E;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_4;
  wire [3:0]\d_out_reg[12]_0 ;
  wire [3:0]\d_out_reg[16]_0 ;
  wire [2:0]\d_out_reg[16]_1 ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [2:0]\d_out_reg[4]_0 ;
  wire \dummy_counter[0]_i_4__2_n_0 ;
  wire \dummy_counter[0]_i_5__2_n_0 ;
  wire \dummy_counter[0]_i_6__1_n_0 ;
  wire [15:0]dummy_counter_reg;
  wire \dummy_counter_reg[0]_0 ;
  wire \dummy_counter_reg[0]_1 ;
  wire \dummy_counter_reg[0]_i_2__0_n_0 ;
  wire \dummy_counter_reg[0]_i_2__0_n_1 ;
  wire \dummy_counter_reg[0]_i_2__0_n_2 ;
  wire \dummy_counter_reg[0]_i_2__0_n_3 ;
  wire \dummy_counter_reg[0]_i_2__0_n_4 ;
  wire \dummy_counter_reg[0]_i_2__0_n_5 ;
  wire \dummy_counter_reg[0]_i_2__0_n_6 ;
  wire \dummy_counter_reg[0]_i_2__0_n_7 ;
  wire \dummy_counter_reg[12]_i_1__2_n_1 ;
  wire \dummy_counter_reg[12]_i_1__2_n_2 ;
  wire \dummy_counter_reg[12]_i_1__2_n_3 ;
  wire \dummy_counter_reg[12]_i_1__2_n_4 ;
  wire \dummy_counter_reg[12]_i_1__2_n_5 ;
  wire \dummy_counter_reg[12]_i_1__2_n_6 ;
  wire \dummy_counter_reg[12]_i_1__2_n_7 ;
  wire \dummy_counter_reg[4]_i_1__2_n_0 ;
  wire \dummy_counter_reg[4]_i_1__2_n_1 ;
  wire \dummy_counter_reg[4]_i_1__2_n_2 ;
  wire \dummy_counter_reg[4]_i_1__2_n_3 ;
  wire \dummy_counter_reg[4]_i_1__2_n_4 ;
  wire \dummy_counter_reg[4]_i_1__2_n_5 ;
  wire \dummy_counter_reg[4]_i_1__2_n_6 ;
  wire \dummy_counter_reg[4]_i_1__2_n_7 ;
  wire \dummy_counter_reg[8]_i_1__2_n_0 ;
  wire \dummy_counter_reg[8]_i_1__2_n_1 ;
  wire \dummy_counter_reg[8]_i_1__2_n_2 ;
  wire \dummy_counter_reg[8]_i_1__2_n_3 ;
  wire \dummy_counter_reg[8]_i_1__2_n_4 ;
  wire \dummy_counter_reg[8]_i_1__2_n_5 ;
  wire \dummy_counter_reg[8]_i_1__2_n_6 ;
  wire \dummy_counter_reg[8]_i_1__2_n_7 ;
  wire \dummy_counter_reg[9]_0 ;
  wire ifclk_out_OBUF_BUFG;
  wire strb_reg_0;
  wire t_counter2_carry;
  wire t_counter2_carry_0;
  wire t_counter2_carry_1;
  wire t_counter2_carry_2;
  wire t_counter2_carry_3;
  wire t_counter2_carry_4;
  wire t_counter2_carry_5;
  wire [0:0]t_counter2_carry_6;
  wire t_counter2_carry__0;
  wire t_counter2_carry__0_0;
  wire t_counter2_carry__0_1;
  wire t_counter2_carry__0_2;
  wire t_counter2_carry__0_3;
  wire t_counter2_carry__0_4;
  wire t_counter2_carry__0_i_10_n_0;
  wire t_counter2_carry__0_i_11_n_0;
  wire t_counter2_carry__0_i_11_n_1;
  wire t_counter2_carry__0_i_11_n_2;
  wire t_counter2_carry__0_i_11_n_3;
  wire t_counter2_carry__0_i_12_n_0;
  wire t_counter2_carry__0_i_13_n_0;
  wire t_counter2_carry__0_i_17_n_0;
  wire t_counter2_carry__0_i_18_n_0;
  wire t_counter2_carry__0_i_19_n_0;
  wire t_counter2_carry__0_i_20_n_0;
  wire t_counter2_carry__0_i_21_n_0;
  wire t_counter2_carry__0_i_22_n_0;
  wire t_counter2_carry__0_i_23_n_0;
  wire t_counter2_carry__0_i_9_n_2;
  wire t_counter2_carry__0_i_9_n_3;
  wire t_counter2_carry_i_10_n_0;
  wire t_counter2_carry_i_10_n_1;
  wire t_counter2_carry_i_10_n_2;
  wire t_counter2_carry_i_10_n_3;
  wire t_counter2_carry_i_11_n_0;
  wire t_counter2_carry_i_12_n_0;
  wire t_counter2_carry_i_12_n_1;
  wire t_counter2_carry_i_12_n_2;
  wire t_counter2_carry_i_12_n_3;
  wire t_counter2_carry_i_12_n_7;
  wire t_counter2_carry_i_13_n_0;
  wire t_counter2_carry_i_17_n_0;
  wire t_counter2_carry_i_18_n_0;
  wire t_counter2_carry_i_19_n_0;
  wire t_counter2_carry_i_20_n_0;
  wire t_counter2_carry_i_21_n_0;
  wire t_counter2_carry_i_22_n_0;
  wire t_counter2_carry_i_23_n_0;
  wire t_counter2_carry_i_24_n_0;
  wire t_counter2_carry_i_25_n_0;
  wire t_counter2_carry_i_9_n_0;
  wire [3:3]\NLW_dummy_counter_reg[12]_i_1__2_CO_UNCONNECTED ;
  wire [3:2]NLW_t_counter2_carry__0_i_9_CO_UNCONNECTED;
  wire [3:3]NLW_t_counter2_carry__0_i_9_O_UNCONNECTED;

  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[9]),
        .Q(Q[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[5]),
        .Q(Q[5]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAAAAA8AAAAAAAA)) 
    \dummy_counter[0]_i_3__0 
       (.I0(\dummy_counter_reg[0]_1 ),
        .I1(dummy_counter_reg[9]),
        .I2(dummy_counter_reg[14]),
        .I3(dummy_counter_reg[13]),
        .I4(\dummy_counter[0]_i_5__2_n_0 ),
        .I5(\dummy_counter[0]_i_6__1_n_0 ),
        .O(\dummy_counter_reg[9]_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dummy_counter[0]_i_4__2 
       (.I0(dummy_counter_reg[0]),
        .O(\dummy_counter[0]_i_4__2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \dummy_counter[0]_i_5__2 
       (.I0(dummy_counter_reg[11]),
        .I1(dummy_counter_reg[15]),
        .I2(dummy_counter_reg[7]),
        .I3(dummy_counter_reg[12]),
        .I4(dummy_counter_reg[8]),
        .I5(dummy_counter_reg[10]),
        .O(\dummy_counter[0]_i_5__2_n_0 ));
  LUT5 #(
    .INIT(32'h01FFFFFF)) 
    \dummy_counter[0]_i_6__1 
       (.I0(dummy_counter_reg[3]),
        .I1(dummy_counter_reg[4]),
        .I2(dummy_counter_reg[2]),
        .I3(dummy_counter_reg[6]),
        .I4(dummy_counter_reg[5]),
        .O(\dummy_counter[0]_i_6__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2__0_n_7 ),
        .Q(dummy_counter_reg[0]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[0]_i_2__0 
       (.CI(1'b0),
        .CO({\dummy_counter_reg[0]_i_2__0_n_0 ,\dummy_counter_reg[0]_i_2__0_n_1 ,\dummy_counter_reg[0]_i_2__0_n_2 ,\dummy_counter_reg[0]_i_2__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\dummy_counter_reg[0]_i_2__0_n_4 ,\dummy_counter_reg[0]_i_2__0_n_5 ,\dummy_counter_reg[0]_i_2__0_n_6 ,\dummy_counter_reg[0]_i_2__0_n_7 }),
        .S({dummy_counter_reg[3:1],\dummy_counter[0]_i_4__2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__2_n_5 ),
        .Q(dummy_counter_reg[10]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__2_n_4 ),
        .Q(dummy_counter_reg[11]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__2_n_7 ),
        .Q(dummy_counter_reg[12]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[12]_i_1__2 
       (.CI(\dummy_counter_reg[8]_i_1__2_n_0 ),
        .CO({\NLW_dummy_counter_reg[12]_i_1__2_CO_UNCONNECTED [3],\dummy_counter_reg[12]_i_1__2_n_1 ,\dummy_counter_reg[12]_i_1__2_n_2 ,\dummy_counter_reg[12]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[12]_i_1__2_n_4 ,\dummy_counter_reg[12]_i_1__2_n_5 ,\dummy_counter_reg[12]_i_1__2_n_6 ,\dummy_counter_reg[12]_i_1__2_n_7 }),
        .S(dummy_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__2_n_6 ),
        .Q(dummy_counter_reg[13]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__2_n_5 ),
        .Q(dummy_counter_reg[14]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__2_n_4 ),
        .Q(dummy_counter_reg[15]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2__0_n_6 ),
        .Q(dummy_counter_reg[1]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2__0_n_5 ),
        .Q(dummy_counter_reg[2]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2__0_n_4 ),
        .Q(dummy_counter_reg[3]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__2_n_7 ),
        .Q(dummy_counter_reg[4]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[4]_i_1__2 
       (.CI(\dummy_counter_reg[0]_i_2__0_n_0 ),
        .CO({\dummy_counter_reg[4]_i_1__2_n_0 ,\dummy_counter_reg[4]_i_1__2_n_1 ,\dummy_counter_reg[4]_i_1__2_n_2 ,\dummy_counter_reg[4]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[4]_i_1__2_n_4 ,\dummy_counter_reg[4]_i_1__2_n_5 ,\dummy_counter_reg[4]_i_1__2_n_6 ,\dummy_counter_reg[4]_i_1__2_n_7 }),
        .S(dummy_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__2_n_6 ),
        .Q(dummy_counter_reg[5]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__2_n_5 ),
        .Q(dummy_counter_reg[6]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__2_n_4 ),
        .Q(dummy_counter_reg[7]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__2_n_7 ),
        .Q(dummy_counter_reg[8]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[8]_i_1__2 
       (.CI(\dummy_counter_reg[4]_i_1__2_n_0 ),
        .CO({\dummy_counter_reg[8]_i_1__2_n_0 ,\dummy_counter_reg[8]_i_1__2_n_1 ,\dummy_counter_reg[8]_i_1__2_n_2 ,\dummy_counter_reg[8]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[8]_i_1__2_n_4 ,\dummy_counter_reg[8]_i_1__2_n_5 ,\dummy_counter_reg[8]_i_1__2_n_6 ,\dummy_counter_reg[8]_i_1__2_n_7 }),
        .S(dummy_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__2_n_6 ),
        .Q(dummy_counter_reg[9]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    strb_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_reg_0),
        .Q(adc_strb_4),
        .R(SR));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry__0_i_10
       (.I0(\d_out_reg[19]_0 [0]),
        .I1(Q[15]),
        .I2(Q[13]),
        .O(t_counter2_carry__0_i_10_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter2_carry__0_i_11
       (.CI(t_counter2_carry_i_10_n_0),
        .CO({t_counter2_carry__0_i_11_n_0,t_counter2_carry__0_i_11_n_1,t_counter2_carry__0_i_11_n_2,t_counter2_carry__0_i_11_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[16]_0 ),
        .S({t_counter2_carry__0_i_20_n_0,t_counter2_carry__0_i_21_n_0,t_counter2_carry__0_i_22_n_0,t_counter2_carry__0_i_23_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry__0_i_12
       (.I0(\d_out_reg[16]_0 [2]),
        .I1(Q[15]),
        .I2(Q[11]),
        .O(t_counter2_carry__0_i_12_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry__0_i_13
       (.I0(\d_out_reg[16]_0 [0]),
        .I1(Q[15]),
        .I2(Q[9]),
        .O(t_counter2_carry__0_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_17
       (.I0(Q[15]),
        .O(t_counter2_carry__0_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_18
       (.I0(Q[14]),
        .O(t_counter2_carry__0_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_19
       (.I0(Q[13]),
        .O(t_counter2_carry__0_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry__0_i_2
       (.I0(t_counter2_carry__0),
        .I1(t_counter2_carry__0_i_10_n_0),
        .I2(Q[12]),
        .I3(Q[15]),
        .I4(\d_out_reg[16]_0 [3]),
        .I5(t_counter2_carry__0_0),
        .O(\d_out_reg[16]_1 [2]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_20
       (.I0(Q[12]),
        .O(t_counter2_carry__0_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_21
       (.I0(Q[11]),
        .O(t_counter2_carry__0_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_22
       (.I0(Q[10]),
        .O(t_counter2_carry__0_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry__0_i_23
       (.I0(Q[9]),
        .O(t_counter2_carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry__0_i_3
       (.I0(t_counter2_carry__0_1),
        .I1(t_counter2_carry__0_i_12_n_0),
        .I2(Q[10]),
        .I3(Q[15]),
        .I4(\d_out_reg[16]_0 [1]),
        .I5(t_counter2_carry__0_2),
        .O(\d_out_reg[16]_1 [1]));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry__0_i_4
       (.I0(t_counter2_carry__0_3),
        .I1(t_counter2_carry__0_i_13_n_0),
        .I2(Q[8]),
        .I3(Q[15]),
        .I4(\d_out_reg[12]_0 [3]),
        .I5(t_counter2_carry__0_4),
        .O(\d_out_reg[16]_1 [0]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter2_carry__0_i_9
       (.CI(t_counter2_carry__0_i_11_n_0),
        .CO({NLW_t_counter2_carry__0_i_9_CO_UNCONNECTED[3:2],t_counter2_carry__0_i_9_n_2,t_counter2_carry__0_i_9_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_t_counter2_carry__0_i_9_O_UNCONNECTED[3],\d_out_reg[19]_0 }),
        .S({1'b0,t_counter2_carry__0_i_17_n_0,t_counter2_carry__0_i_18_n_0,t_counter2_carry__0_i_19_n_0}));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry_i_1
       (.I0(t_counter2_carry),
        .I1(t_counter2_carry_i_9_n_0),
        .I2(Q[6]),
        .I3(Q[15]),
        .I4(\d_out_reg[12]_0 [1]),
        .I5(t_counter2_carry_0),
        .O(DI[3]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter2_carry_i_10
       (.CI(t_counter2_carry_i_12_n_0),
        .CO({t_counter2_carry_i_10_n_0,t_counter2_carry_i_10_n_1,t_counter2_carry_i_10_n_2,t_counter2_carry_i_10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[12]_0 ),
        .S({t_counter2_carry_i_17_n_0,t_counter2_carry_i_18_n_0,t_counter2_carry_i_19_n_0,t_counter2_carry_i_20_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry_i_11
       (.I0(\d_out_reg[12]_0 [0]),
        .I1(Q[15]),
        .I2(Q[5]),
        .O(t_counter2_carry_i_11_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter2_carry_i_12
       (.CI(1'b0),
        .CO({t_counter2_carry_i_12_n_0,t_counter2_carry_i_12_n_1,t_counter2_carry_i_12_n_2,t_counter2_carry_i_12_n_3}),
        .CYINIT(t_counter2_carry_i_21_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\d_out_reg[4]_0 ,t_counter2_carry_i_12_n_7}),
        .S({t_counter2_carry_i_22_n_0,t_counter2_carry_i_23_n_0,t_counter2_carry_i_24_n_0,t_counter2_carry_i_25_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry_i_13
       (.I0(\d_out_reg[4]_0 [1]),
        .I1(Q[15]),
        .I2(Q[3]),
        .O(t_counter2_carry_i_13_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_17
       (.I0(Q[8]),
        .O(t_counter2_carry_i_17_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_18
       (.I0(Q[7]),
        .O(t_counter2_carry_i_18_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_19
       (.I0(Q[6]),
        .O(t_counter2_carry_i_19_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry_i_2
       (.I0(t_counter2_carry_1),
        .I1(t_counter2_carry_i_11_n_0),
        .I2(Q[4]),
        .I3(Q[15]),
        .I4(\d_out_reg[4]_0 [2]),
        .I5(t_counter2_carry_2),
        .O(DI[2]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_20
       (.I0(Q[5]),
        .O(t_counter2_carry_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_21
       (.I0(Q[0]),
        .O(t_counter2_carry_i_21_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_22
       (.I0(Q[4]),
        .O(t_counter2_carry_i_22_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_23
       (.I0(Q[3]),
        .O(t_counter2_carry_i_23_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_24
       (.I0(Q[2]),
        .O(t_counter2_carry_i_24_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter2_carry_i_25
       (.I0(Q[1]),
        .O(t_counter2_carry_i_25_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter2_carry_i_3
       (.I0(t_counter2_carry_3),
        .I1(t_counter2_carry_i_13_n_0),
        .I2(Q[2]),
        .I3(Q[15]),
        .I4(\d_out_reg[4]_0 [0]),
        .I5(t_counter2_carry_4),
        .O(DI[1]));
  LUT6 #(
    .INIT(64'h54045404FD5D5404)) 
    t_counter2_carry_i_4
       (.I0(t_counter2_carry_5),
        .I1(Q[1]),
        .I2(Q[15]),
        .I3(t_counter2_carry_i_12_n_7),
        .I4(Q[0]),
        .I5(t_counter2_carry_6),
        .O(DI[0]));
  LUT6 #(
    .INIT(64'h9099900009000999)) 
    t_counter2_carry_i_8
       (.I0(Q[0]),
        .I1(t_counter2_carry_6),
        .I2(t_counter2_carry_i_12_n_7),
        .I3(Q[15]),
        .I4(Q[1]),
        .I5(t_counter2_carry_5),
        .O(S));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter2_carry_i_9
       (.I0(\d_out_reg[12]_0 [2]),
        .I1(Q[15]),
        .I2(Q[7]),
        .O(t_counter2_carry_i_9_n_0));
endmodule

(* ORIG_REF_NAME = "avg64_binning" *) 
module avg64_binning__parameterized0_3
   (adc_strb_2,
    \d_out_reg[19]_0 ,
    DI,
    Q,
    S,
    \d_out_reg[16]_0 ,
    \dummy_counter_reg[9]_0 ,
    \dummy_counter_reg[0]_0 ,
    \dummy_counter_reg[0]_1 ,
    ifclk_out_OBUF_BUFG,
    SR,
    strb_reg_0,
    t_counter4_carry,
    t_counter4_carry_0,
    t_counter4_carry_1,
    t_counter4_carry_2,
    t_counter4_carry_3,
    t_counter4_carry_4,
    t_counter4_carry_5,
    t_counter4_carry_6,
    t_counter4_carry__0,
    t_counter4_carry__0_0,
    t_counter4_carry__0_1,
    t_counter4_carry__0_2,
    t_counter4_carry__0_3,
    t_counter4_carry__0_4,
    E);
  output adc_strb_2;
  output [13:0]\d_out_reg[19]_0 ;
  output [3:0]DI;
  output [15:0]Q;
  output [0:0]S;
  output [2:0]\d_out_reg[16]_0 ;
  output \dummy_counter_reg[9]_0 ;
  input \dummy_counter_reg[0]_0 ;
  input \dummy_counter_reg[0]_1 ;
  input ifclk_out_OBUF_BUFG;
  input [0:0]SR;
  input strb_reg_0;
  input t_counter4_carry;
  input t_counter4_carry_0;
  input t_counter4_carry_1;
  input t_counter4_carry_2;
  input t_counter4_carry_3;
  input t_counter4_carry_4;
  input t_counter4_carry_5;
  input [0:0]t_counter4_carry_6;
  input t_counter4_carry__0;
  input t_counter4_carry__0_0;
  input t_counter4_carry__0_1;
  input t_counter4_carry__0_2;
  input t_counter4_carry__0_3;
  input t_counter4_carry__0_4;
  input [0:0]E;

  wire [3:0]DI;
  wire [0:0]E;
  wire [15:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire adc_strb_2;
  wire [2:0]\d_out_reg[16]_0 ;
  wire [13:0]\d_out_reg[19]_0 ;
  wire \dummy_counter[0]_i_4__0_n_0 ;
  wire \dummy_counter[0]_i_5__0_n_0 ;
  wire \dummy_counter[0]_i_6_n_0 ;
  wire [15:0]dummy_counter_reg;
  wire \dummy_counter_reg[0]_0 ;
  wire \dummy_counter_reg[0]_1 ;
  wire \dummy_counter_reg[0]_i_2_n_0 ;
  wire \dummy_counter_reg[0]_i_2_n_1 ;
  wire \dummy_counter_reg[0]_i_2_n_2 ;
  wire \dummy_counter_reg[0]_i_2_n_3 ;
  wire \dummy_counter_reg[0]_i_2_n_4 ;
  wire \dummy_counter_reg[0]_i_2_n_5 ;
  wire \dummy_counter_reg[0]_i_2_n_6 ;
  wire \dummy_counter_reg[0]_i_2_n_7 ;
  wire \dummy_counter_reg[12]_i_1__0_n_1 ;
  wire \dummy_counter_reg[12]_i_1__0_n_2 ;
  wire \dummy_counter_reg[12]_i_1__0_n_3 ;
  wire \dummy_counter_reg[12]_i_1__0_n_4 ;
  wire \dummy_counter_reg[12]_i_1__0_n_5 ;
  wire \dummy_counter_reg[12]_i_1__0_n_6 ;
  wire \dummy_counter_reg[12]_i_1__0_n_7 ;
  wire \dummy_counter_reg[4]_i_1__0_n_0 ;
  wire \dummy_counter_reg[4]_i_1__0_n_1 ;
  wire \dummy_counter_reg[4]_i_1__0_n_2 ;
  wire \dummy_counter_reg[4]_i_1__0_n_3 ;
  wire \dummy_counter_reg[4]_i_1__0_n_4 ;
  wire \dummy_counter_reg[4]_i_1__0_n_5 ;
  wire \dummy_counter_reg[4]_i_1__0_n_6 ;
  wire \dummy_counter_reg[4]_i_1__0_n_7 ;
  wire \dummy_counter_reg[8]_i_1__0_n_0 ;
  wire \dummy_counter_reg[8]_i_1__0_n_1 ;
  wire \dummy_counter_reg[8]_i_1__0_n_2 ;
  wire \dummy_counter_reg[8]_i_1__0_n_3 ;
  wire \dummy_counter_reg[8]_i_1__0_n_4 ;
  wire \dummy_counter_reg[8]_i_1__0_n_5 ;
  wire \dummy_counter_reg[8]_i_1__0_n_6 ;
  wire \dummy_counter_reg[8]_i_1__0_n_7 ;
  wire \dummy_counter_reg[9]_0 ;
  wire ifclk_out_OBUF_BUFG;
  wire strb_reg_0;
  wire t_counter4_carry;
  wire t_counter4_carry_0;
  wire t_counter4_carry_1;
  wire t_counter4_carry_2;
  wire t_counter4_carry_3;
  wire t_counter4_carry_4;
  wire t_counter4_carry_5;
  wire [0:0]t_counter4_carry_6;
  wire t_counter4_carry__0;
  wire t_counter4_carry__0_0;
  wire t_counter4_carry__0_1;
  wire t_counter4_carry__0_2;
  wire t_counter4_carry__0_3;
  wire t_counter4_carry__0_4;
  wire t_counter4_carry__0_i_10_n_2;
  wire t_counter4_carry__0_i_10_n_3;
  wire t_counter4_carry__0_i_13_n_0;
  wire t_counter4_carry__0_i_14_n_0;
  wire t_counter4_carry__0_i_14_n_1;
  wire t_counter4_carry__0_i_14_n_2;
  wire t_counter4_carry__0_i_14_n_3;
  wire t_counter4_carry__0_i_17_n_0;
  wire t_counter4_carry__0_i_20_n_0;
  wire t_counter4_carry__0_i_26_n_0;
  wire t_counter4_carry__0_i_27_n_0;
  wire t_counter4_carry__0_i_28_n_0;
  wire t_counter4_carry__0_i_29_n_0;
  wire t_counter4_carry__0_i_30_n_0;
  wire t_counter4_carry__0_i_31_n_0;
  wire t_counter4_carry__0_i_32_n_0;
  wire t_counter4_carry_i_10_n_0;
  wire t_counter4_carry_i_11_n_0;
  wire t_counter4_carry_i_11_n_1;
  wire t_counter4_carry_i_11_n_2;
  wire t_counter4_carry_i_11_n_3;
  wire t_counter4_carry_i_14_n_0;
  wire t_counter4_carry_i_15_n_0;
  wire t_counter4_carry_i_15_n_1;
  wire t_counter4_carry_i_15_n_2;
  wire t_counter4_carry_i_15_n_3;
  wire t_counter4_carry_i_18_n_0;
  wire t_counter4_carry_i_25_n_0;
  wire t_counter4_carry_i_26_n_0;
  wire t_counter4_carry_i_27_n_0;
  wire t_counter4_carry_i_28_n_0;
  wire t_counter4_carry_i_29_n_0;
  wire t_counter4_carry_i_30_n_0;
  wire t_counter4_carry_i_31_n_0;
  wire t_counter4_carry_i_32_n_0;
  wire t_counter4_carry_i_33_n_0;
  wire [1:1]\trigger/out0 ;
  wire [3:3]\NLW_dummy_counter_reg[12]_i_1__0_CO_UNCONNECTED ;
  wire [3:2]NLW_t_counter4_carry__0_i_10_CO_UNCONNECTED;
  wire [3:3]NLW_t_counter4_carry__0_i_10_O_UNCONNECTED;

  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[9]),
        .Q(Q[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \d_out_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(E),
        .D(dummy_counter_reg[5]),
        .Q(Q[5]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hAAAAAAA8AAAAAAAA)) 
    \dummy_counter[0]_i_3 
       (.I0(\dummy_counter_reg[0]_1 ),
        .I1(dummy_counter_reg[9]),
        .I2(dummy_counter_reg[14]),
        .I3(dummy_counter_reg[13]),
        .I4(\dummy_counter[0]_i_5__0_n_0 ),
        .I5(\dummy_counter[0]_i_6_n_0 ),
        .O(\dummy_counter_reg[9]_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \dummy_counter[0]_i_4__0 
       (.I0(dummy_counter_reg[0]),
        .O(\dummy_counter[0]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \dummy_counter[0]_i_5__0 
       (.I0(dummy_counter_reg[11]),
        .I1(dummy_counter_reg[15]),
        .I2(dummy_counter_reg[7]),
        .I3(dummy_counter_reg[12]),
        .I4(dummy_counter_reg[8]),
        .I5(dummy_counter_reg[10]),
        .O(\dummy_counter[0]_i_5__0_n_0 ));
  LUT5 #(
    .INIT(32'h01FFFFFF)) 
    \dummy_counter[0]_i_6 
       (.I0(dummy_counter_reg[3]),
        .I1(dummy_counter_reg[4]),
        .I2(dummy_counter_reg[2]),
        .I3(dummy_counter_reg[6]),
        .I4(dummy_counter_reg[5]),
        .O(\dummy_counter[0]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2_n_7 ),
        .Q(dummy_counter_reg[0]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\dummy_counter_reg[0]_i_2_n_0 ,\dummy_counter_reg[0]_i_2_n_1 ,\dummy_counter_reg[0]_i_2_n_2 ,\dummy_counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\dummy_counter_reg[0]_i_2_n_4 ,\dummy_counter_reg[0]_i_2_n_5 ,\dummy_counter_reg[0]_i_2_n_6 ,\dummy_counter_reg[0]_i_2_n_7 }),
        .S({dummy_counter_reg[3:1],\dummy_counter[0]_i_4__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__0_n_5 ),
        .Q(dummy_counter_reg[10]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__0_n_4 ),
        .Q(dummy_counter_reg[11]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__0_n_7 ),
        .Q(dummy_counter_reg[12]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[12]_i_1__0 
       (.CI(\dummy_counter_reg[8]_i_1__0_n_0 ),
        .CO({\NLW_dummy_counter_reg[12]_i_1__0_CO_UNCONNECTED [3],\dummy_counter_reg[12]_i_1__0_n_1 ,\dummy_counter_reg[12]_i_1__0_n_2 ,\dummy_counter_reg[12]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[12]_i_1__0_n_4 ,\dummy_counter_reg[12]_i_1__0_n_5 ,\dummy_counter_reg[12]_i_1__0_n_6 ,\dummy_counter_reg[12]_i_1__0_n_7 }),
        .S(dummy_counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__0_n_6 ),
        .Q(dummy_counter_reg[13]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__0_n_5 ),
        .Q(dummy_counter_reg[14]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[12]_i_1__0_n_4 ),
        .Q(dummy_counter_reg[15]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2_n_6 ),
        .Q(dummy_counter_reg[1]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2_n_5 ),
        .Q(dummy_counter_reg[2]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[0]_i_2_n_4 ),
        .Q(dummy_counter_reg[3]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__0_n_7 ),
        .Q(dummy_counter_reg[4]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[4]_i_1__0 
       (.CI(\dummy_counter_reg[0]_i_2_n_0 ),
        .CO({\dummy_counter_reg[4]_i_1__0_n_0 ,\dummy_counter_reg[4]_i_1__0_n_1 ,\dummy_counter_reg[4]_i_1__0_n_2 ,\dummy_counter_reg[4]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[4]_i_1__0_n_4 ,\dummy_counter_reg[4]_i_1__0_n_5 ,\dummy_counter_reg[4]_i_1__0_n_6 ,\dummy_counter_reg[4]_i_1__0_n_7 }),
        .S(dummy_counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__0_n_6 ),
        .Q(dummy_counter_reg[5]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__0_n_5 ),
        .Q(dummy_counter_reg[6]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[4]_i_1__0_n_4 ),
        .Q(dummy_counter_reg[7]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__0_n_7 ),
        .Q(dummy_counter_reg[8]),
        .R(\dummy_counter_reg[0]_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \dummy_counter_reg[8]_i_1__0 
       (.CI(\dummy_counter_reg[4]_i_1__0_n_0 ),
        .CO({\dummy_counter_reg[8]_i_1__0_n_0 ,\dummy_counter_reg[8]_i_1__0_n_1 ,\dummy_counter_reg[8]_i_1__0_n_2 ,\dummy_counter_reg[8]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\dummy_counter_reg[8]_i_1__0_n_4 ,\dummy_counter_reg[8]_i_1__0_n_5 ,\dummy_counter_reg[8]_i_1__0_n_6 ,\dummy_counter_reg[8]_i_1__0_n_7 }),
        .S(dummy_counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \dummy_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\dummy_counter_reg[0]_1 ),
        .D(\dummy_counter_reg[8]_i_1__0_n_6 ),
        .Q(dummy_counter_reg[9]),
        .R(\dummy_counter_reg[0]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    strb_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_reg_0),
        .Q(adc_strb_2),
        .R(SR));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry__0_i_10
       (.CI(t_counter4_carry__0_i_14_n_0),
        .CO({NLW_t_counter4_carry__0_i_10_CO_UNCONNECTED[3:2],t_counter4_carry__0_i_10_n_2,t_counter4_carry__0_i_10_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_t_counter4_carry__0_i_10_O_UNCONNECTED[3],\d_out_reg[19]_0 [13:11]}),
        .S({1'b0,t_counter4_carry__0_i_26_n_0,t_counter4_carry__0_i_27_n_0,t_counter4_carry__0_i_28_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_13
       (.I0(\d_out_reg[19]_0 [11]),
        .I1(Q[15]),
        .I2(Q[13]),
        .O(t_counter4_carry__0_i_13_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry__0_i_14
       (.CI(t_counter4_carry_i_11_n_0),
        .CO({t_counter4_carry__0_i_14_n_0,t_counter4_carry__0_i_14_n_1,t_counter4_carry__0_i_14_n_2,t_counter4_carry__0_i_14_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[19]_0 [10:7]),
        .S({t_counter4_carry__0_i_29_n_0,t_counter4_carry__0_i_30_n_0,t_counter4_carry__0_i_31_n_0,t_counter4_carry__0_i_32_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_17
       (.I0(\d_out_reg[19]_0 [9]),
        .I1(Q[15]),
        .I2(Q[11]),
        .O(t_counter4_carry__0_i_17_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry__0_i_2
       (.I0(t_counter4_carry__0),
        .I1(t_counter4_carry__0_i_13_n_0),
        .I2(Q[12]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [10]),
        .I5(t_counter4_carry__0_0),
        .O(\d_out_reg[16]_0 [2]));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_20
       (.I0(\d_out_reg[19]_0 [7]),
        .I1(Q[15]),
        .I2(Q[9]),
        .O(t_counter4_carry__0_i_20_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_26
       (.I0(Q[15]),
        .O(t_counter4_carry__0_i_26_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_27
       (.I0(Q[14]),
        .O(t_counter4_carry__0_i_27_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_28
       (.I0(Q[13]),
        .O(t_counter4_carry__0_i_28_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_29
       (.I0(Q[12]),
        .O(t_counter4_carry__0_i_29_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry__0_i_3
       (.I0(t_counter4_carry__0_1),
        .I1(t_counter4_carry__0_i_17_n_0),
        .I2(Q[10]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [8]),
        .I5(t_counter4_carry__0_2),
        .O(\d_out_reg[16]_0 [1]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_30
       (.I0(Q[11]),
        .O(t_counter4_carry__0_i_30_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_31
       (.I0(Q[10]),
        .O(t_counter4_carry__0_i_31_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_32
       (.I0(Q[9]),
        .O(t_counter4_carry__0_i_32_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry__0_i_4
       (.I0(t_counter4_carry__0_3),
        .I1(t_counter4_carry__0_i_20_n_0),
        .I2(Q[8]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [6]),
        .I5(t_counter4_carry__0_4),
        .O(\d_out_reg[16]_0 [0]));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry_i_1
       (.I0(t_counter4_carry),
        .I1(t_counter4_carry_i_10_n_0),
        .I2(Q[6]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [4]),
        .I5(t_counter4_carry_0),
        .O(DI[3]));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_10
       (.I0(\d_out_reg[19]_0 [5]),
        .I1(Q[15]),
        .I2(Q[7]),
        .O(t_counter4_carry_i_10_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry_i_11
       (.CI(t_counter4_carry_i_15_n_0),
        .CO({t_counter4_carry_i_11_n_0,t_counter4_carry_i_11_n_1,t_counter4_carry_i_11_n_2,t_counter4_carry_i_11_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\d_out_reg[19]_0 [6:3]),
        .S({t_counter4_carry_i_25_n_0,t_counter4_carry_i_26_n_0,t_counter4_carry_i_27_n_0,t_counter4_carry_i_28_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_14
       (.I0(\d_out_reg[19]_0 [3]),
        .I1(Q[15]),
        .I2(Q[5]),
        .O(t_counter4_carry_i_14_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry_i_15
       (.CI(1'b0),
        .CO({t_counter4_carry_i_15_n_0,t_counter4_carry_i_15_n_1,t_counter4_carry_i_15_n_2,t_counter4_carry_i_15_n_3}),
        .CYINIT(t_counter4_carry_i_29_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\d_out_reg[19]_0 [2:0],\trigger/out0 }),
        .S({t_counter4_carry_i_30_n_0,t_counter4_carry_i_31_n_0,t_counter4_carry_i_32_n_0,t_counter4_carry_i_33_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_18
       (.I0(\d_out_reg[19]_0 [1]),
        .I1(Q[15]),
        .I2(Q[3]),
        .O(t_counter4_carry_i_18_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry_i_2
       (.I0(t_counter4_carry_1),
        .I1(t_counter4_carry_i_14_n_0),
        .I2(Q[4]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [2]),
        .I5(t_counter4_carry_2),
        .O(DI[2]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_25
       (.I0(Q[8]),
        .O(t_counter4_carry_i_25_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_26
       (.I0(Q[7]),
        .O(t_counter4_carry_i_26_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_27
       (.I0(Q[6]),
        .O(t_counter4_carry_i_27_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_28
       (.I0(Q[5]),
        .O(t_counter4_carry_i_28_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_29
       (.I0(Q[0]),
        .O(t_counter4_carry_i_29_n_0));
  LUT6 #(
    .INIT(64'h44444444DDD444D4)) 
    t_counter4_carry_i_3
       (.I0(t_counter4_carry_3),
        .I1(t_counter4_carry_i_18_n_0),
        .I2(Q[2]),
        .I3(Q[15]),
        .I4(\d_out_reg[19]_0 [0]),
        .I5(t_counter4_carry_4),
        .O(DI[1]));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_30
       (.I0(Q[4]),
        .O(t_counter4_carry_i_30_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_31
       (.I0(Q[3]),
        .O(t_counter4_carry_i_31_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_32
       (.I0(Q[2]),
        .O(t_counter4_carry_i_32_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_33
       (.I0(Q[1]),
        .O(t_counter4_carry_i_33_n_0));
  LUT6 #(
    .INIT(64'h54045404FD5D5404)) 
    t_counter4_carry_i_4
       (.I0(t_counter4_carry_5),
        .I1(Q[1]),
        .I2(Q[15]),
        .I3(\trigger/out0 ),
        .I4(Q[0]),
        .I5(t_counter4_carry_6),
        .O(DI[0]));
  LUT6 #(
    .INIT(64'h9099900009000999)) 
    t_counter4_carry_i_8
       (.I0(Q[0]),
        .I1(t_counter4_carry_6),
        .I2(\trigger/out0 ),
        .I3(Q[15]),
        .I4(Q[1]),
        .I5(t_counter4_carry_5),
        .O(S));
endmodule

module fx3s_interface
   (DO,
    fifo_rst_internal,
    rx_empty,
    rst_9d_reg_0,
    A_OBUF,
    SLCS_OBUF,
    SLWR_OBUF,
    SLRD_OBUF,
    SLOE_OBUF,
    PKTEND_OBUF,
    rst_d,
    rst_3d,
    rst_6d,
    \DQ_TRI[0] ,
    rst_internal,
    E,
    rst_3d_reg_0,
    rst_3d_reg_1,
    SR,
    LED_RED_n_OBUF,
    ifclk_out_OBUF_BUFG,
    DI,
    \prefix_reg[15] ,
    rst,
    rst_2d,
    rst_4d,
    rst_7d,
    \d_out_reg[19] ,
    \dummy_counter_reg[0] ,
    \dummy_counter_reg[0]_0 ,
    FLAGB_IBUF,
    FLAGA_IBUF,
    LED_GREEN_3_OBUF,
    rx_oe,
    LED_BLUE_OBUF);
  output [15:0]DO;
  output fifo_rst_internal;
  output rx_empty;
  output [15:0]rst_9d_reg_0;
  output [0:0]A_OBUF;
  output SLCS_OBUF;
  output SLWR_OBUF;
  output SLRD_OBUF;
  output SLOE_OBUF;
  output PKTEND_OBUF;
  output rst_d;
  output rst_3d;
  output rst_6d;
  output \DQ_TRI[0] ;
  output rst_internal;
  output [0:0]E;
  output rst_3d_reg_0;
  output rst_3d_reg_1;
  output [0:0]SR;
  output LED_RED_n_OBUF;
  input ifclk_out_OBUF_BUFG;
  input [16:0]DI;
  input [15:0]\prefix_reg[15] ;
  input rst;
  input rst_2d;
  input rst_4d;
  input rst_7d;
  input \d_out_reg[19] ;
  input \dummy_counter_reg[0] ;
  input \dummy_counter_reg[0]_0 ;
  input FLAGB_IBUF;
  input FLAGA_IBUF;
  input LED_GREEN_3_OBUF;
  input rx_oe;
  input LED_BLUE_OBUF;

  wire A0_i_1_n_0;
  wire A0_i_2_n_0;
  wire A0_i_3_n_0;
  wire A0_i_4_n_0;
  wire A0_i_5_n_0;
  wire [0:0]A_OBUF;
  wire [16:0]DI;
  wire [15:0]DO;
  wire \DQ_TRI[0] ;
  wire [0:0]E;
  wire FLAGA_IBUF;
  wire FLAGB_IBUF;
  wire LED_BLUE_OBUF;
  wire LED_GREEN_3_OBUF;
  wire LED_RED_n_OBUF;
  wire PKTEND_OBUF;
  wire PKTEND_i_1_n_0;
  wire PKTEND_i_2_n_0;
  wire SLCS_OBUF;
  wire SLCS_i_1_n_0;
  wire SLCS_i_2_n_0;
  wire SLCS_i_3_n_0;
  wire SLCS_i_4_n_0;
  wire SLOE_OBUF;
  wire SLOE_i_1_n_0;
  wire SLOE_i_2_n_0;
  wire SLRD_OBUF;
  wire SLRD_i_1_n_0;
  wire SLRD_i_2_n_0;
  wire SLWR_OBUF;
  wire SLWR_i_1_n_0;
  wire SLWR_i_2_n_0;
  wire SLWR_i_3_n_0;
  wire [0:0]SR;
  wire \d_out_reg[19] ;
  wire \dummy_counter_reg[0] ;
  wire \dummy_counter_reg[0]_0 ;
  wire fifo_rst_internal;
  wire \h_counter[0]_i_4_n_0 ;
  wire \h_counter[0]_i_5_n_0 ;
  wire ifclk_out_OBUF_BUFG;
  wire is_outgoing_i_1_n_0;
  wire is_outgoing_i_2_n_0;
  wire is_outgoing_i_3_n_0;
  wire is_outgoing_i_4_n_0;
  wire is_outgoing_i_5_n_0;
  wire [3:0]master_state;
  wire \master_state[0]_i_2_n_0 ;
  wire \master_state[1]_i_1_n_0 ;
  wire \master_state[2]_i_1_n_0 ;
  wire \master_state[3]_i_2_n_0 ;
  wire \master_state[3]_i_4_n_0 ;
  wire \master_state[3]_i_5_n_0 ;
  wire \master_state[3]_i_6_n_0 ;
  wire \master_state_reg_n_0_[0] ;
  wire \master_state_reg_n_0_[1] ;
  wire \master_state_reg_n_0_[2] ;
  wire \master_state_reg_n_0_[3] ;
  wire output_strobe_internal;
  wire p_1_in;
  wire p_2_in;
  wire p_3_in;
  wire p_4_in;
  wire pkt_end;
  wire [15:0]\prefix_reg[15] ;
  wire rst;
  wire rst_2d;
  wire rst_3d;
  wire rst_3d_reg_0;
  wire rst_3d_reg_1;
  wire rst_4d;
  wire rst_5d;
  wire rst_6d;
  wire rst_7d;
  wire rst_8d;
  wire rst_9d;
  wire [15:0]rst_9d_reg_0;
  wire rst_d;
  wire rst_internal;
  wire rst_internal_0;
  wire rx_empty;
  wire rx_full;
  wire rx_oe;
  wire rx_wr_en;
  wire rx_wr_en_i_1_n_0;
  wire rx_wr_en_internal;
  wire sending_i_1_n_0;
  wire sending_i_2_n_0;
  wire sending_i_3_n_0;
  wire sending_reg_n_0;
  wire \trigged_d_reg_n_0_[0] ;
  wire \trigged_d_reg_n_0_[5] ;
  wire tx_empty;
  wire tx_full;
  wire tx_rd_en;
  wire tx_rd_en_i_1_n_0;
  wire tx_rd_en_i_2_n_0;
  wire tx_rd_en_i_3_n_0;
  wire tx_rd_en_i_4_n_0;
  wire tx_rd_en_i_5_n_0;
  wire tx_rd_en_i_6_n_0;
  wire tx_wr_en;
  wire NLW_fifo_arrival_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_fifo_arrival_DBITERR_UNCONNECTED;
  wire NLW_fifo_arrival_FULL_UNCONNECTED;
  wire NLW_fifo_arrival_RDERR_UNCONNECTED;
  wire NLW_fifo_arrival_SBITERR_UNCONNECTED;
  wire NLW_fifo_arrival_WRERR_UNCONNECTED;
  wire [63:16]NLW_fifo_arrival_DI_UNCONNECTED;
  wire [63:16]NLW_fifo_arrival_DO_UNCONNECTED;
  wire [7:0]NLW_fifo_arrival_DOP_UNCONNECTED;
  wire [7:0]NLW_fifo_arrival_ECCPARITY_UNCONNECTED;
  wire [12:0]NLW_fifo_arrival_RDCOUNT_UNCONNECTED;
  wire [12:0]NLW_fifo_arrival_WRCOUNT_UNCONNECTED;
  wire NLW_fifo_departure_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_fifo_departure_DBITERR_UNCONNECTED;
  wire NLW_fifo_departure_FULL_UNCONNECTED;
  wire NLW_fifo_departure_RDERR_UNCONNECTED;
  wire NLW_fifo_departure_SBITERR_UNCONNECTED;
  wire NLW_fifo_departure_WRERR_UNCONNECTED;
  wire [63:17]NLW_fifo_departure_DI_UNCONNECTED;
  wire [63:17]NLW_fifo_departure_DO_UNCONNECTED;
  wire [7:0]NLW_fifo_departure_DOP_UNCONNECTED;
  wire [7:0]NLW_fifo_departure_ECCPARITY_UNCONNECTED;
  wire [12:0]NLW_fifo_departure_RDCOUNT_UNCONNECTED;
  wire [12:0]NLW_fifo_departure_WRCOUNT_UNCONNECTED;

  LUT6 #(
    .INIT(64'h0001000100010000)) 
    A0_i_1
       (.I0(\master_state_reg_n_0_[1] ),
        .I1(\master_state_reg_n_0_[0] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state_reg_n_0_[2] ),
        .I4(A0_i_3_n_0),
        .I5(A0_i_4_n_0),
        .O(A0_i_1_n_0));
  LUT5 #(
    .INIT(32'hF200F2F2)) 
    A0_i_2
       (.I0(FLAGB_IBUF),
        .I1(tx_empty),
        .I2(A0_i_5_n_0),
        .I3(rx_full),
        .I4(FLAGA_IBUF),
        .O(A0_i_2_n_0));
  LUT3 #(
    .INIT(8'hBA)) 
    A0_i_3
       (.I0(A0_i_5_n_0),
        .I1(tx_empty),
        .I2(FLAGB_IBUF),
        .O(A0_i_3_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    A0_i_4
       (.I0(FLAGA_IBUF),
        .I1(rx_full),
        .O(A0_i_4_n_0));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    A0_i_5
       (.I0(sending_reg_n_0),
        .I1(tx_empty),
        .I2(LED_GREEN_3_OBUF),
        .I3(p_3_in),
        .I4(\trigged_d_reg_n_0_[5] ),
        .I5(\master_state[3]_i_5_n_0 ),
        .O(A0_i_5_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    A0_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(A0_i_1_n_0),
        .D(A0_i_2_n_0),
        .Q(A_OBUF),
        .R(rst_internal_0));
  LUT1 #(
    .INIT(2'h1)) 
    LED_RED_n_OBUF_inst_i_1
       (.I0(tx_full),
        .O(LED_RED_n_OBUF));
  LUT5 #(
    .INIT(32'hFFA0000E)) 
    PKTEND_i_1
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(A0_i_2_n_0),
        .I2(\master_state_reg_n_0_[1] ),
        .I3(\master_state_reg_n_0_[2] ),
        .I4(\master_state_reg_n_0_[3] ),
        .O(PKTEND_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'hFFF1)) 
    PKTEND_i_2
       (.I0(A0_i_5_n_0),
        .I1(pkt_end),
        .I2(\master_state_reg_n_0_[0] ),
        .I3(\master_state_reg_n_0_[2] ),
        .O(PKTEND_i_2_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    PKTEND_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(PKTEND_i_1_n_0),
        .D(PKTEND_i_2_n_0),
        .Q(PKTEND_OBUF),
        .S(rst_internal_0));
  LUT5 #(
    .INIT(32'hF1F1C0C1)) 
    SLCS_i_1
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(\master_state_reg_n_0_[1] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state[3]_i_4_n_0 ),
        .I4(\master_state_reg_n_0_[2] ),
        .O(SLCS_i_1_n_0));
  LUT6 #(
    .INIT(64'h40404555FFFFFFFF)) 
    SLCS_i_2
       (.I0(A0_i_4_n_0),
        .I1(SLCS_i_3_n_0),
        .I2(tx_empty),
        .I3(sending_reg_n_0),
        .I4(FLAGB_IBUF),
        .I5(SLCS_i_4_n_0),
        .O(SLCS_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    SLCS_i_3
       (.I0(LED_GREEN_3_OBUF),
        .I1(p_3_in),
        .I2(\trigged_d_reg_n_0_[5] ),
        .I3(\master_state[3]_i_5_n_0 ),
        .O(SLCS_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h1)) 
    SLCS_i_4
       (.I0(\master_state_reg_n_0_[1] ),
        .I1(\master_state_reg_n_0_[2] ),
        .O(SLCS_i_4_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    SLCS_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(SLCS_i_1_n_0),
        .D(SLCS_i_2_n_0),
        .Q(SLCS_OBUF),
        .S(rst_internal_0));
  LUT6 #(
    .INIT(64'hFF00FF00FF00000E)) 
    SLOE_i_1
       (.I0(A0_i_4_n_0),
        .I1(A0_i_3_n_0),
        .I2(\master_state_reg_n_0_[0] ),
        .I3(\master_state_reg_n_0_[3] ),
        .I4(\master_state_reg_n_0_[1] ),
        .I5(\master_state_reg_n_0_[2] ),
        .O(SLOE_i_1_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    SLOE_i_2
       (.I0(A0_i_2_n_0),
        .I1(\master_state_reg_n_0_[2] ),
        .I2(\master_state_reg_n_0_[1] ),
        .O(SLOE_i_2_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    SLOE_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(SLOE_i_1_n_0),
        .D(SLOE_i_2_n_0),
        .Q(SLOE_OBUF),
        .S(rst_internal_0));
  LUT4 #(
    .INIT(16'hACC8)) 
    SLRD_i_1
       (.I0(\master_state_reg_n_0_[3] ),
        .I1(\master_state_reg_n_0_[2] ),
        .I2(\master_state_reg_n_0_[1] ),
        .I3(\master_state_reg_n_0_[0] ),
        .O(SLRD_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    SLRD_i_2
       (.I0(\master_state_reg_n_0_[3] ),
        .I1(\master_state_reg_n_0_[1] ),
        .O(SLRD_i_2_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    SLRD_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(SLRD_i_1_n_0),
        .D(SLRD_i_2_n_0),
        .Q(SLRD_OBUF),
        .S(rst_internal_0));
  LUT5 #(
    .INIT(32'hFFA0000B)) 
    SLWR_i_1
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(\master_state[3]_i_4_n_0 ),
        .I2(\master_state_reg_n_0_[1] ),
        .I3(\master_state_reg_n_0_[2] ),
        .I4(\master_state_reg_n_0_[3] ),
        .O(SLWR_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFCFEFCFFFFFFFFF)) 
    SLWR_i_2
       (.I0(sending_reg_n_0),
        .I1(A0_i_4_n_0),
        .I2(SLWR_i_3_n_0),
        .I3(tx_empty),
        .I4(SLCS_i_3_n_0),
        .I5(FLAGB_IBUF),
        .O(SLWR_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h1)) 
    SLWR_i_3
       (.I0(\master_state_reg_n_0_[2] ),
        .I1(\master_state_reg_n_0_[0] ),
        .O(SLWR_i_3_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    SLWR_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(SLWR_i_1_n_0),
        .D(SLWR_i_2_n_0),
        .Q(SLWR_OBUF),
        .S(rst_internal_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \counter_q[5]_i_1 
       (.I0(rst),
        .I1(rst_2d),
        .I2(rst_d),
        .I3(rst_3d),
        .O(SR));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    \d_out[19]_i_1 
       (.I0(\d_out_reg[19] ),
        .I1(rst_3d),
        .I2(rst_d),
        .I3(rst_2d),
        .I4(rst),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \dummy_counter[0]_i_1__0 
       (.I0(rst_3d),
        .I1(rst_d),
        .I2(rst_2d),
        .I3(rst),
        .I4(\dummy_counter_reg[0] ),
        .O(rst_3d_reg_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \dummy_counter[0]_i_1__2 
       (.I0(rst_3d),
        .I1(rst_d),
        .I2(rst_2d),
        .I3(rst),
        .I4(\dummy_counter_reg[0]_0 ),
        .O(rst_3d_reg_1));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FIFO36E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0080),
    .ALMOST_FULL_OFFSET(13'h0014),
    .DATA_WIDTH(18),
    .DO_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO36"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(72'h000000000000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(72'h000000000000000000)) 
    fifo_arrival
       (.ALMOSTEMPTY(NLW_fifo_arrival_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(rx_full),
        .DBITERR(NLW_fifo_arrival_DBITERR_UNCONNECTED),
        .DI({NLW_fifo_arrival_DI_UNCONNECTED[63:16],\prefix_reg[15] }),
        .DIP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_fifo_arrival_DO_UNCONNECTED[63:16],rst_9d_reg_0}),
        .DOP(NLW_fifo_arrival_DOP_UNCONNECTED[7:0]),
        .ECCPARITY(NLW_fifo_arrival_ECCPARITY_UNCONNECTED[7:0]),
        .EMPTY(rx_empty),
        .FULL(NLW_fifo_arrival_FULL_UNCONNECTED),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDCLK(ifclk_out_OBUF_BUFG),
        .RDCOUNT(NLW_fifo_arrival_RDCOUNT_UNCONNECTED[12:0]),
        .RDEN(output_strobe_internal),
        .RDERR(NLW_fifo_arrival_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(fifo_rst_internal),
        .RSTREG(1'b0),
        .SBITERR(NLW_fifo_arrival_SBITERR_UNCONNECTED),
        .WRCLK(ifclk_out_OBUF_BUFG),
        .WRCOUNT(NLW_fifo_arrival_WRCOUNT_UNCONNECTED[12:0]),
        .WREN(rx_wr_en_internal),
        .WRERR(NLW_fifo_arrival_WRERR_UNCONNECTED));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'h10)) 
    fifo_arrival_i_1
       (.I0(rst_9d),
        .I1(rst_internal),
        .I2(rx_oe),
        .O(output_strobe_internal));
  LUT2 #(
    .INIT(4'h8)) 
    fifo_arrival_i_2
       (.I0(FLAGA_IBUF),
        .I1(rx_wr_en),
        .O(rx_wr_en_internal));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FIFO36E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0080),
    .ALMOST_FULL_OFFSET(13'h0014),
    .DATA_WIDTH(36),
    .DO_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO36"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(72'h000000000000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(72'h000000000000000000)) 
    fifo_departure
       (.ALMOSTEMPTY(NLW_fifo_departure_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(tx_full),
        .DBITERR(NLW_fifo_departure_DBITERR_UNCONNECTED),
        .DI({NLW_fifo_departure_DI_UNCONNECTED[63:17],DI}),
        .DIP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO({NLW_fifo_departure_DO_UNCONNECTED[63:17],pkt_end,DO}),
        .DOP(NLW_fifo_departure_DOP_UNCONNECTED[7:0]),
        .ECCPARITY(NLW_fifo_departure_ECCPARITY_UNCONNECTED[7:0]),
        .EMPTY(tx_empty),
        .FULL(NLW_fifo_departure_FULL_UNCONNECTED),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDCLK(ifclk_out_OBUF_BUFG),
        .RDCOUNT(NLW_fifo_departure_RDCOUNT_UNCONNECTED[12:0]),
        .RDEN(tx_rd_en),
        .RDERR(NLW_fifo_departure_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(fifo_rst_internal),
        .RSTREG(1'b0),
        .SBITERR(NLW_fifo_departure_SBITERR_UNCONNECTED),
        .WRCLK(ifclk_out_OBUF_BUFG),
        .WRCOUNT(NLW_fifo_departure_WRCOUNT_UNCONNECTED[12:0]),
        .WREN(tx_wr_en),
        .WRERR(NLW_fifo_departure_WRERR_UNCONNECTED));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    fifo_departure_i_1
       (.I0(rst_3d),
        .I1(rst_d),
        .I2(rst_2d),
        .I3(rst),
        .I4(rst_4d),
        .I5(rst_5d),
        .O(fifo_rst_internal));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'h10)) 
    fifo_departure_i_2
       (.I0(rst_9d),
        .I1(rst_internal),
        .I2(LED_BLUE_OBUF),
        .O(tx_wr_en));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \h_counter[0]_i_1 
       (.I0(rst_5d),
        .I1(rst_4d),
        .I2(rst),
        .I3(\h_counter[0]_i_4_n_0 ),
        .I4(\h_counter[0]_i_5_n_0 ),
        .O(rst_internal));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \h_counter[0]_i_4 
       (.I0(rst_3d),
        .I1(rst_d),
        .I2(rst_2d),
        .O(\h_counter[0]_i_4_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \h_counter[0]_i_5 
       (.I0(rst_8d),
        .I1(rst_6d),
        .I2(rst_7d),
        .O(\h_counter[0]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    is_outgoing_i_1
       (.I0(is_outgoing_i_2_n_0),
        .O(is_outgoing_i_1_n_0));
  LUT6 #(
    .INIT(64'h020202FF02020200)) 
    is_outgoing_i_2
       (.I0(A0_i_2_n_0),
        .I1(\master_state_reg_n_0_[2] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(is_outgoing_i_3_n_0),
        .I4(is_outgoing_i_4_n_0),
        .I5(is_outgoing_i_5_n_0),
        .O(is_outgoing_i_2_n_0));
  LUT5 #(
    .INIT(32'h11110001)) 
    is_outgoing_i_3
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(\master_state_reg_n_0_[1] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state[3]_i_4_n_0 ),
        .I4(\master_state_reg_n_0_[2] ),
        .O(is_outgoing_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'hE0A0)) 
    is_outgoing_i_4
       (.I0(\master_state_reg_n_0_[2] ),
        .I1(\master_state_reg_n_0_[1] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state_reg_n_0_[0] ),
        .O(is_outgoing_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    is_outgoing_i_5
       (.I0(\DQ_TRI[0] ),
        .O(is_outgoing_i_5_n_0));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    is_outgoing_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(is_outgoing_i_1_n_0),
        .Q(\DQ_TRI[0] ),
        .S(rst_internal_0));
  LUT5 #(
    .INIT(32'h000005A3)) 
    \master_state[0]_i_1 
       (.I0(\master_state_reg_n_0_[1] ),
        .I1(\master_state[0]_i_2_n_0 ),
        .I2(\master_state_reg_n_0_[2] ),
        .I3(\master_state_reg_n_0_[3] ),
        .I4(\master_state_reg_n_0_[0] ),
        .O(master_state[0]));
  LUT6 #(
    .INIT(64'h0011000100110011)) 
    \master_state[0]_i_2 
       (.I0(A0_i_4_n_0),
        .I1(\master_state_reg_n_0_[1] ),
        .I2(pkt_end),
        .I3(A0_i_5_n_0),
        .I4(tx_empty),
        .I5(FLAGB_IBUF),
        .O(\master_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'h0570)) 
    \master_state[1]_i_1 
       (.I0(\master_state_reg_n_0_[3] ),
        .I1(\master_state_reg_n_0_[2] ),
        .I2(\master_state_reg_n_0_[0] ),
        .I3(\master_state_reg_n_0_[1] ),
        .O(\master_state[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1440144014411440)) 
    \master_state[2]_i_1 
       (.I0(\master_state_reg_n_0_[3] ),
        .I1(\master_state_reg_n_0_[0] ),
        .I2(\master_state_reg_n_0_[1] ),
        .I3(\master_state_reg_n_0_[2] ),
        .I4(FLAGA_IBUF),
        .I5(rx_full),
        .O(\master_state[2]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \master_state[3]_i_1 
       (.I0(rst_9d),
        .I1(rst_internal),
        .O(rst_internal_0));
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \master_state[3]_i_2 
       (.I0(\master_state_reg_n_0_[1] ),
        .I1(\master_state_reg_n_0_[0] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state_reg_n_0_[2] ),
        .I4(\master_state[3]_i_4_n_0 ),
        .O(\master_state[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'h200C)) 
    \master_state[3]_i_3 
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(\master_state_reg_n_0_[3] ),
        .I2(\master_state_reg_n_0_[2] ),
        .I3(\master_state_reg_n_0_[1] ),
        .O(master_state[3]));
  LUT6 #(
    .INIT(64'h0000001000000000)) 
    \master_state[3]_i_4 
       (.I0(A0_i_4_n_0),
        .I1(sending_reg_n_0),
        .I2(FLAGB_IBUF),
        .I3(\master_state[3]_i_5_n_0 ),
        .I4(\master_state[3]_i_6_n_0 ),
        .I5(tx_empty),
        .O(\master_state[3]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \master_state[3]_i_5 
       (.I0(p_2_in),
        .I1(p_4_in),
        .I2(p_1_in),
        .I3(\trigged_d_reg_n_0_[0] ),
        .O(\master_state[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    \master_state[3]_i_6 
       (.I0(\trigged_d_reg_n_0_[5] ),
        .I1(p_3_in),
        .I2(LED_GREEN_3_OBUF),
        .O(\master_state[3]_i_6_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \master_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\master_state[3]_i_2_n_0 ),
        .D(master_state[0]),
        .Q(\master_state_reg_n_0_[0] ),
        .R(rst_internal_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \master_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\master_state[3]_i_2_n_0 ),
        .D(\master_state[1]_i_1_n_0 ),
        .Q(\master_state_reg_n_0_[1] ),
        .R(rst_internal_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \master_state_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\master_state[3]_i_2_n_0 ),
        .D(\master_state[2]_i_1_n_0 ),
        .Q(\master_state_reg_n_0_[2] ),
        .R(rst_internal_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \master_state_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\master_state[3]_i_2_n_0 ),
        .D(master_state[3]),
        .Q(\master_state_reg_n_0_[3] ),
        .R(rst_internal_0));
  FDRE #(
    .INIT(1'b1)) 
    rst_3d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_2d),
        .Q(rst_3d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_5d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_4d),
        .Q(rst_5d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_6d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_5d),
        .Q(rst_6d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_8d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_7d),
        .Q(rst_8d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_9d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_8d),
        .Q(rst_9d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst),
        .Q(rst_d),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'h1F4F0800)) 
    rx_wr_en_i_1
       (.I0(\master_state_reg_n_0_[2] ),
        .I1(\master_state_reg_n_0_[0] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(\master_state_reg_n_0_[1] ),
        .I4(rx_wr_en),
        .O(rx_wr_en_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    rx_wr_en_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rx_wr_en_i_1_n_0),
        .Q(rx_wr_en),
        .R(rst_internal_0));
  LUT6 #(
    .INIT(64'hFFFF02FF00000200)) 
    sending_i_1
       (.I0(sending_i_2_n_0),
        .I1(\master_state_reg_n_0_[0] ),
        .I2(\master_state_reg_n_0_[3] ),
        .I3(PKTEND_i_2_n_0),
        .I4(sending_i_3_n_0),
        .I5(sending_reg_n_0),
        .O(sending_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    sending_i_2
       (.I0(FLAGB_IBUF),
        .I1(tx_empty),
        .O(sending_i_2_n_0));
  LUT6 #(
    .INIT(64'h55555A5A5555FEFF)) 
    sending_i_3
       (.I0(\master_state_reg_n_0_[3] ),
        .I1(A0_i_4_n_0),
        .I2(\master_state_reg_n_0_[1] ),
        .I3(sending_i_2_n_0),
        .I4(\master_state_reg_n_0_[2] ),
        .I5(\master_state_reg_n_0_[0] ),
        .O(sending_i_3_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    sending_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sending_i_1_n_0),
        .Q(sending_reg_n_0),
        .R(rst_internal_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(LED_GREEN_3_OBUF),
        .Q(\trigged_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\trigged_d_reg_n_0_[0] ),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in),
        .Q(p_2_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_2_in),
        .Q(p_3_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_3_in),
        .Q(p_4_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigged_d_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_4_in),
        .Q(\trigged_d_reg_n_0_[5] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hABBBA888)) 
    tx_rd_en_i_1
       (.I0(tx_rd_en_i_2_n_0),
        .I1(tx_rd_en_i_3_n_0),
        .I2(tx_rd_en_i_4_n_0),
        .I3(A0_i_4_n_0),
        .I4(tx_rd_en),
        .O(tx_rd_en_i_1_n_0));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    tx_rd_en_i_2
       (.I0(FLAGB_IBUF),
        .I1(tx_empty),
        .I2(tx_rd_en_i_5_n_0),
        .I3(\master_state_reg_n_0_[0] ),
        .I4(\master_state_reg_n_0_[3] ),
        .I5(\master_state_reg_n_0_[2] ),
        .O(tx_rd_en_i_2_n_0));
  LUT6 #(
    .INIT(64'hFFFFAA00000000AE)) 
    tx_rd_en_i_3
       (.I0(\master_state_reg_n_0_[0] ),
        .I1(tx_rd_en_i_6_n_0),
        .I2(A0_i_4_n_0),
        .I3(\master_state_reg_n_0_[1] ),
        .I4(\master_state_reg_n_0_[2] ),
        .I5(\master_state_reg_n_0_[3] ),
        .O(tx_rd_en_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    tx_rd_en_i_4
       (.I0(\master_state_reg_n_0_[2] ),
        .I1(\master_state_reg_n_0_[3] ),
        .I2(\master_state_reg_n_0_[0] ),
        .I3(\master_state_reg_n_0_[1] ),
        .O(tx_rd_en_i_4_n_0));
  LUT3 #(
    .INIT(8'h45)) 
    tx_rd_en_i_5
       (.I0(\master_state_reg_n_0_[1] ),
        .I1(rx_full),
        .I2(FLAGA_IBUF),
        .O(tx_rd_en_i_5_n_0));
  LUT5 #(
    .INIT(32'hFFFFFDFF)) 
    tx_rd_en_i_6
       (.I0(tx_empty),
        .I1(\master_state[3]_i_6_n_0 ),
        .I2(\master_state[3]_i_5_n_0 ),
        .I3(FLAGB_IBUF),
        .I4(sending_reg_n_0),
        .O(tx_rd_en_i_6_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    tx_rd_en_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(tx_rd_en_i_1_n_0),
        .Q(tx_rd_en),
        .R(rst_internal_0));
endmodule

module hydrophone_config_manager
   (rx_oe,
    poten_update_start,
    t_counter0,
    Q,
    S,
    \trigger_level_reg[15]_0 ,
    \d_out_reg[19] ,
    \d_out_reg[19]_0 ,
    \d_out_reg[19]_1 ,
    \trigger_level_reg[15]_1 ,
    \trigger_level_reg[15]_2 ,
    \trigger_level_reg[15]_3 ,
    \trigger_level_reg[15]_4 ,
    \trigger_level_reg[15]_5 ,
    \trigger_level_reg[15]_6 ,
    DI,
    \d_out_reg[19]_2 ,
    \d_out_reg[19]_3 ,
    \d_out_reg[19]_4 ,
    \d_out_reg[19]_5 ,
    \d_out_reg[19]_6 ,
    \d_out_reg[19]_7 ,
    \d_out_reg[19]_8 ,
    \trigger_level_reg[15]_7 ,
    \trigger_level_reg[15]_8 ,
    \trigger_level_reg[15]_9 ,
    \trigger_level_reg[15]_10 ,
    \trigger_level_reg[15]_11 ,
    \trigger_level_reg[15]_12 ,
    D,
    \poten1_value_reg[7]_0 ,
    rst,
    ifclk_out_OBUF_BUFG,
    rx_empty,
    FUNC_EN_IBUF,
    CO,
    trigged_reg,
    trigged_reg_0,
    trigged_reg_1,
    t_counter4_carry__0,
    t_counter4_carry__0_i_8_0,
    \t_counter4_inferred__0/i__carry__0 ,
    i__carry__0_i_8_0,
    t_counter2_carry__0,
    t_counter2_carry__0_i_8_0,
    t_counter3_carry__0,
    t_counter3_carry__0_i_8_0,
    O,
    t_counter2_carry,
    t_counter3_carry,
    t_counter3_carry__0_0,
    t_counter2_carry__0_0,
    \t_counter4_inferred__0/i__carry__0_0 ,
    \t_counter4_inferred__0/i__carry__0_1 ,
    t_counter2_carry__0_1,
    t_counter3_carry__0_1,
    sub_state__0,
    \prefix_reg[15]_0 );
  output rx_oe;
  output poten_update_start;
  output t_counter0;
  output [0:0]Q;
  output [2:0]S;
  output \trigger_level_reg[15]_0 ;
  output [2:0]\d_out_reg[19] ;
  output [2:0]\d_out_reg[19]_0 ;
  output [2:0]\d_out_reg[19]_1 ;
  output \trigger_level_reg[15]_1 ;
  output \trigger_level_reg[15]_2 ;
  output \trigger_level_reg[15]_3 ;
  output \trigger_level_reg[15]_4 ;
  output \trigger_level_reg[15]_5 ;
  output \trigger_level_reg[15]_6 ;
  output [0:0]DI;
  output [3:0]\d_out_reg[19]_2 ;
  output [0:0]\d_out_reg[19]_3 ;
  output [3:0]\d_out_reg[19]_4 ;
  output [0:0]\d_out_reg[19]_5 ;
  output [3:0]\d_out_reg[19]_6 ;
  output [0:0]\d_out_reg[19]_7 ;
  output [3:0]\d_out_reg[19]_8 ;
  output \trigger_level_reg[15]_7 ;
  output \trigger_level_reg[15]_8 ;
  output \trigger_level_reg[15]_9 ;
  output \trigger_level_reg[15]_10 ;
  output \trigger_level_reg[15]_11 ;
  output \trigger_level_reg[15]_12 ;
  output [0:0]D;
  output [6:0]\poten1_value_reg[7]_0 ;
  input rst;
  input ifclk_out_OBUF_BUFG;
  input rx_empty;
  input FUNC_EN_IBUF;
  input [0:0]CO;
  input [0:0]trigged_reg;
  input [0:0]trigged_reg_0;
  input [0:0]trigged_reg_1;
  input [13:0]t_counter4_carry__0;
  input [13:0]t_counter4_carry__0_i_8_0;
  input [3:0]\t_counter4_inferred__0/i__carry__0 ;
  input [13:0]i__carry__0_i_8_0;
  input [3:0]t_counter2_carry__0;
  input [13:0]t_counter2_carry__0_i_8_0;
  input [3:0]t_counter3_carry__0;
  input [13:0]t_counter3_carry__0_i_8_0;
  input [2:0]O;
  input [2:0]t_counter2_carry;
  input [2:0]t_counter3_carry;
  input [2:0]t_counter3_carry__0_0;
  input [2:0]t_counter2_carry__0_0;
  input [2:0]\t_counter4_inferred__0/i__carry__0_0 ;
  input [3:0]\t_counter4_inferred__0/i__carry__0_1 ;
  input [3:0]t_counter2_carry__0_1;
  input [3:0]t_counter3_carry__0_1;
  input [0:0]sub_state__0;
  input [15:0]\prefix_reg[15]_0 ;

  wire [0:0]CO;
  wire [0:0]D;
  wire [0:0]DI;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[0]_i_3_n_0 ;
  wire \FSM_sequential_state[0]_i_4_n_0 ;
  wire \FSM_sequential_state[0]_i_5_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_3_n_0 ;
  wire \FSM_sequential_state[1]_i_4_n_0 ;
  wire FUNC_EN_IBUF;
  wire [2:0]O;
  wire [0:0]Q;
  wire [2:0]S;
  wire config_d_oe_i_1_n_0;
  wire config_d_oe_i_2_n_0;
  wire \counter[0]_i_3_n_0 ;
  wire [31:0]counter_reg;
  wire \counter_reg[0]_i_2_n_0 ;
  wire \counter_reg[0]_i_2_n_1 ;
  wire \counter_reg[0]_i_2_n_2 ;
  wire \counter_reg[0]_i_2_n_3 ;
  wire \counter_reg[0]_i_2_n_4 ;
  wire \counter_reg[0]_i_2_n_5 ;
  wire \counter_reg[0]_i_2_n_6 ;
  wire \counter_reg[0]_i_2_n_7 ;
  wire \counter_reg[12]_i_1_n_0 ;
  wire \counter_reg[12]_i_1_n_1 ;
  wire \counter_reg[12]_i_1_n_2 ;
  wire \counter_reg[12]_i_1_n_3 ;
  wire \counter_reg[12]_i_1_n_4 ;
  wire \counter_reg[12]_i_1_n_5 ;
  wire \counter_reg[12]_i_1_n_6 ;
  wire \counter_reg[12]_i_1_n_7 ;
  wire \counter_reg[16]_i_1_n_0 ;
  wire \counter_reg[16]_i_1_n_1 ;
  wire \counter_reg[16]_i_1_n_2 ;
  wire \counter_reg[16]_i_1_n_3 ;
  wire \counter_reg[16]_i_1_n_4 ;
  wire \counter_reg[16]_i_1_n_5 ;
  wire \counter_reg[16]_i_1_n_6 ;
  wire \counter_reg[16]_i_1_n_7 ;
  wire \counter_reg[20]_i_1_n_0 ;
  wire \counter_reg[20]_i_1_n_1 ;
  wire \counter_reg[20]_i_1_n_2 ;
  wire \counter_reg[20]_i_1_n_3 ;
  wire \counter_reg[20]_i_1_n_4 ;
  wire \counter_reg[20]_i_1_n_5 ;
  wire \counter_reg[20]_i_1_n_6 ;
  wire \counter_reg[20]_i_1_n_7 ;
  wire \counter_reg[24]_i_1_n_0 ;
  wire \counter_reg[24]_i_1_n_1 ;
  wire \counter_reg[24]_i_1_n_2 ;
  wire \counter_reg[24]_i_1_n_3 ;
  wire \counter_reg[24]_i_1_n_4 ;
  wire \counter_reg[24]_i_1_n_5 ;
  wire \counter_reg[24]_i_1_n_6 ;
  wire \counter_reg[24]_i_1_n_7 ;
  wire \counter_reg[28]_i_1_n_1 ;
  wire \counter_reg[28]_i_1_n_2 ;
  wire \counter_reg[28]_i_1_n_3 ;
  wire \counter_reg[28]_i_1_n_4 ;
  wire \counter_reg[28]_i_1_n_5 ;
  wire \counter_reg[28]_i_1_n_6 ;
  wire \counter_reg[28]_i_1_n_7 ;
  wire \counter_reg[4]_i_1_n_0 ;
  wire \counter_reg[4]_i_1_n_1 ;
  wire \counter_reg[4]_i_1_n_2 ;
  wire \counter_reg[4]_i_1_n_3 ;
  wire \counter_reg[4]_i_1_n_4 ;
  wire \counter_reg[4]_i_1_n_5 ;
  wire \counter_reg[4]_i_1_n_6 ;
  wire \counter_reg[4]_i_1_n_7 ;
  wire \counter_reg[8]_i_1_n_0 ;
  wire \counter_reg[8]_i_1_n_1 ;
  wire \counter_reg[8]_i_1_n_2 ;
  wire \counter_reg[8]_i_1_n_3 ;
  wire \counter_reg[8]_i_1_n_4 ;
  wire \counter_reg[8]_i_1_n_5 ;
  wire \counter_reg[8]_i_1_n_6 ;
  wire \counter_reg[8]_i_1_n_7 ;
  wire [2:0]\d_out_reg[19] ;
  wire [2:0]\d_out_reg[19]_0 ;
  wire [2:0]\d_out_reg[19]_1 ;
  wire [3:0]\d_out_reg[19]_2 ;
  wire [0:0]\d_out_reg[19]_3 ;
  wire [3:0]\d_out_reg[19]_4 ;
  wire [0:0]\d_out_reg[19]_5 ;
  wire [3:0]\d_out_reg[19]_6 ;
  wire [0:0]\d_out_reg[19]_7 ;
  wire [3:0]\d_out_reg[19]_8 ;
  wire i__carry__0_i_14_n_0;
  wire i__carry__0_i_15_n_0;
  wire i__carry__0_i_16_n_0;
  wire [13:0]i__carry__0_i_8_0;
  wire i__carry_i_14_n_0;
  wire i__carry_i_15_n_0;
  wire i__carry_i_16_n_0;
  wire ifclk_out_OBUF_BUFG;
  wire p_0_in;
  wire p_1_in;
  wire [7:0]p_2_in;
  wire [4:4]poten0;
  wire \poten1_value[7]_i_1_n_0 ;
  wire [6:0]\poten1_value_reg[7]_0 ;
  wire poten_update_start;
  wire \prefix[15]_i_1_n_0 ;
  wire [15:0]\prefix_reg[15]_0 ;
  wire rst;
  wire rx_empty;
  wire rx_oe;
  wire sel;
  wire state1;
  wire state1_carry__0_i_1_n_0;
  wire state1_carry__0_i_2_n_0;
  wire state1_carry__0_i_3_n_0;
  wire state1_carry__0_i_4_n_0;
  wire state1_carry__0_i_5_n_0;
  wire state1_carry__0_i_6_n_0;
  wire state1_carry__0_i_7_n_0;
  wire state1_carry__0_i_8_n_0;
  wire state1_carry__0_n_0;
  wire state1_carry__0_n_1;
  wire state1_carry__0_n_2;
  wire state1_carry__0_n_3;
  wire state1_carry__1_i_1_n_0;
  wire state1_carry__1_i_2_n_0;
  wire state1_carry__1_i_3_n_0;
  wire state1_carry__1_i_4_n_0;
  wire state1_carry__1_i_5_n_0;
  wire state1_carry__1_i_6_n_0;
  wire state1_carry__1_i_7_n_0;
  wire state1_carry__1_i_8_n_0;
  wire state1_carry__1_n_0;
  wire state1_carry__1_n_1;
  wire state1_carry__1_n_2;
  wire state1_carry__1_n_3;
  wire state1_carry__2_i_1_n_0;
  wire state1_carry__2_i_2_n_0;
  wire state1_carry__2_i_3_n_0;
  wire state1_carry__2_i_4_n_0;
  wire state1_carry__2_i_5_n_0;
  wire state1_carry__2_i_6_n_0;
  wire state1_carry__2_i_7_n_0;
  wire state1_carry__2_i_8_n_0;
  wire state1_carry__2_n_1;
  wire state1_carry__2_n_2;
  wire state1_carry__2_n_3;
  wire state1_carry_i_1_n_0;
  wire state1_carry_i_2_n_0;
  wire state1_carry_i_3_n_0;
  wire state1_carry_i_4_n_0;
  wire state1_carry_i_5_n_0;
  wire state1_carry_i_6_n_0;
  wire state1_carry_i_7_n_0;
  wire state1_carry_i_8_n_0;
  wire state1_carry_n_0;
  wire state1_carry_n_1;
  wire state1_carry_n_2;
  wire state1_carry_n_3;
  wire [1:0]state__0;
  wire [0:0]sub_state__0;
  wire t_counter0;
  wire [2:0]t_counter2_carry;
  wire [3:0]t_counter2_carry__0;
  wire [2:0]t_counter2_carry__0_0;
  wire [3:0]t_counter2_carry__0_1;
  wire t_counter2_carry__0_i_14_n_0;
  wire t_counter2_carry__0_i_15_n_0;
  wire t_counter2_carry__0_i_16_n_0;
  wire [13:0]t_counter2_carry__0_i_8_0;
  wire t_counter2_carry_i_14_n_0;
  wire t_counter2_carry_i_15_n_0;
  wire t_counter2_carry_i_16_n_0;
  wire [2:0]t_counter3_carry;
  wire [3:0]t_counter3_carry__0;
  wire [2:0]t_counter3_carry__0_0;
  wire [3:0]t_counter3_carry__0_1;
  wire t_counter3_carry__0_i_14_n_0;
  wire t_counter3_carry__0_i_15_n_0;
  wire t_counter3_carry__0_i_16_n_0;
  wire [13:0]t_counter3_carry__0_i_8_0;
  wire t_counter3_carry_i_14_n_0;
  wire t_counter3_carry_i_15_n_0;
  wire t_counter3_carry_i_16_n_0;
  wire [13:0]t_counter4_carry__0;
  wire t_counter4_carry__0_i_11_n_0;
  wire t_counter4_carry__0_i_22_n_0;
  wire t_counter4_carry__0_i_23_n_0;
  wire t_counter4_carry__0_i_24_n_0;
  wire t_counter4_carry__0_i_25_n_2;
  wire t_counter4_carry__0_i_25_n_3;
  wire t_counter4_carry__0_i_25_n_5;
  wire t_counter4_carry__0_i_25_n_6;
  wire t_counter4_carry__0_i_25_n_7;
  wire t_counter4_carry__0_i_33_n_0;
  wire t_counter4_carry__0_i_33_n_1;
  wire t_counter4_carry__0_i_33_n_2;
  wire t_counter4_carry__0_i_33_n_3;
  wire t_counter4_carry__0_i_33_n_4;
  wire t_counter4_carry__0_i_33_n_5;
  wire t_counter4_carry__0_i_33_n_6;
  wire t_counter4_carry__0_i_33_n_7;
  wire t_counter4_carry__0_i_34_n_0;
  wire t_counter4_carry__0_i_35_n_0;
  wire t_counter4_carry__0_i_36_n_0;
  wire t_counter4_carry__0_i_37_n_0;
  wire t_counter4_carry__0_i_38_n_0;
  wire t_counter4_carry__0_i_39_n_0;
  wire t_counter4_carry__0_i_40_n_0;
  wire [13:0]t_counter4_carry__0_i_8_0;
  wire t_counter4_carry__0_i_9_n_0;
  wire t_counter4_carry_i_21_n_0;
  wire t_counter4_carry_i_22_n_0;
  wire t_counter4_carry_i_23_n_0;
  wire t_counter4_carry_i_24_n_0;
  wire t_counter4_carry_i_24_n_1;
  wire t_counter4_carry_i_24_n_2;
  wire t_counter4_carry_i_24_n_3;
  wire t_counter4_carry_i_24_n_4;
  wire t_counter4_carry_i_24_n_5;
  wire t_counter4_carry_i_24_n_6;
  wire t_counter4_carry_i_24_n_7;
  wire t_counter4_carry_i_34_n_0;
  wire t_counter4_carry_i_34_n_1;
  wire t_counter4_carry_i_34_n_2;
  wire t_counter4_carry_i_34_n_3;
  wire t_counter4_carry_i_34_n_4;
  wire t_counter4_carry_i_34_n_5;
  wire t_counter4_carry_i_34_n_6;
  wire t_counter4_carry_i_34_n_7;
  wire t_counter4_carry_i_35_n_0;
  wire t_counter4_carry_i_36_n_0;
  wire t_counter4_carry_i_37_n_0;
  wire t_counter4_carry_i_38_n_0;
  wire t_counter4_carry_i_39_n_0;
  wire t_counter4_carry_i_40_n_0;
  wire t_counter4_carry_i_41_n_0;
  wire t_counter4_carry_i_42_n_0;
  wire t_counter4_carry_i_43_n_0;
  wire [3:0]\t_counter4_inferred__0/i__carry__0 ;
  wire [2:0]\t_counter4_inferred__0/i__carry__0_0 ;
  wire [3:0]\t_counter4_inferred__0/i__carry__0_1 ;
  wire [0:0]trigged_reg;
  wire [0:0]trigged_reg_0;
  wire [0:0]trigged_reg_1;
  wire [15:1]trigger_level;
  wire \trigger_level[15]_i_1_n_0 ;
  wire \trigger_level_reg[15]_0 ;
  wire \trigger_level_reg[15]_1 ;
  wire \trigger_level_reg[15]_10 ;
  wire \trigger_level_reg[15]_11 ;
  wire \trigger_level_reg[15]_12 ;
  wire \trigger_level_reg[15]_2 ;
  wire \trigger_level_reg[15]_3 ;
  wire \trigger_level_reg[15]_4 ;
  wire \trigger_level_reg[15]_5 ;
  wire \trigger_level_reg[15]_6 ;
  wire \trigger_level_reg[15]_7 ;
  wire \trigger_level_reg[15]_8 ;
  wire \trigger_level_reg[15]_9 ;
  wire update_poten_i_1_n_0;
  wire update_poten_i_2_n_0;
  wire update_poten_i_3_n_0;
  wire update_poten_i_4_n_0;
  wire update_poten_i_5_n_0;
  wire [3:3]\NLW_counter_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_state1_carry_O_UNCONNECTED;
  wire [3:0]NLW_state1_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_state1_carry__1_O_UNCONNECTED;
  wire [3:0]NLW_state1_carry__2_O_UNCONNECTED;
  wire [3:2]NLW_t_counter4_carry__0_i_25_CO_UNCONNECTED;
  wire [3:3]NLW_t_counter4_carry__0_i_25_O_UNCONNECTED;

  LUT6 #(
    .INIT(64'hEFFFEFEFE000E0E0)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[0]_i_3_n_0 ),
        .I2(\FSM_sequential_state[0]_i_4_n_0 ),
        .I3(p_0_in),
        .I4(\FSM_sequential_state[1]_i_3_n_0 ),
        .I5(state__0[0]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(state__0[0]),
        .I1(state__0[1]),
        .I2(rx_empty),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \FSM_sequential_state[0]_i_3 
       (.I0(\FSM_sequential_state[1]_i_4_n_0 ),
        .I1(\FSM_sequential_state[0]_i_5_n_0 ),
        .I2(p_1_in),
        .I3(state__0[0]),
        .I4(state__0[1]),
        .I5(p_2_in[7]),
        .O(\FSM_sequential_state[0]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \FSM_sequential_state[0]_i_4 
       (.I0(state1),
        .I1(rx_empty),
        .O(\FSM_sequential_state[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \FSM_sequential_state[0]_i_5 
       (.I0(p_2_in[5]),
        .I1(p_2_in[6]),
        .O(\FSM_sequential_state[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFDFDF30002000)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(state__0[0]),
        .I1(rx_empty),
        .I2(state1),
        .I3(p_0_in),
        .I4(\FSM_sequential_state[1]_i_3_n_0 ),
        .I5(state__0[1]),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000004000000)) 
    \FSM_sequential_state[1]_i_3 
       (.I0(p_1_in),
        .I1(p_2_in[6]),
        .I2(p_2_in[5]),
        .I3(\FSM_sequential_state[1]_i_4_n_0 ),
        .I4(p_2_in[7]),
        .I5(update_poten_i_3_n_0),
        .O(\FSM_sequential_state[1]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h00000080)) 
    \FSM_sequential_state[1]_i_4 
       (.I0(p_2_in[3]),
        .I1(p_2_in[4]),
        .I2(p_2_in[2]),
        .I3(p_2_in[0]),
        .I4(p_2_in[1]),
        .O(\FSM_sequential_state[1]_i_4_n_0 ));
  (* FSM_ENCODED_STATES = "state_read_trigger:01,state_read_poten1_2:10,state_wait_prefix:00,state_read_poten3_4:11" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_sequential_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state__0[0]),
        .R(rst));
  (* FSM_ENCODED_STATES = "state_read_trigger:01,state_read_poten1_2:10,state_wait_prefix:00,state_read_poten3_4:11" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_sequential_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_state[1]_i_2_n_0 ),
        .Q(state__0[1]),
        .R(rst));
  LUT6 #(
    .INIT(64'hBFBBFBFB80880808)) 
    config_d_oe_i_1
       (.I0(config_d_oe_i_2_n_0),
        .I1(\FSM_sequential_state[0]_i_4_n_0 ),
        .I2(state__0[1]),
        .I3(p_0_in),
        .I4(state__0[0]),
        .I5(rx_oe),
        .O(config_d_oe_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h00200000)) 
    config_d_oe_i_2
       (.I0(\FSM_sequential_state[1]_i_4_n_0 ),
        .I1(state__0[0]),
        .I2(p_2_in[7]),
        .I3(p_2_in[5]),
        .I4(p_2_in[6]),
        .O(config_d_oe_i_2_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    config_d_oe_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(config_d_oe_i_1_n_0),
        .Q(rx_oe),
        .R(rst));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_1 
       (.I0(state1),
        .O(sel));
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_3 
       (.I0(counter_reg[0]),
        .O(\counter[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[0]_i_2_n_7 ),
        .Q(counter_reg[0]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\counter_reg[0]_i_2_n_0 ,\counter_reg[0]_i_2_n_1 ,\counter_reg[0]_i_2_n_2 ,\counter_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\counter_reg[0]_i_2_n_4 ,\counter_reg[0]_i_2_n_5 ,\counter_reg[0]_i_2_n_6 ,\counter_reg[0]_i_2_n_7 }),
        .S({counter_reg[3:1],\counter[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[8]_i_1_n_5 ),
        .Q(counter_reg[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[8]_i_1_n_4 ),
        .Q(counter_reg[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[12]_i_1_n_7 ),
        .Q(counter_reg[12]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[12]_i_1 
       (.CI(\counter_reg[8]_i_1_n_0 ),
        .CO({\counter_reg[12]_i_1_n_0 ,\counter_reg[12]_i_1_n_1 ,\counter_reg[12]_i_1_n_2 ,\counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[12]_i_1_n_4 ,\counter_reg[12]_i_1_n_5 ,\counter_reg[12]_i_1_n_6 ,\counter_reg[12]_i_1_n_7 }),
        .S(counter_reg[15:12]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[12]_i_1_n_6 ),
        .Q(counter_reg[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[12]_i_1_n_5 ),
        .Q(counter_reg[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[12]_i_1_n_4 ),
        .Q(counter_reg[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[16]_i_1_n_7 ),
        .Q(counter_reg[16]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[16]_i_1 
       (.CI(\counter_reg[12]_i_1_n_0 ),
        .CO({\counter_reg[16]_i_1_n_0 ,\counter_reg[16]_i_1_n_1 ,\counter_reg[16]_i_1_n_2 ,\counter_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[16]_i_1_n_4 ,\counter_reg[16]_i_1_n_5 ,\counter_reg[16]_i_1_n_6 ,\counter_reg[16]_i_1_n_7 }),
        .S(counter_reg[19:16]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[16]_i_1_n_6 ),
        .Q(counter_reg[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[16]_i_1_n_5 ),
        .Q(counter_reg[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[16]_i_1_n_4 ),
        .Q(counter_reg[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[0]_i_2_n_6 ),
        .Q(counter_reg[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[20] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[20]_i_1_n_7 ),
        .Q(counter_reg[20]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[20]_i_1 
       (.CI(\counter_reg[16]_i_1_n_0 ),
        .CO({\counter_reg[20]_i_1_n_0 ,\counter_reg[20]_i_1_n_1 ,\counter_reg[20]_i_1_n_2 ,\counter_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[20]_i_1_n_4 ,\counter_reg[20]_i_1_n_5 ,\counter_reg[20]_i_1_n_6 ,\counter_reg[20]_i_1_n_7 }),
        .S(counter_reg[23:20]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[21] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[20]_i_1_n_6 ),
        .Q(counter_reg[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[22] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[20]_i_1_n_5 ),
        .Q(counter_reg[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[23] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[20]_i_1_n_4 ),
        .Q(counter_reg[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[24] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[24]_i_1_n_7 ),
        .Q(counter_reg[24]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[24]_i_1 
       (.CI(\counter_reg[20]_i_1_n_0 ),
        .CO({\counter_reg[24]_i_1_n_0 ,\counter_reg[24]_i_1_n_1 ,\counter_reg[24]_i_1_n_2 ,\counter_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[24]_i_1_n_4 ,\counter_reg[24]_i_1_n_5 ,\counter_reg[24]_i_1_n_6 ,\counter_reg[24]_i_1_n_7 }),
        .S(counter_reg[27:24]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[25] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[24]_i_1_n_6 ),
        .Q(counter_reg[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[26] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[24]_i_1_n_5 ),
        .Q(counter_reg[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[27] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[24]_i_1_n_4 ),
        .Q(counter_reg[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[28] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[28]_i_1_n_7 ),
        .Q(counter_reg[28]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[28]_i_1 
       (.CI(\counter_reg[24]_i_1_n_0 ),
        .CO({\NLW_counter_reg[28]_i_1_CO_UNCONNECTED [3],\counter_reg[28]_i_1_n_1 ,\counter_reg[28]_i_1_n_2 ,\counter_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[28]_i_1_n_4 ,\counter_reg[28]_i_1_n_5 ,\counter_reg[28]_i_1_n_6 ,\counter_reg[28]_i_1_n_7 }),
        .S(counter_reg[31:28]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[29] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[28]_i_1_n_6 ),
        .Q(counter_reg[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[0]_i_2_n_5 ),
        .Q(counter_reg[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[30] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[28]_i_1_n_5 ),
        .Q(counter_reg[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[31] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[28]_i_1_n_4 ),
        .Q(counter_reg[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[0]_i_2_n_4 ),
        .Q(counter_reg[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[4]_i_1_n_7 ),
        .Q(counter_reg[4]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[4]_i_1 
       (.CI(\counter_reg[0]_i_2_n_0 ),
        .CO({\counter_reg[4]_i_1_n_0 ,\counter_reg[4]_i_1_n_1 ,\counter_reg[4]_i_1_n_2 ,\counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[4]_i_1_n_4 ,\counter_reg[4]_i_1_n_5 ,\counter_reg[4]_i_1_n_6 ,\counter_reg[4]_i_1_n_7 }),
        .S(counter_reg[7:4]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[4]_i_1_n_6 ),
        .Q(counter_reg[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[4]_i_1_n_5 ),
        .Q(counter_reg[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[4]_i_1_n_4 ),
        .Q(counter_reg[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[8]_i_1_n_7 ),
        .Q(counter_reg[8]),
        .R(rst));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \counter_reg[8]_i_1 
       (.CI(\counter_reg[4]_i_1_n_0 ),
        .CO({\counter_reg[8]_i_1_n_0 ,\counter_reg[8]_i_1_n_1 ,\counter_reg[8]_i_1_n_2 ,\counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\counter_reg[8]_i_1_n_4 ,\counter_reg[8]_i_1_n_5 ,\counter_reg[8]_i_1_n_6 ,\counter_reg[8]_i_1_n_7 }),
        .S(counter_reg[11:8]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\counter_reg[8]_i_1_n_6 ),
        .Q(counter_reg[9]),
        .R(rst));
  LUT6 #(
    .INIT(64'h40404040D5D04540)) 
    i__carry__0_i_1
       (.I0(t_counter4_carry__0_i_9_n_0),
        .I1(\t_counter4_inferred__0/i__carry__0_0 [2]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[12]),
        .I4(\t_counter4_inferred__0/i__carry__0_0 [1]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_7 ));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry__0_i_14
       (.I0(trigger_level[13]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_25_n_7),
        .I3(i__carry__0_i_8_0[11]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(\t_counter4_inferred__0/i__carry__0_0 [0]),
        .O(i__carry__0_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry__0_i_15
       (.I0(trigger_level[11]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_5),
        .I3(i__carry__0_i_8_0[9]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(\t_counter4_inferred__0/i__carry__0_1 [2]),
        .O(i__carry__0_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry__0_i_16
       (.I0(trigger_level[9]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_7),
        .I3(i__carry__0_i_8_0[7]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(\t_counter4_inferred__0/i__carry__0_1 [0]),
        .O(i__carry__0_i_16_n_0));
  LUT6 #(
    .INIT(64'h9033900009000933)) 
    i__carry__0_i_5
       (.I0(\t_counter4_inferred__0/i__carry__0_0 [2]),
        .I1(t_counter4_carry__0_i_9_n_0),
        .I2(\t_counter4_inferred__0/i__carry__0_0 [1]),
        .I3(i__carry__0_i_8_0[13]),
        .I4(i__carry__0_i_8_0[12]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_8 [3]));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry__0_i_6
       (.I0(i__carry__0_i_14_n_0),
        .I1(\t_counter4_inferred__0/i__carry__0_1 [3]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[10]),
        .I4(\trigger_level_reg[15]_7 ),
        .O(\d_out_reg[19]_8 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry__0_i_7
       (.I0(i__carry__0_i_15_n_0),
        .I1(\t_counter4_inferred__0/i__carry__0_1 [1]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[8]),
        .I4(\trigger_level_reg[15]_9 ),
        .O(\d_out_reg[19]_8 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry__0_i_8
       (.I0(i__carry__0_i_16_n_0),
        .I1(\t_counter4_inferred__0/i__carry__0 [3]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[6]),
        .I4(\trigger_level_reg[15]_11 ),
        .O(\d_out_reg[19]_8 [0]));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry_i_14
       (.I0(trigger_level[7]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_5),
        .I3(i__carry__0_i_8_0[5]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(\t_counter4_inferred__0/i__carry__0 [2]),
        .O(i__carry_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry_i_15
       (.I0(trigger_level[5]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_7),
        .I3(i__carry__0_i_8_0[3]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(\t_counter4_inferred__0/i__carry__0 [0]),
        .O(i__carry_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    i__carry_i_16
       (.I0(trigger_level[3]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_34_n_5),
        .I3(i__carry__0_i_8_0[1]),
        .I4(i__carry__0_i_8_0[13]),
        .I5(O[1]),
        .O(i__carry_i_16_n_0));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry_i_5
       (.I0(i__carry_i_14_n_0),
        .I1(\t_counter4_inferred__0/i__carry__0 [1]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[4]),
        .I4(\trigger_level_reg[15]_0 ),
        .O(\d_out_reg[19] [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry_i_6
       (.I0(i__carry_i_15_n_0),
        .I1(O[2]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[2]),
        .I4(\trigger_level_reg[15]_2 ),
        .O(\d_out_reg[19] [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    i__carry_i_7
       (.I0(i__carry_i_16_n_0),
        .I1(O[0]),
        .I2(i__carry__0_i_8_0[13]),
        .I3(i__carry__0_i_8_0[0]),
        .I4(\trigger_level_reg[15]_4 ),
        .O(\d_out_reg[19] [0]));
  LUT4 #(
    .INIT(16'h0400)) 
    \poten1_value[7]_i_1 
       (.I0(rx_empty),
        .I1(state1),
        .I2(state__0[0]),
        .I3(state__0[1]),
        .O(\poten1_value[7]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [8]),
        .Q(\poten1_value_reg[7]_0 [0]),
        .S(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [9]),
        .Q(\poten1_value_reg[7]_0 [1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [10]),
        .Q(\poten1_value_reg[7]_0 [2]),
        .R(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [11]),
        .Q(\poten1_value_reg[7]_0 [3]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [12]),
        .Q(poten0),
        .S(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [13]),
        .Q(\poten1_value_reg[7]_0 [4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [14]),
        .Q(\poten1_value_reg[7]_0 [5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \poten1_value_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\poten1_value[7]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [15]),
        .Q(\poten1_value_reg[7]_0 [6]),
        .R(rst));
  LUT5 #(
    .INIT(32'h00000004)) 
    \prefix[15]_i_1 
       (.I0(rst),
        .I1(state1),
        .I2(rx_empty),
        .I3(state__0[1]),
        .I4(state__0[0]),
        .O(\prefix[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [10]),
        .Q(p_2_in[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [11]),
        .Q(p_2_in[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [12]),
        .Q(p_2_in[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [13]),
        .Q(p_2_in[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [14]),
        .Q(p_2_in[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [15]),
        .Q(p_2_in[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [2]),
        .Q(p_0_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [3]),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [8]),
        .Q(p_2_in[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \prefix_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\prefix[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [9]),
        .Q(p_2_in[1]),
        .R(1'b0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 state1_carry
       (.CI(1'b0),
        .CO({state1_carry_n_0,state1_carry_n_1,state1_carry_n_2,state1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({state1_carry_i_1_n_0,state1_carry_i_2_n_0,state1_carry_i_3_n_0,state1_carry_i_4_n_0}),
        .O(NLW_state1_carry_O_UNCONNECTED[3:0]),
        .S({state1_carry_i_5_n_0,state1_carry_i_6_n_0,state1_carry_i_7_n_0,state1_carry_i_8_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 state1_carry__0
       (.CI(state1_carry_n_0),
        .CO({state1_carry__0_n_0,state1_carry__0_n_1,state1_carry__0_n_2,state1_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({state1_carry__0_i_1_n_0,state1_carry__0_i_2_n_0,state1_carry__0_i_3_n_0,state1_carry__0_i_4_n_0}),
        .O(NLW_state1_carry__0_O_UNCONNECTED[3:0]),
        .S({state1_carry__0_i_5_n_0,state1_carry__0_i_6_n_0,state1_carry__0_i_7_n_0,state1_carry__0_i_8_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__0_i_1
       (.I0(counter_reg[14]),
        .I1(counter_reg[15]),
        .O(state1_carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__0_i_2
       (.I0(counter_reg[12]),
        .I1(counter_reg[13]),
        .O(state1_carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__0_i_3
       (.I0(counter_reg[10]),
        .I1(counter_reg[11]),
        .O(state1_carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__0_i_4
       (.I0(counter_reg[8]),
        .I1(counter_reg[9]),
        .O(state1_carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__0_i_5
       (.I0(counter_reg[15]),
        .I1(counter_reg[14]),
        .O(state1_carry__0_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__0_i_6
       (.I0(counter_reg[13]),
        .I1(counter_reg[12]),
        .O(state1_carry__0_i_6_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__0_i_7
       (.I0(counter_reg[11]),
        .I1(counter_reg[10]),
        .O(state1_carry__0_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__0_i_8
       (.I0(counter_reg[9]),
        .I1(counter_reg[8]),
        .O(state1_carry__0_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 state1_carry__1
       (.CI(state1_carry__0_n_0),
        .CO({state1_carry__1_n_0,state1_carry__1_n_1,state1_carry__1_n_2,state1_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({state1_carry__1_i_1_n_0,state1_carry__1_i_2_n_0,state1_carry__1_i_3_n_0,state1_carry__1_i_4_n_0}),
        .O(NLW_state1_carry__1_O_UNCONNECTED[3:0]),
        .S({state1_carry__1_i_5_n_0,state1_carry__1_i_6_n_0,state1_carry__1_i_7_n_0,state1_carry__1_i_8_n_0}));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__1_i_1
       (.I0(counter_reg[22]),
        .I1(counter_reg[23]),
        .O(state1_carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__1_i_2
       (.I0(counter_reg[20]),
        .I1(counter_reg[21]),
        .O(state1_carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__1_i_3
       (.I0(counter_reg[18]),
        .I1(counter_reg[19]),
        .O(state1_carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__1_i_4
       (.I0(counter_reg[16]),
        .I1(counter_reg[17]),
        .O(state1_carry__1_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__1_i_5
       (.I0(counter_reg[23]),
        .I1(counter_reg[22]),
        .O(state1_carry__1_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__1_i_6
       (.I0(counter_reg[21]),
        .I1(counter_reg[20]),
        .O(state1_carry__1_i_6_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__1_i_7
       (.I0(counter_reg[19]),
        .I1(counter_reg[18]),
        .O(state1_carry__1_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__1_i_8
       (.I0(counter_reg[17]),
        .I1(counter_reg[16]),
        .O(state1_carry__1_i_8_n_0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 state1_carry__2
       (.CI(state1_carry__1_n_0),
        .CO({state1,state1_carry__2_n_1,state1_carry__2_n_2,state1_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({state1_carry__2_i_1_n_0,state1_carry__2_i_2_n_0,state1_carry__2_i_3_n_0,state1_carry__2_i_4_n_0}),
        .O(NLW_state1_carry__2_O_UNCONNECTED[3:0]),
        .S({state1_carry__2_i_5_n_0,state1_carry__2_i_6_n_0,state1_carry__2_i_7_n_0,state1_carry__2_i_8_n_0}));
  LUT2 #(
    .INIT(4'h2)) 
    state1_carry__2_i_1
       (.I0(counter_reg[30]),
        .I1(counter_reg[31]),
        .O(state1_carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__2_i_2
       (.I0(counter_reg[28]),
        .I1(counter_reg[29]),
        .O(state1_carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__2_i_3
       (.I0(counter_reg[26]),
        .I1(counter_reg[27]),
        .O(state1_carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry__2_i_4
       (.I0(counter_reg[24]),
        .I1(counter_reg[25]),
        .O(state1_carry__2_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__2_i_5
       (.I0(counter_reg[31]),
        .I1(counter_reg[30]),
        .O(state1_carry__2_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__2_i_6
       (.I0(counter_reg[29]),
        .I1(counter_reg[28]),
        .O(state1_carry__2_i_6_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__2_i_7
       (.I0(counter_reg[27]),
        .I1(counter_reg[26]),
        .O(state1_carry__2_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry__2_i_8
       (.I0(counter_reg[25]),
        .I1(counter_reg[24]),
        .O(state1_carry__2_i_8_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry_i_1
       (.I0(counter_reg[6]),
        .I1(counter_reg[7]),
        .O(state1_carry_i_1_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry_i_2
       (.I0(counter_reg[4]),
        .I1(counter_reg[5]),
        .O(state1_carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    state1_carry_i_3
       (.I0(counter_reg[2]),
        .I1(counter_reg[3]),
        .O(state1_carry_i_3_n_0));
  LUT2 #(
    .INIT(4'hE)) 
    state1_carry_i_4
       (.I0(counter_reg[0]),
        .I1(counter_reg[1]),
        .O(state1_carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry_i_5
       (.I0(counter_reg[7]),
        .I1(counter_reg[6]),
        .O(state1_carry_i_5_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry_i_6
       (.I0(counter_reg[5]),
        .I1(counter_reg[4]),
        .O(state1_carry_i_6_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    state1_carry_i_7
       (.I0(counter_reg[3]),
        .I1(counter_reg[2]),
        .O(state1_carry_i_7_n_0));
  LUT2 #(
    .INIT(4'h1)) 
    state1_carry_i_8
       (.I0(counter_reg[1]),
        .I1(counter_reg[0]),
        .O(state1_carry_i_8_n_0));
  LUT6 #(
    .INIT(64'h40404040D5D04540)) 
    t_counter2_carry__0_i_1
       (.I0(t_counter4_carry__0_i_9_n_0),
        .I1(t_counter2_carry__0_0[2]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[12]),
        .I4(t_counter2_carry__0_0[1]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_5 ));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry__0_i_14
       (.I0(trigger_level[13]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_25_n_7),
        .I3(t_counter2_carry__0_i_8_0[11]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry__0_0[0]),
        .O(t_counter2_carry__0_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry__0_i_15
       (.I0(trigger_level[11]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_5),
        .I3(t_counter2_carry__0_i_8_0[9]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry__0_1[2]),
        .O(t_counter2_carry__0_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry__0_i_16
       (.I0(trigger_level[9]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_7),
        .I3(t_counter2_carry__0_i_8_0[7]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry__0_1[0]),
        .O(t_counter2_carry__0_i_16_n_0));
  LUT6 #(
    .INIT(64'h9033900009000933)) 
    t_counter2_carry__0_i_5
       (.I0(t_counter2_carry__0_0[2]),
        .I1(t_counter4_carry__0_i_9_n_0),
        .I2(t_counter2_carry__0_0[1]),
        .I3(t_counter2_carry__0_i_8_0[13]),
        .I4(t_counter2_carry__0_i_8_0[12]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_6 [3]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry__0_i_6
       (.I0(t_counter2_carry__0_i_14_n_0),
        .I1(t_counter2_carry__0_1[3]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[10]),
        .I4(\trigger_level_reg[15]_7 ),
        .O(\d_out_reg[19]_6 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry__0_i_7
       (.I0(t_counter2_carry__0_i_15_n_0),
        .I1(t_counter2_carry__0_1[1]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[8]),
        .I4(\trigger_level_reg[15]_9 ),
        .O(\d_out_reg[19]_6 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry__0_i_8
       (.I0(t_counter2_carry__0_i_16_n_0),
        .I1(t_counter2_carry__0[3]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[6]),
        .I4(\trigger_level_reg[15]_11 ),
        .O(\d_out_reg[19]_6 [0]));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry_i_14
       (.I0(trigger_level[7]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_5),
        .I3(t_counter2_carry__0_i_8_0[5]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry__0[2]),
        .O(t_counter2_carry_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry_i_15
       (.I0(trigger_level[5]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_7),
        .I3(t_counter2_carry__0_i_8_0[3]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry__0[0]),
        .O(t_counter2_carry_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter2_carry_i_16
       (.I0(trigger_level[3]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_34_n_5),
        .I3(t_counter2_carry__0_i_8_0[1]),
        .I4(t_counter2_carry__0_i_8_0[13]),
        .I5(t_counter2_carry[1]),
        .O(t_counter2_carry_i_16_n_0));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry_i_5
       (.I0(t_counter2_carry_i_14_n_0),
        .I1(t_counter2_carry__0[1]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[4]),
        .I4(\trigger_level_reg[15]_0 ),
        .O(\d_out_reg[19]_0 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry_i_6
       (.I0(t_counter2_carry_i_15_n_0),
        .I1(t_counter2_carry[2]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[2]),
        .I4(\trigger_level_reg[15]_2 ),
        .O(\d_out_reg[19]_0 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter2_carry_i_7
       (.I0(t_counter2_carry_i_16_n_0),
        .I1(t_counter2_carry[0]),
        .I2(t_counter2_carry__0_i_8_0[13]),
        .I3(t_counter2_carry__0_i_8_0[0]),
        .I4(\trigger_level_reg[15]_4 ),
        .O(\d_out_reg[19]_0 [0]));
  LUT6 #(
    .INIT(64'h40404040D5D04540)) 
    t_counter3_carry__0_i_1
       (.I0(t_counter4_carry__0_i_9_n_0),
        .I1(t_counter3_carry__0_0[2]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[12]),
        .I4(t_counter3_carry__0_0[1]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_3 ));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry__0_i_14
       (.I0(trigger_level[13]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_25_n_7),
        .I3(t_counter3_carry__0_i_8_0[11]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry__0_0[0]),
        .O(t_counter3_carry__0_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry__0_i_15
       (.I0(trigger_level[11]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_5),
        .I3(t_counter3_carry__0_i_8_0[9]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry__0_1[2]),
        .O(t_counter3_carry__0_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry__0_i_16
       (.I0(trigger_level[9]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_7),
        .I3(t_counter3_carry__0_i_8_0[7]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry__0_1[0]),
        .O(t_counter3_carry__0_i_16_n_0));
  LUT6 #(
    .INIT(64'h9033900009000933)) 
    t_counter3_carry__0_i_5
       (.I0(t_counter3_carry__0_0[2]),
        .I1(t_counter4_carry__0_i_9_n_0),
        .I2(t_counter3_carry__0_0[1]),
        .I3(t_counter3_carry__0_i_8_0[13]),
        .I4(t_counter3_carry__0_i_8_0[12]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_4 [3]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry__0_i_6
       (.I0(t_counter3_carry__0_i_14_n_0),
        .I1(t_counter3_carry__0_1[3]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[10]),
        .I4(\trigger_level_reg[15]_7 ),
        .O(\d_out_reg[19]_4 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry__0_i_7
       (.I0(t_counter3_carry__0_i_15_n_0),
        .I1(t_counter3_carry__0_1[1]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[8]),
        .I4(\trigger_level_reg[15]_9 ),
        .O(\d_out_reg[19]_4 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry__0_i_8
       (.I0(t_counter3_carry__0_i_16_n_0),
        .I1(t_counter3_carry__0[3]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[6]),
        .I4(\trigger_level_reg[15]_11 ),
        .O(\d_out_reg[19]_4 [0]));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry_i_14
       (.I0(trigger_level[7]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_5),
        .I3(t_counter3_carry__0_i_8_0[5]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry__0[2]),
        .O(t_counter3_carry_i_14_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry_i_15
       (.I0(trigger_level[5]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_7),
        .I3(t_counter3_carry__0_i_8_0[3]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry__0[0]),
        .O(t_counter3_carry_i_15_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter3_carry_i_16
       (.I0(trigger_level[3]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_34_n_5),
        .I3(t_counter3_carry__0_i_8_0[1]),
        .I4(t_counter3_carry__0_i_8_0[13]),
        .I5(t_counter3_carry[1]),
        .O(t_counter3_carry_i_16_n_0));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry_i_5
       (.I0(t_counter3_carry_i_14_n_0),
        .I1(t_counter3_carry__0[1]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[4]),
        .I4(\trigger_level_reg[15]_0 ),
        .O(\d_out_reg[19]_1 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry_i_6
       (.I0(t_counter3_carry_i_15_n_0),
        .I1(t_counter3_carry[2]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[2]),
        .I4(\trigger_level_reg[15]_2 ),
        .O(\d_out_reg[19]_1 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter3_carry_i_7
       (.I0(t_counter3_carry_i_16_n_0),
        .I1(t_counter3_carry[0]),
        .I2(t_counter3_carry__0_i_8_0[13]),
        .I3(t_counter3_carry__0_i_8_0[0]),
        .I4(\trigger_level_reg[15]_4 ),
        .O(\d_out_reg[19]_1 [0]));
  LUT6 #(
    .INIT(64'h40404040D5D04540)) 
    t_counter4_carry__0_i_1
       (.I0(t_counter4_carry__0_i_9_n_0),
        .I1(t_counter4_carry__0[13]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[12]),
        .I4(t_counter4_carry__0[12]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(DI));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_11
       (.I0(t_counter4_carry__0_i_25_n_6),
        .I1(trigger_level[15]),
        .I2(trigger_level[14]),
        .O(t_counter4_carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_12
       (.I0(t_counter4_carry__0_i_25_n_7),
        .I1(trigger_level[15]),
        .I2(trigger_level[13]),
        .O(\trigger_level_reg[15]_8 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_15
       (.I0(t_counter4_carry__0_i_33_n_4),
        .I1(trigger_level[15]),
        .I2(trigger_level[12]),
        .O(\trigger_level_reg[15]_7 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_16
       (.I0(t_counter4_carry__0_i_33_n_5),
        .I1(trigger_level[15]),
        .I2(trigger_level[11]),
        .O(\trigger_level_reg[15]_10 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_18
       (.I0(t_counter4_carry__0_i_33_n_6),
        .I1(trigger_level[15]),
        .I2(trigger_level[10]),
        .O(\trigger_level_reg[15]_9 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_19
       (.I0(t_counter4_carry__0_i_33_n_7),
        .I1(trigger_level[15]),
        .I2(trigger_level[9]),
        .O(\trigger_level_reg[15]_12 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry__0_i_21
       (.I0(t_counter4_carry_i_24_n_4),
        .I1(trigger_level[15]),
        .I2(trigger_level[8]),
        .O(\trigger_level_reg[15]_11 ));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry__0_i_22
       (.I0(trigger_level[13]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_25_n_7),
        .I3(t_counter4_carry__0_i_8_0[11]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[11]),
        .O(t_counter4_carry__0_i_22_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry__0_i_23
       (.I0(trigger_level[11]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_5),
        .I3(t_counter4_carry__0_i_8_0[9]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[9]),
        .O(t_counter4_carry__0_i_23_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry__0_i_24
       (.I0(trigger_level[9]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry__0_i_33_n_7),
        .I3(t_counter4_carry__0_i_8_0[7]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[7]),
        .O(t_counter4_carry__0_i_24_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry__0_i_25
       (.CI(t_counter4_carry__0_i_33_n_0),
        .CO({NLW_t_counter4_carry__0_i_25_CO_UNCONNECTED[3:2],t_counter4_carry__0_i_25_n_2,t_counter4_carry__0_i_25_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_t_counter4_carry__0_i_25_O_UNCONNECTED[3],t_counter4_carry__0_i_25_n_5,t_counter4_carry__0_i_25_n_6,t_counter4_carry__0_i_25_n_7}),
        .S({1'b0,t_counter4_carry__0_i_34_n_0,t_counter4_carry__0_i_35_n_0,t_counter4_carry__0_i_36_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry__0_i_33
       (.CI(t_counter4_carry_i_24_n_0),
        .CO({t_counter4_carry__0_i_33_n_0,t_counter4_carry__0_i_33_n_1,t_counter4_carry__0_i_33_n_2,t_counter4_carry__0_i_33_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({t_counter4_carry__0_i_33_n_4,t_counter4_carry__0_i_33_n_5,t_counter4_carry__0_i_33_n_6,t_counter4_carry__0_i_33_n_7}),
        .S({t_counter4_carry__0_i_37_n_0,t_counter4_carry__0_i_38_n_0,t_counter4_carry__0_i_39_n_0,t_counter4_carry__0_i_40_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_34
       (.I0(trigger_level[15]),
        .O(t_counter4_carry__0_i_34_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_35
       (.I0(trigger_level[14]),
        .O(t_counter4_carry__0_i_35_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_36
       (.I0(trigger_level[13]),
        .O(t_counter4_carry__0_i_36_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_37
       (.I0(trigger_level[12]),
        .O(t_counter4_carry__0_i_37_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_38
       (.I0(trigger_level[11]),
        .O(t_counter4_carry__0_i_38_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_39
       (.I0(trigger_level[10]),
        .O(t_counter4_carry__0_i_39_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry__0_i_40
       (.I0(trigger_level[9]),
        .O(t_counter4_carry__0_i_40_n_0));
  LUT6 #(
    .INIT(64'h9033900009000933)) 
    t_counter4_carry__0_i_5
       (.I0(t_counter4_carry__0[13]),
        .I1(t_counter4_carry__0_i_9_n_0),
        .I2(t_counter4_carry__0[12]),
        .I3(t_counter4_carry__0_i_8_0[13]),
        .I4(t_counter4_carry__0_i_8_0[12]),
        .I5(t_counter4_carry__0_i_11_n_0),
        .O(\d_out_reg[19]_2 [3]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry__0_i_6
       (.I0(t_counter4_carry__0_i_22_n_0),
        .I1(t_counter4_carry__0[10]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[10]),
        .I4(\trigger_level_reg[15]_7 ),
        .O(\d_out_reg[19]_2 [2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry__0_i_7
       (.I0(t_counter4_carry__0_i_23_n_0),
        .I1(t_counter4_carry__0[8]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[8]),
        .I4(\trigger_level_reg[15]_9 ),
        .O(\d_out_reg[19]_2 [1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry__0_i_8
       (.I0(t_counter4_carry__0_i_24_n_0),
        .I1(t_counter4_carry__0[6]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[6]),
        .I4(\trigger_level_reg[15]_11 ),
        .O(\d_out_reg[19]_2 [0]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h8)) 
    t_counter4_carry__0_i_9
       (.I0(trigger_level[15]),
        .I1(t_counter4_carry__0_i_25_n_5),
        .O(t_counter4_carry__0_i_9_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_12
       (.I0(t_counter4_carry_i_24_n_6),
        .I1(trigger_level[15]),
        .I2(trigger_level[6]),
        .O(\trigger_level_reg[15]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_13
       (.I0(t_counter4_carry_i_24_n_7),
        .I1(trigger_level[15]),
        .I2(trigger_level[5]),
        .O(\trigger_level_reg[15]_3 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_16
       (.I0(t_counter4_carry_i_34_n_4),
        .I1(trigger_level[15]),
        .I2(trigger_level[4]),
        .O(\trigger_level_reg[15]_2 ));
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_17
       (.I0(t_counter4_carry_i_34_n_5),
        .I1(trigger_level[15]),
        .I2(trigger_level[3]),
        .O(\trigger_level_reg[15]_5 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_19
       (.I0(t_counter4_carry_i_34_n_6),
        .I1(trigger_level[15]),
        .I2(trigger_level[2]),
        .O(\trigger_level_reg[15]_4 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_20
       (.I0(t_counter4_carry_i_34_n_7),
        .I1(trigger_level[15]),
        .I2(trigger_level[1]),
        .O(\trigger_level_reg[15]_6 ));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry_i_21
       (.I0(trigger_level[7]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_5),
        .I3(t_counter4_carry__0_i_8_0[5]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[5]),
        .O(t_counter4_carry_i_21_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry_i_22
       (.I0(trigger_level[5]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_24_n_7),
        .I3(t_counter4_carry__0_i_8_0[3]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[3]),
        .O(t_counter4_carry_i_22_n_0));
  LUT6 #(
    .INIT(64'h1D1D1DE2E2E21DE2)) 
    t_counter4_carry_i_23
       (.I0(trigger_level[3]),
        .I1(trigger_level[15]),
        .I2(t_counter4_carry_i_34_n_5),
        .I3(t_counter4_carry__0_i_8_0[1]),
        .I4(t_counter4_carry__0_i_8_0[13]),
        .I5(t_counter4_carry__0[1]),
        .O(t_counter4_carry_i_23_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry_i_24
       (.CI(t_counter4_carry_i_34_n_0),
        .CO({t_counter4_carry_i_24_n_0,t_counter4_carry_i_24_n_1,t_counter4_carry_i_24_n_2,t_counter4_carry_i_24_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({t_counter4_carry_i_24_n_4,t_counter4_carry_i_24_n_5,t_counter4_carry_i_24_n_6,t_counter4_carry_i_24_n_7}),
        .S({t_counter4_carry_i_35_n_0,t_counter4_carry_i_36_n_0,t_counter4_carry_i_37_n_0,t_counter4_carry_i_38_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 t_counter4_carry_i_34
       (.CI(1'b0),
        .CO({t_counter4_carry_i_34_n_0,t_counter4_carry_i_34_n_1,t_counter4_carry_i_34_n_2,t_counter4_carry_i_34_n_3}),
        .CYINIT(t_counter4_carry_i_39_n_0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({t_counter4_carry_i_34_n_4,t_counter4_carry_i_34_n_5,t_counter4_carry_i_34_n_6,t_counter4_carry_i_34_n_7}),
        .S({t_counter4_carry_i_40_n_0,t_counter4_carry_i_41_n_0,t_counter4_carry_i_42_n_0,t_counter4_carry_i_43_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_35
       (.I0(trigger_level[8]),
        .O(t_counter4_carry_i_35_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_36
       (.I0(trigger_level[7]),
        .O(t_counter4_carry_i_36_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_37
       (.I0(trigger_level[6]),
        .O(t_counter4_carry_i_37_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_38
       (.I0(trigger_level[5]),
        .O(t_counter4_carry_i_38_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_39
       (.I0(Q),
        .O(t_counter4_carry_i_39_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_40
       (.I0(trigger_level[4]),
        .O(t_counter4_carry_i_40_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_41
       (.I0(trigger_level[3]),
        .O(t_counter4_carry_i_41_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_42
       (.I0(trigger_level[2]),
        .O(t_counter4_carry_i_42_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    t_counter4_carry_i_43
       (.I0(trigger_level[1]),
        .O(t_counter4_carry_i_43_n_0));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry_i_5
       (.I0(t_counter4_carry_i_21_n_0),
        .I1(t_counter4_carry__0[4]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[4]),
        .I4(\trigger_level_reg[15]_0 ),
        .O(S[2]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry_i_6
       (.I0(t_counter4_carry_i_22_n_0),
        .I1(t_counter4_carry__0[2]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[2]),
        .I4(\trigger_level_reg[15]_2 ),
        .O(S[1]));
  LUT5 #(
    .INIT(32'h45401015)) 
    t_counter4_carry_i_7
       (.I0(t_counter4_carry_i_23_n_0),
        .I1(t_counter4_carry__0[0]),
        .I2(t_counter4_carry__0_i_8_0[13]),
        .I3(t_counter4_carry__0_i_8_0[0]),
        .I4(\trigger_level_reg[15]_4 ),
        .O(S[0]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    t_counter4_carry_i_9
       (.I0(t_counter4_carry_i_24_n_5),
        .I1(trigger_level[15]),
        .I2(trigger_level[7]),
        .O(\trigger_level_reg[15]_1 ));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \t_counter[0]_i_4 
       (.I0(FUNC_EN_IBUF),
        .I1(CO),
        .I2(trigged_reg),
        .I3(trigged_reg_0),
        .I4(trigged_reg_1),
        .O(t_counter0));
  LUT4 #(
    .INIT(16'h0040)) 
    \trigger_level[15]_i_1 
       (.I0(rx_empty),
        .I1(state1),
        .I2(state__0[0]),
        .I3(state__0[1]),
        .O(\trigger_level[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [0]),
        .Q(Q),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [10]),
        .Q(trigger_level[10]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [11]),
        .Q(trigger_level[11]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [12]),
        .Q(trigger_level[12]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [13]),
        .Q(trigger_level[13]),
        .S(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [14]),
        .Q(trigger_level[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [15]),
        .Q(trigger_level[15]),
        .R(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [1]),
        .Q(trigger_level[1]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [2]),
        .Q(trigger_level[2]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [3]),
        .Q(trigger_level[3]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [4]),
        .Q(trigger_level[4]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [5]),
        .Q(trigger_level[5]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [6]),
        .Q(trigger_level[6]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [7]),
        .Q(trigger_level[7]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [8]),
        .Q(trigger_level[8]),
        .S(rst));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \trigger_level_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\trigger_level[15]_i_1_n_0 ),
        .D(\prefix_reg[15]_0 [9]),
        .Q(trigger_level[9]),
        .S(rst));
  LUT2 #(
    .INIT(4'hB)) 
    \txr[4]_i_1 
       (.I0(poten0),
        .I1(sub_state__0),
        .O(D));
  LUT6 #(
    .INIT(64'hEEFFEAFF22002A00)) 
    update_poten_i_1
       (.I0(update_poten_i_2_n_0),
        .I1(update_poten_i_3_n_0),
        .I2(update_poten_i_4_n_0),
        .I3(state1),
        .I4(rx_empty),
        .I5(poten_update_start),
        .O(update_poten_i_1_n_0));
  LUT5 #(
    .INIT(32'h0000DFFF)) 
    update_poten_i_2
       (.I0(update_poten_i_5_n_0),
        .I1(rx_empty),
        .I2(p_0_in),
        .I3(p_2_in[7]),
        .I4(state__0[0]),
        .O(update_poten_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'hE)) 
    update_poten_i_3
       (.I0(state__0[1]),
        .I1(state__0[0]),
        .O(update_poten_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'hB)) 
    update_poten_i_4
       (.I0(state__0[1]),
        .I1(p_0_in),
        .O(update_poten_i_4_n_0));
  LUT4 #(
    .INIT(16'h0020)) 
    update_poten_i_5
       (.I0(\FSM_sequential_state[1]_i_4_n_0 ),
        .I1(p_2_in[5]),
        .I2(p_2_in[6]),
        .I3(p_1_in),
        .O(update_poten_i_5_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    update_poten_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(update_poten_i_1_n_0),
        .Q(poten_update_start),
        .R(rst));
endmodule

module hydrophone_trigger
   (D,
    trigger_strobe,
    rst_4d,
    rst_7d,
    \d_out_reg[19] ,
    \d_out_reg[19]_0 ,
    \d_out_reg[19]_1 ,
    CO,
    LED_GREEN_3_OBUF,
    latched_input0,
    in_strb_d_reg,
    ifclk_out_OBUF_BUFG,
    fifo_rst_internal,
    DI,
    rst_3d,
    rst_6d,
    rst_internal,
    t_counter4_carry__0_0,
    S,
    \t_counter[0]_i_4 ,
    \t_counter[0]_i_4_0 ,
    t_counter3_carry__0_0,
    t_counter3_carry__0_1,
    \t_counter[0]_i_4_1 ,
    \t_counter[0]_i_4_2 ,
    t_counter2_carry__0_0,
    t_counter2_carry__0_1,
    \t_counter[0]_i_4_3 ,
    \t_counter[0]_i_4_4 ,
    \t_counter4_inferred__0/i__carry__0_0 ,
    \t_counter4_inferred__0/i__carry__0_1 ,
    \t_counter[0]_i_4_5 ,
    \t_counter[0]_i_4_6 ,
    strb_d_reg_0,
    in_strb_d,
    t_counter0);
  output [63:0]D;
  output trigger_strobe;
  output rst_4d;
  output rst_7d;
  output [0:0]\d_out_reg[19] ;
  output [0:0]\d_out_reg[19]_0 ;
  output [0:0]\d_out_reg[19]_1 ;
  output [0:0]CO;
  output LED_GREEN_3_OBUF;
  output latched_input0;
  output in_strb_d_reg;
  input ifclk_out_OBUF_BUFG;
  input fifo_rst_internal;
  input [63:0]DI;
  input rst_3d;
  input rst_6d;
  input rst_internal;
  input [3:0]t_counter4_carry__0_0;
  input [3:0]S;
  input [3:0]\t_counter[0]_i_4 ;
  input [3:0]\t_counter[0]_i_4_0 ;
  input [3:0]t_counter3_carry__0_0;
  input [3:0]t_counter3_carry__0_1;
  input [3:0]\t_counter[0]_i_4_1 ;
  input [3:0]\t_counter[0]_i_4_2 ;
  input [3:0]t_counter2_carry__0_0;
  input [3:0]t_counter2_carry__0_1;
  input [3:0]\t_counter[0]_i_4_3 ;
  input [3:0]\t_counter[0]_i_4_4 ;
  input [3:0]\t_counter4_inferred__0/i__carry__0_0 ;
  input [3:0]\t_counter4_inferred__0/i__carry__0_1 ;
  input [3:0]\t_counter[0]_i_4_5 ;
  input [3:0]\t_counter[0]_i_4_6 ;
  input strb_d_reg_0;
  input in_strb_d;
  input t_counter0;

  wire [0:0]CO;
  wire [63:0]D;
  wire [63:0]DI;
  wire FIFO36E1_inst_i_1_n_0;
  wire FIFO36E1_inst_n_1;
  wire LED_GREEN_3_OBUF;
  wire [3:0]S;
  wire [0:0]\d_out_reg[19] ;
  wire [0:0]\d_out_reg[19]_0 ;
  wire [0:0]\d_out_reg[19]_1 ;
  wire fifo_rst_internal;
  wire h_counter;
  wire \h_counter[0]_i_10_n_0 ;
  wire \h_counter[0]_i_11_n_0 ;
  wire \h_counter[0]_i_12_n_0 ;
  wire \h_counter[0]_i_13_n_0 ;
  wire \h_counter[0]_i_14_n_0 ;
  wire \h_counter[0]_i_6_n_0 ;
  wire \h_counter[0]_i_7_n_0 ;
  wire \h_counter[0]_i_8_n_0 ;
  wire \h_counter[0]_i_9_n_0 ;
  wire \h_counter[12]_i_2_n_0 ;
  wire \h_counter[12]_i_3_n_0 ;
  wire \h_counter[12]_i_4_n_0 ;
  wire \h_counter[12]_i_5_n_0 ;
  wire \h_counter[4]_i_2_n_0 ;
  wire \h_counter[4]_i_3_n_0 ;
  wire \h_counter[4]_i_4_n_0 ;
  wire \h_counter[4]_i_5_n_0 ;
  wire \h_counter[8]_i_2_n_0 ;
  wire \h_counter[8]_i_3_n_0 ;
  wire \h_counter[8]_i_4_n_0 ;
  wire \h_counter[8]_i_5_n_0 ;
  wire [15:0]h_counter_reg;
  wire \h_counter_reg[0]_i_3_n_0 ;
  wire \h_counter_reg[0]_i_3_n_1 ;
  wire \h_counter_reg[0]_i_3_n_2 ;
  wire \h_counter_reg[0]_i_3_n_3 ;
  wire \h_counter_reg[0]_i_3_n_4 ;
  wire \h_counter_reg[0]_i_3_n_5 ;
  wire \h_counter_reg[0]_i_3_n_6 ;
  wire \h_counter_reg[0]_i_3_n_7 ;
  wire \h_counter_reg[12]_i_1_n_1 ;
  wire \h_counter_reg[12]_i_1_n_2 ;
  wire \h_counter_reg[12]_i_1_n_3 ;
  wire \h_counter_reg[12]_i_1_n_4 ;
  wire \h_counter_reg[12]_i_1_n_5 ;
  wire \h_counter_reg[12]_i_1_n_6 ;
  wire \h_counter_reg[12]_i_1_n_7 ;
  wire \h_counter_reg[4]_i_1_n_0 ;
  wire \h_counter_reg[4]_i_1_n_1 ;
  wire \h_counter_reg[4]_i_1_n_2 ;
  wire \h_counter_reg[4]_i_1_n_3 ;
  wire \h_counter_reg[4]_i_1_n_4 ;
  wire \h_counter_reg[4]_i_1_n_5 ;
  wire \h_counter_reg[4]_i_1_n_6 ;
  wire \h_counter_reg[4]_i_1_n_7 ;
  wire \h_counter_reg[8]_i_1_n_0 ;
  wire \h_counter_reg[8]_i_1_n_1 ;
  wire \h_counter_reg[8]_i_1_n_2 ;
  wire \h_counter_reg[8]_i_1_n_3 ;
  wire \h_counter_reg[8]_i_1_n_4 ;
  wire \h_counter_reg[8]_i_1_n_5 ;
  wire \h_counter_reg[8]_i_1_n_6 ;
  wire \h_counter_reg[8]_i_1_n_7 ;
  wire ifclk_out_OBUF_BUFG;
  wire in_strb_d;
  wire in_strb_d_reg;
  wire latched_input0;
  wire [12:0]rd_counter;
  wire rd_en_i_1_n_0;
  wire rd_en_reg_n_0;
  wire rst_3d;
  wire rst_4d;
  wire rst_6d;
  wire rst_7d;
  wire rst_internal;
  wire strb_d;
  wire strb_d_reg_0;
  wire strb_dd;
  wire strb_dd_i_1_n_0;
  wire t_counter0;
  wire [3:0]t_counter2_carry__0_0;
  wire [3:0]t_counter2_carry__0_1;
  wire t_counter2_carry__0_n_1;
  wire t_counter2_carry__0_n_2;
  wire t_counter2_carry__0_n_3;
  wire t_counter2_carry_n_0;
  wire t_counter2_carry_n_1;
  wire t_counter2_carry_n_2;
  wire t_counter2_carry_n_3;
  wire [3:0]t_counter3_carry__0_0;
  wire [3:0]t_counter3_carry__0_1;
  wire t_counter3_carry__0_n_1;
  wire t_counter3_carry__0_n_2;
  wire t_counter3_carry__0_n_3;
  wire t_counter3_carry_n_0;
  wire t_counter3_carry_n_1;
  wire t_counter3_carry_n_2;
  wire t_counter3_carry_n_3;
  wire [3:0]t_counter4_carry__0_0;
  wire t_counter4_carry__0_n_1;
  wire t_counter4_carry__0_n_2;
  wire t_counter4_carry__0_n_3;
  wire t_counter4_carry_n_0;
  wire t_counter4_carry_n_1;
  wire t_counter4_carry_n_2;
  wire t_counter4_carry_n_3;
  wire [3:0]\t_counter4_inferred__0/i__carry__0_0 ;
  wire [3:0]\t_counter4_inferred__0/i__carry__0_1 ;
  wire \t_counter4_inferred__0/i__carry__0_n_1 ;
  wire \t_counter4_inferred__0/i__carry__0_n_2 ;
  wire \t_counter4_inferred__0/i__carry__0_n_3 ;
  wire \t_counter4_inferred__0/i__carry_n_0 ;
  wire \t_counter4_inferred__0/i__carry_n_1 ;
  wire \t_counter4_inferred__0/i__carry_n_2 ;
  wire \t_counter4_inferred__0/i__carry_n_3 ;
  wire \t_counter[0]_i_10_n_0 ;
  wire \t_counter[0]_i_11_n_0 ;
  wire \t_counter[0]_i_12_n_0 ;
  wire \t_counter[0]_i_13_n_0 ;
  wire \t_counter[0]_i_1_n_0 ;
  wire \t_counter[0]_i_2_n_0 ;
  wire [3:0]\t_counter[0]_i_4 ;
  wire [3:0]\t_counter[0]_i_4_0 ;
  wire [3:0]\t_counter[0]_i_4_1 ;
  wire [3:0]\t_counter[0]_i_4_2 ;
  wire [3:0]\t_counter[0]_i_4_3 ;
  wire [3:0]\t_counter[0]_i_4_4 ;
  wire [3:0]\t_counter[0]_i_4_5 ;
  wire [3:0]\t_counter[0]_i_4_6 ;
  wire \t_counter[0]_i_5_n_0 ;
  wire \t_counter[0]_i_6_n_0 ;
  wire \t_counter[0]_i_7_n_0 ;
  wire \t_counter[0]_i_8_n_0 ;
  wire \t_counter[0]_i_9_n_0 ;
  wire \t_counter[12]_i_2_n_0 ;
  wire \t_counter[12]_i_3_n_0 ;
  wire \t_counter[12]_i_4_n_0 ;
  wire \t_counter[12]_i_5_n_0 ;
  wire \t_counter[4]_i_2_n_0 ;
  wire \t_counter[4]_i_3_n_0 ;
  wire \t_counter[4]_i_4_n_0 ;
  wire \t_counter[4]_i_5_n_0 ;
  wire \t_counter[8]_i_2_n_0 ;
  wire \t_counter[8]_i_3_n_0 ;
  wire \t_counter[8]_i_4_n_0 ;
  wire \t_counter[8]_i_5_n_0 ;
  wire [15:0]t_counter_reg;
  wire \t_counter_reg[0]_i_3_n_0 ;
  wire \t_counter_reg[0]_i_3_n_1 ;
  wire \t_counter_reg[0]_i_3_n_2 ;
  wire \t_counter_reg[0]_i_3_n_3 ;
  wire \t_counter_reg[0]_i_3_n_4 ;
  wire \t_counter_reg[0]_i_3_n_5 ;
  wire \t_counter_reg[0]_i_3_n_6 ;
  wire \t_counter_reg[0]_i_3_n_7 ;
  wire \t_counter_reg[12]_i_1_n_1 ;
  wire \t_counter_reg[12]_i_1_n_2 ;
  wire \t_counter_reg[12]_i_1_n_3 ;
  wire \t_counter_reg[12]_i_1_n_4 ;
  wire \t_counter_reg[12]_i_1_n_5 ;
  wire \t_counter_reg[12]_i_1_n_6 ;
  wire \t_counter_reg[12]_i_1_n_7 ;
  wire \t_counter_reg[4]_i_1_n_0 ;
  wire \t_counter_reg[4]_i_1_n_1 ;
  wire \t_counter_reg[4]_i_1_n_2 ;
  wire \t_counter_reg[4]_i_1_n_3 ;
  wire \t_counter_reg[4]_i_1_n_4 ;
  wire \t_counter_reg[4]_i_1_n_5 ;
  wire \t_counter_reg[4]_i_1_n_6 ;
  wire \t_counter_reg[4]_i_1_n_7 ;
  wire \t_counter_reg[8]_i_1_n_0 ;
  wire \t_counter_reg[8]_i_1_n_1 ;
  wire \t_counter_reg[8]_i_1_n_2 ;
  wire \t_counter_reg[8]_i_1_n_3 ;
  wire \t_counter_reg[8]_i_1_n_4 ;
  wire \t_counter_reg[8]_i_1_n_5 ;
  wire \t_counter_reg[8]_i_1_n_6 ;
  wire \t_counter_reg[8]_i_1_n_7 ;
  wire trigged_i_1_n_0;
  wire trigger_strobe;
  wire [12:0]wr_counter;
  wire NLW_FIFO36E1_inst_ALMOSTEMPTY_UNCONNECTED;
  wire NLW_FIFO36E1_inst_DBITERR_UNCONNECTED;
  wire NLW_FIFO36E1_inst_EMPTY_UNCONNECTED;
  wire NLW_FIFO36E1_inst_FULL_UNCONNECTED;
  wire NLW_FIFO36E1_inst_RDERR_UNCONNECTED;
  wire NLW_FIFO36E1_inst_SBITERR_UNCONNECTED;
  wire NLW_FIFO36E1_inst_WRERR_UNCONNECTED;
  wire [7:0]NLW_FIFO36E1_inst_DOP_UNCONNECTED;
  wire [7:0]NLW_FIFO36E1_inst_ECCPARITY_UNCONNECTED;
  wire [3:3]\NLW_h_counter_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:0]NLW_t_counter2_carry_O_UNCONNECTED;
  wire [3:0]NLW_t_counter2_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_t_counter3_carry_O_UNCONNECTED;
  wire [3:0]NLW_t_counter3_carry__0_O_UNCONNECTED;
  wire [3:0]NLW_t_counter4_carry_O_UNCONNECTED;
  wire [3:0]NLW_t_counter4_carry__0_O_UNCONNECTED;
  wire [3:0]\NLW_t_counter4_inferred__0/i__carry_O_UNCONNECTED ;
  wire [3:0]\NLW_t_counter4_inferred__0/i__carry__0_O_UNCONNECTED ;
  wire [3:3]\NLW_t_counter_reg[12]_i_1_CO_UNCONNECTED ;

  (* BOX_TYPE = "PRIMITIVE" *) 
  FIFO36E1 #(
    .ALMOST_EMPTY_OFFSET(13'h0080),
    .ALMOST_FULL_OFFSET(13'h000A),
    .DATA_WIDTH(72),
    .DO_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .EN_SYN("FALSE"),
    .FIFO_MODE("FIFO36_72"),
    .FIRST_WORD_FALL_THROUGH("TRUE"),
    .INIT(72'h000000000000000000),
    .IS_RDCLK_INVERTED(1'b0),
    .IS_RDEN_INVERTED(1'b0),
    .IS_RSTREG_INVERTED(1'b0),
    .IS_RST_INVERTED(1'b0),
    .IS_WRCLK_INVERTED(1'b0),
    .IS_WREN_INVERTED(1'b0),
    .SIM_DEVICE("7SERIES"),
    .SRVAL(72'h000000000000000000)) 
    FIFO36E1_inst
       (.ALMOSTEMPTY(NLW_FIFO36E1_inst_ALMOSTEMPTY_UNCONNECTED),
        .ALMOSTFULL(FIFO36E1_inst_n_1),
        .DBITERR(NLW_FIFO36E1_inst_DBITERR_UNCONNECTED),
        .DI(DI),
        .DIP({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(D),
        .DOP(NLW_FIFO36E1_inst_DOP_UNCONNECTED[7:0]),
        .ECCPARITY(NLW_FIFO36E1_inst_ECCPARITY_UNCONNECTED[7:0]),
        .EMPTY(NLW_FIFO36E1_inst_EMPTY_UNCONNECTED),
        .FULL(NLW_FIFO36E1_inst_FULL_UNCONNECTED),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDCLK(ifclk_out_OBUF_BUFG),
        .RDCOUNT(rd_counter),
        .RDEN(FIFO36E1_inst_i_1_n_0),
        .RDERR(NLW_FIFO36E1_inst_RDERR_UNCONNECTED),
        .REGCE(1'b1),
        .RST(fifo_rst_internal),
        .RSTREG(1'b0),
        .SBITERR(NLW_FIFO36E1_inst_SBITERR_UNCONNECTED),
        .WRCLK(ifclk_out_OBUF_BUFG),
        .WRCOUNT(wr_counter),
        .WREN(trigger_strobe),
        .WRERR(NLW_FIFO36E1_inst_WRERR_UNCONNECTED));
  LUT5 #(
    .INIT(32'h04040400)) 
    FIFO36E1_inst_i_1
       (.I0(strb_dd),
        .I1(strb_d),
        .I2(rst_internal),
        .I3(FIFO36E1_inst_n_1),
        .I4(rd_en_reg_n_0),
        .O(FIFO36E1_inst_i_1_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \FSM_onehot_main_state[9]_i_4 
       (.I0(in_strb_d),
        .I1(strb_dd),
        .I2(strb_d),
        .I3(rst_internal),
        .O(in_strb_d_reg));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[0]_i_10 
       (.I0(h_counter_reg[0]),
        .O(\h_counter[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \h_counter[0]_i_11 
       (.I0(h_counter_reg[9]),
        .I1(h_counter_reg[8]),
        .I2(h_counter_reg[11]),
        .I3(h_counter_reg[10]),
        .O(\h_counter[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \h_counter[0]_i_12 
       (.I0(h_counter_reg[14]),
        .I1(h_counter_reg[13]),
        .I2(h_counter_reg[12]),
        .I3(h_counter_reg[15]),
        .O(\h_counter[0]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \h_counter[0]_i_13 
       (.I0(h_counter_reg[1]),
        .I1(h_counter_reg[3]),
        .I2(h_counter_reg[2]),
        .I3(h_counter_reg[0]),
        .O(\h_counter[0]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \h_counter[0]_i_14 
       (.I0(h_counter_reg[5]),
        .I1(h_counter_reg[6]),
        .I2(h_counter_reg[4]),
        .I3(h_counter_reg[7]),
        .O(\h_counter[0]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \h_counter[0]_i_2 
       (.I0(strb_dd),
        .I1(strb_d),
        .I2(rst_internal),
        .I3(\h_counter[0]_i_6_n_0 ),
        .O(h_counter));
  LUT4 #(
    .INIT(16'h0004)) 
    \h_counter[0]_i_6 
       (.I0(\h_counter[0]_i_11_n_0 ),
        .I1(\h_counter[0]_i_12_n_0 ),
        .I2(\h_counter[0]_i_13_n_0 ),
        .I3(\h_counter[0]_i_14_n_0 ),
        .O(\h_counter[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[0]_i_7 
       (.I0(h_counter_reg[3]),
        .O(\h_counter[0]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[0]_i_8 
       (.I0(h_counter_reg[2]),
        .O(\h_counter[0]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[0]_i_9 
       (.I0(h_counter_reg[1]),
        .O(\h_counter[0]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[12]_i_2 
       (.I0(h_counter_reg[15]),
        .O(\h_counter[12]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[12]_i_3 
       (.I0(h_counter_reg[14]),
        .O(\h_counter[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[12]_i_4 
       (.I0(h_counter_reg[13]),
        .O(\h_counter[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[12]_i_5 
       (.I0(h_counter_reg[12]),
        .O(\h_counter[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[4]_i_2 
       (.I0(h_counter_reg[7]),
        .O(\h_counter[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[4]_i_3 
       (.I0(h_counter_reg[6]),
        .O(\h_counter[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[4]_i_4 
       (.I0(h_counter_reg[5]),
        .O(\h_counter[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[4]_i_5 
       (.I0(h_counter_reg[4]),
        .O(\h_counter[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[8]_i_2 
       (.I0(h_counter_reg[11]),
        .O(\h_counter[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[8]_i_3 
       (.I0(h_counter_reg[10]),
        .O(\h_counter[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[8]_i_4 
       (.I0(h_counter_reg[9]),
        .O(\h_counter[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \h_counter[8]_i_5 
       (.I0(h_counter_reg[8]),
        .O(\h_counter[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[0]_i_3_n_7 ),
        .Q(h_counter_reg[0]),
        .R(rst_internal));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \h_counter_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\h_counter_reg[0]_i_3_n_0 ,\h_counter_reg[0]_i_3_n_1 ,\h_counter_reg[0]_i_3_n_2 ,\h_counter_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\h_counter_reg[0]_i_3_n_4 ,\h_counter_reg[0]_i_3_n_5 ,\h_counter_reg[0]_i_3_n_6 ,\h_counter_reg[0]_i_3_n_7 }),
        .S({\h_counter[0]_i_7_n_0 ,\h_counter[0]_i_8_n_0 ,\h_counter[0]_i_9_n_0 ,\h_counter[0]_i_10_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[8]_i_1_n_5 ),
        .Q(h_counter_reg[10]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[8]_i_1_n_4 ),
        .Q(h_counter_reg[11]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[12]_i_1_n_7 ),
        .Q(h_counter_reg[12]),
        .R(rst_internal));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \h_counter_reg[12]_i_1 
       (.CI(\h_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_h_counter_reg[12]_i_1_CO_UNCONNECTED [3],\h_counter_reg[12]_i_1_n_1 ,\h_counter_reg[12]_i_1_n_2 ,\h_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b1,1'b1,1'b1}),
        .O({\h_counter_reg[12]_i_1_n_4 ,\h_counter_reg[12]_i_1_n_5 ,\h_counter_reg[12]_i_1_n_6 ,\h_counter_reg[12]_i_1_n_7 }),
        .S({\h_counter[12]_i_2_n_0 ,\h_counter[12]_i_3_n_0 ,\h_counter[12]_i_4_n_0 ,\h_counter[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[12]_i_1_n_6 ),
        .Q(h_counter_reg[13]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[12]_i_1_n_5 ),
        .Q(h_counter_reg[14]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[12]_i_1_n_4 ),
        .Q(h_counter_reg[15]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[0]_i_3_n_6 ),
        .Q(h_counter_reg[1]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[0]_i_3_n_5 ),
        .Q(h_counter_reg[2]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[0]_i_3_n_4 ),
        .Q(h_counter_reg[3]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[4]_i_1_n_7 ),
        .Q(h_counter_reg[4]),
        .R(rst_internal));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \h_counter_reg[4]_i_1 
       (.CI(\h_counter_reg[0]_i_3_n_0 ),
        .CO({\h_counter_reg[4]_i_1_n_0 ,\h_counter_reg[4]_i_1_n_1 ,\h_counter_reg[4]_i_1_n_2 ,\h_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\h_counter_reg[4]_i_1_n_4 ,\h_counter_reg[4]_i_1_n_5 ,\h_counter_reg[4]_i_1_n_6 ,\h_counter_reg[4]_i_1_n_7 }),
        .S({\h_counter[4]_i_2_n_0 ,\h_counter[4]_i_3_n_0 ,\h_counter[4]_i_4_n_0 ,\h_counter[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[4]_i_1_n_6 ),
        .Q(h_counter_reg[5]),
        .R(rst_internal));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[4]_i_1_n_5 ),
        .Q(h_counter_reg[6]),
        .S(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[4]_i_1_n_4 ),
        .Q(h_counter_reg[7]),
        .R(rst_internal));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[8]_i_1_n_7 ),
        .Q(h_counter_reg[8]),
        .R(rst_internal));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \h_counter_reg[8]_i_1 
       (.CI(\h_counter_reg[4]_i_1_n_0 ),
        .CO({\h_counter_reg[8]_i_1_n_0 ,\h_counter_reg[8]_i_1_n_1 ,\h_counter_reg[8]_i_1_n_2 ,\h_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\h_counter_reg[8]_i_1_n_4 ,\h_counter_reg[8]_i_1_n_5 ,\h_counter_reg[8]_i_1_n_6 ,\h_counter_reg[8]_i_1_n_7 }),
        .S({\h_counter[8]_i_2_n_0 ,\h_counter[8]_i_3_n_0 ,\h_counter[8]_i_4_n_0 ,\h_counter[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \h_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(h_counter),
        .D(\h_counter_reg[8]_i_1_n_6 ),
        .Q(h_counter_reg[9]),
        .R(rst_internal));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'h04)) 
    in_strb_d_i_1
       (.I0(rst_internal),
        .I1(strb_d),
        .I2(strb_dd),
        .O(trigger_strobe));
  LUT5 #(
    .INIT(32'h00000020)) 
    \latched_input[63]_i_1 
       (.I0(LED_GREEN_3_OBUF),
        .I1(rst_internal),
        .I2(strb_d),
        .I3(strb_dd),
        .I4(in_strb_d),
        .O(latched_input0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT5 #(
    .INIT(32'h0F0B0400)) 
    rd_en_i_1
       (.I0(strb_dd),
        .I1(strb_d),
        .I2(rst_internal),
        .I3(\h_counter[0]_i_6_n_0 ),
        .I4(rd_en_reg_n_0),
        .O(rd_en_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    rd_en_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rd_en_i_1_n_0),
        .Q(rd_en_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_4d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_3d),
        .Q(rst_4d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    rst_7d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_6d),
        .Q(rst_7d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    strb_d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_d_reg_0),
        .Q(strb_d),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h2)) 
    strb_dd_i_1
       (.I0(strb_d),
        .I1(rst_internal),
        .O(strb_dd_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    strb_dd_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(strb_dd_i_1_n_0),
        .Q(strb_dd),
        .R(1'b0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter2_carry
       (.CI(1'b0),
        .CO({t_counter2_carry_n_0,t_counter2_carry_n_1,t_counter2_carry_n_2,t_counter2_carry_n_3}),
        .CYINIT(1'b1),
        .DI(t_counter2_carry__0_0),
        .O(NLW_t_counter2_carry_O_UNCONNECTED[3:0]),
        .S(t_counter2_carry__0_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter2_carry__0
       (.CI(t_counter2_carry_n_0),
        .CO({\d_out_reg[19]_1 ,t_counter2_carry__0_n_1,t_counter2_carry__0_n_2,t_counter2_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(\t_counter[0]_i_4_3 ),
        .O(NLW_t_counter2_carry__0_O_UNCONNECTED[3:0]),
        .S(\t_counter[0]_i_4_4 ));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter3_carry
       (.CI(1'b0),
        .CO({t_counter3_carry_n_0,t_counter3_carry_n_1,t_counter3_carry_n_2,t_counter3_carry_n_3}),
        .CYINIT(1'b1),
        .DI(t_counter3_carry__0_0),
        .O(NLW_t_counter3_carry_O_UNCONNECTED[3:0]),
        .S(t_counter3_carry__0_1));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter3_carry__0
       (.CI(t_counter3_carry_n_0),
        .CO({\d_out_reg[19]_0 ,t_counter3_carry__0_n_1,t_counter3_carry__0_n_2,t_counter3_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(\t_counter[0]_i_4_1 ),
        .O(NLW_t_counter3_carry__0_O_UNCONNECTED[3:0]),
        .S(\t_counter[0]_i_4_2 ));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter4_carry
       (.CI(1'b0),
        .CO({t_counter4_carry_n_0,t_counter4_carry_n_1,t_counter4_carry_n_2,t_counter4_carry_n_3}),
        .CYINIT(1'b1),
        .DI(t_counter4_carry__0_0),
        .O(NLW_t_counter4_carry_O_UNCONNECTED[3:0]),
        .S(S));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 t_counter4_carry__0
       (.CI(t_counter4_carry_n_0),
        .CO({\d_out_reg[19] ,t_counter4_carry__0_n_1,t_counter4_carry__0_n_2,t_counter4_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(\t_counter[0]_i_4 ),
        .O(NLW_t_counter4_carry__0_O_UNCONNECTED[3:0]),
        .S(\t_counter[0]_i_4_0 ));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \t_counter4_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\t_counter4_inferred__0/i__carry_n_0 ,\t_counter4_inferred__0/i__carry_n_1 ,\t_counter4_inferred__0/i__carry_n_2 ,\t_counter4_inferred__0/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI(\t_counter4_inferred__0/i__carry__0_0 ),
        .O(\NLW_t_counter4_inferred__0/i__carry_O_UNCONNECTED [3:0]),
        .S(\t_counter4_inferred__0/i__carry__0_1 ));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \t_counter4_inferred__0/i__carry__0 
       (.CI(\t_counter4_inferred__0/i__carry_n_0 ),
        .CO({CO,\t_counter4_inferred__0/i__carry__0_n_1 ,\t_counter4_inferred__0/i__carry__0_n_2 ,\t_counter4_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI(\t_counter[0]_i_4_5 ),
        .O(\NLW_t_counter4_inferred__0/i__carry__0_O_UNCONNECTED [3:0]),
        .S(\t_counter[0]_i_4_6 ));
  LUT5 #(
    .INIT(32'hAEAAAAAA)) 
    \t_counter[0]_i_1 
       (.I0(rst_internal),
        .I1(strb_d),
        .I2(strb_dd),
        .I3(t_counter0),
        .I4(\h_counter[0]_i_6_n_0 ),
        .O(\t_counter[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[0]_i_10 
       (.I0(t_counter_reg[0]),
        .O(\t_counter[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \t_counter[0]_i_11 
       (.I0(t_counter_reg[1]),
        .I1(t_counter_reg[5]),
        .I2(t_counter_reg[0]),
        .I3(t_counter_reg[8]),
        .O(\t_counter[0]_i_11_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \t_counter[0]_i_12 
       (.I0(t_counter_reg[11]),
        .I1(t_counter_reg[12]),
        .I2(t_counter_reg[15]),
        .I3(t_counter_reg[10]),
        .I4(\t_counter[0]_i_13_n_0 ),
        .O(\t_counter[0]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \t_counter[0]_i_13 
       (.I0(t_counter_reg[13]),
        .I1(t_counter_reg[7]),
        .I2(t_counter_reg[14]),
        .I3(t_counter_reg[9]),
        .O(\t_counter[0]_i_13_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \t_counter[0]_i_2 
       (.I0(\t_counter[0]_i_5_n_0 ),
        .I1(\t_counter[0]_i_6_n_0 ),
        .O(\t_counter[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0400)) 
    \t_counter[0]_i_5 
       (.I0(strb_dd),
        .I1(strb_d),
        .I2(rst_internal),
        .I3(\h_counter[0]_i_6_n_0 ),
        .O(\t_counter[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \t_counter[0]_i_6 
       (.I0(\t_counter[0]_i_11_n_0 ),
        .I1(t_counter_reg[3]),
        .I2(t_counter_reg[2]),
        .I3(t_counter_reg[4]),
        .I4(t_counter_reg[6]),
        .I5(\t_counter[0]_i_12_n_0 ),
        .O(\t_counter[0]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[0]_i_7 
       (.I0(t_counter_reg[3]),
        .O(\t_counter[0]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[0]_i_8 
       (.I0(t_counter_reg[2]),
        .O(\t_counter[0]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[0]_i_9 
       (.I0(t_counter_reg[1]),
        .O(\t_counter[0]_i_9_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[12]_i_2 
       (.I0(t_counter_reg[15]),
        .O(\t_counter[12]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[12]_i_3 
       (.I0(t_counter_reg[14]),
        .O(\t_counter[12]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[12]_i_4 
       (.I0(t_counter_reg[13]),
        .O(\t_counter[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[12]_i_5 
       (.I0(t_counter_reg[12]),
        .O(\t_counter[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[4]_i_2 
       (.I0(t_counter_reg[7]),
        .O(\t_counter[4]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[4]_i_3 
       (.I0(t_counter_reg[6]),
        .O(\t_counter[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[4]_i_4 
       (.I0(t_counter_reg[5]),
        .O(\t_counter[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[4]_i_5 
       (.I0(t_counter_reg[4]),
        .O(\t_counter[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[8]_i_2 
       (.I0(t_counter_reg[11]),
        .O(\t_counter[8]_i_2_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[8]_i_3 
       (.I0(t_counter_reg[10]),
        .O(\t_counter[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[8]_i_4 
       (.I0(t_counter_reg[9]),
        .O(\t_counter[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \t_counter[8]_i_5 
       (.I0(t_counter_reg[8]),
        .O(\t_counter[8]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[0]_i_3_n_7 ),
        .Q(t_counter_reg[0]),
        .R(\t_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \t_counter_reg[0]_i_3 
       (.CI(1'b0),
        .CO({\t_counter_reg[0]_i_3_n_0 ,\t_counter_reg[0]_i_3_n_1 ,\t_counter_reg[0]_i_3_n_2 ,\t_counter_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\t_counter_reg[0]_i_3_n_4 ,\t_counter_reg[0]_i_3_n_5 ,\t_counter_reg[0]_i_3_n_6 ,\t_counter_reg[0]_i_3_n_7 }),
        .S({\t_counter[0]_i_7_n_0 ,\t_counter[0]_i_8_n_0 ,\t_counter[0]_i_9_n_0 ,\t_counter[0]_i_10_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[8]_i_1_n_5 ),
        .Q(t_counter_reg[10]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[8]_i_1_n_4 ),
        .Q(t_counter_reg[11]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[12]_i_1_n_7 ),
        .Q(t_counter_reg[12]),
        .R(\t_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \t_counter_reg[12]_i_1 
       (.CI(\t_counter_reg[8]_i_1_n_0 ),
        .CO({\NLW_t_counter_reg[12]_i_1_CO_UNCONNECTED [3],\t_counter_reg[12]_i_1_n_1 ,\t_counter_reg[12]_i_1_n_2 ,\t_counter_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b1,1'b1,1'b1}),
        .O({\t_counter_reg[12]_i_1_n_4 ,\t_counter_reg[12]_i_1_n_5 ,\t_counter_reg[12]_i_1_n_6 ,\t_counter_reg[12]_i_1_n_7 }),
        .S({\t_counter[12]_i_2_n_0 ,\t_counter[12]_i_3_n_0 ,\t_counter[12]_i_4_n_0 ,\t_counter[12]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[12]_i_1_n_6 ),
        .Q(t_counter_reg[13]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[12]_i_1_n_5 ),
        .Q(t_counter_reg[14]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[12]_i_1_n_4 ),
        .Q(t_counter_reg[15]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[0]_i_3_n_6 ),
        .Q(t_counter_reg[1]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[0]_i_3_n_5 ),
        .Q(t_counter_reg[2]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[0]_i_3_n_4 ),
        .Q(t_counter_reg[3]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[4]_i_1_n_7 ),
        .Q(t_counter_reg[4]),
        .R(\t_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \t_counter_reg[4]_i_1 
       (.CI(\t_counter_reg[0]_i_3_n_0 ),
        .CO({\t_counter_reg[4]_i_1_n_0 ,\t_counter_reg[4]_i_1_n_1 ,\t_counter_reg[4]_i_1_n_2 ,\t_counter_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\t_counter_reg[4]_i_1_n_4 ,\t_counter_reg[4]_i_1_n_5 ,\t_counter_reg[4]_i_1_n_6 ,\t_counter_reg[4]_i_1_n_7 }),
        .S({\t_counter[4]_i_2_n_0 ,\t_counter[4]_i_3_n_0 ,\t_counter[4]_i_4_n_0 ,\t_counter[4]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[4]_i_1_n_6 ),
        .Q(t_counter_reg[5]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[4]_i_1_n_5 ),
        .Q(t_counter_reg[6]),
        .R(\t_counter[0]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[4]_i_1_n_4 ),
        .Q(t_counter_reg[7]),
        .S(\t_counter[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[8]_i_1_n_7 ),
        .Q(t_counter_reg[8]),
        .R(\t_counter[0]_i_1_n_0 ));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \t_counter_reg[8]_i_1 
       (.CI(\t_counter_reg[4]_i_1_n_0 ),
        .CO({\t_counter_reg[8]_i_1_n_0 ,\t_counter_reg[8]_i_1_n_1 ,\t_counter_reg[8]_i_1_n_2 ,\t_counter_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b1,1'b1,1'b1,1'b1}),
        .O({\t_counter_reg[8]_i_1_n_4 ,\t_counter_reg[8]_i_1_n_5 ,\t_counter_reg[8]_i_1_n_6 ,\t_counter_reg[8]_i_1_n_7 }),
        .S({\t_counter[8]_i_2_n_0 ,\t_counter[8]_i_3_n_0 ,\t_counter[8]_i_4_n_0 ,\t_counter[8]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \t_counter_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\t_counter[0]_i_2_n_0 ),
        .D(\t_counter_reg[8]_i_1_n_6 ),
        .Q(t_counter_reg[9]),
        .R(\t_counter[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000CEAA)) 
    trigged_i_1
       (.I0(LED_GREEN_3_OBUF),
        .I1(t_counter0),
        .I2(\t_counter[0]_i_6_n_0 ),
        .I3(\t_counter[0]_i_5_n_0 ),
        .I4(rst_internal),
        .O(trigged_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    trigged_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(trigged_i_1_n_0),
        .Q(LED_GREEN_3_OBUF),
        .R(1'b0));
endmodule

module i2c_master_bit_ctrl
   (scl_oen_reg_0,
    sSDA_reg_0,
    SDA_TRI,
    \filter_cnt_reg[12]_0 ,
    D,
    core_txd4_out,
    cmd_ack1_out,
    c_state,
    shift5_out,
    \txr_reg[0] ,
    al_reg_0,
    cmd_phase_reg,
    cmd_phase_reg_0,
    cmd_phase_reg_1,
    al_reg_1,
    \dcnt_reg[0] ,
    \FSM_sequential_c_state_reg[1] ,
    ifclk_out_OBUF_BUFG,
    \filter_cnt_reg[3]_0 ,
    dSDA_reg_0,
    rst,
    Q,
    \core_cmd_reg[1] ,
    c_state__0,
    cmd_ack_reg_0,
    core_txd_reg,
    \core_cmd_reg[0] ,
    \FSM_sequential_c_state_reg[1]_0 ,
    \FSM_sequential_c_state_reg[1]_1 ,
    \FSM_sequential_c_state_reg[1]_2 ,
    \cmd_reg[0] ,
    shift_reg,
    sda_oen_reg_0,
    \filter_cnt_reg[4]_0 ,
    done,
    \core_cmd_reg[0]_0 ,
    sub_state__0,
    \cmd_reg[3] ,
    main_state,
    \cmd_reg[0]_0 ,
    \sr_reg[0] ,
    \sr_reg[0]_0 ,
    \FSM_sequential_c_state_reg[2] ,
    \FSM_sequential_c_state_reg[2]_0 ,
    \FSM_sequential_c_state_reg[0] ,
    SCL_IBUF,
    fSDA,
    SDA_IBUF);
  output scl_oen_reg_0;
  output sSDA_reg_0;
  output SDA_TRI;
  output \filter_cnt_reg[12]_0 ;
  output [3:0]D;
  output core_txd4_out;
  output cmd_ack1_out;
  output c_state;
  output shift5_out;
  output \txr_reg[0] ;
  output al_reg_0;
  output cmd_phase_reg;
  output cmd_phase_reg_0;
  output cmd_phase_reg_1;
  output al_reg_1;
  output \dcnt_reg[0] ;
  output \FSM_sequential_c_state_reg[1] ;
  input ifclk_out_OBUF_BUFG;
  input \filter_cnt_reg[3]_0 ;
  input dSDA_reg_0;
  input rst;
  input [3:0]Q;
  input \core_cmd_reg[1] ;
  input [2:0]c_state__0;
  input cmd_ack_reg_0;
  input core_txd_reg;
  input \core_cmd_reg[0] ;
  input \FSM_sequential_c_state_reg[1]_0 ;
  input \FSM_sequential_c_state_reg[1]_1 ;
  input \FSM_sequential_c_state_reg[1]_2 ;
  input \cmd_reg[0] ;
  input shift_reg;
  input sda_oen_reg_0;
  input \filter_cnt_reg[4]_0 ;
  input done;
  input \core_cmd_reg[0]_0 ;
  input [0:0]sub_state__0;
  input \cmd_reg[3] ;
  input [0:0]main_state;
  input \cmd_reg[0]_0 ;
  input [0:0]\sr_reg[0] ;
  input \sr_reg[0]_0 ;
  input \FSM_sequential_c_state_reg[2] ;
  input \FSM_sequential_c_state_reg[2]_0 ;
  input \FSM_sequential_c_state_reg[0] ;
  input SCL_IBUF;
  input fSDA;
  input SDA_IBUF;

  wire [3:0]D;
  wire \FSM_onehot_c_state[0]_i_1_n_0 ;
  wire \FSM_onehot_c_state[0]_i_2_n_0 ;
  wire \FSM_onehot_c_state[0]_i_3_n_0 ;
  wire \FSM_onehot_c_state[0]_i_4_n_0 ;
  wire \FSM_onehot_c_state[0]_i_5_n_0 ;
  wire \FSM_onehot_c_state[10]_i_1_n_0 ;
  wire \FSM_onehot_c_state[11]_i_1_n_0 ;
  wire \FSM_onehot_c_state[12]_i_1_n_0 ;
  wire \FSM_onehot_c_state[13]_i_1_n_0 ;
  wire \FSM_onehot_c_state[13]_i_2_n_0 ;
  wire \FSM_onehot_c_state[14]_i_1_n_0 ;
  wire \FSM_onehot_c_state[15]_i_1_n_0 ;
  wire \FSM_onehot_c_state[16]_i_1_n_0 ;
  wire \FSM_onehot_c_state[17]_i_1_n_0 ;
  wire \FSM_onehot_c_state[17]_i_2_n_0 ;
  wire \FSM_onehot_c_state[17]_i_3_n_0 ;
  wire \FSM_onehot_c_state[17]_i_4_n_0 ;
  wire \FSM_onehot_c_state[1]_i_1_n_0 ;
  wire \FSM_onehot_c_state[2]_i_1_n_0 ;
  wire \FSM_onehot_c_state[3]_i_1_n_0 ;
  wire \FSM_onehot_c_state[4]_i_1_n_0 ;
  wire \FSM_onehot_c_state[5]_i_1_n_0 ;
  wire \FSM_onehot_c_state[6]_i_1_n_0 ;
  wire \FSM_onehot_c_state[7]_i_1_n_0 ;
  wire \FSM_onehot_c_state[8]_i_1_n_0 ;
  wire \FSM_onehot_c_state[9]_i_1_n_0 ;
  wire \FSM_onehot_c_state[9]_i_2_n_0 ;
  wire \FSM_onehot_c_state[9]_i_3_n_0 ;
  wire \FSM_onehot_c_state_reg_n_0_[10] ;
  wire \FSM_onehot_c_state_reg_n_0_[11] ;
  wire \FSM_onehot_c_state_reg_n_0_[13] ;
  wire \FSM_onehot_c_state_reg_n_0_[14] ;
  wire \FSM_onehot_c_state_reg_n_0_[15] ;
  wire \FSM_onehot_c_state_reg_n_0_[16] ;
  wire \FSM_onehot_c_state_reg_n_0_[17] ;
  wire \FSM_onehot_c_state_reg_n_0_[1] ;
  wire \FSM_onehot_c_state_reg_n_0_[2] ;
  wire \FSM_onehot_c_state_reg_n_0_[3] ;
  wire \FSM_onehot_c_state_reg_n_0_[4] ;
  wire \FSM_onehot_c_state_reg_n_0_[5] ;
  wire \FSM_onehot_c_state_reg_n_0_[6] ;
  wire \FSM_onehot_c_state_reg_n_0_[7] ;
  wire \FSM_onehot_c_state_reg_n_0_[8] ;
  wire \FSM_onehot_c_state_reg_n_0_[9] ;
  wire \FSM_sequential_c_state[1]_i_2_n_0 ;
  wire \FSM_sequential_c_state_reg[0] ;
  wire \FSM_sequential_c_state_reg[1] ;
  wire \FSM_sequential_c_state_reg[1]_0 ;
  wire \FSM_sequential_c_state_reg[1]_1 ;
  wire \FSM_sequential_c_state_reg[1]_2 ;
  wire \FSM_sequential_c_state_reg[2] ;
  wire \FSM_sequential_c_state_reg[2]_0 ;
  wire [3:0]Q;
  wire SCL_IBUF;
  wire SDA_IBUF;
  wire SDA_TRI;
  wire al_i_1_n_0;
  wire al_i_2_n_0;
  wire al_i_3_n_0;
  wire al_i_4_n_0;
  wire al_reg_0;
  wire al_reg_1;
  wire \cSDA_reg_n_0_[1] ;
  wire c_state;
  wire [0:0]c_state_0;
  wire [2:0]c_state__0;
  wire clk_en;
  wire \cmd[3]_i_2_n_0 ;
  wire cmd_ack1_out;
  wire cmd_ack3_out;
  wire cmd_ack_reg_0;
  wire cmd_phase_reg;
  wire cmd_phase_reg_0;
  wire cmd_phase_reg_1;
  wire \cmd_reg[0] ;
  wire \cmd_reg[0]_0 ;
  wire \cmd_reg[3] ;
  wire cmd_stop_i_1_n_0;
  wire cmd_stop_i_2_n_0;
  wire cmd_stop_reg_n_0;
  wire [15:0]cnt;
  wire [15:1]cnt0;
  wire cnt0_carry__0_i_1_n_0;
  wire cnt0_carry__0_i_2_n_0;
  wire cnt0_carry__0_i_3_n_0;
  wire cnt0_carry__0_i_4_n_0;
  wire cnt0_carry__0_n_0;
  wire cnt0_carry__0_n_1;
  wire cnt0_carry__0_n_2;
  wire cnt0_carry__0_n_3;
  wire cnt0_carry__1_i_1_n_0;
  wire cnt0_carry__1_i_2_n_0;
  wire cnt0_carry__1_i_3_n_0;
  wire cnt0_carry__1_i_4_n_0;
  wire cnt0_carry__1_n_0;
  wire cnt0_carry__1_n_1;
  wire cnt0_carry__1_n_2;
  wire cnt0_carry__1_n_3;
  wire cnt0_carry__2_i_1_n_0;
  wire cnt0_carry__2_i_2_n_0;
  wire cnt0_carry__2_i_3_n_0;
  wire cnt0_carry__2_n_2;
  wire cnt0_carry__2_n_3;
  wire cnt0_carry_i_1_n_0;
  wire cnt0_carry_i_2_n_0;
  wire cnt0_carry_i_3_n_0;
  wire cnt0_carry_i_4_n_0;
  wire cnt0_carry_n_0;
  wire cnt0_carry_n_1;
  wire cnt0_carry_n_2;
  wire cnt0_carry_n_3;
  wire cnt1;
  wire \cnt[0]_i_1_n_0 ;
  wire \cnt[15]_i_1_n_0 ;
  wire \cnt[15]_i_2_n_0 ;
  wire \cnt[15]_i_3_n_0 ;
  wire \cnt[15]_i_4_n_0 ;
  wire \cnt[15]_i_5_n_0 ;
  wire \cnt[15]_i_6_n_0 ;
  wire core_ack;
  wire \core_cmd[3]_i_3_n_0 ;
  wire \core_cmd[3]_i_4_n_0 ;
  wire \core_cmd_reg[0] ;
  wire \core_cmd_reg[0]_0 ;
  wire \core_cmd_reg[1] ;
  wire core_rxd;
  wire core_txd4_out;
  wire core_txd_reg;
  wire dSCL;
  wire dSCL_i_1_n_0;
  wire dSDA;
  wire dSDA_reg_0;
  wire \dcnt_reg[0] ;
  wire done;
  wire dout_i_1_n_0;
  wire dscl_oen;
  wire \fSCL_reg_n_0_[2] ;
  wire fSDA;
  wire \fSDA_reg_n_0_[0] ;
  wire \fSDA_reg_n_0_[1] ;
  wire \fSDA_reg_n_0_[2] ;
  wire [13:0]filter_cnt;
  wire [13:1]filter_cnt0;
  wire filter_cnt0_carry__0_i_1_n_0;
  wire filter_cnt0_carry__0_i_2_n_0;
  wire filter_cnt0_carry__0_i_3_n_0;
  wire filter_cnt0_carry__0_i_4_n_0;
  wire filter_cnt0_carry__0_n_0;
  wire filter_cnt0_carry__0_n_1;
  wire filter_cnt0_carry__0_n_2;
  wire filter_cnt0_carry__0_n_3;
  wire filter_cnt0_carry__1_i_1_n_0;
  wire filter_cnt0_carry__1_i_2_n_0;
  wire filter_cnt0_carry__1_i_3_n_0;
  wire filter_cnt0_carry__1_i_4_n_0;
  wire filter_cnt0_carry__1_n_0;
  wire filter_cnt0_carry__1_n_1;
  wire filter_cnt0_carry__1_n_2;
  wire filter_cnt0_carry__1_n_3;
  wire filter_cnt0_carry__2_i_1_n_0;
  wire filter_cnt0_carry_i_1_n_0;
  wire filter_cnt0_carry_i_2_n_0;
  wire filter_cnt0_carry_i_3_n_0;
  wire filter_cnt0_carry_i_4_n_0;
  wire filter_cnt0_carry_n_0;
  wire filter_cnt0_carry_n_1;
  wire filter_cnt0_carry_n_2;
  wire filter_cnt0_carry_n_3;
  wire \filter_cnt[0]_i_1_n_0 ;
  wire \filter_cnt[10]_i_1_n_0 ;
  wire \filter_cnt[11]_i_1_n_0 ;
  wire \filter_cnt[12]_i_1_n_0 ;
  wire \filter_cnt[13]_i_1_n_0 ;
  wire \filter_cnt[13]_i_2_n_0 ;
  wire \filter_cnt[13]_i_4_n_0 ;
  wire \filter_cnt[13]_i_5_n_0 ;
  wire \filter_cnt[1]_i_1_n_0 ;
  wire \filter_cnt[2]_i_1_n_0 ;
  wire \filter_cnt[3]_i_2_n_0 ;
  wire \filter_cnt[4]_i_1_n_0 ;
  wire \filter_cnt[5]_i_1_n_0 ;
  wire \filter_cnt[6]_i_1_n_0 ;
  wire \filter_cnt[7]_i_1_n_0 ;
  wire \filter_cnt[8]_i_1_n_0 ;
  wire \filter_cnt[9]_i_1_n_0 ;
  wire \filter_cnt_reg[12]_0 ;
  wire \filter_cnt_reg[3]_0 ;
  wire \filter_cnt_reg[4]_0 ;
  wire i2c_al;
  wire ifclk_out_OBUF_BUFG;
  wire [0:0]main_state;
  wire [1:1]p_0_in;
  wire [1:1]p_0_in__0;
  wire [2:0]p_0_in__1;
  wire rst;
  wire sSCL;
  wire sSCL_i_1_n_0;
  wire sSDA_i_1_n_0;
  wire sSDA_reg_0;
  wire scl_oen_i_1_n_0;
  wire scl_oen_i_2_n_0;
  wire scl_oen_i_3_n_0;
  wire scl_oen_reg_0;
  wire sda_chk;
  wire sda_chk_i_1_n_0;
  wire sda_chk_reg_n_0;
  wire sda_oen_i_1_n_0;
  wire sda_oen_i_2_n_0;
  wire sda_oen_i_3_n_0;
  wire sda_oen_i_4_n_0;
  wire sda_oen_i_5_n_0;
  wire sda_oen_reg_0;
  wire shift5_out;
  wire shift_reg;
  wire slave_wait;
  wire slave_wait0;
  wire [0:0]\sr_reg[0] ;
  wire \sr_reg[0]_0 ;
  wire sto_condition_i_1_n_0;
  wire sto_condition_reg_n_0;
  wire [0:0]sub_state__0;
  wire \txr_reg[0] ;
  wire [3:2]NLW_cnt0_carry__2_CO_UNCONNECTED;
  wire [3:3]NLW_cnt0_carry__2_O_UNCONNECTED;
  wire [3:0]NLW_filter_cnt0_carry__2_CO_UNCONNECTED;
  wire [3:1]NLW_filter_cnt0_carry__2_O_UNCONNECTED;

  LUT6 #(
    .INIT(64'hFEEEFEFFFEEEFEEE)) 
    \FSM_onehot_c_state[0]_i_1 
       (.I0(rst),
        .I1(i2c_al),
        .I2(\FSM_onehot_c_state[0]_i_2_n_0 ),
        .I3(c_state_0),
        .I4(\FSM_onehot_c_state[9]_i_3_n_0 ),
        .I5(\FSM_onehot_c_state[0]_i_3_n_0 ),
        .O(\FSM_onehot_c_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hFEE9)) 
    \FSM_onehot_c_state[0]_i_2 
       (.I0(Q[0]),
        .I1(Q[1]),
        .I2(Q[2]),
        .I3(Q[3]),
        .O(\FSM_onehot_c_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAABAAABAAABAAAA)) 
    \FSM_onehot_c_state[0]_i_3 
       (.I0(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[8] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[7] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[9] ),
        .I5(\FSM_onehot_c_state[0]_i_4_n_0 ),
        .O(\FSM_onehot_c_state[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h1111111100000001)) 
    \FSM_onehot_c_state[0]_i_4 
       (.I0(\FSM_onehot_c_state[0]_i_5_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I3(sda_chk),
        .I4(\FSM_onehot_c_state_reg_n_0_[11] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[17] ),
        .O(\FSM_onehot_c_state[0]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \FSM_onehot_c_state[0]_i_5 
       (.I0(\FSM_onehot_c_state_reg_n_0_[16] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[15] ),
        .O(\FSM_onehot_c_state[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000400000)) 
    \FSM_onehot_c_state[10]_i_1 
       (.I0(Q[0]),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(c_state_0),
        .I3(Q[1]),
        .I4(Q[2]),
        .I5(Q[3]),
        .O(\FSM_onehot_c_state[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'h0008)) 
    \FSM_onehot_c_state[11]_i_1 
       (.I0(\FSM_onehot_c_state[13]_i_2_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I3(c_state_0),
        .O(\FSM_onehot_c_state[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \FSM_onehot_c_state[12]_i_1 
       (.I0(\FSM_onehot_c_state[13]_i_2_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[11] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I3(c_state_0),
        .I4(\FSM_onehot_c_state_reg_n_0_[14] ),
        .O(\FSM_onehot_c_state[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \FSM_onehot_c_state[13]_i_1 
       (.I0(\FSM_onehot_c_state[13]_i_2_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[11] ),
        .I2(sda_chk),
        .I3(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I4(c_state_0),
        .I5(\FSM_onehot_c_state_reg_n_0_[14] ),
        .O(\FSM_onehot_c_state[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000002)) 
    \FSM_onehot_c_state[13]_i_2 
       (.I0(\FSM_onehot_c_state[17]_i_3_n_0 ),
        .I1(i2c_al),
        .I2(rst),
        .I3(\FSM_onehot_c_state_reg_n_0_[17] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[15] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[16] ),
        .O(\FSM_onehot_c_state[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000400000)) 
    \FSM_onehot_c_state[14]_i_1 
       (.I0(Q[0]),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(c_state_0),
        .I3(Q[1]),
        .I4(Q[3]),
        .I5(Q[2]),
        .O(\FSM_onehot_c_state[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h00000008)) 
    \FSM_onehot_c_state[15]_i_1 
       (.I0(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I1(\FSM_onehot_c_state[17]_i_3_n_0 ),
        .I2(rst),
        .I3(i2c_al),
        .I4(c_state_0),
        .O(\FSM_onehot_c_state[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \FSM_onehot_c_state[16]_i_1 
       (.I0(\FSM_onehot_c_state[17]_i_3_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[15] ),
        .I2(c_state_0),
        .I3(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I4(i2c_al),
        .I5(rst),
        .O(\FSM_onehot_c_state[16]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hFE)) 
    \FSM_onehot_c_state[17]_i_1 
       (.I0(i2c_al),
        .I1(rst),
        .I2(clk_en),
        .O(\FSM_onehot_c_state[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000010000000)) 
    \FSM_onehot_c_state[17]_i_2 
       (.I0(\FSM_onehot_c_state_reg_n_0_[15] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[16] ),
        .I3(\FSM_onehot_c_state[17]_i_3_n_0 ),
        .I4(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I5(c_state_0),
        .O(\FSM_onehot_c_state[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \FSM_onehot_c_state[17]_i_3 
       (.I0(\FSM_onehot_c_state_reg_n_0_[8] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[9] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[7] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I5(\FSM_onehot_c_state[9]_i_3_n_0 ),
        .O(\FSM_onehot_c_state[17]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \FSM_onehot_c_state[17]_i_4 
       (.I0(i2c_al),
        .I1(rst),
        .O(\FSM_onehot_c_state[17]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000004000)) 
    \FSM_onehot_c_state[1]_i_1 
       (.I0(Q[1]),
        .I1(c_state_0),
        .I2(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I3(Q[0]),
        .I4(Q[2]),
        .I5(Q[3]),
        .O(\FSM_onehot_c_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'h0002)) 
    \FSM_onehot_c_state[2]_i_1 
       (.I0(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I1(c_state_0),
        .I2(i2c_al),
        .I3(rst),
        .O(\FSM_onehot_c_state[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h00000100)) 
    \FSM_onehot_c_state[3]_i_1 
       (.I0(c_state_0),
        .I1(i2c_al),
        .I2(rst),
        .I3(\FSM_onehot_c_state_reg_n_0_[2] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[1] ),
        .O(\FSM_onehot_c_state[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \FSM_onehot_c_state[4]_i_1 
       (.I0(\FSM_onehot_c_state_reg_n_0_[2] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I2(i2c_al),
        .I3(rst),
        .I4(\FSM_onehot_c_state_reg_n_0_[3] ),
        .I5(c_state_0),
        .O(\FSM_onehot_c_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000040)) 
    \FSM_onehot_c_state[5]_i_1 
       (.I0(c_state_0),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(\FSM_onehot_c_state_reg_n_0_[4] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[2] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[3] ),
        .O(\FSM_onehot_c_state[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \FSM_onehot_c_state[6]_i_1 
       (.I0(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I1(c_state_0),
        .I2(Q[0]),
        .I3(Q[3]),
        .I4(Q[2]),
        .I5(Q[1]),
        .O(\FSM_onehot_c_state[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \FSM_onehot_c_state[7]_i_1 
       (.I0(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I1(rst),
        .I2(i2c_al),
        .I3(c_state_0),
        .I4(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I5(\FSM_onehot_c_state[9]_i_3_n_0 ),
        .O(\FSM_onehot_c_state[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000040000)) 
    \FSM_onehot_c_state[8]_i_1 
       (.I0(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(c_state_0),
        .I3(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[7] ),
        .I5(\FSM_onehot_c_state[9]_i_3_n_0 ),
        .O(\FSM_onehot_c_state[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \FSM_onehot_c_state[9]_i_1 
       (.I0(\FSM_onehot_c_state[9]_i_2_n_0 ),
        .I1(\FSM_onehot_c_state_reg_n_0_[8] ),
        .I2(\FSM_onehot_c_state[9]_i_3_n_0 ),
        .I3(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[7] ),
        .O(\FSM_onehot_c_state[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \FSM_onehot_c_state[9]_i_2 
       (.I0(rst),
        .I1(i2c_al),
        .I2(c_state_0),
        .O(\FSM_onehot_c_state[9]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_c_state[9]_i_3 
       (.I0(\FSM_onehot_c_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[1] ),
        .O(\FSM_onehot_c_state[9]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b1)) 
    \FSM_onehot_c_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[0]_i_1_n_0 ),
        .Q(c_state_0),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[10]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[10] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[11]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[11] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[12]_i_1_n_0 ),
        .Q(sda_chk),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[13]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[13] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[14]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[14] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[15]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[15] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[16]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[16] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[17]_i_2_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[17] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[1]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[1] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[2]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[2] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[3]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[3] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[4] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[5]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[5] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[6]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[6] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[7]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[7] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[8]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[8] ),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "wr_b:000000100000000000,start_d:000000000000010000,start_c:000000000000001000,wr_a:000000010000000000,rd_a:000100000000000000,wr_d:000010000000000000,stop_a:000000000001000000,stop_d:000000001000000000,stop_c:000000000100000000,rd_b:001000000000000000,start_b:000000000000000100,rd_d:100000000000000000,wr_c:000001000000000000,start_e:000000000000100000,stop_b:000000000010000000,start_a:000000000000000010,rd_c:010000000000000000,idle:000000000000000001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_c_state_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_c_state[17]_i_1_n_0 ),
        .D(\FSM_onehot_c_state[9]_i_1_n_0 ),
        .Q(\FSM_onehot_c_state_reg_n_0_[9] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0A00FFFF02000000)) 
    \FSM_sequential_c_state[0]_i_1 
       (.I0(\FSM_sequential_c_state_reg[2]_0 ),
        .I1(c_state__0[1]),
        .I2(\FSM_sequential_c_state_reg[0] ),
        .I3(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I4(c_state),
        .I5(c_state__0[0]),
        .O(\FSM_sequential_c_state_reg[1] ));
  LUT6 #(
    .INIT(64'hFE00FFFFFF000000)) 
    \FSM_sequential_c_state[1]_i_1 
       (.I0(\FSM_sequential_c_state_reg[1]_2 ),
        .I1(\FSM_sequential_c_state_reg[1]_1 ),
        .I2(\FSM_sequential_c_state_reg[1]_0 ),
        .I3(\FSM_sequential_c_state[1]_i_2_n_0 ),
        .I4(c_state),
        .I5(c_state__0[1]),
        .O(\dcnt_reg[0] ));
  LUT6 #(
    .INIT(64'h4444440444444400)) 
    \FSM_sequential_c_state[1]_i_2 
       (.I0(c_state__0[2]),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(\core_cmd_reg[0] ),
        .I3(c_state__0[1]),
        .I4(c_state__0[0]),
        .I5(\cmd_reg[0] ),
        .O(\FSM_sequential_c_state[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h1011FFFF10110000)) 
    \FSM_sequential_c_state[2]_i_1 
       (.I0(rst),
        .I1(i2c_al),
        .I2(\FSM_sequential_c_state_reg[2] ),
        .I3(\FSM_sequential_c_state_reg[2]_0 ),
        .I4(c_state),
        .I5(c_state__0[2]),
        .O(al_reg_1));
  LUT6 #(
    .INIT(64'hFFFFFFFF04040400)) 
    al_i_1
       (.I0(rst),
        .I1(sto_condition_reg_n_0),
        .I2(cmd_stop_reg_n_0),
        .I3(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I4(al_i_2_n_0),
        .I5(al_i_3_n_0),
        .O(al_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    al_i_2
       (.I0(al_i_4_n_0),
        .I1(\FSM_onehot_c_state_reg_n_0_[5] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[7] ),
        .I5(scl_oen_i_3_n_0),
        .O(al_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    al_i_3
       (.I0(rst),
        .I1(sSDA_reg_0),
        .I2(sda_chk_reg_n_0),
        .I3(SDA_TRI),
        .O(al_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    al_i_4
       (.I0(sda_oen_i_3_n_0),
        .I1(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I2(sda_chk),
        .I3(\FSM_onehot_c_state_reg_n_0_[11] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[13] ),
        .O(al_i_4_n_0));
  FDRE #(
    .INIT(1'b0)) 
    al_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(al_i_1_n_0),
        .Q(i2c_al),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \cSCL_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(SCL_IBUF),
        .Q(p_0_in),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cSCL_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in),
        .Q(p_0_in__1[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cSDA_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(SDA_IBUF),
        .Q(p_0_in__0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cSDA_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0),
        .Q(\cSDA_reg_n_0_[1] ),
        .R(rst));
  LUT6 #(
    .INIT(64'hFFFFFFFFBAAAFFFF)) 
    clk_en_i_1
       (.I0(\cnt[15]_i_3_n_0 ),
        .I1(sSCL),
        .I2(dSCL),
        .I3(scl_oen_reg_0),
        .I4(\filter_cnt_reg[4]_0 ),
        .I5(rst),
        .O(cnt1));
  FDRE #(
    .INIT(1'b0)) 
    clk_en_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(cnt1),
        .Q(clk_en),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0444FFFF04440000)) 
    \cmd[0]_i_1 
       (.I0(\cmd_reg[0]_0 ),
        .I1(main_state),
        .I2(\cmd_reg[3] ),
        .I3(sub_state__0),
        .I4(\cmd[3]_i_2_n_0 ),
        .I5(\cmd_reg[0] ),
        .O(cmd_phase_reg_1));
  LUT6 #(
    .INIT(64'h0040FFFF00400000)) 
    \cmd[2]_i_1 
       (.I0(\cmd_reg[0]_0 ),
        .I1(main_state),
        .I2(\cmd_reg[3] ),
        .I3(sub_state__0),
        .I4(\cmd[3]_i_2_n_0 ),
        .I5(cmd_ack_reg_0),
        .O(cmd_phase_reg_0));
  LUT6 #(
    .INIT(64'h0004FFFF00040000)) 
    \cmd[3]_i_1 
       (.I0(\cmd_reg[0]_0 ),
        .I1(main_state),
        .I2(\cmd_reg[3] ),
        .I3(sub_state__0),
        .I4(\cmd[3]_i_2_n_0 ),
        .I5(\core_cmd_reg[0] ),
        .O(cmd_phase_reg));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF0070)) 
    \cmd[3]_i_2 
       (.I0(sub_state__0),
        .I1(\cmd_reg[3] ),
        .I2(main_state),
        .I3(\cmd_reg[0]_0 ),
        .I4(done),
        .I5(i2c_al),
        .O(\cmd[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8888888888888880)) 
    cmd_ack_i_1
       (.I0(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I1(clk_en),
        .I2(\FSM_onehot_c_state_reg_n_0_[17] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[13] ),
        .I4(\FSM_onehot_c_state_reg_n_0_[9] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[5] ),
        .O(cmd_ack3_out));
  LUT6 #(
    .INIT(64'h00008A0000000000)) 
    cmd_ack_i_1__0
       (.I0(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I1(c_state__0[0]),
        .I2(cmd_ack_reg_0),
        .I3(c_state__0[2]),
        .I4(c_state__0[1]),
        .I5(core_ack),
        .O(cmd_ack1_out));
  FDRE #(
    .INIT(1'b0)) 
    cmd_ack_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(cmd_ack3_out),
        .Q(core_ack),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h000004FF00000400)) 
    cmd_stop_i_1
       (.I0(cmd_stop_i_2_n_0),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(clk_en),
        .I4(rst),
        .I5(cmd_stop_reg_n_0),
        .O(cmd_stop_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'hE)) 
    cmd_stop_i_2
       (.I0(Q[2]),
        .I1(Q[3]),
        .O(cmd_stop_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    cmd_stop_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(cmd_stop_i_1_n_0),
        .Q(cmd_stop_reg_n_0),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 cnt0_carry
       (.CI(1'b0),
        .CO({cnt0_carry_n_0,cnt0_carry_n_1,cnt0_carry_n_2,cnt0_carry_n_3}),
        .CYINIT(cnt[0]),
        .DI(cnt[4:1]),
        .O(cnt0[4:1]),
        .S({cnt0_carry_i_1_n_0,cnt0_carry_i_2_n_0,cnt0_carry_i_3_n_0,cnt0_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 cnt0_carry__0
       (.CI(cnt0_carry_n_0),
        .CO({cnt0_carry__0_n_0,cnt0_carry__0_n_1,cnt0_carry__0_n_2,cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(cnt[8:5]),
        .O(cnt0[8:5]),
        .S({cnt0_carry__0_i_1_n_0,cnt0_carry__0_i_2_n_0,cnt0_carry__0_i_3_n_0,cnt0_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__0_i_1
       (.I0(cnt[8]),
        .O(cnt0_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__0_i_2
       (.I0(cnt[7]),
        .O(cnt0_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__0_i_3
       (.I0(cnt[6]),
        .O(cnt0_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__0_i_4
       (.I0(cnt[5]),
        .O(cnt0_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 cnt0_carry__1
       (.CI(cnt0_carry__0_n_0),
        .CO({cnt0_carry__1_n_0,cnt0_carry__1_n_1,cnt0_carry__1_n_2,cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(cnt[12:9]),
        .O(cnt0[12:9]),
        .S({cnt0_carry__1_i_1_n_0,cnt0_carry__1_i_2_n_0,cnt0_carry__1_i_3_n_0,cnt0_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__1_i_1
       (.I0(cnt[12]),
        .O(cnt0_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__1_i_2
       (.I0(cnt[11]),
        .O(cnt0_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__1_i_3
       (.I0(cnt[10]),
        .O(cnt0_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__1_i_4
       (.I0(cnt[9]),
        .O(cnt0_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 cnt0_carry__2
       (.CI(cnt0_carry__1_n_0),
        .CO({NLW_cnt0_carry__2_CO_UNCONNECTED[3:2],cnt0_carry__2_n_2,cnt0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,cnt[14:13]}),
        .O({NLW_cnt0_carry__2_O_UNCONNECTED[3],cnt0[15:13]}),
        .S({1'b0,cnt0_carry__2_i_1_n_0,cnt0_carry__2_i_2_n_0,cnt0_carry__2_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__2_i_1
       (.I0(cnt[15]),
        .O(cnt0_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__2_i_2
       (.I0(cnt[14]),
        .O(cnt0_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry__2_i_3
       (.I0(cnt[13]),
        .O(cnt0_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry_i_1
       (.I0(cnt[4]),
        .O(cnt0_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry_i_2
       (.I0(cnt[3]),
        .O(cnt0_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry_i_3
       (.I0(cnt[2]),
        .O(cnt0_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    cnt0_carry_i_4
       (.I0(cnt[1]),
        .O(cnt0_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \cnt[0]_i_1 
       (.I0(cnt[0]),
        .O(\cnt[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFDFFFDFDFDFDFDFD)) 
    \cnt[15]_i_1 
       (.I0(\filter_cnt_reg[4]_0 ),
        .I1(rst),
        .I2(\cnt[15]_i_3_n_0 ),
        .I3(sSCL),
        .I4(dSCL),
        .I5(scl_oen_reg_0),
        .O(\cnt[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h08FF)) 
    \cnt[15]_i_2 
       (.I0(scl_oen_reg_0),
        .I1(dSCL),
        .I2(sSCL),
        .I3(slave_wait),
        .O(\cnt[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \cnt[15]_i_3 
       (.I0(\cnt[15]_i_4_n_0 ),
        .I1(cnt[4]),
        .I2(cnt[6]),
        .I3(cnt[0]),
        .I4(cnt[14]),
        .I5(\cnt[15]_i_5_n_0 ),
        .O(\cnt[15]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \cnt[15]_i_4 
       (.I0(cnt[15]),
        .I1(cnt[9]),
        .I2(cnt[13]),
        .I3(cnt[12]),
        .O(\cnt[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \cnt[15]_i_5 
       (.I0(cnt[2]),
        .I1(cnt[3]),
        .I2(cnt[5]),
        .I3(cnt[7]),
        .I4(\cnt[15]_i_6_n_0 ),
        .O(\cnt[15]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \cnt[15]_i_6 
       (.I0(cnt[8]),
        .I1(cnt[11]),
        .I2(cnt[1]),
        .I3(cnt[10]),
        .O(\cnt[15]_i_6_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(\cnt[0]_i_1_n_0 ),
        .Q(cnt[0]),
        .S(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[10]),
        .Q(cnt[10]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[11]),
        .Q(cnt[11]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[12]),
        .Q(cnt[12]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[13]),
        .Q(cnt[13]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[14]),
        .Q(cnt[14]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[15]),
        .Q(cnt[15]),
        .R(\cnt[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[1]),
        .Q(cnt[1]),
        .S(\cnt[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[2]),
        .Q(cnt[2]),
        .S(\cnt[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[3]),
        .Q(cnt[3]),
        .S(\cnt[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[4]),
        .Q(cnt[4]),
        .S(\cnt[15]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \cnt_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[5]),
        .Q(cnt[5]),
        .S(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[6]),
        .Q(cnt[6]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[7]),
        .Q(cnt[7]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[8]),
        .Q(cnt[8]),
        .R(\cnt[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\cnt[15]_i_2_n_0 ),
        .D(cnt0[9]),
        .Q(cnt[9]),
        .R(\cnt[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    \core_cmd[0]_i_1 
       (.I0(c_state__0[2]),
        .I1(i2c_al),
        .I2(rst),
        .I3(c_state__0[0]),
        .I4(c_state__0[1]),
        .I5(\core_cmd_reg[0] ),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h1010111010101010)) 
    \core_cmd[1]_i_1 
       (.I0(rst),
        .I1(i2c_al),
        .I2(\core_cmd_reg[1] ),
        .I3(c_state__0[2]),
        .I4(c_state__0[0]),
        .I5(cmd_ack_reg_0),
        .O(D[1]));
  LUT6 #(
    .INIT(64'h88888882AAAAAAAA)) 
    \core_cmd[2]_i_1 
       (.I0(\FSM_sequential_c_state[1]_i_2_n_0 ),
        .I1(c_state__0[0]),
        .I2(\FSM_sequential_c_state_reg[1]_0 ),
        .I3(\FSM_sequential_c_state_reg[1]_1 ),
        .I4(\FSM_sequential_c_state_reg[1]_2 ),
        .I5(c_state__0[1]),
        .O(D[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFAEEA)) 
    \core_cmd[3]_i_1 
       (.I0(\core_cmd[3]_i_3_n_0 ),
        .I1(core_ack),
        .I2(c_state__0[2]),
        .I3(c_state__0[1]),
        .I4(i2c_al),
        .I5(rst),
        .O(c_state));
  LUT6 #(
    .INIT(64'h2222222800000000)) 
    \core_cmd[3]_i_2 
       (.I0(\core_cmd[3]_i_4_n_0 ),
        .I1(c_state__0[0]),
        .I2(\FSM_sequential_c_state_reg[1]_0 ),
        .I3(\FSM_sequential_c_state_reg[1]_1 ),
        .I4(\FSM_sequential_c_state_reg[1]_2 ),
        .I5(c_state__0[1]),
        .O(D[3]));
  LUT6 #(
    .INIT(64'h00000000FF540054)) 
    \core_cmd[3]_i_3 
       (.I0(done),
        .I1(\cmd_reg[0] ),
        .I2(cmd_ack_reg_0),
        .I3(c_state__0[0]),
        .I4(core_ack),
        .I5(\core_cmd_reg[0]_0 ),
        .O(\core_cmd[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \core_cmd[3]_i_4 
       (.I0(rst),
        .I1(i2c_al),
        .I2(c_state__0[2]),
        .O(\core_cmd[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0A020000AA8A0080)) 
    core_txd_i_1
       (.I0(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I1(core_ack),
        .I2(c_state__0[2]),
        .I3(c_state__0[0]),
        .I4(core_txd_reg),
        .I5(c_state__0[1]),
        .O(core_txd4_out));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'hE)) 
    dSCL_i_1
       (.I0(sSCL),
        .I1(rst),
        .O(dSCL_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dSCL_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(dSCL_i_1_n_0),
        .Q(dSCL),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    dSDA_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(dSDA_reg_0),
        .Q(dSDA),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFB08)) 
    dout_i_1
       (.I0(sSDA_reg_0),
        .I1(sSCL),
        .I2(dSCL),
        .I3(core_rxd),
        .O(dout_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dout_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(dout_i_1_n_0),
        .Q(core_rxd),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    dscl_oen_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(scl_oen_reg_0),
        .Q(dscl_oen),
        .R(1'b0));
  FDSE #(
    .INIT(1'b1)) 
    \fSCL_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(p_0_in__1[0]),
        .Q(p_0_in__1[1]),
        .S(rst));
  FDSE #(
    .INIT(1'b1)) 
    \fSCL_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(p_0_in__1[1]),
        .Q(p_0_in__1[2]),
        .S(rst));
  FDSE #(
    .INIT(1'b1)) 
    \fSCL_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(p_0_in__1[2]),
        .Q(\fSCL_reg_n_0_[2] ),
        .S(rst));
  FDSE #(
    .INIT(1'b1)) 
    \fSDA_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(\cSDA_reg_n_0_[1] ),
        .Q(\fSDA_reg_n_0_[0] ),
        .S(rst));
  FDSE #(
    .INIT(1'b1)) 
    \fSDA_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(\fSDA_reg_n_0_[0] ),
        .Q(\fSDA_reg_n_0_[1] ),
        .S(rst));
  FDSE #(
    .INIT(1'b1)) 
    \fSDA_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(fSDA),
        .D(\fSDA_reg_n_0_[1] ),
        .Q(\fSDA_reg_n_0_[2] ),
        .S(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 filter_cnt0_carry
       (.CI(1'b0),
        .CO({filter_cnt0_carry_n_0,filter_cnt0_carry_n_1,filter_cnt0_carry_n_2,filter_cnt0_carry_n_3}),
        .CYINIT(filter_cnt[0]),
        .DI(filter_cnt[4:1]),
        .O(filter_cnt0[4:1]),
        .S({filter_cnt0_carry_i_1_n_0,filter_cnt0_carry_i_2_n_0,filter_cnt0_carry_i_3_n_0,filter_cnt0_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 filter_cnt0_carry__0
       (.CI(filter_cnt0_carry_n_0),
        .CO({filter_cnt0_carry__0_n_0,filter_cnt0_carry__0_n_1,filter_cnt0_carry__0_n_2,filter_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(filter_cnt[8:5]),
        .O(filter_cnt0[8:5]),
        .S({filter_cnt0_carry__0_i_1_n_0,filter_cnt0_carry__0_i_2_n_0,filter_cnt0_carry__0_i_3_n_0,filter_cnt0_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__0_i_1
       (.I0(filter_cnt[8]),
        .O(filter_cnt0_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__0_i_2
       (.I0(filter_cnt[7]),
        .O(filter_cnt0_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__0_i_3
       (.I0(filter_cnt[6]),
        .O(filter_cnt0_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__0_i_4
       (.I0(filter_cnt[5]),
        .O(filter_cnt0_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 filter_cnt0_carry__1
       (.CI(filter_cnt0_carry__0_n_0),
        .CO({filter_cnt0_carry__1_n_0,filter_cnt0_carry__1_n_1,filter_cnt0_carry__1_n_2,filter_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(filter_cnt[12:9]),
        .O(filter_cnt0[12:9]),
        .S({filter_cnt0_carry__1_i_1_n_0,filter_cnt0_carry__1_i_2_n_0,filter_cnt0_carry__1_i_3_n_0,filter_cnt0_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__1_i_1
       (.I0(filter_cnt[12]),
        .O(filter_cnt0_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__1_i_2
       (.I0(filter_cnt[11]),
        .O(filter_cnt0_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__1_i_3
       (.I0(filter_cnt[10]),
        .O(filter_cnt0_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__1_i_4
       (.I0(filter_cnt[9]),
        .O(filter_cnt0_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 filter_cnt0_carry__2
       (.CI(filter_cnt0_carry__1_n_0),
        .CO(NLW_filter_cnt0_carry__2_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_filter_cnt0_carry__2_O_UNCONNECTED[3:1],filter_cnt0[13]}),
        .S({1'b0,1'b0,1'b0,filter_cnt0_carry__2_i_1_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry__2_i_1
       (.I0(filter_cnt[13]),
        .O(filter_cnt0_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry_i_1
       (.I0(filter_cnt[4]),
        .O(filter_cnt0_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry_i_2
       (.I0(filter_cnt[3]),
        .O(filter_cnt0_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry_i_3
       (.I0(filter_cnt[2]),
        .O(filter_cnt0_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    filter_cnt0_carry_i_4
       (.I0(filter_cnt[1]),
        .O(filter_cnt0_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \filter_cnt[0]_i_1 
       (.I0(filter_cnt[0]),
        .O(\filter_cnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[10]_i_1 
       (.I0(filter_cnt0[10]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[11]_i_1 
       (.I0(filter_cnt0[11]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[12]_i_1 
       (.I0(filter_cnt0[12]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[12]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \filter_cnt[13]_i_1 
       (.I0(\filter_cnt_reg[12]_0 ),
        .O(\filter_cnt[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[13]_i_2 
       (.I0(filter_cnt0[13]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \filter_cnt[13]_i_3 
       (.I0(\filter_cnt[13]_i_4_n_0 ),
        .I1(\filter_cnt[13]_i_5_n_0 ),
        .I2(filter_cnt[12]),
        .I3(filter_cnt[7]),
        .I4(filter_cnt[2]),
        .I5(filter_cnt[6]),
        .O(\filter_cnt_reg[12]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \filter_cnt[13]_i_4 
       (.I0(filter_cnt[11]),
        .I1(filter_cnt[10]),
        .I2(filter_cnt[13]),
        .I3(filter_cnt[0]),
        .I4(filter_cnt[1]),
        .I5(filter_cnt[3]),
        .O(\filter_cnt[13]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \filter_cnt[13]_i_5 
       (.I0(filter_cnt[9]),
        .I1(filter_cnt[8]),
        .I2(filter_cnt[4]),
        .I3(filter_cnt[5]),
        .O(\filter_cnt[13]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'hB)) 
    \filter_cnt[1]_i_1 
       (.I0(filter_cnt0[1]),
        .I1(\filter_cnt_reg[12]_0 ),
        .O(\filter_cnt[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \filter_cnt[2]_i_1 
       (.I0(filter_cnt0[2]),
        .I1(\filter_cnt_reg[12]_0 ),
        .O(\filter_cnt[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \filter_cnt[3]_i_2 
       (.I0(filter_cnt0[3]),
        .I1(\filter_cnt_reg[12]_0 ),
        .O(\filter_cnt[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[4]_i_1 
       (.I0(filter_cnt0[4]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[5]_i_1 
       (.I0(filter_cnt0[5]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[6]_i_1 
       (.I0(filter_cnt0[6]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[7]_i_1 
       (.I0(filter_cnt0[7]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[8]_i_1 
       (.I0(filter_cnt0[8]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \filter_cnt[9]_i_1 
       (.I0(filter_cnt0[9]),
        .I1(rst),
        .I2(\filter_cnt_reg[4]_0 ),
        .O(\filter_cnt[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[0]_i_1_n_0 ),
        .Q(filter_cnt[0]),
        .R(\filter_cnt_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[10]_i_1_n_0 ),
        .Q(filter_cnt[10]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[11]_i_1_n_0 ),
        .Q(filter_cnt[11]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[12]_i_1_n_0 ),
        .Q(filter_cnt[12]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[13]_i_2_n_0 ),
        .Q(filter_cnt[13]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[1]_i_1_n_0 ),
        .Q(filter_cnt[1]),
        .R(\filter_cnt_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[2]_i_1_n_0 ),
        .Q(filter_cnt[2]),
        .R(\filter_cnt_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[3]_i_2_n_0 ),
        .Q(filter_cnt[3]),
        .R(\filter_cnt_reg[3]_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[4]_i_1_n_0 ),
        .Q(filter_cnt[4]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[5]_i_1_n_0 ),
        .Q(filter_cnt[5]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[6]_i_1_n_0 ),
        .Q(filter_cnt[6]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[7]_i_1_n_0 ),
        .Q(filter_cnt[7]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[8]_i_1_n_0 ),
        .Q(filter_cnt[8]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \filter_cnt_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\filter_cnt[9]_i_1_n_0 ),
        .Q(filter_cnt[9]),
        .R(\filter_cnt[13]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h02)) 
    ld_i_1
       (.I0(\core_cmd[3]_i_3_n_0 ),
        .I1(rst),
        .I2(i2c_al),
        .O(al_reg_0));
  LUT4 #(
    .INIT(16'hFEEA)) 
    sSCL_i_1
       (.I0(rst),
        .I1(p_0_in__1[1]),
        .I2(p_0_in__1[2]),
        .I3(\fSCL_reg_n_0_[2] ),
        .O(sSCL_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sSCL_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sSCL_i_1_n_0),
        .Q(sSCL),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hFEEA)) 
    sSDA_i_1
       (.I0(rst),
        .I1(\fSDA_reg_n_0_[0] ),
        .I2(\fSDA_reg_n_0_[1] ),
        .I3(\fSDA_reg_n_0_[2] ),
        .O(sSDA_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sSDA_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sSDA_i_1_n_0),
        .Q(sSDA_reg_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hEFFFFFFFE000FFFF)) 
    scl_oen_i_1
       (.I0(scl_oen_i_2_n_0),
        .I1(scl_oen_i_3_n_0),
        .I2(clk_en),
        .I3(al_i_2_n_0),
        .I4(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I5(scl_oen_reg_0),
        .O(scl_oen_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    scl_oen_i_2
       (.I0(\FSM_onehot_c_state_reg_n_0_[4] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[11] ),
        .I3(sda_chk),
        .I4(\FSM_onehot_c_state_reg_n_0_[16] ),
        .I5(\FSM_onehot_c_state_reg_n_0_[15] ),
        .O(scl_oen_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    scl_oen_i_3
       (.I0(\FSM_onehot_c_state_reg_n_0_[8] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[9] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[3] ),
        .O(scl_oen_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    scl_oen_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(scl_oen_i_1_n_0),
        .Q(scl_oen_reg_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h02030200)) 
    sda_chk_i_1
       (.I0(sda_chk),
        .I1(i2c_al),
        .I2(rst),
        .I3(clk_en),
        .I4(sda_chk_reg_n_0),
        .O(sda_chk_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sda_chk_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sda_chk_i_1_n_0),
        .Q(sda_chk_reg_n_0),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hBBBFAAAA8880AAAA)) 
    sda_oen_i_1
       (.I0(sda_oen_i_2_n_0),
        .I1(clk_en),
        .I2(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I3(al_i_2_n_0),
        .I4(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I5(SDA_TRI),
        .O(sda_oen_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFEECEFFFF)) 
    sda_oen_i_2
       (.I0(sda_oen_reg_0),
        .I1(sda_oen_i_3_n_0),
        .I2(sda_oen_i_4_n_0),
        .I3(\FSM_onehot_c_state_reg_n_0_[13] ),
        .I4(sda_oen_i_5_n_0),
        .I5(\FSM_onehot_c_state_reg_n_0_[9] ),
        .O(sda_oen_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    sda_oen_i_3
       (.I0(\FSM_onehot_c_state_reg_n_0_[14] ),
        .I1(\FSM_onehot_c_state_reg_n_0_[16] ),
        .I2(\FSM_onehot_c_state_reg_n_0_[15] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[17] ),
        .O(sda_oen_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h01)) 
    sda_oen_i_4
       (.I0(\FSM_onehot_c_state_reg_n_0_[10] ),
        .I1(sda_chk),
        .I2(\FSM_onehot_c_state_reg_n_0_[11] ),
        .O(sda_oen_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    sda_oen_i_5
       (.I0(rst),
        .I1(i2c_al),
        .I2(\FSM_onehot_c_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_c_state_reg_n_0_[2] ),
        .O(sda_oen_i_5_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sda_oen_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sda_oen_i_1_n_0),
        .Q(SDA_TRI),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h0444000000000000)) 
    shift_i_1
       (.I0(c_state__0[2]),
        .I1(\FSM_onehot_c_state[17]_i_4_n_0 ),
        .I2(c_state__0[0]),
        .I3(shift_reg),
        .I4(c_state__0[1]),
        .I5(core_ack),
        .O(shift5_out));
  LUT4 #(
    .INIT(16'h00F2)) 
    slave_wait_i_1
       (.I0(scl_oen_reg_0),
        .I1(dscl_oen),
        .I2(slave_wait),
        .I3(sSCL),
        .O(slave_wait0));
  FDRE #(
    .INIT(1'b0)) 
    slave_wait_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(slave_wait0),
        .Q(slave_wait),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[0]_i_1 
       (.I0(\sr_reg[0] ),
        .I1(\sr_reg[0]_0 ),
        .I2(core_rxd),
        .O(\txr_reg[0] ));
  LUT3 #(
    .INIT(8'h40)) 
    sto_condition_i_1
       (.I0(dSDA),
        .I1(sSDA_reg_0),
        .I2(sSCL),
        .O(sto_condition_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    sto_condition_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(sto_condition_i_1_n_0),
        .Q(sto_condition_reg_n_0),
        .R(rst));
endmodule

module i2c_master_byte_ctrl
   (scl_oen_reg,
    sSDA_reg,
    SDA_TRI,
    \filter_cnt_reg[12] ,
    cmd_phase_reg,
    cmd_phase_reg_0,
    cmd_phase_reg_1,
    ifclk_out_OBUF_BUFG,
    \filter_cnt_reg[3] ,
    dSDA_reg,
    rst,
    cmd_ack_reg_0,
    \core_cmd_reg[0]_0 ,
    \cmd_reg[0] ,
    \filter_cnt_reg[4] ,
    sub_state__0,
    \cmd_reg[3] ,
    main_state,
    \cmd_reg[0]_0 ,
    Q,
    SCL_IBUF,
    fSDA,
    SDA_IBUF);
  output scl_oen_reg;
  output sSDA_reg;
  output SDA_TRI;
  output \filter_cnt_reg[12] ;
  output cmd_phase_reg;
  output cmd_phase_reg_0;
  output cmd_phase_reg_1;
  input ifclk_out_OBUF_BUFG;
  input \filter_cnt_reg[3] ;
  input dSDA_reg;
  input rst;
  input cmd_ack_reg_0;
  input \core_cmd_reg[0]_0 ;
  input \cmd_reg[0] ;
  input \filter_cnt_reg[4] ;
  input [0:0]sub_state__0;
  input \cmd_reg[3] ;
  input [0:0]main_state;
  input \cmd_reg[0]_0 ;
  input [7:0]Q;
  input SCL_IBUF;
  input fSDA;
  input SDA_IBUF;

  wire \FSM_sequential_c_state[0]_i_2_n_0 ;
  wire \FSM_sequential_c_state[2]_i_2_n_0 ;
  wire \FSM_sequential_c_state[2]_i_3_n_0 ;
  wire [7:0]Q;
  wire SCL_IBUF;
  wire SDA_IBUF;
  wire SDA_TRI;
  wire bit_controller_n_12;
  wire bit_controller_n_13;
  wire bit_controller_n_17;
  wire bit_controller_n_18;
  wire bit_controller_n_19;
  wire bit_controller_n_4;
  wire bit_controller_n_5;
  wire bit_controller_n_6;
  wire bit_controller_n_7;
  wire c_state;
  wire [2:0]c_state__0;
  wire cmd_ack1_out;
  wire cmd_ack_reg_0;
  wire cmd_phase_reg;
  wire cmd_phase_reg_0;
  wire cmd_phase_reg_1;
  wire \cmd_reg[0] ;
  wire \cmd_reg[0]_0 ;
  wire \cmd_reg[3] ;
  wire \core_cmd[1]_i_2_n_0 ;
  wire \core_cmd[3]_i_5_n_0 ;
  wire \core_cmd_reg[0]_0 ;
  wire \core_cmd_reg_n_0_[0] ;
  wire \core_cmd_reg_n_0_[1] ;
  wire \core_cmd_reg_n_0_[2] ;
  wire \core_cmd_reg_n_0_[3] ;
  wire core_txd4_out;
  wire core_txd_reg_n_0;
  wire dSDA_reg;
  wire dcnt;
  wire \dcnt[0]_i_1_n_0 ;
  wire \dcnt[1]_i_1_n_0 ;
  wire \dcnt[2]_i_2_n_0 ;
  wire \dcnt_reg_n_0_[0] ;
  wire \dcnt_reg_n_0_[1] ;
  wire \dcnt_reg_n_0_[2] ;
  wire done;
  wire fSDA;
  wire \filter_cnt_reg[12] ;
  wire \filter_cnt_reg[3] ;
  wire \filter_cnt_reg[4] ;
  wire ifclk_out_OBUF_BUFG;
  wire ld_reg_n_0;
  wire [0:0]main_state;
  wire rst;
  wire sSDA_reg;
  wire scl_oen_reg;
  wire shift5_out;
  wire shift_i_2_n_0;
  wire shift_reg_n_0;
  wire [6:0]sr;
  wire \sr[1]_i_1_n_0 ;
  wire \sr[2]_i_1_n_0 ;
  wire \sr[3]_i_1_n_0 ;
  wire \sr[4]_i_1_n_0 ;
  wire \sr[5]_i_1_n_0 ;
  wire \sr[6]_i_1_n_0 ;
  wire \sr[7]_i_1_n_0 ;
  wire \sr_reg_n_0_[7] ;
  wire [0:0]sub_state__0;

  LUT4 #(
    .INIT(16'h00B0)) 
    \FSM_sequential_c_state[0]_i_2 
       (.I0(c_state__0[0]),
        .I1(cmd_ack_reg_0),
        .I2(c_state__0[2]),
        .I3(c_state__0[1]),
        .O(\FSM_sequential_c_state[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h000000000000888B)) 
    \FSM_sequential_c_state[2]_i_2 
       (.I0(cmd_ack_reg_0),
        .I1(c_state__0[2]),
        .I2(\core_cmd_reg[0]_0 ),
        .I3(\cmd_reg[0] ),
        .I4(c_state__0[1]),
        .I5(c_state__0[0]),
        .O(\FSM_sequential_c_state[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    \FSM_sequential_c_state[2]_i_3 
       (.I0(c_state__0[1]),
        .I1(\dcnt_reg_n_0_[2] ),
        .I2(\dcnt_reg_n_0_[1] ),
        .I3(\dcnt_reg_n_0_[0] ),
        .O(\FSM_sequential_c_state[2]_i_3_n_0 ));
  (* FSM_ENCODED_STATES = "ST_START:001,ST_WRITE:011,ST_READ:010,ST_ACK:100,ST_IDLE:000,ST_STOP:101" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_c_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(bit_controller_n_19),
        .Q(c_state__0[0]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "ST_START:001,ST_WRITE:011,ST_READ:010,ST_ACK:100,ST_IDLE:000,ST_STOP:101" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_c_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(bit_controller_n_18),
        .Q(c_state__0[1]),
        .R(1'b0));
  (* FSM_ENCODED_STATES = "ST_START:001,ST_WRITE:011,ST_READ:010,ST_ACK:100,ST_IDLE:000,ST_STOP:101" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_c_state_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(bit_controller_n_17),
        .Q(c_state__0[2]),
        .R(1'b0));
  i2c_master_bit_ctrl bit_controller
       (.D({bit_controller_n_4,bit_controller_n_5,bit_controller_n_6,bit_controller_n_7}),
        .\FSM_sequential_c_state_reg[0] (\FSM_sequential_c_state[0]_i_2_n_0 ),
        .\FSM_sequential_c_state_reg[1] (bit_controller_n_19),
        .\FSM_sequential_c_state_reg[1]_0 (\dcnt_reg_n_0_[2] ),
        .\FSM_sequential_c_state_reg[1]_1 (\dcnt_reg_n_0_[1] ),
        .\FSM_sequential_c_state_reg[1]_2 (\dcnt_reg_n_0_[0] ),
        .\FSM_sequential_c_state_reg[2] (\FSM_sequential_c_state[2]_i_2_n_0 ),
        .\FSM_sequential_c_state_reg[2]_0 (\FSM_sequential_c_state[2]_i_3_n_0 ),
        .Q({\core_cmd_reg_n_0_[3] ,\core_cmd_reg_n_0_[2] ,\core_cmd_reg_n_0_[1] ,\core_cmd_reg_n_0_[0] }),
        .SCL_IBUF(SCL_IBUF),
        .SDA_IBUF(SDA_IBUF),
        .SDA_TRI(SDA_TRI),
        .al_reg_0(bit_controller_n_13),
        .al_reg_1(bit_controller_n_17),
        .c_state(c_state),
        .c_state__0(c_state__0),
        .cmd_ack1_out(cmd_ack1_out),
        .cmd_ack_reg_0(cmd_ack_reg_0),
        .cmd_phase_reg(cmd_phase_reg),
        .cmd_phase_reg_0(cmd_phase_reg_0),
        .cmd_phase_reg_1(cmd_phase_reg_1),
        .\cmd_reg[0] (\cmd_reg[0] ),
        .\cmd_reg[0]_0 (\cmd_reg[0]_0 ),
        .\cmd_reg[3] (\cmd_reg[3] ),
        .\core_cmd_reg[0] (\core_cmd_reg[0]_0 ),
        .\core_cmd_reg[0]_0 (\core_cmd[3]_i_5_n_0 ),
        .\core_cmd_reg[1] (\core_cmd[1]_i_2_n_0 ),
        .core_txd4_out(core_txd4_out),
        .core_txd_reg(\sr_reg_n_0_[7] ),
        .dSDA_reg_0(dSDA_reg),
        .\dcnt_reg[0] (bit_controller_n_18),
        .done(done),
        .fSDA(fSDA),
        .\filter_cnt_reg[12]_0 (\filter_cnt_reg[12] ),
        .\filter_cnt_reg[3]_0 (\filter_cnt_reg[3] ),
        .\filter_cnt_reg[4]_0 (\filter_cnt_reg[4] ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .main_state(main_state),
        .rst(rst),
        .sSDA_reg_0(sSDA_reg),
        .scl_oen_reg_0(scl_oen_reg),
        .sda_oen_reg_0(core_txd_reg_n_0),
        .shift5_out(shift5_out),
        .shift_reg(shift_i_2_n_0),
        .\sr_reg[0] (Q[0]),
        .\sr_reg[0]_0 (ld_reg_n_0),
        .sub_state__0(sub_state__0),
        .\txr_reg[0] (bit_controller_n_12));
  FDRE #(
    .INIT(1'b0)) 
    cmd_ack_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(cmd_ack1_out),
        .Q(done),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \core_cmd[1]_i_2 
       (.I0(c_state__0[0]),
        .I1(c_state__0[1]),
        .I2(\cmd_reg[0] ),
        .I3(\core_cmd_reg[0]_0 ),
        .I4(c_state__0[2]),
        .O(\core_cmd[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \core_cmd[3]_i_5 
       (.I0(c_state__0[1]),
        .I1(c_state__0[2]),
        .O(\core_cmd[3]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \core_cmd_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(c_state),
        .D(bit_controller_n_7),
        .Q(\core_cmd_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \core_cmd_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(c_state),
        .D(bit_controller_n_6),
        .Q(\core_cmd_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \core_cmd_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(c_state),
        .D(bit_controller_n_5),
        .Q(\core_cmd_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \core_cmd_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(c_state),
        .D(bit_controller_n_4),
        .Q(\core_cmd_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    core_txd_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(core_txd4_out),
        .Q(core_txd_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \dcnt[0]_i_1 
       (.I0(ld_reg_n_0),
        .I1(\dcnt_reg_n_0_[0] ),
        .O(\dcnt[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hEB)) 
    \dcnt[1]_i_1 
       (.I0(ld_reg_n_0),
        .I1(\dcnt_reg_n_0_[0] ),
        .I2(\dcnt_reg_n_0_[1] ),
        .O(\dcnt[1]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \dcnt[2]_i_1 
       (.I0(shift_reg_n_0),
        .I1(ld_reg_n_0),
        .O(dcnt));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hFEAB)) 
    \dcnt[2]_i_2 
       (.I0(ld_reg_n_0),
        .I1(\dcnt_reg_n_0_[1] ),
        .I2(\dcnt_reg_n_0_[0] ),
        .I3(\dcnt_reg_n_0_[2] ),
        .O(\dcnt[2]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \dcnt_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\dcnt[0]_i_1_n_0 ),
        .Q(\dcnt_reg_n_0_[0] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \dcnt_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\dcnt[1]_i_1_n_0 ),
        .Q(\dcnt_reg_n_0_[1] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \dcnt_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\dcnt[2]_i_2_n_0 ),
        .Q(\dcnt_reg_n_0_[2] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    ld_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(bit_controller_n_13),
        .Q(ld_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h01)) 
    shift_i_2
       (.I0(\dcnt_reg_n_0_[0] ),
        .I1(\dcnt_reg_n_0_[1] ),
        .I2(\dcnt_reg_n_0_[2] ),
        .O(shift_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    shift_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(shift5_out),
        .Q(shift_reg_n_0),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[1]_i_1 
       (.I0(Q[1]),
        .I1(ld_reg_n_0),
        .I2(sr[0]),
        .O(\sr[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[2]_i_1 
       (.I0(Q[2]),
        .I1(ld_reg_n_0),
        .I2(sr[1]),
        .O(\sr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[3]_i_1 
       (.I0(Q[3]),
        .I1(ld_reg_n_0),
        .I2(sr[2]),
        .O(\sr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[4]_i_1 
       (.I0(Q[4]),
        .I1(ld_reg_n_0),
        .I2(sr[3]),
        .O(\sr[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[5]_i_1 
       (.I0(Q[5]),
        .I1(ld_reg_n_0),
        .I2(sr[4]),
        .O(\sr[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[6]_i_1 
       (.I0(Q[6]),
        .I1(ld_reg_n_0),
        .I2(sr[5]),
        .O(\sr[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \sr[7]_i_1 
       (.I0(Q[7]),
        .I1(ld_reg_n_0),
        .I2(sr[6]),
        .O(\sr[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(bit_controller_n_12),
        .Q(sr[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[1]_i_1_n_0 ),
        .Q(sr[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[2]_i_1_n_0 ),
        .Q(sr[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[3]_i_1_n_0 ),
        .Q(sr[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[4]_i_1_n_0 ),
        .Q(sr[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[5]_i_1_n_0 ),
        .Q(sr[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[6]_i_1_n_0 ),
        .Q(sr[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \sr_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(dcnt),
        .D(\sr[7]_i_1_n_0 ),
        .Q(\sr_reg_n_0_[7] ),
        .R(rst));
endmodule

module packetizer
   (in_strb_d,
    DI,
    LED_BLUE_OBUF,
    trigger_strobe,
    ifclk_out_OBUF_BUFG,
    rst,
    LED_GREEN_3_OBUF,
    \FSM_onehot_main_state_reg[0]_0 ,
    latched_input0,
    D);
  output in_strb_d;
  output [16:0]DI;
  output LED_BLUE_OBUF;
  input trigger_strobe;
  input ifclk_out_OBUF_BUFG;
  input rst;
  input LED_GREEN_3_OBUF;
  input \FSM_onehot_main_state_reg[0]_0 ;
  input latched_input0;
  input [63:0]D;

  wire [63:0]D;
  wire [16:0]DI;
  wire \FSM_onehot_main_state[0]_i_1_n_0 ;
  wire \FSM_onehot_main_state[4]_i_1_n_0 ;
  wire \FSM_onehot_main_state[9]_i_1_n_0 ;
  wire \FSM_onehot_main_state[9]_i_2_n_0 ;
  wire \FSM_onehot_main_state[9]_i_3_n_0 ;
  wire \FSM_onehot_main_state[9]_i_5_n_0 ;
  wire \FSM_onehot_main_state[9]_i_6_n_0 ;
  wire \FSM_onehot_main_state[9]_i_7_n_0 ;
  wire \FSM_onehot_main_state_reg[0]_0 ;
  wire \FSM_onehot_main_state_reg_n_0_[0] ;
  wire \FSM_onehot_main_state_reg_n_0_[1] ;
  wire \FSM_onehot_main_state_reg_n_0_[2] ;
  wire \FSM_onehot_main_state_reg_n_0_[3] ;
  wire \FSM_onehot_main_state_reg_n_0_[4] ;
  wire \FSM_onehot_main_state_reg_n_0_[5] ;
  wire \FSM_onehot_main_state_reg_n_0_[6] ;
  wire \FSM_onehot_main_state_reg_n_0_[7] ;
  wire \FSM_onehot_main_state_reg_n_0_[8] ;
  wire \FSM_onehot_main_state_reg_n_0_[9] ;
  wire LED_BLUE_OBUF;
  wire LED_GREEN_3_OBUF;
  wire current_pkt_size0_carry__0_n_0;
  wire current_pkt_size0_carry__0_n_1;
  wire current_pkt_size0_carry__0_n_2;
  wire current_pkt_size0_carry__0_n_3;
  wire current_pkt_size0_carry__1_n_0;
  wire current_pkt_size0_carry__1_n_1;
  wire current_pkt_size0_carry__1_n_2;
  wire current_pkt_size0_carry__1_n_3;
  wire current_pkt_size0_carry__2_n_2;
  wire current_pkt_size0_carry__2_n_3;
  wire current_pkt_size0_carry_i_1_n_0;
  wire current_pkt_size0_carry_n_0;
  wire current_pkt_size0_carry_n_1;
  wire current_pkt_size0_carry_n_2;
  wire current_pkt_size0_carry_n_3;
  wire \current_pkt_size[15]_i_1_n_0 ;
  wire \current_pkt_size[15]_i_2_n_0 ;
  wire \current_pkt_size[2]_i_1_n_0 ;
  wire \current_pkt_size_reg_n_0_[10] ;
  wire \current_pkt_size_reg_n_0_[11] ;
  wire \current_pkt_size_reg_n_0_[12] ;
  wire \current_pkt_size_reg_n_0_[13] ;
  wire \current_pkt_size_reg_n_0_[14] ;
  wire \current_pkt_size_reg_n_0_[15] ;
  wire \current_pkt_size_reg_n_0_[1] ;
  wire \current_pkt_size_reg_n_0_[2] ;
  wire \current_pkt_size_reg_n_0_[3] ;
  wire \current_pkt_size_reg_n_0_[4] ;
  wire \current_pkt_size_reg_n_0_[5] ;
  wire \current_pkt_size_reg_n_0_[6] ;
  wire \current_pkt_size_reg_n_0_[7] ;
  wire \current_pkt_size_reg_n_0_[8] ;
  wire \current_pkt_size_reg_n_0_[9] ;
  wire [15:1]data0;
  wire [15:0]data2;
  wire [15:0]data4;
  wire [15:0]data5;
  wire [15:0]data6;
  wire fifo_departure_i_19_n_0;
  wire fifo_departure_i_20_n_0;
  wire fifo_departure_i_21_n_0;
  wire fifo_departure_i_22_n_0;
  wire fifo_departure_i_23_n_0;
  wire fifo_departure_i_24_n_0;
  wire fifo_departure_i_25_n_0;
  wire fifo_departure_i_26_n_0;
  wire fifo_departure_i_27_n_0;
  wire fifo_departure_i_28_n_0;
  wire fifo_departure_i_29_n_0;
  wire fifo_departure_i_30_n_0;
  wire fifo_departure_i_31_n_0;
  wire fifo_departure_i_32_n_0;
  wire fifo_departure_i_33_n_0;
  wire fifo_departure_i_34_n_0;
  wire fifo_departure_i_35_n_0;
  wire fifo_departure_i_36_n_0;
  wire fifo_departure_i_37_n_0;
  wire fifo_departure_i_38_n_0;
  wire fifo_departure_i_39_n_0;
  wire fifo_departure_i_40_n_0;
  wire fifo_departure_i_41_n_0;
  wire fifo_departure_i_42_n_0;
  wire fifo_departure_i_43_n_0;
  wire fifo_departure_i_44_n_0;
  wire fifo_departure_i_45_n_0;
  wire fifo_departure_i_46_n_0;
  wire fifo_departure_i_47_n_0;
  wire fifo_departure_i_48_n_0;
  wire fifo_departure_i_49_n_0;
  wire fifo_departure_i_50_n_0;
  wire ifclk_out_OBUF_BUFG;
  wire [15:1]in6;
  wire in_strb_d;
  wire latched_input0;
  wire \latched_input_reg_n_0_[0] ;
  wire \latched_input_reg_n_0_[10] ;
  wire \latched_input_reg_n_0_[11] ;
  wire \latched_input_reg_n_0_[12] ;
  wire \latched_input_reg_n_0_[13] ;
  wire \latched_input_reg_n_0_[14] ;
  wire \latched_input_reg_n_0_[15] ;
  wire \latched_input_reg_n_0_[1] ;
  wire \latched_input_reg_n_0_[2] ;
  wire \latched_input_reg_n_0_[3] ;
  wire \latched_input_reg_n_0_[4] ;
  wire \latched_input_reg_n_0_[5] ;
  wire \latched_input_reg_n_0_[6] ;
  wire \latched_input_reg_n_0_[7] ;
  wire \latched_input_reg_n_0_[8] ;
  wire \latched_input_reg_n_0_[9] ;
  wire \out_sel[0]_i_1_n_0 ;
  wire \out_sel[0]_i_2_n_0 ;
  wire \out_sel[1]_i_1_n_0 ;
  wire \out_sel[1]_i_2_n_0 ;
  wire \out_sel[2]_i_1_n_0 ;
  wire \out_sel[2]_i_2_n_0 ;
  wire \out_sel[2]_i_3_n_0 ;
  wire \out_sel_reg_n_0_[0] ;
  wire \out_sel_reg_n_0_[1] ;
  wire \out_sel_reg_n_0_[2] ;
  wire out_strobe_i_1_n_0;
  wire pkt_end_i_1_n_0;
  wire rst;
  wire \seq_cnt[0]_i_1_n_0 ;
  wire \seq_cnt[0]_i_3_n_0 ;
  wire [15:0]seq_cnt_reg;
  wire \seq_cnt_reg[0]_i_2_n_0 ;
  wire \seq_cnt_reg[0]_i_2_n_1 ;
  wire \seq_cnt_reg[0]_i_2_n_2 ;
  wire \seq_cnt_reg[0]_i_2_n_3 ;
  wire \seq_cnt_reg[0]_i_2_n_4 ;
  wire \seq_cnt_reg[0]_i_2_n_5 ;
  wire \seq_cnt_reg[0]_i_2_n_6 ;
  wire \seq_cnt_reg[0]_i_2_n_7 ;
  wire \seq_cnt_reg[12]_i_1_n_1 ;
  wire \seq_cnt_reg[12]_i_1_n_2 ;
  wire \seq_cnt_reg[12]_i_1_n_3 ;
  wire \seq_cnt_reg[12]_i_1_n_4 ;
  wire \seq_cnt_reg[12]_i_1_n_5 ;
  wire \seq_cnt_reg[12]_i_1_n_6 ;
  wire \seq_cnt_reg[12]_i_1_n_7 ;
  wire \seq_cnt_reg[4]_i_1_n_0 ;
  wire \seq_cnt_reg[4]_i_1_n_1 ;
  wire \seq_cnt_reg[4]_i_1_n_2 ;
  wire \seq_cnt_reg[4]_i_1_n_3 ;
  wire \seq_cnt_reg[4]_i_1_n_4 ;
  wire \seq_cnt_reg[4]_i_1_n_5 ;
  wire \seq_cnt_reg[4]_i_1_n_6 ;
  wire \seq_cnt_reg[4]_i_1_n_7 ;
  wire \seq_cnt_reg[8]_i_1_n_0 ;
  wire \seq_cnt_reg[8]_i_1_n_1 ;
  wire \seq_cnt_reg[8]_i_1_n_2 ;
  wire \seq_cnt_reg[8]_i_1_n_3 ;
  wire \seq_cnt_reg[8]_i_1_n_4 ;
  wire \seq_cnt_reg[8]_i_1_n_5 ;
  wire \seq_cnt_reg[8]_i_1_n_6 ;
  wire \seq_cnt_reg[8]_i_1_n_7 ;
  wire [0:0]time_cnt;
  wire time_cnt0_carry__0_n_0;
  wire time_cnt0_carry__0_n_1;
  wire time_cnt0_carry__0_n_2;
  wire time_cnt0_carry__0_n_3;
  wire time_cnt0_carry__1_n_0;
  wire time_cnt0_carry__1_n_1;
  wire time_cnt0_carry__1_n_2;
  wire time_cnt0_carry__1_n_3;
  wire time_cnt0_carry__2_n_2;
  wire time_cnt0_carry__2_n_3;
  wire time_cnt0_carry_n_0;
  wire time_cnt0_carry_n_1;
  wire time_cnt0_carry_n_2;
  wire time_cnt0_carry_n_3;
  wire \time_cnt[0]_i_2_n_0 ;
  wire \time_cnt[0]_i_3_n_0 ;
  wire \time_cnt[0]_i_4_n_0 ;
  wire \time_cnt[0]_i_5_n_0 ;
  wire \time_cnt_reg_n_0_[0] ;
  wire \time_cnt_reg_n_0_[10] ;
  wire \time_cnt_reg_n_0_[11] ;
  wire \time_cnt_reg_n_0_[12] ;
  wire \time_cnt_reg_n_0_[13] ;
  wire \time_cnt_reg_n_0_[14] ;
  wire \time_cnt_reg_n_0_[15] ;
  wire \time_cnt_reg_n_0_[1] ;
  wire \time_cnt_reg_n_0_[2] ;
  wire \time_cnt_reg_n_0_[3] ;
  wire \time_cnt_reg_n_0_[4] ;
  wire \time_cnt_reg_n_0_[5] ;
  wire \time_cnt_reg_n_0_[6] ;
  wire \time_cnt_reg_n_0_[7] ;
  wire \time_cnt_reg_n_0_[8] ;
  wire \time_cnt_reg_n_0_[9] ;
  wire timer;
  wire \timer[0]_i_2_n_0 ;
  wire \timer_reg[0]_i_1_n_0 ;
  wire \timer_reg[0]_i_1_n_1 ;
  wire \timer_reg[0]_i_1_n_2 ;
  wire \timer_reg[0]_i_1_n_3 ;
  wire \timer_reg[0]_i_1_n_4 ;
  wire \timer_reg[0]_i_1_n_5 ;
  wire \timer_reg[0]_i_1_n_6 ;
  wire \timer_reg[0]_i_1_n_7 ;
  wire \timer_reg[12]_i_1_n_0 ;
  wire \timer_reg[12]_i_1_n_1 ;
  wire \timer_reg[12]_i_1_n_2 ;
  wire \timer_reg[12]_i_1_n_3 ;
  wire \timer_reg[12]_i_1_n_4 ;
  wire \timer_reg[12]_i_1_n_5 ;
  wire \timer_reg[12]_i_1_n_6 ;
  wire \timer_reg[12]_i_1_n_7 ;
  wire \timer_reg[16]_i_1_n_0 ;
  wire \timer_reg[16]_i_1_n_1 ;
  wire \timer_reg[16]_i_1_n_2 ;
  wire \timer_reg[16]_i_1_n_3 ;
  wire \timer_reg[16]_i_1_n_4 ;
  wire \timer_reg[16]_i_1_n_5 ;
  wire \timer_reg[16]_i_1_n_6 ;
  wire \timer_reg[16]_i_1_n_7 ;
  wire \timer_reg[20]_i_1_n_0 ;
  wire \timer_reg[20]_i_1_n_1 ;
  wire \timer_reg[20]_i_1_n_2 ;
  wire \timer_reg[20]_i_1_n_3 ;
  wire \timer_reg[20]_i_1_n_4 ;
  wire \timer_reg[20]_i_1_n_5 ;
  wire \timer_reg[20]_i_1_n_6 ;
  wire \timer_reg[20]_i_1_n_7 ;
  wire \timer_reg[24]_i_1_n_0 ;
  wire \timer_reg[24]_i_1_n_1 ;
  wire \timer_reg[24]_i_1_n_2 ;
  wire \timer_reg[24]_i_1_n_3 ;
  wire \timer_reg[24]_i_1_n_4 ;
  wire \timer_reg[24]_i_1_n_5 ;
  wire \timer_reg[24]_i_1_n_6 ;
  wire \timer_reg[24]_i_1_n_7 ;
  wire \timer_reg[28]_i_1_n_1 ;
  wire \timer_reg[28]_i_1_n_2 ;
  wire \timer_reg[28]_i_1_n_3 ;
  wire \timer_reg[28]_i_1_n_4 ;
  wire \timer_reg[28]_i_1_n_5 ;
  wire \timer_reg[28]_i_1_n_6 ;
  wire \timer_reg[28]_i_1_n_7 ;
  wire \timer_reg[4]_i_1_n_0 ;
  wire \timer_reg[4]_i_1_n_1 ;
  wire \timer_reg[4]_i_1_n_2 ;
  wire \timer_reg[4]_i_1_n_3 ;
  wire \timer_reg[4]_i_1_n_4 ;
  wire \timer_reg[4]_i_1_n_5 ;
  wire \timer_reg[4]_i_1_n_6 ;
  wire \timer_reg[4]_i_1_n_7 ;
  wire \timer_reg[8]_i_1_n_0 ;
  wire \timer_reg[8]_i_1_n_1 ;
  wire \timer_reg[8]_i_1_n_2 ;
  wire \timer_reg[8]_i_1_n_3 ;
  wire \timer_reg[8]_i_1_n_4 ;
  wire \timer_reg[8]_i_1_n_5 ;
  wire \timer_reg[8]_i_1_n_6 ;
  wire \timer_reg[8]_i_1_n_7 ;
  wire \timer_reg_n_0_[0] ;
  wire \timer_reg_n_0_[10] ;
  wire \timer_reg_n_0_[11] ;
  wire \timer_reg_n_0_[12] ;
  wire \timer_reg_n_0_[13] ;
  wire \timer_reg_n_0_[14] ;
  wire \timer_reg_n_0_[15] ;
  wire \timer_reg_n_0_[1] ;
  wire \timer_reg_n_0_[2] ;
  wire \timer_reg_n_0_[3] ;
  wire \timer_reg_n_0_[4] ;
  wire \timer_reg_n_0_[5] ;
  wire \timer_reg_n_0_[6] ;
  wire \timer_reg_n_0_[7] ;
  wire \timer_reg_n_0_[8] ;
  wire \timer_reg_n_0_[9] ;
  wire trigger_strobe;
  wire [3:2]NLW_current_pkt_size0_carry__2_CO_UNCONNECTED;
  wire [3:3]NLW_current_pkt_size0_carry__2_O_UNCONNECTED;
  wire [3:3]\NLW_seq_cnt_reg[12]_i_1_CO_UNCONNECTED ;
  wire [3:2]NLW_time_cnt0_carry__2_CO_UNCONNECTED;
  wire [3:3]NLW_time_cnt0_carry__2_O_UNCONNECTED;
  wire [3:3]\NLW_timer_reg[28]_i_1_CO_UNCONNECTED ;

  LUT4 #(
    .INIT(16'h4F44)) 
    \FSM_onehot_main_state[0]_i_1 
       (.I0(LED_GREEN_3_OBUF),
        .I1(\FSM_onehot_main_state_reg_n_0_[9] ),
        .I2(\FSM_onehot_main_state[9]_i_5_n_0 ),
        .I3(\FSM_onehot_main_state_reg_n_0_[8] ),
        .O(\FSM_onehot_main_state[0]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hEA)) 
    \FSM_onehot_main_state[4]_i_1 
       (.I0(\FSM_onehot_main_state_reg_n_0_[3] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[9] ),
        .I2(LED_GREEN_3_OBUF),
        .O(\FSM_onehot_main_state[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFAFFFAFAFFFFFEFA)) 
    \FSM_onehot_main_state[9]_i_1 
       (.I0(\FSM_onehot_main_state[9]_i_3_n_0 ),
        .I1(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[8] ),
        .I3(LED_GREEN_3_OBUF),
        .I4(\FSM_onehot_main_state_reg_n_0_[9] ),
        .I5(\FSM_onehot_main_state_reg[0]_0 ),
        .O(\FSM_onehot_main_state[9]_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \FSM_onehot_main_state[9]_i_2 
       (.I0(\FSM_onehot_main_state_reg_n_0_[8] ),
        .I1(\FSM_onehot_main_state[9]_i_5_n_0 ),
        .O(\FSM_onehot_main_state[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \FSM_onehot_main_state[9]_i_3 
       (.I0(\out_sel[2]_i_3_n_0 ),
        .I1(\FSM_onehot_main_state_reg_n_0_[3] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_main_state_reg_n_0_[1] ),
        .O(\FSM_onehot_main_state[9]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \FSM_onehot_main_state[9]_i_5 
       (.I0(\FSM_onehot_main_state[9]_i_6_n_0 ),
        .I1(\current_pkt_size_reg_n_0_[13] ),
        .I2(LED_GREEN_3_OBUF),
        .I3(\current_pkt_size_reg_n_0_[14] ),
        .I4(\current_pkt_size_reg_n_0_[15] ),
        .I5(\current_pkt_size_reg_n_0_[12] ),
        .O(\FSM_onehot_main_state[9]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF00015555)) 
    \FSM_onehot_main_state[9]_i_6 
       (.I0(\current_pkt_size_reg_n_0_[6] ),
        .I1(\current_pkt_size_reg_n_0_[3] ),
        .I2(\current_pkt_size_reg_n_0_[4] ),
        .I3(\current_pkt_size_reg_n_0_[2] ),
        .I4(\current_pkt_size_reg_n_0_[5] ),
        .I5(\FSM_onehot_main_state[9]_i_7_n_0 ),
        .O(\FSM_onehot_main_state[9]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h7FFFFFFF)) 
    \FSM_onehot_main_state[9]_i_7 
       (.I0(\current_pkt_size_reg_n_0_[9] ),
        .I1(\current_pkt_size_reg_n_0_[11] ),
        .I2(\current_pkt_size_reg_n_0_[10] ),
        .I3(\current_pkt_size_reg_n_0_[8] ),
        .I4(\current_pkt_size_reg_n_0_[7] ),
        .O(\FSM_onehot_main_state[9]_i_7_n_0 ));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDSE #(
    .INIT(1'b1),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_main_state_reg_n_0_[0] ),
        .S(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[0] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[1] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[1] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[2] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[2] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[3] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state[4]_i_1_n_0 ),
        .Q(\FSM_onehot_main_state_reg_n_0_[4] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[4] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[5] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[5] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[6] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[6] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[7] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state_reg_n_0_[7] ),
        .Q(\FSM_onehot_main_state_reg_n_0_[8] ),
        .R(rst));
  (* FSM_ENCODED_STATES = "STATE_IDLE:0000000001,STATE_WAIT_STROBE:1000000000,STATE_SEND_DATA_CH4:0010000000,STATE_LATCH_LAST_WORD:0100000000,STATE_SEND_DATA_CH3:0001000000,STATE_SEND_DATA_CH2:0000100000,STATE_SEND_DATA_CH1:0000010000,STATE_SEND_HEADER_TIME_L:0000001000,STATE_SEND_HEADER_TIME_H:0000000100,STATE_SEND_HEADER_SEQ:0000000010" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \FSM_onehot_main_state_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\FSM_onehot_main_state[9]_i_1_n_0 ),
        .D(\FSM_onehot_main_state[9]_i_2_n_0 ),
        .Q(\FSM_onehot_main_state_reg_n_0_[9] ),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 current_pkt_size0_carry
       (.CI(1'b0),
        .CO({current_pkt_size0_carry_n_0,current_pkt_size0_carry_n_1,current_pkt_size0_carry_n_2,current_pkt_size0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\current_pkt_size_reg_n_0_[2] ,1'b0}),
        .O(in6[4:1]),
        .S({\current_pkt_size_reg_n_0_[4] ,\current_pkt_size_reg_n_0_[3] ,current_pkt_size0_carry_i_1_n_0,\current_pkt_size_reg_n_0_[1] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 current_pkt_size0_carry__0
       (.CI(current_pkt_size0_carry_n_0),
        .CO({current_pkt_size0_carry__0_n_0,current_pkt_size0_carry__0_n_1,current_pkt_size0_carry__0_n_2,current_pkt_size0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in6[8:5]),
        .S({\current_pkt_size_reg_n_0_[8] ,\current_pkt_size_reg_n_0_[7] ,\current_pkt_size_reg_n_0_[6] ,\current_pkt_size_reg_n_0_[5] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 current_pkt_size0_carry__1
       (.CI(current_pkt_size0_carry__0_n_0),
        .CO({current_pkt_size0_carry__1_n_0,current_pkt_size0_carry__1_n_1,current_pkt_size0_carry__1_n_2,current_pkt_size0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(in6[12:9]),
        .S({\current_pkt_size_reg_n_0_[12] ,\current_pkt_size_reg_n_0_[11] ,\current_pkt_size_reg_n_0_[10] ,\current_pkt_size_reg_n_0_[9] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 current_pkt_size0_carry__2
       (.CI(current_pkt_size0_carry__1_n_0),
        .CO({NLW_current_pkt_size0_carry__2_CO_UNCONNECTED[3:2],current_pkt_size0_carry__2_n_2,current_pkt_size0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_current_pkt_size0_carry__2_O_UNCONNECTED[3],in6[15:13]}),
        .S({1'b0,\current_pkt_size_reg_n_0_[15] ,\current_pkt_size_reg_n_0_[14] ,\current_pkt_size_reg_n_0_[13] }));
  LUT1 #(
    .INIT(2'h1)) 
    current_pkt_size0_carry_i_1
       (.I0(\current_pkt_size_reg_n_0_[2] ),
        .O(current_pkt_size0_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h02)) 
    \current_pkt_size[15]_i_1 
       (.I0(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I1(rst),
        .I2(\FSM_onehot_main_state_reg_n_0_[4] ),
        .O(\current_pkt_size[15]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h54)) 
    \current_pkt_size[15]_i_2 
       (.I0(rst),
        .I1(\FSM_onehot_main_state_reg_n_0_[4] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[0] ),
        .O(\current_pkt_size[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFEFAFCFF0E0A0C00)) 
    \current_pkt_size[2]_i_1 
       (.I0(latched_input0),
        .I1(in6[2]),
        .I2(rst),
        .I3(\FSM_onehot_main_state_reg_n_0_[4] ),
        .I4(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I5(\current_pkt_size_reg_n_0_[2] ),
        .O(\current_pkt_size[2]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[10]),
        .Q(\current_pkt_size_reg_n_0_[10] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[11]),
        .Q(\current_pkt_size_reg_n_0_[11] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[12]),
        .Q(\current_pkt_size_reg_n_0_[12] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[13]),
        .Q(\current_pkt_size_reg_n_0_[13] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[14]),
        .Q(\current_pkt_size_reg_n_0_[14] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[15]),
        .Q(\current_pkt_size_reg_n_0_[15] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[1]),
        .Q(\current_pkt_size_reg_n_0_[1] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\current_pkt_size[2]_i_1_n_0 ),
        .Q(\current_pkt_size_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[3]),
        .Q(\current_pkt_size_reg_n_0_[3] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[4]),
        .Q(\current_pkt_size_reg_n_0_[4] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[5]),
        .Q(\current_pkt_size_reg_n_0_[5] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[6]),
        .Q(\current_pkt_size_reg_n_0_[6] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[7]),
        .Q(\current_pkt_size_reg_n_0_[7] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[8]),
        .Q(\current_pkt_size_reg_n_0_[8] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \current_pkt_size_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\current_pkt_size[15]_i_2_n_0 ),
        .D(in6[9]),
        .Q(\current_pkt_size_reg_n_0_[9] ),
        .R(\current_pkt_size[15]_i_1_n_0 ));
  MUXF7 fifo_departure_i_10
       (.I0(fifo_departure_i_33_n_0),
        .I1(fifo_departure_i_34_n_0),
        .O(DI[8]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_11
       (.I0(fifo_departure_i_35_n_0),
        .I1(fifo_departure_i_36_n_0),
        .O(DI[7]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_12
       (.I0(fifo_departure_i_37_n_0),
        .I1(fifo_departure_i_38_n_0),
        .O(DI[6]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_13
       (.I0(fifo_departure_i_39_n_0),
        .I1(fifo_departure_i_40_n_0),
        .O(DI[5]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_14
       (.I0(fifo_departure_i_41_n_0),
        .I1(fifo_departure_i_42_n_0),
        .O(DI[4]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_15
       (.I0(fifo_departure_i_43_n_0),
        .I1(fifo_departure_i_44_n_0),
        .O(DI[3]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_16
       (.I0(fifo_departure_i_45_n_0),
        .I1(fifo_departure_i_46_n_0),
        .O(DI[2]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_17
       (.I0(fifo_departure_i_47_n_0),
        .I1(fifo_departure_i_48_n_0),
        .O(DI[1]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_18
       (.I0(fifo_departure_i_49_n_0),
        .I1(fifo_departure_i_50_n_0),
        .O(DI[0]),
        .S(\out_sel_reg_n_0_[2] ));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_19
       (.I0(data2[15]),
        .I1(\timer_reg_n_0_[15] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[15]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_19_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_20
       (.I0(data6[15]),
        .I1(data5[15]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[15]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[15] ),
        .O(fifo_departure_i_20_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_21
       (.I0(data2[14]),
        .I1(\timer_reg_n_0_[14] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[14]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_21_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_22
       (.I0(data6[14]),
        .I1(data5[14]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[14]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[14] ),
        .O(fifo_departure_i_22_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_23
       (.I0(data2[13]),
        .I1(\timer_reg_n_0_[13] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[13]),
        .O(fifo_departure_i_23_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_24
       (.I0(data6[13]),
        .I1(data5[13]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[13]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[13] ),
        .O(fifo_departure_i_24_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_25
       (.I0(data2[12]),
        .I1(\timer_reg_n_0_[12] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[12]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_25_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_26
       (.I0(data6[12]),
        .I1(data5[12]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[12]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[12] ),
        .O(fifo_departure_i_26_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_27
       (.I0(data2[11]),
        .I1(\timer_reg_n_0_[11] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[11]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_27_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_28
       (.I0(data6[11]),
        .I1(data5[11]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[11]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[11] ),
        .O(fifo_departure_i_28_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_29
       (.I0(data2[10]),
        .I1(\timer_reg_n_0_[10] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[10]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_29_n_0));
  MUXF7 fifo_departure_i_3
       (.I0(fifo_departure_i_19_n_0),
        .I1(fifo_departure_i_20_n_0),
        .O(DI[15]),
        .S(\out_sel_reg_n_0_[2] ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_30
       (.I0(data6[10]),
        .I1(data5[10]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[10]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[10] ),
        .O(fifo_departure_i_30_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_31
       (.I0(data2[9]),
        .I1(\timer_reg_n_0_[9] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[9]),
        .O(fifo_departure_i_31_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_32
       (.I0(data6[9]),
        .I1(data5[9]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[9]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[9] ),
        .O(fifo_departure_i_32_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_33
       (.I0(data2[8]),
        .I1(\timer_reg_n_0_[8] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[8]),
        .O(fifo_departure_i_33_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_34
       (.I0(data6[8]),
        .I1(data5[8]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[8]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[8] ),
        .O(fifo_departure_i_34_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_35
       (.I0(data2[7]),
        .I1(\timer_reg_n_0_[7] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[7]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_35_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_36
       (.I0(data6[7]),
        .I1(data5[7]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[7]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[7] ),
        .O(fifo_departure_i_36_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_37
       (.I0(data2[6]),
        .I1(\timer_reg_n_0_[6] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[6]),
        .O(fifo_departure_i_37_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_38
       (.I0(data6[6]),
        .I1(data5[6]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[6]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[6] ),
        .O(fifo_departure_i_38_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_39
       (.I0(data2[5]),
        .I1(\timer_reg_n_0_[5] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[5]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_39_n_0));
  MUXF7 fifo_departure_i_4
       (.I0(fifo_departure_i_21_n_0),
        .I1(fifo_departure_i_22_n_0),
        .O(DI[14]),
        .S(\out_sel_reg_n_0_[2] ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_40
       (.I0(data6[5]),
        .I1(data5[5]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[5]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[5] ),
        .O(fifo_departure_i_40_n_0));
  LUT5 #(
    .INIT(32'hAFA0CFCF)) 
    fifo_departure_i_41
       (.I0(data2[4]),
        .I1(\timer_reg_n_0_[4] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[4]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_41_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_42
       (.I0(data6[4]),
        .I1(data5[4]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[4]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[4] ),
        .O(fifo_departure_i_42_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_43
       (.I0(data2[3]),
        .I1(\timer_reg_n_0_[3] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[3]),
        .O(fifo_departure_i_43_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_44
       (.I0(data6[3]),
        .I1(data5[3]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[3]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[3] ),
        .O(fifo_departure_i_44_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_45
       (.I0(data2[2]),
        .I1(\timer_reg_n_0_[2] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[2]),
        .O(fifo_departure_i_45_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_46
       (.I0(data6[2]),
        .I1(data5[2]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[2]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[2] ),
        .O(fifo_departure_i_46_n_0));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    fifo_departure_i_47
       (.I0(data2[1]),
        .I1(\timer_reg_n_0_[1] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(\out_sel_reg_n_0_[0] ),
        .I4(seq_cnt_reg[1]),
        .O(fifo_departure_i_47_n_0));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_48
       (.I0(data6[1]),
        .I1(data5[1]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[1]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[1] ),
        .O(fifo_departure_i_48_n_0));
  LUT5 #(
    .INIT(32'hAFA0C0C0)) 
    fifo_departure_i_49
       (.I0(data2[0]),
        .I1(\timer_reg_n_0_[0] ),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(seq_cnt_reg[0]),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(fifo_departure_i_49_n_0));
  MUXF7 fifo_departure_i_5
       (.I0(fifo_departure_i_23_n_0),
        .I1(fifo_departure_i_24_n_0),
        .O(DI[13]),
        .S(\out_sel_reg_n_0_[2] ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    fifo_departure_i_50
       (.I0(data6[0]),
        .I1(data5[0]),
        .I2(\out_sel_reg_n_0_[1] ),
        .I3(data4[0]),
        .I4(\out_sel_reg_n_0_[0] ),
        .I5(\latched_input_reg_n_0_[0] ),
        .O(fifo_departure_i_50_n_0));
  MUXF7 fifo_departure_i_6
       (.I0(fifo_departure_i_25_n_0),
        .I1(fifo_departure_i_26_n_0),
        .O(DI[12]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_7
       (.I0(fifo_departure_i_27_n_0),
        .I1(fifo_departure_i_28_n_0),
        .O(DI[11]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_8
       (.I0(fifo_departure_i_29_n_0),
        .I1(fifo_departure_i_30_n_0),
        .O(DI[10]),
        .S(\out_sel_reg_n_0_[2] ));
  MUXF7 fifo_departure_i_9
       (.I0(fifo_departure_i_31_n_0),
        .I1(fifo_departure_i_32_n_0),
        .O(DI[9]),
        .S(\out_sel_reg_n_0_[2] ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    in_strb_d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(trigger_strobe),
        .Q(in_strb_d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[0]),
        .Q(\latched_input_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[10]),
        .Q(\latched_input_reg_n_0_[10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[11]),
        .Q(\latched_input_reg_n_0_[11] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[12]),
        .Q(\latched_input_reg_n_0_[12] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[13]),
        .Q(\latched_input_reg_n_0_[13] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[14]),
        .Q(\latched_input_reg_n_0_[14] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[15]),
        .Q(\latched_input_reg_n_0_[15] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[16]),
        .Q(data4[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[17]),
        .Q(data4[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[18]),
        .Q(data4[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[19]),
        .Q(data4[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[1]),
        .Q(\latched_input_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[20] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[20]),
        .Q(data4[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[21] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[21]),
        .Q(data4[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[22] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[22]),
        .Q(data4[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[23] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[23]),
        .Q(data4[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[24] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[24]),
        .Q(data4[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[25] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[25]),
        .Q(data4[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[26] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[26]),
        .Q(data4[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[27] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[27]),
        .Q(data4[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[28] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[28]),
        .Q(data4[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[29] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[29]),
        .Q(data4[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[2]),
        .Q(\latched_input_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[30] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[30]),
        .Q(data4[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[31] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[31]),
        .Q(data4[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[32] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[32]),
        .Q(data5[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[33] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[33]),
        .Q(data5[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[34] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[34]),
        .Q(data5[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[35] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[35]),
        .Q(data5[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[36] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[36]),
        .Q(data5[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[37] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[37]),
        .Q(data5[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[38] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[38]),
        .Q(data5[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[39] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[39]),
        .Q(data5[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[3]),
        .Q(\latched_input_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[40] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[40]),
        .Q(data5[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[41] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[41]),
        .Q(data5[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[42] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[42]),
        .Q(data5[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[43] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[43]),
        .Q(data5[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[44] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[44]),
        .Q(data5[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[45] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[45]),
        .Q(data5[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[46] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[46]),
        .Q(data5[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[47] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[47]),
        .Q(data5[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[48] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[48]),
        .Q(data6[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[49] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[49]),
        .Q(data6[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[4]),
        .Q(\latched_input_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[50] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[50]),
        .Q(data6[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[51] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[51]),
        .Q(data6[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[52] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[52]),
        .Q(data6[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[53] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[53]),
        .Q(data6[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[54] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[54]),
        .Q(data6[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[55] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[55]),
        .Q(data6[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[56] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[56]),
        .Q(data6[8]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[57] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[57]),
        .Q(data6[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[58] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[58]),
        .Q(data6[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[59] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[59]),
        .Q(data6[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[5]),
        .Q(\latched_input_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[60] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[60]),
        .Q(data6[12]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[61] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[61]),
        .Q(data6[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[62] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[62]),
        .Q(data6[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[63] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[63]),
        .Q(data6[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[6]),
        .Q(\latched_input_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[7]),
        .Q(\latched_input_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[8]),
        .Q(\latched_input_reg_n_0_[8] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \latched_input_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(latched_input0),
        .D(D[9]),
        .Q(\latched_input_reg_n_0_[9] ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hAABFAA80)) 
    \out_sel[0]_i_1 
       (.I0(\out_sel[0]_i_2_n_0 ),
        .I1(latched_input0),
        .I2(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_main_state[9]_i_3_n_0 ),
        .I4(\out_sel_reg_n_0_[0] ),
        .O(\out_sel[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \out_sel[0]_i_2 
       (.I0(\FSM_onehot_main_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[1] ),
        .I3(\FSM_onehot_main_state_reg_n_0_[2] ),
        .O(\out_sel[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAABFAA80)) 
    \out_sel[1]_i_1 
       (.I0(\out_sel[1]_i_2_n_0 ),
        .I1(latched_input0),
        .I2(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I3(\FSM_onehot_main_state[9]_i_3_n_0 ),
        .I4(\out_sel_reg_n_0_[1] ),
        .O(\out_sel[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \out_sel[1]_i_2 
       (.I0(\FSM_onehot_main_state_reg_n_0_[6] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[2] ),
        .I3(\FSM_onehot_main_state_reg_n_0_[3] ),
        .O(\out_sel[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0007FFFF0000)) 
    \out_sel[2]_i_1 
       (.I0(latched_input0),
        .I1(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[1] ),
        .I3(\out_sel[2]_i_2_n_0 ),
        .I4(\out_sel[2]_i_3_n_0 ),
        .I5(\out_sel_reg_n_0_[2] ),
        .O(\out_sel[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \out_sel[2]_i_2 
       (.I0(\FSM_onehot_main_state_reg_n_0_[3] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[2] ),
        .O(\out_sel[2]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \out_sel[2]_i_3 
       (.I0(\FSM_onehot_main_state_reg_n_0_[5] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[7] ),
        .I2(\FSM_onehot_main_state_reg_n_0_[6] ),
        .I3(\FSM_onehot_main_state_reg_n_0_[4] ),
        .O(\out_sel[2]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \out_sel_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\out_sel[0]_i_1_n_0 ),
        .Q(\out_sel_reg_n_0_[0] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \out_sel_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\out_sel[1]_i_1_n_0 ),
        .Q(\out_sel_reg_n_0_[1] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \out_sel_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\out_sel[2]_i_1_n_0 ),
        .Q(\out_sel_reg_n_0_[2] ),
        .R(rst));
  LUT5 #(
    .INIT(32'hFFD5FFC0)) 
    out_strobe_i_1
       (.I0(\FSM_onehot_main_state_reg_n_0_[8] ),
        .I1(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I2(latched_input0),
        .I3(\FSM_onehot_main_state_reg_n_0_[4] ),
        .I4(LED_BLUE_OBUF),
        .O(out_strobe_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    out_strobe_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(out_strobe_i_1_n_0),
        .Q(LED_BLUE_OBUF),
        .R(rst));
  LUT4 #(
    .INIT(16'hEF22)) 
    pkt_end_i_1
       (.I0(\FSM_onehot_main_state_reg_n_0_[7] ),
        .I1(\FSM_onehot_main_state[9]_i_5_n_0 ),
        .I2(\FSM_onehot_main_state_reg_n_0_[8] ),
        .I3(DI[16]),
        .O(pkt_end_i_1_n_0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    pkt_end_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(pkt_end_i_1_n_0),
        .Q(DI[16]),
        .R(rst));
  LUT2 #(
    .INIT(4'h8)) 
    \seq_cnt[0]_i_1 
       (.I0(\FSM_onehot_main_state_reg_n_0_[0] ),
        .I1(latched_input0),
        .O(\seq_cnt[0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \seq_cnt[0]_i_3 
       (.I0(seq_cnt_reg[0]),
        .O(\seq_cnt[0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[0]_i_2_n_7 ),
        .Q(seq_cnt_reg[0]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \seq_cnt_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\seq_cnt_reg[0]_i_2_n_0 ,\seq_cnt_reg[0]_i_2_n_1 ,\seq_cnt_reg[0]_i_2_n_2 ,\seq_cnt_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\seq_cnt_reg[0]_i_2_n_4 ,\seq_cnt_reg[0]_i_2_n_5 ,\seq_cnt_reg[0]_i_2_n_6 ,\seq_cnt_reg[0]_i_2_n_7 }),
        .S({seq_cnt_reg[3:1],\seq_cnt[0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[8]_i_1_n_5 ),
        .Q(seq_cnt_reg[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[8]_i_1_n_4 ),
        .Q(seq_cnt_reg[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[12]_i_1_n_7 ),
        .Q(seq_cnt_reg[12]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \seq_cnt_reg[12]_i_1 
       (.CI(\seq_cnt_reg[8]_i_1_n_0 ),
        .CO({\NLW_seq_cnt_reg[12]_i_1_CO_UNCONNECTED [3],\seq_cnt_reg[12]_i_1_n_1 ,\seq_cnt_reg[12]_i_1_n_2 ,\seq_cnt_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\seq_cnt_reg[12]_i_1_n_4 ,\seq_cnt_reg[12]_i_1_n_5 ,\seq_cnt_reg[12]_i_1_n_6 ,\seq_cnt_reg[12]_i_1_n_7 }),
        .S(seq_cnt_reg[15:12]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[12]_i_1_n_6 ),
        .Q(seq_cnt_reg[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[12]_i_1_n_5 ),
        .Q(seq_cnt_reg[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[12]_i_1_n_4 ),
        .Q(seq_cnt_reg[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[0]_i_2_n_6 ),
        .Q(seq_cnt_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[0]_i_2_n_5 ),
        .Q(seq_cnt_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[0]_i_2_n_4 ),
        .Q(seq_cnt_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[4]_i_1_n_7 ),
        .Q(seq_cnt_reg[4]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \seq_cnt_reg[4]_i_1 
       (.CI(\seq_cnt_reg[0]_i_2_n_0 ),
        .CO({\seq_cnt_reg[4]_i_1_n_0 ,\seq_cnt_reg[4]_i_1_n_1 ,\seq_cnt_reg[4]_i_1_n_2 ,\seq_cnt_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\seq_cnt_reg[4]_i_1_n_4 ,\seq_cnt_reg[4]_i_1_n_5 ,\seq_cnt_reg[4]_i_1_n_6 ,\seq_cnt_reg[4]_i_1_n_7 }),
        .S(seq_cnt_reg[7:4]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[4]_i_1_n_6 ),
        .Q(seq_cnt_reg[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[4]_i_1_n_5 ),
        .Q(seq_cnt_reg[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[4]_i_1_n_4 ),
        .Q(seq_cnt_reg[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[8]_i_1_n_7 ),
        .Q(seq_cnt_reg[8]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \seq_cnt_reg[8]_i_1 
       (.CI(\seq_cnt_reg[4]_i_1_n_0 ),
        .CO({\seq_cnt_reg[8]_i_1_n_0 ,\seq_cnt_reg[8]_i_1_n_1 ,\seq_cnt_reg[8]_i_1_n_2 ,\seq_cnt_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\seq_cnt_reg[8]_i_1_n_4 ,\seq_cnt_reg[8]_i_1_n_5 ,\seq_cnt_reg[8]_i_1_n_6 ,\seq_cnt_reg[8]_i_1_n_7 }),
        .S(seq_cnt_reg[11:8]));
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    \seq_cnt_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\seq_cnt[0]_i_1_n_0 ),
        .D(\seq_cnt_reg[8]_i_1_n_6 ),
        .Q(seq_cnt_reg[9]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 time_cnt0_carry
       (.CI(1'b0),
        .CO({time_cnt0_carry_n_0,time_cnt0_carry_n_1,time_cnt0_carry_n_2,time_cnt0_carry_n_3}),
        .CYINIT(\time_cnt_reg_n_0_[0] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S({\time_cnt_reg_n_0_[4] ,\time_cnt_reg_n_0_[3] ,\time_cnt_reg_n_0_[2] ,\time_cnt_reg_n_0_[1] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 time_cnt0_carry__0
       (.CI(time_cnt0_carry_n_0),
        .CO({time_cnt0_carry__0_n_0,time_cnt0_carry__0_n_1,time_cnt0_carry__0_n_2,time_cnt0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S({\time_cnt_reg_n_0_[8] ,\time_cnt_reg_n_0_[7] ,\time_cnt_reg_n_0_[6] ,\time_cnt_reg_n_0_[5] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 time_cnt0_carry__1
       (.CI(time_cnt0_carry__0_n_0),
        .CO({time_cnt0_carry__1_n_0,time_cnt0_carry__1_n_1,time_cnt0_carry__1_n_2,time_cnt0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S({\time_cnt_reg_n_0_[12] ,\time_cnt_reg_n_0_[11] ,\time_cnt_reg_n_0_[10] ,\time_cnt_reg_n_0_[9] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 time_cnt0_carry__2
       (.CI(time_cnt0_carry__1_n_0),
        .CO({NLW_time_cnt0_carry__2_CO_UNCONNECTED[3:2],time_cnt0_carry__2_n_2,time_cnt0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_time_cnt0_carry__2_O_UNCONNECTED[3],data0[15:13]}),
        .S({1'b0,\time_cnt_reg_n_0_[15] ,\time_cnt_reg_n_0_[14] ,\time_cnt_reg_n_0_[13] }));
  LUT2 #(
    .INIT(4'h1)) 
    \time_cnt[0]_i_1 
       (.I0(\time_cnt_reg_n_0_[0] ),
        .I1(\time_cnt[0]_i_2_n_0 ),
        .O(time_cnt));
  LUT6 #(
    .INIT(64'h0000000000040000)) 
    \time_cnt[0]_i_2 
       (.I0(\time_cnt[0]_i_3_n_0 ),
        .I1(\time_cnt[0]_i_4_n_0 ),
        .I2(\time_cnt[0]_i_5_n_0 ),
        .I3(\time_cnt_reg_n_0_[8] ),
        .I4(\time_cnt_reg_n_0_[13] ),
        .I5(\time_cnt_reg_n_0_[7] ),
        .O(\time_cnt[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFEF)) 
    \time_cnt[0]_i_3 
       (.I0(\time_cnt_reg_n_0_[3] ),
        .I1(\time_cnt_reg_n_0_[2] ),
        .I2(\time_cnt_reg_n_0_[14] ),
        .I3(\time_cnt_reg_n_0_[10] ),
        .O(\time_cnt[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \time_cnt[0]_i_4 
       (.I0(\time_cnt_reg_n_0_[4] ),
        .I1(\time_cnt_reg_n_0_[11] ),
        .I2(\time_cnt_reg_n_0_[6] ),
        .I3(\time_cnt_reg_n_0_[1] ),
        .O(\time_cnt[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hDFFF)) 
    \time_cnt[0]_i_5 
       (.I0(\time_cnt_reg_n_0_[12] ),
        .I1(\time_cnt_reg_n_0_[5] ),
        .I2(\time_cnt_reg_n_0_[15] ),
        .I3(\time_cnt_reg_n_0_[9] ),
        .O(\time_cnt[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \time_cnt[15]_i_1 
       (.I0(\time_cnt[0]_i_2_n_0 ),
        .I1(\time_cnt_reg_n_0_[0] ),
        .O(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(time_cnt),
        .Q(\time_cnt_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[10]),
        .Q(\time_cnt_reg_n_0_[10] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[11]),
        .Q(\time_cnt_reg_n_0_[11] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[12]),
        .Q(\time_cnt_reg_n_0_[12] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[13]),
        .Q(\time_cnt_reg_n_0_[13] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[14]),
        .Q(\time_cnt_reg_n_0_[14] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[15]),
        .Q(\time_cnt_reg_n_0_[15] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[1]),
        .Q(\time_cnt_reg_n_0_[1] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[2]),
        .Q(\time_cnt_reg_n_0_[2] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[3]),
        .Q(\time_cnt_reg_n_0_[3] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[4]),
        .Q(\time_cnt_reg_n_0_[4] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[5]),
        .Q(\time_cnt_reg_n_0_[5] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[6]),
        .Q(\time_cnt_reg_n_0_[6] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[7]),
        .Q(\time_cnt_reg_n_0_[7] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[8]),
        .Q(\time_cnt_reg_n_0_[8] ),
        .R(timer));
  FDRE #(
    .INIT(1'b0)) 
    \time_cnt_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(data0[9]),
        .Q(\time_cnt_reg_n_0_[9] ),
        .R(timer));
  LUT1 #(
    .INIT(2'h1)) 
    \timer[0]_i_2 
       (.I0(\timer_reg_n_0_[0] ),
        .O(\timer[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[0]_i_1_n_7 ),
        .Q(\timer_reg_n_0_[0] ),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\timer_reg[0]_i_1_n_0 ,\timer_reg[0]_i_1_n_1 ,\timer_reg[0]_i_1_n_2 ,\timer_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\timer_reg[0]_i_1_n_4 ,\timer_reg[0]_i_1_n_5 ,\timer_reg[0]_i_1_n_6 ,\timer_reg[0]_i_1_n_7 }),
        .S({\timer_reg_n_0_[3] ,\timer_reg_n_0_[2] ,\timer_reg_n_0_[1] ,\timer[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[10] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[8]_i_1_n_5 ),
        .Q(\timer_reg_n_0_[10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[11] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[8]_i_1_n_4 ),
        .Q(\timer_reg_n_0_[11] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[12] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[12]_i_1_n_7 ),
        .Q(\timer_reg_n_0_[12] ),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[12]_i_1 
       (.CI(\timer_reg[8]_i_1_n_0 ),
        .CO({\timer_reg[12]_i_1_n_0 ,\timer_reg[12]_i_1_n_1 ,\timer_reg[12]_i_1_n_2 ,\timer_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[12]_i_1_n_4 ,\timer_reg[12]_i_1_n_5 ,\timer_reg[12]_i_1_n_6 ,\timer_reg[12]_i_1_n_7 }),
        .S({\timer_reg_n_0_[15] ,\timer_reg_n_0_[14] ,\timer_reg_n_0_[13] ,\timer_reg_n_0_[12] }));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[13] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[12]_i_1_n_6 ),
        .Q(\timer_reg_n_0_[13] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[14] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[12]_i_1_n_5 ),
        .Q(\timer_reg_n_0_[14] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[15] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[12]_i_1_n_4 ),
        .Q(\timer_reg_n_0_[15] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[16] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[16]_i_1_n_7 ),
        .Q(data2[0]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[16]_i_1 
       (.CI(\timer_reg[12]_i_1_n_0 ),
        .CO({\timer_reg[16]_i_1_n_0 ,\timer_reg[16]_i_1_n_1 ,\timer_reg[16]_i_1_n_2 ,\timer_reg[16]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[16]_i_1_n_4 ,\timer_reg[16]_i_1_n_5 ,\timer_reg[16]_i_1_n_6 ,\timer_reg[16]_i_1_n_7 }),
        .S(data2[3:0]));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[17] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[16]_i_1_n_6 ),
        .Q(data2[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[18] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[16]_i_1_n_5 ),
        .Q(data2[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[19] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[16]_i_1_n_4 ),
        .Q(data2[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[0]_i_1_n_6 ),
        .Q(\timer_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[20] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[20]_i_1_n_7 ),
        .Q(data2[4]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[20]_i_1 
       (.CI(\timer_reg[16]_i_1_n_0 ),
        .CO({\timer_reg[20]_i_1_n_0 ,\timer_reg[20]_i_1_n_1 ,\timer_reg[20]_i_1_n_2 ,\timer_reg[20]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[20]_i_1_n_4 ,\timer_reg[20]_i_1_n_5 ,\timer_reg[20]_i_1_n_6 ,\timer_reg[20]_i_1_n_7 }),
        .S(data2[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[21] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[20]_i_1_n_6 ),
        .Q(data2[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[22] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[20]_i_1_n_5 ),
        .Q(data2[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[23] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[20]_i_1_n_4 ),
        .Q(data2[7]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[24] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[24]_i_1_n_7 ),
        .Q(data2[8]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[24]_i_1 
       (.CI(\timer_reg[20]_i_1_n_0 ),
        .CO({\timer_reg[24]_i_1_n_0 ,\timer_reg[24]_i_1_n_1 ,\timer_reg[24]_i_1_n_2 ,\timer_reg[24]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[24]_i_1_n_4 ,\timer_reg[24]_i_1_n_5 ,\timer_reg[24]_i_1_n_6 ,\timer_reg[24]_i_1_n_7 }),
        .S(data2[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[25] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[24]_i_1_n_6 ),
        .Q(data2[9]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[26] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[24]_i_1_n_5 ),
        .Q(data2[10]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[27] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[24]_i_1_n_4 ),
        .Q(data2[11]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[28] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[28]_i_1_n_7 ),
        .Q(data2[12]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[28]_i_1 
       (.CI(\timer_reg[24]_i_1_n_0 ),
        .CO({\NLW_timer_reg[28]_i_1_CO_UNCONNECTED [3],\timer_reg[28]_i_1_n_1 ,\timer_reg[28]_i_1_n_2 ,\timer_reg[28]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[28]_i_1_n_4 ,\timer_reg[28]_i_1_n_5 ,\timer_reg[28]_i_1_n_6 ,\timer_reg[28]_i_1_n_7 }),
        .S(data2[15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[29] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[28]_i_1_n_6 ),
        .Q(data2[13]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[0]_i_1_n_5 ),
        .Q(\timer_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[30] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[28]_i_1_n_5 ),
        .Q(data2[14]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[31] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[28]_i_1_n_4 ),
        .Q(data2[15]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[0]_i_1_n_4 ),
        .Q(\timer_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[4]_i_1_n_7 ),
        .Q(\timer_reg_n_0_[4] ),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[4]_i_1 
       (.CI(\timer_reg[0]_i_1_n_0 ),
        .CO({\timer_reg[4]_i_1_n_0 ,\timer_reg[4]_i_1_n_1 ,\timer_reg[4]_i_1_n_2 ,\timer_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[4]_i_1_n_4 ,\timer_reg[4]_i_1_n_5 ,\timer_reg[4]_i_1_n_6 ,\timer_reg[4]_i_1_n_7 }),
        .S({\timer_reg_n_0_[7] ,\timer_reg_n_0_[6] ,\timer_reg_n_0_[5] ,\timer_reg_n_0_[4] }));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[4]_i_1_n_6 ),
        .Q(\timer_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[4]_i_1_n_5 ),
        .Q(\timer_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[4]_i_1_n_4 ),
        .Q(\timer_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[8] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[8]_i_1_n_7 ),
        .Q(\timer_reg_n_0_[8] ),
        .R(1'b0));
  (* ADDER_THRESHOLD = "11" *) 
  CARRY4 \timer_reg[8]_i_1 
       (.CI(\timer_reg[4]_i_1_n_0 ),
        .CO({\timer_reg[8]_i_1_n_0 ,\timer_reg[8]_i_1_n_1 ,\timer_reg[8]_i_1_n_2 ,\timer_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\timer_reg[8]_i_1_n_4 ,\timer_reg[8]_i_1_n_5 ,\timer_reg[8]_i_1_n_6 ,\timer_reg[8]_i_1_n_7 }),
        .S({\timer_reg_n_0_[11] ,\timer_reg_n_0_[10] ,\timer_reg_n_0_[9] ,\timer_reg_n_0_[8] }));
  FDRE #(
    .INIT(1'b0)) 
    \timer_reg[9] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(timer),
        .D(\timer_reg[8]_i_1_n_6 ),
        .Q(\timer_reg_n_0_[9] ),
        .R(1'b0));
endmodule

module poten_interface
   (core_en,
    SCL_TRI,
    sSDA,
    SDA_TRI,
    \FSM_sequential_sub_state_reg[1]_0 ,
    \filter_cnt_reg[12] ,
    rst,
    ifclk_out_OBUF_BUFG,
    \filter_cnt_reg[3] ,
    dSDA_reg,
    poten_update_start,
    D,
    \txr_reg[7]_0 ,
    SCL_IBUF,
    fSDA,
    SDA_IBUF);
  output core_en;
  output SCL_TRI;
  output sSDA;
  output SDA_TRI;
  output [0:0]\FSM_sequential_sub_state_reg[1]_0 ;
  output \filter_cnt_reg[12] ;
  input rst;
  input ifclk_out_OBUF_BUFG;
  input \filter_cnt_reg[3] ;
  input dSDA_reg;
  input poten_update_start;
  input [0:0]D;
  input [6:0]\txr_reg[7]_0 ;
  input SCL_IBUF;
  input fSDA;
  input SDA_IBUF;

  wire [0:0]D;
  wire \FSM_sequential_sub_state[0]_i_1_n_0 ;
  wire \FSM_sequential_sub_state[1]_i_1_n_0 ;
  wire [0:0]\FSM_sequential_sub_state_reg[1]_0 ;
  wire SCL_IBUF;
  wire SCL_TRI;
  wire SDA_IBUF;
  wire SDA_TRI;
  wire byte_controller_n_4;
  wire byte_controller_n_5;
  wire byte_controller_n_6;
  wire cmd_phase_i_1_n_0;
  wire cmd_phase_reg_n_0;
  wire \cmd_reg_n_0_[0] ;
  wire \cmd_reg_n_0_[2] ;
  wire \cmd_reg_n_0_[3] ;
  wire core_en;
  wire dSDA_reg;
  wire [7:0]data0;
  wire fSDA;
  wire \filter_cnt_reg[12] ;
  wire \filter_cnt_reg[3] ;
  wire ifclk_out_OBUF_BUFG;
  wire [0:0]main_state;
  wire \main_state[0]_i_1_n_0 ;
  wire poten_update_start;
  wire rst;
  wire sSDA;
  wire start_d;
  wire start_dd;
  wire [0:0]sub_state__0;
  wire \txr[2]_i_1_n_0 ;
  wire \txr[3]_i_1_n_0 ;
  wire \txr[6]_i_1_n_0 ;
  wire \txr[7]_i_1_n_0 ;
  wire [6:0]\txr_reg[7]_0 ;
  wire \txr_reg_n_0_[0] ;
  wire \txr_reg_n_0_[1] ;
  wire \txr_reg_n_0_[2] ;
  wire \txr_reg_n_0_[3] ;
  wire \txr_reg_n_0_[4] ;
  wire \txr_reg_n_0_[5] ;
  wire \txr_reg_n_0_[6] ;
  wire \txr_reg_n_0_[7] ;

  LUT5 #(
    .INIT(32'hAAAA9AAA)) 
    \FSM_sequential_sub_state[0]_i_1 
       (.I0(sub_state__0),
        .I1(\FSM_sequential_sub_state_reg[1]_0 ),
        .I2(main_state),
        .I3(cmd_phase_reg_n_0),
        .I4(\cmd_reg_n_0_[0] ),
        .O(\FSM_sequential_sub_state[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'hCCCCACCC)) 
    \FSM_sequential_sub_state[1]_i_1 
       (.I0(sub_state__0),
        .I1(\FSM_sequential_sub_state_reg[1]_0 ),
        .I2(main_state),
        .I3(cmd_phase_reg_n_0),
        .I4(\cmd_reg_n_0_[0] ),
        .O(\FSM_sequential_sub_state[1]_i_1_n_0 ));
  (* FSM_ENCODED_STATES = "SUBSTATE_SEND_POTEN_ADDR:01,SUBSTATE_SEND_POTEN_VAL:10,SUBSTATE_SEND_SLAVE_ADDR:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_sub_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_sub_state[0]_i_1_n_0 ),
        .Q(sub_state__0),
        .R(rst));
  (* FSM_ENCODED_STATES = "SUBSTATE_SEND_POTEN_ADDR:01,SUBSTATE_SEND_POTEN_VAL:10,SUBSTATE_SEND_SLAVE_ADDR:00,iSTATE:11" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_sub_state_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\FSM_sequential_sub_state[1]_i_1_n_0 ),
        .Q(\FSM_sequential_sub_state_reg[1]_0 ),
        .R(rst));
  i2c_master_byte_ctrl byte_controller
       (.Q({\txr_reg_n_0_[7] ,\txr_reg_n_0_[6] ,\txr_reg_n_0_[5] ,\txr_reg_n_0_[4] ,\txr_reg_n_0_[3] ,\txr_reg_n_0_[2] ,\txr_reg_n_0_[1] ,\txr_reg_n_0_[0] }),
        .SCL_IBUF(SCL_IBUF),
        .SDA_IBUF(SDA_IBUF),
        .SDA_TRI(SDA_TRI),
        .cmd_ack_reg_0(\cmd_reg_n_0_[2] ),
        .cmd_phase_reg(byte_controller_n_4),
        .cmd_phase_reg_0(byte_controller_n_5),
        .cmd_phase_reg_1(byte_controller_n_6),
        .\cmd_reg[0] (\cmd_reg_n_0_[0] ),
        .\cmd_reg[0]_0 (cmd_phase_reg_n_0),
        .\cmd_reg[3] (\FSM_sequential_sub_state_reg[1]_0 ),
        .\core_cmd_reg[0]_0 (\cmd_reg_n_0_[3] ),
        .dSDA_reg(dSDA_reg),
        .fSDA(fSDA),
        .\filter_cnt_reg[12] (\filter_cnt_reg[12] ),
        .\filter_cnt_reg[3] (\filter_cnt_reg[3] ),
        .\filter_cnt_reg[4] (core_en),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .main_state(main_state),
        .rst(rst),
        .sSDA_reg(sSDA),
        .scl_oen_reg(SCL_TRI),
        .sub_state__0(sub_state__0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'hFF708F70)) 
    cmd_phase_i_1
       (.I0(sub_state__0),
        .I1(\FSM_sequential_sub_state_reg[1]_0 ),
        .I2(main_state),
        .I3(cmd_phase_reg_n_0),
        .I4(\cmd_reg_n_0_[0] ),
        .O(cmd_phase_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    cmd_phase_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(cmd_phase_i_1_n_0),
        .Q(cmd_phase_reg_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cmd_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(byte_controller_n_6),
        .Q(\cmd_reg_n_0_[0] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cmd_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(byte_controller_n_5),
        .Q(\cmd_reg_n_0_[2] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \cmd_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(byte_controller_n_4),
        .Q(\cmd_reg_n_0_[3] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    core_en_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(1'b1),
        .Q(core_en),
        .R(rst));
  LUT3 #(
    .INIT(8'hF2)) 
    \main_state[0]_i_1 
       (.I0(start_d),
        .I1(start_dd),
        .I2(main_state),
        .O(\main_state[0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \main_state_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(\main_state[0]_i_1_n_0 ),
        .Q(main_state),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    start_d_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(poten_update_start),
        .Q(start_d),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    start_dd_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(start_d),
        .Q(start_dd),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hEA)) 
    \txr[0]_i_1 
       (.I0(sub_state__0),
        .I1(\txr_reg[7]_0 [0]),
        .I2(\FSM_sequential_sub_state_reg[1]_0 ),
        .O(data0[0]));
  LUT2 #(
    .INIT(4'h8)) 
    \txr[1]_i_1 
       (.I0(\FSM_sequential_sub_state_reg[1]_0 ),
        .I1(\txr_reg[7]_0 [1]),
        .O(data0[1]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h45)) 
    \txr[2]_i_1 
       (.I0(sub_state__0),
        .I1(\txr_reg[7]_0 [2]),
        .I2(\FSM_sequential_sub_state_reg[1]_0 ),
        .O(\txr[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'h45)) 
    \txr[3]_i_1 
       (.I0(sub_state__0),
        .I1(\txr_reg[7]_0 [3]),
        .I2(\FSM_sequential_sub_state_reg[1]_0 ),
        .O(\txr[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \txr[5]_i_1 
       (.I0(\FSM_sequential_sub_state_reg[1]_0 ),
        .I1(\txr_reg[7]_0 [4]),
        .O(data0[5]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'h45)) 
    \txr[6]_i_1 
       (.I0(sub_state__0),
        .I1(\txr_reg[7]_0 [5]),
        .I2(\FSM_sequential_sub_state_reg[1]_0 ),
        .O(\txr[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0070)) 
    \txr[7]_i_1 
       (.I0(sub_state__0),
        .I1(\FSM_sequential_sub_state_reg[1]_0 ),
        .I2(main_state),
        .I3(rst),
        .O(\txr[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \txr[7]_i_2 
       (.I0(\FSM_sequential_sub_state_reg[1]_0 ),
        .I1(\txr_reg[7]_0 [6]),
        .O(data0[7]));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(data0[0]),
        .Q(\txr_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(data0[1]),
        .Q(\txr_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(\txr[2]_i_1_n_0 ),
        .Q(\txr_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(\txr[3]_i_1_n_0 ),
        .Q(\txr_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(D),
        .Q(\txr_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[5] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(data0[5]),
        .Q(\txr_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[6] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(\txr[6]_i_1_n_0 ),
        .Q(\txr_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \txr_reg[7] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(\txr[7]_i_1_n_0 ),
        .D(data0[7]),
        .Q(\txr_reg_n_0_[7] ),
        .R(1'b0));
endmodule

module reset_subs
   (fSDA,
    rst,
    sSDA_reg,
    LED_GREEN_OBUF,
    core_en_reg,
    ifclk_out_OBUF_BUFG,
    \fSCL_reg[2] ,
    sSDA,
    RST_IBUF,
    pll_locked,
    core_en);
  output fSDA;
  output rst;
  output sSDA_reg;
  output LED_GREEN_OBUF;
  output core_en_reg;
  input ifclk_out_OBUF_BUFG;
  input \fSCL_reg[2] ;
  input sSDA;
  input RST_IBUF;
  input pll_locked;
  input core_en;

  wire LED_GREEN_OBUF;
  wire RST_IBUF;
  wire core_en;
  wire core_en_reg;
  wire \fSCL_reg[2] ;
  wire fSDA;
  wire [4:0]hold_counter0;
  wire \hold_counter[1]_i_1_n_0 ;
  wire \hold_counter[4]_i_1_n_0 ;
  wire [4:0]hold_counter_reg;
  wire ifclk_out_OBUF_BUFG;
  wire pll_locked;
  wire rst;
  wire rst_0;
  wire rst_i_1_n_0;
  wire sSDA;
  wire sSDA_reg;
  wire sel;

  LUT3 #(
    .INIT(8'hFB)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(rst_0),
        .I1(pll_locked),
        .I2(RST_IBUF),
        .O(rst));
  LUT3 #(
    .INIT(8'h04)) 
    LED_GREEN_OBUF_inst_i_1
       (.I0(RST_IBUF),
        .I1(pll_locked),
        .I2(rst_0),
        .O(LED_GREEN_OBUF));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \byte_controller/bit_controller/filter_cnt[3]_i_1 
       (.I0(rst),
        .I1(core_en),
        .O(core_en_reg));
  LUT2 #(
    .INIT(4'hE)) 
    dSDA_i_1
       (.I0(rst),
        .I1(sSDA),
        .O(sSDA_reg));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \fSCL[2]_i_1 
       (.I0(rst),
        .I1(\fSCL_reg[2] ),
        .O(fSDA));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \hold_counter[0]_i_1 
       (.I0(hold_counter_reg[0]),
        .O(hold_counter0[0]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \hold_counter[1]_i_1 
       (.I0(hold_counter_reg[1]),
        .I1(hold_counter_reg[0]),
        .O(\hold_counter[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'hA9)) 
    \hold_counter[2]_i_1 
       (.I0(hold_counter_reg[2]),
        .I1(hold_counter_reg[0]),
        .I2(hold_counter_reg[1]),
        .O(hold_counter0[2]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'hAAA9)) 
    \hold_counter[3]_i_1 
       (.I0(hold_counter_reg[3]),
        .I1(hold_counter_reg[2]),
        .I2(hold_counter_reg[1]),
        .I3(hold_counter_reg[0]),
        .O(hold_counter0[3]));
  LUT2 #(
    .INIT(4'hB)) 
    \hold_counter[4]_i_1 
       (.I0(RST_IBUF),
        .I1(pll_locked),
        .O(\hold_counter[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \hold_counter[4]_i_2 
       (.I0(hold_counter_reg[4]),
        .I1(hold_counter_reg[3]),
        .I2(hold_counter_reg[0]),
        .I3(hold_counter_reg[1]),
        .I4(hold_counter_reg[2]),
        .O(sel));
  LUT5 #(
    .INIT(32'hAAAAAAA9)) 
    \hold_counter[4]_i_3 
       (.I0(hold_counter_reg[4]),
        .I1(hold_counter_reg[3]),
        .I2(hold_counter_reg[0]),
        .I3(hold_counter_reg[1]),
        .I4(hold_counter_reg[2]),
        .O(hold_counter0[4]));
  FDRE #(
    .INIT(1'b0)) 
    \hold_counter_reg[0] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(hold_counter0[0]),
        .Q(hold_counter_reg[0]),
        .R(\hold_counter[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hold_counter_reg[1] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(\hold_counter[1]_i_1_n_0 ),
        .Q(hold_counter_reg[1]),
        .R(\hold_counter[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hold_counter_reg[2] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(hold_counter0[2]),
        .Q(hold_counter_reg[2]),
        .R(\hold_counter[4]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \hold_counter_reg[3] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(hold_counter0[3]),
        .Q(hold_counter_reg[3]),
        .R(\hold_counter[4]_i_1_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \hold_counter_reg[4] 
       (.C(ifclk_out_OBUF_BUFG),
        .CE(sel),
        .D(hold_counter0[4]),
        .Q(hold_counter_reg[4]),
        .S(\hold_counter[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    rst_i_1
       (.I0(hold_counter_reg[2]),
        .I1(hold_counter_reg[1]),
        .I2(hold_counter_reg[0]),
        .I3(hold_counter_reg[3]),
        .I4(hold_counter_reg[4]),
        .I5(\hold_counter[4]_i_1_n_0 ),
        .O(rst_i_1_n_0));
  FDRE #(
    .INIT(1'b1)) 
    rst_reg
       (.C(ifclk_out_OBUF_BUFG),
        .CE(1'b1),
        .D(rst_i_1_n_0),
        .Q(rst_0),
        .R(1'b0));
endmodule

(* trigger_head = "64" *) (* trigger_tail = "64" *) 
(* NotValidForBitStream *)
module zeabus_hydrophone
   (OTR_1,
    D_1,
    CLKA_1,
    CLKB_1,
    OTR_2,
    D_2,
    CLKA_2,
    CLKB_2,
    SCL,
    SDA,
    ifclk_out,
    DQ,
    SLCS,
    SLWR,
    SLRD,
    SLOE,
    PKTEND,
    A,
    FLAGA,
    FLAGB,
    RST,
    FUNC_EN,
    LED_BLUE,
    LED_GREEN,
    LED_RED_n,
    LED_RED_1,
    LED_YELLOW_1,
    LED_GREEN_1,
    LED_RED_2,
    LED_YELLOW_2,
    LED_GREEN_2,
    LED_RED_3,
    LED_YELLOW_3,
    LED_GREEN_3,
    clk_in);
  input OTR_1;
  input [13:0]D_1;
  output CLKA_1;
  output CLKB_1;
  input OTR_2;
  input [13:0]D_2;
  output CLKA_2;
  output CLKB_2;
  inout SCL;
  inout SDA;
  output ifclk_out;
  inout [15:0]DQ;
  output SLCS;
  output SLWR;
  output SLRD;
  output SLOE;
  output PKTEND;
  output [1:0]A;
  input FLAGA;
  input FLAGB;
  input RST;
  input FUNC_EN;
  output LED_BLUE;
  output LED_GREEN;
  output LED_RED_n;
  output LED_RED_1;
  output LED_YELLOW_1;
  output LED_GREEN_1;
  output LED_RED_2;
  output LED_YELLOW_2;
  output LED_GREEN_2;
  output LED_RED_3;
  output LED_YELLOW_3;
  output LED_GREEN_3;
  input clk_in;

  wire [1:0]A;
  wire [0:0]A_OBUF;
  wire CLKA_1;
  wire CLKA_2;
  wire CLKB_1;
  wire CLKB_2;
  wire CLKB_2_OBUF;
  wire [15:0]DQ;
  wire [15:0]DQ_IBUF;
  wire [15:0]DQ_OBUF;
  wire \DQ_TRI[0] ;
  wire [13:0]D_1;
  wire [13:0]D_1_IBUF;
  wire [13:0]D_2;
  wire [13:0]D_2_IBUF;
  wire FLAGA;
  wire FLAGA_IBUF;
  wire FLAGB;
  wire FLAGB_IBUF;
  wire FUNC_EN;
  wire FUNC_EN_IBUF;
  wire LED_BLUE;
  wire LED_BLUE_OBUF;
  wire LED_GREEN;
  wire LED_GREEN_1;
  wire LED_GREEN_2;
  wire LED_GREEN_3;
  wire LED_GREEN_3_OBUF;
  wire LED_GREEN_OBUF;
  wire LED_RED_1;
  wire LED_RED_2;
  wire LED_RED_3;
  wire LED_RED_n;
  wire LED_RED_n_OBUF;
  wire LED_YELLOW_1;
  wire LED_YELLOW_2;
  wire LED_YELLOW_3;
  wire OTR_1;
  wire OTR_1_IBUF;
  wire OTR_2;
  wire OTR_2_IBUF;
  wire PKTEND;
  wire PKTEND_OBUF;
  wire RST;
  wire RST_IBUF;
  wire SCL;
  wire SCL_IBUF;
  wire SCL_TRI;
  wire SDA;
  wire SDA_IBUF;
  wire SDA_TRI;
  wire SLCS;
  wire SLCS_OBUF;
  wire SLOE;
  wire SLOE_OBUF;
  wire SLRD;
  wire SLRD_OBUF;
  wire SLWR;
  wire SLWR_OBUF;
  wire adc1_n_0;
  wire adc1_n_17;
  wire adc1_n_18;
  wire adc1_n_19;
  wire adc1_n_20;
  wire adc1_n_21;
  wire adc1_n_22;
  wire adc1_n_23;
  wire adc1_n_24;
  wire adc1_n_25;
  wire adc1_n_26;
  wire adc1_n_27;
  wire adc1_n_28;
  wire adc1_n_29;
  wire adc1_n_30;
  wire adc1_n_31;
  wire adc1_n_32;
  wire adc1_n_33;
  wire adc1_n_34;
  wire adc1_n_35;
  wire adc1_n_36;
  wire adc1_n_37;
  wire adc1_n_38;
  wire adc1_n_39;
  wire adc1_n_40;
  wire adc1_n_41;
  wire adc1_n_42;
  wire adc1_n_43;
  wire adc1_n_44;
  wire adc1_n_45;
  wire adc1_n_46;
  wire adc1_n_47;
  wire adc1_n_48;
  wire adc1_n_49;
  wire adc1_n_50;
  wire adc1_n_51;
  wire adc1_n_52;
  wire adc1_n_53;
  wire adc1_n_54;
  wire adc1_n_71;
  wire adc1_n_72;
  wire adc1_n_73;
  wire adc1_n_74;
  wire adc1_n_75;
  wire adc1_n_76;
  wire adc1_n_77;
  wire adc1_n_78;
  wire adc1_n_79;
  wire adc2_n_1;
  wire adc2_n_10;
  wire adc2_n_11;
  wire adc2_n_12;
  wire adc2_n_13;
  wire adc2_n_14;
  wire adc2_n_15;
  wire adc2_n_16;
  wire adc2_n_17;
  wire adc2_n_18;
  wire adc2_n_19;
  wire adc2_n_2;
  wire adc2_n_20;
  wire adc2_n_21;
  wire adc2_n_22;
  wire adc2_n_23;
  wire adc2_n_24;
  wire adc2_n_25;
  wire adc2_n_26;
  wire adc2_n_27;
  wire adc2_n_28;
  wire adc2_n_29;
  wire adc2_n_3;
  wire adc2_n_30;
  wire adc2_n_31;
  wire adc2_n_32;
  wire adc2_n_33;
  wire adc2_n_34;
  wire adc2_n_35;
  wire adc2_n_36;
  wire adc2_n_37;
  wire adc2_n_38;
  wire adc2_n_39;
  wire adc2_n_4;
  wire adc2_n_40;
  wire adc2_n_41;
  wire adc2_n_42;
  wire adc2_n_43;
  wire adc2_n_44;
  wire adc2_n_45;
  wire adc2_n_46;
  wire adc2_n_47;
  wire adc2_n_48;
  wire adc2_n_49;
  wire adc2_n_5;
  wire adc2_n_50;
  wire adc2_n_51;
  wire adc2_n_52;
  wire adc2_n_6;
  wire adc2_n_69;
  wire adc2_n_7;
  wire adc2_n_70;
  wire adc2_n_71;
  wire adc2_n_72;
  wire adc2_n_73;
  wire adc2_n_74;
  wire adc2_n_75;
  wire adc2_n_76;
  wire adc2_n_77;
  wire adc2_n_78;
  wire adc2_n_8;
  wire adc2_n_9;
  wire adc_strb_1;
  wire adc_strb_2;
  wire \byte_controller/bit_controller/fSDA ;
  wire \byte_controller/bit_controller/sSDA ;
  wire clk_in;
  wire clk_in_IBUF;
  wire clk_in_buf;
  wire config_man_n_10;
  wire config_man_n_11;
  wire config_man_n_12;
  wire config_man_n_13;
  wire config_man_n_14;
  wire config_man_n_15;
  wire config_man_n_16;
  wire config_man_n_17;
  wire config_man_n_18;
  wire config_man_n_19;
  wire config_man_n_20;
  wire config_man_n_21;
  wire config_man_n_22;
  wire config_man_n_23;
  wire config_man_n_24;
  wire config_man_n_25;
  wire config_man_n_26;
  wire config_man_n_27;
  wire config_man_n_28;
  wire config_man_n_29;
  wire config_man_n_30;
  wire config_man_n_31;
  wire config_man_n_32;
  wire config_man_n_33;
  wire config_man_n_34;
  wire config_man_n_35;
  wire config_man_n_36;
  wire config_man_n_37;
  wire config_man_n_38;
  wire config_man_n_39;
  wire config_man_n_4;
  wire config_man_n_40;
  wire config_man_n_41;
  wire config_man_n_42;
  wire config_man_n_43;
  wire config_man_n_44;
  wire config_man_n_45;
  wire config_man_n_46;
  wire config_man_n_47;
  wire config_man_n_48;
  wire config_man_n_5;
  wire config_man_n_6;
  wire config_man_n_7;
  wire config_man_n_8;
  wire config_man_n_9;
  wire core_en;
  wire [19:4]d_out;
  wire [19:4]d_out_0;
  wire [4:4]data0;
  wire fifo_rst_internal;
  wire filter_rst;
  wire ifclk_out;
  wire ifclk_out_OBUF;
  wire ifclk_out_OBUF_BUFG;
  wire in_strb_d;
  wire latched_input0;
  wire [15:2]out0;
  wire [15:0]packetize_out;
  wire pkt_end;
  wire pll_fb;
  wire pll_locked;
  wire [7:0]poten0;
  wire poten_i2c_n_5;
  wire poten_update_start;
  wire reset_inst_n_2;
  wire reset_inst_n_4;
  wire rst;
  wire rst_2d;
  wire rst_3d;
  wire rst_4d;
  wire rst_6d;
  wire rst_7d;
  wire rst_d;
  wire rst_internal;
  wire [15:0]rx_data;
  wire rx_empty;
  wire rx_oe;
  wire slave_fifo_n_45;
  wire slave_fifo_n_46;
  wire slave_fifo_n_47;
  wire [1:1]sub_state__0;
  wire t_counter0;
  wire t_counter2;
  wire t_counter3;
  wire t_counter4;
  wire t_counter40_in;
  wire [63:0]trigged_out;
  wire [0:0]trigger_level;
  wire trigger_n_73;
  wire trigger_strobe;
  wire NLW_PLLE2_BASE_inst_CLKOUT2_UNCONNECTED;
  wire NLW_PLLE2_BASE_inst_CLKOUT3_UNCONNECTED;
  wire NLW_PLLE2_BASE_inst_CLKOUT4_UNCONNECTED;
  wire NLW_PLLE2_BASE_inst_CLKOUT5_UNCONNECTED;
  wire NLW_PLLE2_BASE_inst_DRDY_UNCONNECTED;
  wire [15:0]NLW_PLLE2_BASE_inst_DO_UNCONNECTED;

  OBUF \A_OBUF[0]_inst 
       (.I(A_OBUF),
        .O(A[0]));
  OBUF \A_OBUF[1]_inst 
       (.I(1'b0),
        .O(A[1]));
  OBUF CLKA_1_OBUF_inst
       (.I(CLKB_2_OBUF),
        .O(CLKA_1));
  OBUF CLKA_2_OBUF_inst
       (.I(CLKB_2_OBUF),
        .O(CLKA_2));
  OBUF CLKB_1_OBUF_inst
       (.I(CLKB_2_OBUF),
        .O(CLKB_1));
  OBUF CLKB_2_OBUF_inst
       (.I(CLKB_2_OBUF),
        .O(CLKB_2));
  IOBUF \DQ_IOBUF[0]_inst 
       (.I(DQ_OBUF[0]),
        .IO(DQ[0]),
        .O(DQ_IBUF[0]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[10]_inst 
       (.I(DQ_OBUF[10]),
        .IO(DQ[10]),
        .O(DQ_IBUF[10]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[11]_inst 
       (.I(DQ_OBUF[11]),
        .IO(DQ[11]),
        .O(DQ_IBUF[11]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[12]_inst 
       (.I(DQ_OBUF[12]),
        .IO(DQ[12]),
        .O(DQ_IBUF[12]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[13]_inst 
       (.I(DQ_OBUF[13]),
        .IO(DQ[13]),
        .O(DQ_IBUF[13]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[14]_inst 
       (.I(DQ_OBUF[14]),
        .IO(DQ[14]),
        .O(DQ_IBUF[14]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[15]_inst 
       (.I(DQ_OBUF[15]),
        .IO(DQ[15]),
        .O(DQ_IBUF[15]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[1]_inst 
       (.I(DQ_OBUF[1]),
        .IO(DQ[1]),
        .O(DQ_IBUF[1]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[2]_inst 
       (.I(DQ_OBUF[2]),
        .IO(DQ[2]),
        .O(DQ_IBUF[2]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[3]_inst 
       (.I(DQ_OBUF[3]),
        .IO(DQ[3]),
        .O(DQ_IBUF[3]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[4]_inst 
       (.I(DQ_OBUF[4]),
        .IO(DQ[4]),
        .O(DQ_IBUF[4]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[5]_inst 
       (.I(DQ_OBUF[5]),
        .IO(DQ[5]),
        .O(DQ_IBUF[5]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[6]_inst 
       (.I(DQ_OBUF[6]),
        .IO(DQ[6]),
        .O(DQ_IBUF[6]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[7]_inst 
       (.I(DQ_OBUF[7]),
        .IO(DQ[7]),
        .O(DQ_IBUF[7]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[8]_inst 
       (.I(DQ_OBUF[8]),
        .IO(DQ[8]),
        .O(DQ_IBUF[8]),
        .T(\DQ_TRI[0] ));
  IOBUF \DQ_IOBUF[9]_inst 
       (.I(DQ_OBUF[9]),
        .IO(DQ[9]),
        .O(DQ_IBUF[9]),
        .T(\DQ_TRI[0] ));
  IBUF \D_1_IBUF[0]_inst 
       (.I(D_1[0]),
        .O(D_1_IBUF[0]));
  IBUF \D_1_IBUF[10]_inst 
       (.I(D_1[10]),
        .O(D_1_IBUF[10]));
  IBUF \D_1_IBUF[11]_inst 
       (.I(D_1[11]),
        .O(D_1_IBUF[11]));
  IBUF \D_1_IBUF[12]_inst 
       (.I(D_1[12]),
        .O(D_1_IBUF[12]));
  IBUF \D_1_IBUF[13]_inst 
       (.I(D_1[13]),
        .O(D_1_IBUF[13]));
  IBUF \D_1_IBUF[1]_inst 
       (.I(D_1[1]),
        .O(D_1_IBUF[1]));
  IBUF \D_1_IBUF[2]_inst 
       (.I(D_1[2]),
        .O(D_1_IBUF[2]));
  IBUF \D_1_IBUF[3]_inst 
       (.I(D_1[3]),
        .O(D_1_IBUF[3]));
  IBUF \D_1_IBUF[4]_inst 
       (.I(D_1[4]),
        .O(D_1_IBUF[4]));
  IBUF \D_1_IBUF[5]_inst 
       (.I(D_1[5]),
        .O(D_1_IBUF[5]));
  IBUF \D_1_IBUF[6]_inst 
       (.I(D_1[6]),
        .O(D_1_IBUF[6]));
  IBUF \D_1_IBUF[7]_inst 
       (.I(D_1[7]),
        .O(D_1_IBUF[7]));
  IBUF \D_1_IBUF[8]_inst 
       (.I(D_1[8]),
        .O(D_1_IBUF[8]));
  IBUF \D_1_IBUF[9]_inst 
       (.I(D_1[9]),
        .O(D_1_IBUF[9]));
  IBUF \D_2_IBUF[0]_inst 
       (.I(D_2[0]),
        .O(D_2_IBUF[0]));
  IBUF \D_2_IBUF[10]_inst 
       (.I(D_2[10]),
        .O(D_2_IBUF[10]));
  IBUF \D_2_IBUF[11]_inst 
       (.I(D_2[11]),
        .O(D_2_IBUF[11]));
  IBUF \D_2_IBUF[12]_inst 
       (.I(D_2[12]),
        .O(D_2_IBUF[12]));
  IBUF \D_2_IBUF[13]_inst 
       (.I(D_2[13]),
        .O(D_2_IBUF[13]));
  IBUF \D_2_IBUF[1]_inst 
       (.I(D_2[1]),
        .O(D_2_IBUF[1]));
  IBUF \D_2_IBUF[2]_inst 
       (.I(D_2[2]),
        .O(D_2_IBUF[2]));
  IBUF \D_2_IBUF[3]_inst 
       (.I(D_2[3]),
        .O(D_2_IBUF[3]));
  IBUF \D_2_IBUF[4]_inst 
       (.I(D_2[4]),
        .O(D_2_IBUF[4]));
  IBUF \D_2_IBUF[5]_inst 
       (.I(D_2[5]),
        .O(D_2_IBUF[5]));
  IBUF \D_2_IBUF[6]_inst 
       (.I(D_2[6]),
        .O(D_2_IBUF[6]));
  IBUF \D_2_IBUF[7]_inst 
       (.I(D_2[7]),
        .O(D_2_IBUF[7]));
  IBUF \D_2_IBUF[8]_inst 
       (.I(D_2[8]),
        .O(D_2_IBUF[8]));
  IBUF \D_2_IBUF[9]_inst 
       (.I(D_2[9]),
        .O(D_2_IBUF[9]));
  IBUF FLAGA_IBUF_inst
       (.I(FLAGA),
        .O(FLAGA_IBUF));
  IBUF FLAGB_IBUF_inst
       (.I(FLAGB),
        .O(FLAGB_IBUF));
  IBUF FUNC_EN_IBUF_inst
       (.I(FUNC_EN),
        .O(FUNC_EN_IBUF));
  OBUF LED_BLUE_OBUF_inst
       (.I(LED_BLUE_OBUF),
        .O(LED_BLUE));
  OBUF LED_GREEN_1_OBUF_inst
       (.I(1'b0),
        .O(LED_GREEN_1));
  OBUF LED_GREEN_2_OBUF_inst
       (.I(1'b0),
        .O(LED_GREEN_2));
  OBUF LED_GREEN_3_OBUF_inst
       (.I(LED_GREEN_3_OBUF),
        .O(LED_GREEN_3));
  OBUF LED_GREEN_OBUF_inst
       (.I(LED_GREEN_OBUF),
        .O(LED_GREEN));
  OBUF LED_RED_1_OBUF_inst
       (.I(1'b0),
        .O(LED_RED_1));
  OBUF LED_RED_2_OBUF_inst
       (.I(1'b0),
        .O(LED_RED_2));
  OBUF LED_RED_3_OBUF_inst
       (.I(1'b1),
        .O(LED_RED_3));
  OBUF LED_RED_n_OBUF_inst
       (.I(LED_RED_n_OBUF),
        .O(LED_RED_n));
  OBUF LED_YELLOW_1_OBUF_inst
       (.I(1'b0),
        .O(LED_YELLOW_1));
  OBUF LED_YELLOW_2_OBUF_inst
       (.I(1'b0),
        .O(LED_YELLOW_2));
  OBUF LED_YELLOW_3_OBUF_inst
       (.I(1'b0),
        .O(LED_YELLOW_3));
  IBUF OTR_1_IBUF_inst
       (.I(OTR_1),
        .O(OTR_1_IBUF));
  IBUF OTR_2_IBUF_inst
       (.I(OTR_2),
        .O(OTR_2_IBUF));
  OBUF PKTEND_OBUF_inst
       (.I(PKTEND_OBUF),
        .O(PKTEND));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* XILINX_LEGACY_PRIM = "PLLE2_BASE" *) 
  PLLE2_ADV #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(32),
    .CLKFBOUT_PHASE(0.000000),
    .CLKIN1_PERIOD(38.462000),
    .CLKIN2_PERIOD(10.000000),
    .CLKOUT0_DIVIDE(13),
    .CLKOUT0_DUTY_CYCLE(0.500000),
    .CLKOUT0_PHASE(-141.923000),
    .CLKOUT1_DIVIDE(13),
    .CLKOUT1_DUTY_CYCLE(0.500000),
    .CLKOUT1_PHASE(0.000000),
    .CLKOUT2_DIVIDE(1),
    .CLKOUT2_DUTY_CYCLE(0.500000),
    .CLKOUT2_PHASE(0.000000),
    .CLKOUT3_DIVIDE(1),
    .CLKOUT3_DUTY_CYCLE(0.500000),
    .CLKOUT3_PHASE(0.000000),
    .CLKOUT4_DIVIDE(1),
    .CLKOUT4_DUTY_CYCLE(0.500000),
    .CLKOUT4_PHASE(0.000000),
    .CLKOUT5_DIVIDE(1),
    .CLKOUT5_DUTY_CYCLE(0.500000),
    .CLKOUT5_PHASE(0.000000),
    .COMPENSATION("INTERNAL"),
    .DIVCLK_DIVIDE(1),
    .REF_JITTER1(0.000000),
    .REF_JITTER2(0.010000),
    .STARTUP_WAIT("FALSE")) 
    PLLE2_BASE_inst
       (.CLKFBIN(pll_fb),
        .CLKFBOUT(pll_fb),
        .CLKIN1(clk_in_buf),
        .CLKIN2(1'b0),
        .CLKINSEL(1'b1),
        .CLKOUT0(CLKB_2_OBUF),
        .CLKOUT1(ifclk_out_OBUF),
        .CLKOUT2(NLW_PLLE2_BASE_inst_CLKOUT2_UNCONNECTED),
        .CLKOUT3(NLW_PLLE2_BASE_inst_CLKOUT3_UNCONNECTED),
        .CLKOUT4(NLW_PLLE2_BASE_inst_CLKOUT4_UNCONNECTED),
        .CLKOUT5(NLW_PLLE2_BASE_inst_CLKOUT5_UNCONNECTED),
        .DADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DCLK(1'b0),
        .DEN(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DO(NLW_PLLE2_BASE_inst_DO_UNCONNECTED[15:0]),
        .DRDY(NLW_PLLE2_BASE_inst_DRDY_UNCONNECTED),
        .DWE(1'b0),
        .LOCKED(pll_locked),
        .PWRDWN(1'b0),
        .RST(RST_IBUF));
  IBUF RST_IBUF_inst
       (.I(RST),
        .O(RST_IBUF));
  IOBUF SCL_IOBUF_inst
       (.I(1'b0),
        .IO(SCL),
        .O(SCL_IBUF),
        .T(SCL_TRI));
  IOBUF SDA_IOBUF_inst
       (.I(1'b0),
        .IO(SDA),
        .O(SDA_IBUF),
        .T(SDA_TRI));
  OBUF SLCS_OBUF_inst
       (.I(SLCS_OBUF),
        .O(SLCS));
  OBUF SLOE_OBUF_inst
       (.I(SLOE_OBUF),
        .O(SLOE));
  OBUF SLRD_OBUF_inst
       (.I(SLRD_OBUF),
        .O(SLRD));
  OBUF SLWR_OBUF_inst
       (.I(SLWR_OBUF),
        .O(SLWR));
  adc_interface adc1
       (.DI({adc1_n_31,adc1_n_32,adc1_n_33,adc1_n_34}),
        .D_1_IBUF(D_1_IBUF),
        .E(slave_fifo_n_45),
        .O({adc1_n_17,adc1_n_18,adc1_n_19}),
        .OTR_1_IBUF(OTR_1_IBUF),
        .Q({adc1_n_35,adc1_n_36,adc1_n_37,adc1_n_38,adc1_n_39,adc1_n_40,adc1_n_41,adc1_n_42,adc1_n_43,adc1_n_44,adc1_n_45,adc1_n_46,adc1_n_47,adc1_n_48,adc1_n_49,adc1_n_50}),
        .S(adc1_n_71),
        .SR(filter_rst),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .\counter_q_reg[5] (adc1_n_0),
        .\d_out_reg[10] ({adc1_n_51,adc1_n_52,adc1_n_53,adc1_n_54}),
        .\d_out_reg[12] ({adc1_n_20,adc1_n_21,adc1_n_22,adc1_n_23}),
        .\d_out_reg[16] ({adc1_n_24,adc1_n_25,adc1_n_26,adc1_n_27}),
        .\d_out_reg[16]_0 ({adc1_n_73,adc1_n_74,adc1_n_75}),
        .\d_out_reg[16]_1 ({adc1_n_76,adc1_n_77,adc1_n_78}),
        .\d_out_reg[19] (out0),
        .\d_out_reg[19]_0 ({adc1_n_28,adc1_n_29,adc1_n_30}),
        .\d_out_reg[19]_1 (d_out),
        .\d_out_reg[4] (adc1_n_72),
        .\dummy_counter_reg[0] (slave_fifo_n_46),
        .\dummy_counter_reg[9] (adc1_n_79),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .rst(rst),
        .\t_counter4_inferred__0/i__carry (config_man_n_17),
        .\t_counter4_inferred__0/i__carry_0 (config_man_n_7),
        .\t_counter4_inferred__0/i__carry_1 (config_man_n_19),
        .\t_counter4_inferred__0/i__carry_2 (config_man_n_18),
        .\t_counter4_inferred__0/i__carry_3 (config_man_n_21),
        .\t_counter4_inferred__0/i__carry_4 (config_man_n_20),
        .\t_counter4_inferred__0/i__carry_5 (config_man_n_22),
        .\t_counter4_inferred__0/i__carry_6 (trigger_level),
        .\t_counter4_inferred__0/i__carry__0 (config_man_n_44),
        .\t_counter4_inferred__0/i__carry__0_0 (config_man_n_43),
        .\t_counter4_inferred__0/i__carry__0_1 (config_man_n_46),
        .\t_counter4_inferred__0/i__carry__0_2 (config_man_n_45),
        .\t_counter4_inferred__0/i__carry__0_3 (config_man_n_48),
        .\t_counter4_inferred__0/i__carry__0_4 (config_man_n_47));
  adc_interface_0 adc2
       (.DI({adc2_n_29,adc2_n_30,adc2_n_31,adc2_n_32}),
        .D_2_IBUF(D_2_IBUF),
        .O({adc2_n_1,adc2_n_2,adc2_n_3}),
        .OTR_2_IBUF(OTR_2_IBUF),
        .Q({adc2_n_33,adc2_n_34,adc2_n_35,adc2_n_36,adc2_n_37,adc2_n_38,adc2_n_39,adc2_n_40,adc2_n_41,adc2_n_42,adc2_n_43,adc2_n_44,adc2_n_45,adc2_n_46,adc2_n_47,adc2_n_48}),
        .S(adc2_n_69),
        .SR(filter_rst),
        .adc_strb_1(adc_strb_1),
        .adc_strb_2(adc_strb_2),
        .\d_out_reg[10] ({adc2_n_49,adc2_n_50,adc2_n_51,adc2_n_52}),
        .\d_out_reg[12] ({adc2_n_4,adc2_n_5,adc2_n_6,adc2_n_7}),
        .\d_out_reg[12]_0 ({adc2_n_18,adc2_n_19,adc2_n_20,adc2_n_21}),
        .\d_out_reg[16] ({adc2_n_8,adc2_n_9,adc2_n_10,adc2_n_11}),
        .\d_out_reg[16]_0 ({adc2_n_22,adc2_n_23,adc2_n_24,adc2_n_25}),
        .\d_out_reg[16]_1 ({adc2_n_71,adc2_n_72,adc2_n_73}),
        .\d_out_reg[16]_2 ({adc2_n_74,adc2_n_75,adc2_n_76}),
        .\d_out_reg[19] ({adc2_n_12,adc2_n_13,adc2_n_14}),
        .\d_out_reg[19]_0 ({adc2_n_26,adc2_n_27,adc2_n_28}),
        .\d_out_reg[19]_1 (d_out_0),
        .\d_out_reg[4] ({adc2_n_15,adc2_n_16,adc2_n_17}),
        .\d_out_reg[4]_0 (adc2_n_70),
        .\dummy_counter_reg[0] (slave_fifo_n_47),
        .\dummy_counter_reg[9] (adc2_n_77),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .rst(rst),
        .rst_2d(rst_2d),
        .rst_3d(rst_3d),
        .rst_d(rst_d),
        .rst_internal(rst_internal),
        .strb_reg(adc2_n_78),
        .t_counter3_carry(config_man_n_17),
        .t_counter3_carry_0(config_man_n_7),
        .t_counter3_carry_1(config_man_n_19),
        .t_counter3_carry_2(config_man_n_18),
        .t_counter3_carry_3(config_man_n_21),
        .t_counter3_carry_4(config_man_n_20),
        .t_counter3_carry_5(config_man_n_22),
        .t_counter3_carry_6(trigger_level),
        .t_counter3_carry__0(config_man_n_44),
        .t_counter3_carry__0_0(config_man_n_43),
        .t_counter3_carry__0_1(config_man_n_46),
        .t_counter3_carry__0_2(config_man_n_45),
        .t_counter3_carry__0_3(config_man_n_48),
        .t_counter3_carry__0_4(config_man_n_47));
  IBUF clk_in_IBUF_inst
       (.I(clk_in),
        .O(clk_in_IBUF));
  (* BOX_TYPE = "PRIMITIVE" *) 
  BUFG clock_buf
       (.I(clk_in_IBUF),
        .O(clk_in_buf));
  hydrophone_config_manager config_man
       (.CO(t_counter40_in),
        .D(data0),
        .DI(config_man_n_23),
        .FUNC_EN_IBUF(FUNC_EN_IBUF),
        .O({adc1_n_17,adc1_n_18,adc1_n_19}),
        .Q(trigger_level),
        .S({config_man_n_4,config_man_n_5,config_man_n_6}),
        .\d_out_reg[19] ({config_man_n_8,config_man_n_9,config_man_n_10}),
        .\d_out_reg[19]_0 ({config_man_n_11,config_man_n_12,config_man_n_13}),
        .\d_out_reg[19]_1 ({config_man_n_14,config_man_n_15,config_man_n_16}),
        .\d_out_reg[19]_2 ({config_man_n_24,config_man_n_25,config_man_n_26,config_man_n_27}),
        .\d_out_reg[19]_3 (config_man_n_28),
        .\d_out_reg[19]_4 ({config_man_n_29,config_man_n_30,config_man_n_31,config_man_n_32}),
        .\d_out_reg[19]_5 (config_man_n_33),
        .\d_out_reg[19]_6 ({config_man_n_34,config_man_n_35,config_man_n_36,config_man_n_37}),
        .\d_out_reg[19]_7 (config_man_n_38),
        .\d_out_reg[19]_8 ({config_man_n_39,config_man_n_40,config_man_n_41,config_man_n_42}),
        .i__carry__0_i_8_0(d_out[19:6]),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .\poten1_value_reg[7]_0 ({poten0[7:5],poten0[3:0]}),
        .poten_update_start(poten_update_start),
        .\prefix_reg[15]_0 (rx_data),
        .rst(rst),
        .rx_empty(rx_empty),
        .rx_oe(rx_oe),
        .sub_state__0(sub_state__0),
        .t_counter0(t_counter0),
        .t_counter2_carry({adc2_n_15,adc2_n_16,adc2_n_17}),
        .t_counter2_carry__0({adc2_n_18,adc2_n_19,adc2_n_20,adc2_n_21}),
        .t_counter2_carry__0_0({adc2_n_26,adc2_n_27,adc2_n_28}),
        .t_counter2_carry__0_1({adc2_n_22,adc2_n_23,adc2_n_24,adc2_n_25}),
        .t_counter2_carry__0_i_8_0({adc2_n_33,adc2_n_34,adc2_n_35,adc2_n_36,adc2_n_37,adc2_n_38,adc2_n_39,adc2_n_40,adc2_n_41,adc2_n_42,adc2_n_43,adc2_n_44,adc2_n_45,adc2_n_46}),
        .t_counter3_carry({adc2_n_1,adc2_n_2,adc2_n_3}),
        .t_counter3_carry__0({adc2_n_4,adc2_n_5,adc2_n_6,adc2_n_7}),
        .t_counter3_carry__0_0({adc2_n_12,adc2_n_13,adc2_n_14}),
        .t_counter3_carry__0_1({adc2_n_8,adc2_n_9,adc2_n_10,adc2_n_11}),
        .t_counter3_carry__0_i_8_0(d_out_0[19:6]),
        .t_counter4_carry__0(out0),
        .t_counter4_carry__0_i_8_0({adc1_n_35,adc1_n_36,adc1_n_37,adc1_n_38,adc1_n_39,adc1_n_40,adc1_n_41,adc1_n_42,adc1_n_43,adc1_n_44,adc1_n_45,adc1_n_46,adc1_n_47,adc1_n_48}),
        .\t_counter4_inferred__0/i__carry__0 ({adc1_n_20,adc1_n_21,adc1_n_22,adc1_n_23}),
        .\t_counter4_inferred__0/i__carry__0_0 ({adc1_n_28,adc1_n_29,adc1_n_30}),
        .\t_counter4_inferred__0/i__carry__0_1 ({adc1_n_24,adc1_n_25,adc1_n_26,adc1_n_27}),
        .trigged_reg(t_counter3),
        .trigged_reg_0(t_counter4),
        .trigged_reg_1(t_counter2),
        .\trigger_level_reg[15]_0 (config_man_n_7),
        .\trigger_level_reg[15]_1 (config_man_n_17),
        .\trigger_level_reg[15]_10 (config_man_n_46),
        .\trigger_level_reg[15]_11 (config_man_n_47),
        .\trigger_level_reg[15]_12 (config_man_n_48),
        .\trigger_level_reg[15]_2 (config_man_n_18),
        .\trigger_level_reg[15]_3 (config_man_n_19),
        .\trigger_level_reg[15]_4 (config_man_n_20),
        .\trigger_level_reg[15]_5 (config_man_n_21),
        .\trigger_level_reg[15]_6 (config_man_n_22),
        .\trigger_level_reg[15]_7 (config_man_n_43),
        .\trigger_level_reg[15]_8 (config_man_n_44),
        .\trigger_level_reg[15]_9 (config_man_n_45));
  BUFG ifclk_out_OBUF_BUFG_inst
       (.I(ifclk_out_OBUF),
        .O(ifclk_out_OBUF_BUFG));
  OBUF ifclk_out_OBUF_inst
       (.I(ifclk_out_OBUF_BUFG),
        .O(ifclk_out));
  packetizer packetizer_inst
       (.D(trigged_out),
        .DI({pkt_end,packetize_out}),
        .\FSM_onehot_main_state_reg[0]_0 (trigger_n_73),
        .LED_BLUE_OBUF(LED_BLUE_OBUF),
        .LED_GREEN_3_OBUF(LED_GREEN_3_OBUF),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .in_strb_d(in_strb_d),
        .latched_input0(latched_input0),
        .rst(rst),
        .trigger_strobe(trigger_strobe));
  poten_interface poten_i2c
       (.D(data0),
        .\FSM_sequential_sub_state_reg[1]_0 (sub_state__0),
        .SCL_IBUF(SCL_IBUF),
        .SCL_TRI(SCL_TRI),
        .SDA_IBUF(SDA_IBUF),
        .SDA_TRI(SDA_TRI),
        .core_en(core_en),
        .dSDA_reg(reset_inst_n_2),
        .fSDA(\byte_controller/bit_controller/fSDA ),
        .\filter_cnt_reg[12] (poten_i2c_n_5),
        .\filter_cnt_reg[3] (reset_inst_n_4),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .poten_update_start(poten_update_start),
        .rst(rst),
        .sSDA(\byte_controller/bit_controller/sSDA ),
        .\txr_reg[7]_0 ({poten0[7:5],poten0[3:0]}));
  reset_subs reset_inst
       (.LED_GREEN_OBUF(LED_GREEN_OBUF),
        .RST_IBUF(RST_IBUF),
        .core_en(core_en),
        .core_en_reg(reset_inst_n_4),
        .\fSCL_reg[2] (poten_i2c_n_5),
        .fSDA(\byte_controller/bit_controller/fSDA ),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .pll_locked(pll_locked),
        .rst(rst),
        .sSDA(\byte_controller/bit_controller/sSDA ),
        .sSDA_reg(reset_inst_n_2));
  fx3s_interface slave_fifo
       (.A_OBUF(A_OBUF),
        .DI({pkt_end,packetize_out}),
        .DO(DQ_OBUF),
        .\DQ_TRI[0] (\DQ_TRI[0] ),
        .E(slave_fifo_n_45),
        .FLAGA_IBUF(FLAGA_IBUF),
        .FLAGB_IBUF(FLAGB_IBUF),
        .LED_BLUE_OBUF(LED_BLUE_OBUF),
        .LED_GREEN_3_OBUF(LED_GREEN_3_OBUF),
        .LED_RED_n_OBUF(LED_RED_n_OBUF),
        .PKTEND_OBUF(PKTEND_OBUF),
        .SLCS_OBUF(SLCS_OBUF),
        .SLOE_OBUF(SLOE_OBUF),
        .SLRD_OBUF(SLRD_OBUF),
        .SLWR_OBUF(SLWR_OBUF),
        .SR(filter_rst),
        .\d_out_reg[19] (adc1_n_0),
        .\dummy_counter_reg[0] (adc1_n_79),
        .\dummy_counter_reg[0]_0 (adc2_n_77),
        .fifo_rst_internal(fifo_rst_internal),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .\prefix_reg[15] (DQ_IBUF),
        .rst(rst),
        .rst_2d(rst_2d),
        .rst_3d(rst_3d),
        .rst_3d_reg_0(slave_fifo_n_46),
        .rst_3d_reg_1(slave_fifo_n_47),
        .rst_4d(rst_4d),
        .rst_6d(rst_6d),
        .rst_7d(rst_7d),
        .rst_9d_reg_0(rx_data),
        .rst_d(rst_d),
        .rst_internal(rst_internal),
        .rx_empty(rx_empty),
        .rx_oe(rx_oe));
  hydrophone_trigger trigger
       (.CO(t_counter40_in),
        .D(trigged_out),
        .DI({adc2_n_33,adc2_n_34,adc2_n_35,adc2_n_36,adc2_n_37,adc2_n_38,adc2_n_39,adc2_n_40,adc2_n_41,adc2_n_42,adc2_n_43,adc2_n_44,adc2_n_45,adc2_n_46,adc2_n_47,adc2_n_48,d_out_0,adc1_n_35,adc1_n_36,adc1_n_37,adc1_n_38,adc1_n_39,adc1_n_40,adc1_n_41,adc1_n_42,adc1_n_43,adc1_n_44,adc1_n_45,adc1_n_46,adc1_n_47,adc1_n_48,adc1_n_49,adc1_n_50,d_out}),
        .LED_GREEN_3_OBUF(LED_GREEN_3_OBUF),
        .S({config_man_n_4,config_man_n_5,config_man_n_6,adc1_n_71}),
        .\d_out_reg[19] (t_counter4),
        .\d_out_reg[19]_0 (t_counter3),
        .\d_out_reg[19]_1 (t_counter2),
        .fifo_rst_internal(fifo_rst_internal),
        .ifclk_out_OBUF_BUFG(ifclk_out_OBUF_BUFG),
        .in_strb_d(in_strb_d),
        .in_strb_d_reg(trigger_n_73),
        .latched_input0(latched_input0),
        .rst_3d(rst_3d),
        .rst_4d(rst_4d),
        .rst_6d(rst_6d),
        .rst_7d(rst_7d),
        .rst_internal(rst_internal),
        .strb_d_reg_0(adc2_n_78),
        .t_counter0(t_counter0),
        .t_counter2_carry__0_0({adc2_n_29,adc2_n_30,adc2_n_31,adc2_n_32}),
        .t_counter2_carry__0_1({config_man_n_11,config_man_n_12,config_man_n_13,adc2_n_69}),
        .t_counter3_carry__0_0({adc2_n_49,adc2_n_50,adc2_n_51,adc2_n_52}),
        .t_counter3_carry__0_1({config_man_n_14,config_man_n_15,config_man_n_16,adc2_n_70}),
        .t_counter4_carry__0_0({adc1_n_31,adc1_n_32,adc1_n_33,adc1_n_34}),
        .\t_counter4_inferred__0/i__carry__0_0 ({adc1_n_51,adc1_n_52,adc1_n_53,adc1_n_54}),
        .\t_counter4_inferred__0/i__carry__0_1 ({config_man_n_8,config_man_n_9,config_man_n_10,adc1_n_72}),
        .\t_counter[0]_i_4 ({config_man_n_23,adc1_n_73,adc1_n_74,adc1_n_75}),
        .\t_counter[0]_i_4_0 ({config_man_n_24,config_man_n_25,config_man_n_26,config_man_n_27}),
        .\t_counter[0]_i_4_1 ({config_man_n_28,adc2_n_74,adc2_n_75,adc2_n_76}),
        .\t_counter[0]_i_4_2 ({config_man_n_29,config_man_n_30,config_man_n_31,config_man_n_32}),
        .\t_counter[0]_i_4_3 ({config_man_n_33,adc2_n_71,adc2_n_72,adc2_n_73}),
        .\t_counter[0]_i_4_4 ({config_man_n_34,config_man_n_35,config_man_n_36,config_man_n_37}),
        .\t_counter[0]_i_4_5 ({config_man_n_38,adc1_n_76,adc1_n_77,adc1_n_78}),
        .\t_counter[0]_i_4_6 ({config_man_n_39,config_man_n_40,config_man_n_41,config_man_n_42}),
        .trigger_strobe(trigger_strobe));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
