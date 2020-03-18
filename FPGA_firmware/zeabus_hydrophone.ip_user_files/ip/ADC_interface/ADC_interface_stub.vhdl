-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2.1 (win64) Build 2729669 Thu Dec  5 04:49:17 MST 2019
-- Date        : Sun Mar 15 22:04:46 2020
-- Host        : DESKTOP-MDIICNE running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.runs/ADC_interface_synth_1/ADC_interface_stub.vhdl
-- Design      : ADC_interface
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a15tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC_interface is
  Port ( 
    data_in_from_pins : in STD_LOGIC_VECTOR ( 14 downto 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 29 downto 0 );
    clk_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );

end ADC_interface;

architecture stub of ADC_interface is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "data_in_from_pins[14:0],data_in_to_device[29:0],clk_in,io_reset";
begin
end;
