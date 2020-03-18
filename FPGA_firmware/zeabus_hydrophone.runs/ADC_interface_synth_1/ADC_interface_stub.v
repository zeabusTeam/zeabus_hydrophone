// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2.1 (win64) Build 2729669 Thu Dec  5 04:49:17 MST 2019
// Date        : Sun Mar 15 22:04:46 2020
// Host        : DESKTOP-MDIICNE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.runs/ADC_interface_synth_1/ADC_interface_stub.v
// Design      : ADC_interface
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a15tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ADC_interface(data_in_from_pins, data_in_to_device, clk_in, 
  io_reset)
/* synthesis syn_black_box black_box_pad_pin="data_in_from_pins[14:0],data_in_to_device[29:0],clk_in,io_reset" */;
  input [14:0]data_in_from_pins;
  output [29:0]data_in_to_device;
  input clk_in;
  input io_reset;
endmodule
