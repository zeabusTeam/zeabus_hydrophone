-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 32-bit"
-- VERSION "Version 12.1 Build 177 11/07/2012 SJ Web Edition"

-- DATE "04/12/2013 13:48:19"

-- 
-- Device: Altera EP3C25F324C6 Package FBGA324
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	slaveFIFO2b_ZLP IS
    PORT (
	reset_in_n : IN std_logic;
	clk : IN std_logic;
	clk_out : OUT std_logic;
	slcs : OUT std_logic;
	fdata : INOUT std_logic_vector(31 DOWNTO 0);
	faddr : OUT std_logic_vector(1 DOWNTO 0);
	slrd : OUT std_logic;
	sloe : OUT std_logic;
	slwr : OUT std_logic;
	flaga : IN std_logic;
	flagb : IN std_logic;
	flagc : IN std_logic;
	flagd : IN std_logic;
	pktend : OUT std_logic;
	PMODE : OUT std_logic_vector(1 DOWNTO 0);
	RESET : OUT std_logic
	);
END slaveFIFO2b_ZLP;

-- Design Ports Information
-- reset_in_n	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_out	=>  Location: PIN_U18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slcs	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- faddr[0]	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- faddr[1]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slrd	=>  Location: PIN_M14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sloe	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slwr	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flagc	=>  Location: PIN_H18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flagd	=>  Location: PIN_H17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- pktend	=>  Location: PIN_R4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PMODE[0]	=>  Location: PIN_G17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- PMODE[1]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- RESET	=>  Location: PIN_R2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[0]	=>  Location: PIN_T16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[1]	=>  Location: PIN_N16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[2]	=>  Location: PIN_H16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[3]	=>  Location: PIN_R16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[4]	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[5]	=>  Location: PIN_T2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[6]	=>  Location: PIN_G18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[7]	=>  Location: PIN_P1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[8]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[9]	=>  Location: PIN_N7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[10]	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[11]	=>  Location: PIN_K17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[12]	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[13]	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[14]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[15]	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[16]	=>  Location: PIN_L5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[17]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[18]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[19]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[20]	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[21]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[22]	=>  Location: PIN_K2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[23]	=>  Location: PIN_K1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[24]	=>  Location: PIN_H15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[25]	=>  Location: PIN_N15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[26]	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[27]	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[28]	=>  Location: PIN_R3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[29]	=>  Location: PIN_H2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[30]	=>  Location: PIN_T3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- fdata[31]	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_B9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flagb	=>  Location: PIN_R5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flaga	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF slaveFIFO2b_ZLP IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_reset_in_n : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_clk_out : std_logic;
SIGNAL ww_slcs : std_logic;
SIGNAL ww_faddr : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_slrd : std_logic;
SIGNAL ww_sloe : std_logic;
SIGNAL ww_slwr : std_logic;
SIGNAL ww_flaga : std_logic;
SIGNAL ww_flagb : std_logic;
SIGNAL ww_flagc : std_logic;
SIGNAL ww_flagd : std_logic;
SIGNAL ww_pktend : std_logic;
SIGNAL ww_PMODE : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_RESET : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|pll1_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \data_gen_zlp[1]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[3]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[5]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[6]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[11]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[13]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[15]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[19]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[21]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[22]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[27]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[29]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[31]~_Duplicate_1_q\ : std_logic;
SIGNAL \strob~q\ : std_logic;
SIGNAL \strob~0_combout\ : std_logic;
SIGNAL \strob_cnt~6_combout\ : std_logic;
SIGNAL \current_zlp_state.zlp_write_wr_delay~q\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \next_zlp_state.zlp_write_wr_delay~0_combout\ : std_logic;
SIGNAL \reset_in_n~input_o\ : std_logic;
SIGNAL \flagc~input_o\ : std_logic;
SIGNAL \flagd~input_o\ : std_logic;
SIGNAL \fdata[0]~input_o\ : std_logic;
SIGNAL \fdata[1]~input_o\ : std_logic;
SIGNAL \fdata[2]~input_o\ : std_logic;
SIGNAL \fdata[3]~input_o\ : std_logic;
SIGNAL \fdata[4]~input_o\ : std_logic;
SIGNAL \fdata[5]~input_o\ : std_logic;
SIGNAL \fdata[6]~input_o\ : std_logic;
SIGNAL \fdata[7]~input_o\ : std_logic;
SIGNAL \fdata[8]~input_o\ : std_logic;
SIGNAL \fdata[9]~input_o\ : std_logic;
SIGNAL \fdata[10]~input_o\ : std_logic;
SIGNAL \fdata[11]~input_o\ : std_logic;
SIGNAL \fdata[12]~input_o\ : std_logic;
SIGNAL \fdata[13]~input_o\ : std_logic;
SIGNAL \fdata[14]~input_o\ : std_logic;
SIGNAL \fdata[15]~input_o\ : std_logic;
SIGNAL \fdata[16]~input_o\ : std_logic;
SIGNAL \fdata[17]~input_o\ : std_logic;
SIGNAL \fdata[18]~input_o\ : std_logic;
SIGNAL \fdata[19]~input_o\ : std_logic;
SIGNAL \fdata[20]~input_o\ : std_logic;
SIGNAL \fdata[21]~input_o\ : std_logic;
SIGNAL \fdata[22]~input_o\ : std_logic;
SIGNAL \fdata[23]~input_o\ : std_logic;
SIGNAL \fdata[24]~input_o\ : std_logic;
SIGNAL \fdata[25]~input_o\ : std_logic;
SIGNAL \fdata[26]~input_o\ : std_logic;
SIGNAL \fdata[27]~input_o\ : std_logic;
SIGNAL \fdata[28]~input_o\ : std_logic;
SIGNAL \fdata[29]~input_o\ : std_logic;
SIGNAL \fdata[30]~input_o\ : std_logic;
SIGNAL \fdata[31]~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_fbout\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \data_gen_zlp[0]~93_combout\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_locked\ : std_logic;
SIGNAL \flaga~input_o\ : std_logic;
SIGNAL \flaga_d~q\ : std_logic;
SIGNAL \flagb~input_o\ : std_logic;
SIGNAL \flagb_d~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \current_zlp_state.zlp_wait_flagb~q\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \current_zlp_state.zlp_write~q\ : std_logic;
SIGNAL \slwr_zlp_n_d~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[0]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[1]~31_combout\ : std_logic;
SIGNAL \data_gen_zlp[2]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[1]~32\ : std_logic;
SIGNAL \data_gen_zlp[2]~33_combout\ : std_logic;
SIGNAL \data_gen_zlp[2]~34\ : std_logic;
SIGNAL \data_gen_zlp[3]~35_combout\ : std_logic;
SIGNAL \data_gen_zlp[4]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[3]~36\ : std_logic;
SIGNAL \data_gen_zlp[4]~37_combout\ : std_logic;
SIGNAL \data_gen_zlp[4]~38\ : std_logic;
SIGNAL \data_gen_zlp[5]~39_combout\ : std_logic;
SIGNAL \data_gen_zlp[5]~40\ : std_logic;
SIGNAL \data_gen_zlp[6]~41_combout\ : std_logic;
SIGNAL \data_gen_zlp[7]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[6]~42\ : std_logic;
SIGNAL \data_gen_zlp[7]~43_combout\ : std_logic;
SIGNAL \data_gen_zlp[8]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[7]~44\ : std_logic;
SIGNAL \data_gen_zlp[8]~45_combout\ : std_logic;
SIGNAL \data_gen_zlp[9]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[8]~46\ : std_logic;
SIGNAL \data_gen_zlp[9]~47_combout\ : std_logic;
SIGNAL \data_gen_zlp[10]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[9]~48\ : std_logic;
SIGNAL \data_gen_zlp[10]~49_combout\ : std_logic;
SIGNAL \data_gen_zlp[10]~50\ : std_logic;
SIGNAL \data_gen_zlp[11]~51_combout\ : std_logic;
SIGNAL \data_gen_zlp[12]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[11]~52\ : std_logic;
SIGNAL \data_gen_zlp[12]~53_combout\ : std_logic;
SIGNAL \data_gen_zlp[12]~54\ : std_logic;
SIGNAL \data_gen_zlp[13]~55_combout\ : std_logic;
SIGNAL \data_gen_zlp[14]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[13]~56\ : std_logic;
SIGNAL \data_gen_zlp[14]~57_combout\ : std_logic;
SIGNAL \data_gen_zlp[14]~58\ : std_logic;
SIGNAL \data_gen_zlp[15]~59_combout\ : std_logic;
SIGNAL \data_gen_zlp[16]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[15]~60\ : std_logic;
SIGNAL \data_gen_zlp[16]~61_combout\ : std_logic;
SIGNAL \data_gen_zlp[17]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[16]~62\ : std_logic;
SIGNAL \data_gen_zlp[17]~63_combout\ : std_logic;
SIGNAL \data_gen_zlp[18]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[17]~64\ : std_logic;
SIGNAL \data_gen_zlp[18]~65_combout\ : std_logic;
SIGNAL \data_gen_zlp[18]~66\ : std_logic;
SIGNAL \data_gen_zlp[19]~67_combout\ : std_logic;
SIGNAL \data_gen_zlp[20]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[19]~68\ : std_logic;
SIGNAL \data_gen_zlp[20]~69_combout\ : std_logic;
SIGNAL \data_gen_zlp[20]~70\ : std_logic;
SIGNAL \data_gen_zlp[21]~71_combout\ : std_logic;
SIGNAL \data_gen_zlp[21]~72\ : std_logic;
SIGNAL \data_gen_zlp[22]~73_combout\ : std_logic;
SIGNAL \data_gen_zlp[23]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[22]~74\ : std_logic;
SIGNAL \data_gen_zlp[23]~75_combout\ : std_logic;
SIGNAL \data_gen_zlp[24]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[23]~76\ : std_logic;
SIGNAL \data_gen_zlp[24]~77_combout\ : std_logic;
SIGNAL \data_gen_zlp[25]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[24]~78\ : std_logic;
SIGNAL \data_gen_zlp[25]~79_combout\ : std_logic;
SIGNAL \data_gen_zlp[26]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[25]~80\ : std_logic;
SIGNAL \data_gen_zlp[26]~81_combout\ : std_logic;
SIGNAL \data_gen_zlp[26]~82\ : std_logic;
SIGNAL \data_gen_zlp[27]~83_combout\ : std_logic;
SIGNAL \data_gen_zlp[28]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[27]~84\ : std_logic;
SIGNAL \data_gen_zlp[28]~85_combout\ : std_logic;
SIGNAL \data_gen_zlp[28]~86\ : std_logic;
SIGNAL \data_gen_zlp[29]~87_combout\ : std_logic;
SIGNAL \data_gen_zlp[30]~_Duplicate_1_q\ : std_logic;
SIGNAL \data_gen_zlp[29]~88\ : std_logic;
SIGNAL \data_gen_zlp[30]~89_combout\ : std_logic;
SIGNAL \data_gen_zlp[30]~90\ : std_logic;
SIGNAL \data_gen_zlp[31]~91_combout\ : std_logic;
SIGNAL \slwr_zlp_n_d~q\ : std_logic;
SIGNAL \strob_cnt~4_combout\ : std_logic;
SIGNAL \Selector3~1_combout\ : std_logic;
SIGNAL \current_zlp_state.zlp_wait~q\ : std_logic;
SIGNAL \strob_cnt[3]~3_combout\ : std_logic;
SIGNAL \process_4~0_combout\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \current_zlp_state.zlp_idle~q\ : std_logic;
SIGNAL \strob_cnt~2_combout\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \strob_cnt~5_combout\ : std_logic;
SIGNAL \process_5~0_combout\ : std_logic;
SIGNAL \process_5~1_combout\ : std_logic;
SIGNAL \pktend_zlp_n_d~q\ : std_logic;
SIGNAL strob_cnt : std_logic_vector(3 DOWNTO 0);
SIGNAL data_gen_zlp : std_logic_vector(31 DOWNTO 0);
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ddr_inst|ALTDDIO_OUT_component|auto_generated|dataout\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \ALT_INV_data_gen_zlp[0]~_Duplicate_1_q\ : std_logic;
SIGNAL \ALT_INV_process_5~1_combout\ : std_logic;
SIGNAL \ALT_INV_current_zlp_state.zlp_write~q\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|ALT_INV_wire_pll1_locked\ : std_logic;

BEGIN

ww_reset_in_n <= reset_in_n;
ww_clk <= clk;
clk_out <= ww_clk_out;
slcs <= ww_slcs;
faddr <= ww_faddr;
slrd <= ww_slrd;
sloe <= ww_sloe;
slwr <= ww_slwr;
ww_flaga <= flaga;
ww_flagb <= flagb;
ww_flagc <= flagc;
ww_flagd <= flagd;
pktend <= ww_pktend;
PMODE <= ww_PMODE;
RESET <= ww_RESET;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\pll_inst|altpll_component|auto_generated|pll1_INCLK_bus\ <= (gnd & \clk~input_o\);

\pll_inst|altpll_component|auto_generated|wire_pll1_clk\(0) <= \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\(0);
\pll_inst|altpll_component|auto_generated|wire_pll1_clk\(1) <= \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\(1);
\pll_inst|altpll_component|auto_generated|wire_pll1_clk\(2) <= \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\(2);
\pll_inst|altpll_component|auto_generated|wire_pll1_clk\(3) <= \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\(3);
\pll_inst|altpll_component|auto_generated|wire_pll1_clk\(4) <= \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\(4);

\pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \pll_inst|altpll_component|auto_generated|wire_pll1_clk\(0));
\ALT_INV_data_gen_zlp[0]~_Duplicate_1_q\ <= NOT \data_gen_zlp[0]~_Duplicate_1_q\;
\ALT_INV_process_5~1_combout\ <= NOT \process_5~1_combout\;
\ALT_INV_current_zlp_state.zlp_write~q\ <= NOT \current_zlp_state.zlp_write~q\;
\pll_inst|altpll_component|auto_generated|ALT_INV_wire_pll1_locked\ <= NOT \pll_inst|altpll_component|auto_generated|wire_pll1_locked\;

-- Location: FF_X1_Y12_N3
\data_gen_zlp[1]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[1]~31_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[1]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N7
\data_gen_zlp[3]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[3]~35_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[3]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N11
\data_gen_zlp[5]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[5]~39_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[5]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N13
\data_gen_zlp[6]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[6]~41_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[6]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N23
\data_gen_zlp[11]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[11]~51_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[11]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N27
\data_gen_zlp[13]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[13]~55_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[13]~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N31
\data_gen_zlp[15]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[15]~59_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[15]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N7
\data_gen_zlp[19]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[19]~67_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[19]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N11
\data_gen_zlp[21]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[21]~71_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[21]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N13
\data_gen_zlp[22]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[22]~73_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[22]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N23
\data_gen_zlp[27]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[27]~83_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[27]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N27
\data_gen_zlp[29]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[29]~87_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[29]~_Duplicate_1_q\);

-- Location: FF_X1_Y11_N31
\data_gen_zlp[31]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[31]~91_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[31]~_Duplicate_1_q\);

-- Location: FF_X1_Y4_N27
strob : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \strob~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \strob~q\);

-- Location: FF_X1_Y4_N11
\strob_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \strob_cnt~6_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \strob_cnt[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => strob_cnt(2));

-- Location: LCCOMB_X1_Y4_N26
\strob~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob~0_combout\ = \strob~q\ $ (((!strob_cnt(3) & \process_4~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => strob_cnt(3),
	datac => \strob~q\,
	datad => \process_4~0_combout\,
	combout => \strob~0_combout\);

-- Location: LCCOMB_X1_Y4_N10
\strob_cnt~6\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob_cnt~6_combout\ = (\current_zlp_state.zlp_idle~q\ & (strob_cnt(2) $ (((strob_cnt(0) & strob_cnt(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => strob_cnt(0),
	datab => strob_cnt(1),
	datac => strob_cnt(2),
	datad => \current_zlp_state.zlp_idle~q\,
	combout => \strob_cnt~6_combout\);

-- Location: FF_X1_Y4_N13
\current_zlp_state.zlp_write_wr_delay\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \next_zlp_state.zlp_write_wr_delay~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_zlp_state.zlp_write_wr_delay~q\);

-- Location: LCCOMB_X1_Y4_N6
\Selector3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (\current_zlp_state.zlp_write_wr_delay~q\) # ((\current_zlp_state.zlp_wait_flagb~q\ & (\strob~q\ & \flagb_d~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_zlp_state.zlp_write_wr_delay~q\,
	datab => \current_zlp_state.zlp_wait_flagb~q\,
	datac => \strob~q\,
	datad => \flagb_d~q\,
	combout => \Selector3~0_combout\);

-- Location: LCCOMB_X1_Y4_N12
\next_zlp_state.zlp_write_wr_delay~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \next_zlp_state.zlp_write_wr_delay~0_combout\ = (!\flagb_d~q\ & \current_zlp_state.zlp_write~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \flagb_d~q\,
	datad => \current_zlp_state.zlp_write~q\,
	combout => \next_zlp_state.zlp_write_wr_delay~0_combout\);

-- Location: IOOBUF_X49_Y0_N9
\clk_out~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ddr_inst|ALTDDIO_OUT_component|auto_generated|dataout\(0),
	devoe => ww_devoe,
	o => ww_clk_out);

-- Location: IOOBUF_X53_Y8_N9
\slcs~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_slcs);

-- Location: IOOBUF_X0_Y7_N2
\faddr[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_faddr(0));

-- Location: IOOBUF_X0_Y12_N2
\faddr[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => ww_faddr(1));

-- Location: IOOBUF_X53_Y10_N23
\slrd~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_slrd);

-- Location: IOOBUF_X53_Y22_N9
\sloe~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_sloe);

-- Location: IOOBUF_X51_Y0_N16
\slwr~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \slwr_zlp_n_d~q\,
	devoe => ww_devoe,
	o => ww_slwr);

-- Location: IOOBUF_X0_Y4_N23
\pktend~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \pktend_zlp_n_d~q\,
	devoe => ww_devoe,
	o => ww_pktend);

-- Location: IOOBUF_X53_Y20_N16
\PMODE[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_PMODE(0));

-- Location: IOOBUF_X0_Y13_N23
\PMODE[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_PMODE(1));

-- Location: IOOBUF_X0_Y8_N23
\RESET~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => ww_RESET);

-- Location: IOOBUF_X53_Y6_N23
\fdata[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(0),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(0));

-- Location: IOOBUF_X53_Y9_N9
\fdata[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(1),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(1));

-- Location: IOOBUF_X53_Y22_N2
\fdata[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(2),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(2));

-- Location: IOOBUF_X53_Y6_N16
\fdata[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(3),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(3));

-- Location: IOOBUF_X51_Y0_N2
\fdata[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(4),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(4));

-- Location: IOOBUF_X0_Y7_N9
\fdata[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(5),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(5));

-- Location: IOOBUF_X53_Y20_N23
\fdata[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(6),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(6));

-- Location: IOOBUF_X0_Y8_N16
\fdata[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(7),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(7));

-- Location: IOOBUF_X0_Y29_N2
\fdata[8]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(8),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(8));

-- Location: IOOBUF_X5_Y0_N2
\fdata[9]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(9),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(9));

-- Location: IOOBUF_X0_Y11_N9
\fdata[10]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(10),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(10));

-- Location: IOOBUF_X53_Y16_N9
\fdata[11]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(11),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(11));

-- Location: IOOBUF_X0_Y24_N23
\fdata[12]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(12),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(12));

-- Location: IOOBUF_X40_Y0_N2
\fdata[13]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(13),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(13));

-- Location: IOOBUF_X0_Y13_N16
\fdata[14]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(14),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(14));

-- Location: IOOBUF_X40_Y0_N9
\fdata[15]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(15),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(15));

-- Location: IOOBUF_X0_Y14_N9
\fdata[16]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(16),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(16));

-- Location: IOOBUF_X53_Y21_N23
\fdata[17]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(17),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(17));

-- Location: IOOBUF_X0_Y30_N9
\fdata[18]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(18),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(18));

-- Location: IOOBUF_X7_Y0_N9
\fdata[19]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(19),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(19));

-- Location: IOOBUF_X36_Y0_N23
\fdata[20]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(20),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(20));

-- Location: IOOBUF_X0_Y30_N2
\fdata[21]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(21),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(21));

-- Location: IOOBUF_X0_Y15_N2
\fdata[22]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(22),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(22));

-- Location: IOOBUF_X0_Y15_N9
\fdata[23]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(23),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(23));

-- Location: IOOBUF_X53_Y24_N23
\fdata[24]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(24),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(24));

-- Location: IOOBUF_X53_Y5_N23
\fdata[25]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(25),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(25));

-- Location: IOOBUF_X0_Y11_N2
\fdata[26]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(26),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(26));

-- Location: IOOBUF_X0_Y14_N2
\fdata[27]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(27),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(27));

-- Location: IOOBUF_X0_Y5_N16
\fdata[28]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(28),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(28));

-- Location: IOOBUF_X0_Y23_N16
\fdata[29]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(29),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(29));

-- Location: IOOBUF_X0_Y6_N23
\fdata[30]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(30),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(30));

-- Location: IOOBUF_X0_Y29_N9
\fdata[31]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => data_gen_zlp(31),
	oe => \slwr_zlp_n_d~_Duplicate_1_q\,
	devoe => ww_devoe,
	o => fdata(31));

-- Location: IOIBUF_X25_Y34_N22
\clk~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: PLL_3
\pll_inst|altpll_component|auto_generated|pll1\ : cycloneiii_pll
-- pragma translate_off
GENERIC MAP (
	auto_settings => "false",
	bandwidth_type => "medium",
	c0_high => 3,
	c0_initial => 1,
	c0_low => 3,
	c0_mode => "even",
	c0_ph => 0,
	c1_high => 0,
	c1_initial => 0,
	c1_low => 0,
	c1_mode => "bypass",
	c1_ph => 0,
	c1_use_casc_in => "off",
	c2_high => 0,
	c2_initial => 0,
	c2_low => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	c2_use_casc_in => "off",
	c3_high => 0,
	c3_initial => 0,
	c3_low => 0,
	c3_mode => "bypass",
	c3_ph => 0,
	c3_use_casc_in => "off",
	c4_high => 0,
	c4_initial => 0,
	c4_low => 0,
	c4_mode => "bypass",
	c4_ph => 0,
	c4_use_casc_in => "off",
	charge_pump_current_bits => 1,
	clk0_counter => "c0",
	clk0_divide_by => 1,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 2,
	clk0_phase_shift => "0",
	clk1_counter => "unused",
	clk1_divide_by => 0,
	clk1_duty_cycle => 50,
	clk1_multiply_by => 0,
	clk1_phase_shift => "0",
	clk2_counter => "unused",
	clk2_divide_by => 0,
	clk2_duty_cycle => 50,
	clk2_multiply_by => 0,
	clk2_phase_shift => "0",
	clk3_counter => "unused",
	clk3_divide_by => 0,
	clk3_duty_cycle => 50,
	clk3_multiply_by => 0,
	clk3_phase_shift => "0",
	clk4_counter => "unused",
	clk4_divide_by => 0,
	clk4_duty_cycle => 50,
	clk4_multiply_by => 0,
	clk4_phase_shift => "0",
	compensate_clock => "clock0",
	inclk0_input_frequency => 20000,
	inclk1_input_frequency => 0,
	loop_filter_c_bits => 0,
	loop_filter_r_bits => 27,
	m => 12,
	m_initial => 1,
	m_ph => 0,
	n => 1,
	operation_mode => "normal",
	pfd_max => 200000,
	pfd_min => 3076,
	pll_compensation_delay => 5702,
	self_reset_on_loss_lock => "off",
	simulation_type => "timing",
	switch_over_type => "auto",
	vco_center => 1538,
	vco_divide_by => 0,
	vco_frequency_control => "auto",
	vco_max => 3333,
	vco_min => 1538,
	vco_multiply_by => 0,
	vco_phase_shift_step => 208,
	vco_post_scale => 2)
-- pragma translate_on
PORT MAP (
	areset => GND,
	fbin => \pll_inst|altpll_component|auto_generated|wire_pll1_fbout\,
	inclk => \pll_inst|altpll_component|auto_generated|pll1_INCLK_bus\,
	locked => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	fbout => \pll_inst|altpll_component|auto_generated|wire_pll1_fbout\,
	clk => \pll_inst|altpll_component|auto_generated|pll1_CLK_bus\);

-- Location: CLKCTRL_G13
\pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl\ : cycloneiii_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\);

-- Location: LCCOMB_X1_Y12_N0
\data_gen_zlp[0]~93\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[0]~93_combout\ = !\data_gen_zlp[0]~_Duplicate_1_q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \data_gen_zlp[0]~_Duplicate_1_q\,
	combout => \data_gen_zlp[0]~93_combout\);

-- Location: IOIBUF_X0_Y23_N22
\flaga~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_flaga,
	o => \flaga~input_o\);

-- Location: FF_X0_Y23_N24
flaga_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \flaga~input_o\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \flaga_d~q\);

-- Location: IOIBUF_X0_Y4_N15
\flagb~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_flagb,
	o => \flagb~input_o\);

-- Location: FF_X0_Y4_N17
flagb_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \flagb~input_o\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \flagb_d~q\);

-- Location: LCCOMB_X1_Y4_N16
\Selector1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\current_zlp_state.zlp_idle~q\ & (((\current_zlp_state.zlp_wait_flagb~q\ & !\flagb_d~q\)))) # (!\current_zlp_state.zlp_idle~q\ & ((\flaga_d~q\) # ((\current_zlp_state.zlp_wait_flagb~q\ & !\flagb_d~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_zlp_state.zlp_idle~q\,
	datab => \flaga_d~q\,
	datac => \current_zlp_state.zlp_wait_flagb~q\,
	datad => \flagb_d~q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X1_Y4_N17
\current_zlp_state.zlp_wait_flagb\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector1~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_zlp_state.zlp_wait_flagb~q\);

-- Location: LCCOMB_X1_Y4_N0
\Selector2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (\flagb_d~q\ & ((\current_zlp_state.zlp_write~q\) # ((!\strob~q\ & \current_zlp_state.zlp_wait_flagb~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \strob~q\,
	datab => \current_zlp_state.zlp_wait_flagb~q\,
	datac => \current_zlp_state.zlp_write~q\,
	datad => \flagb_d~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X1_Y4_N1
\current_zlp_state.zlp_write\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector2~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_zlp_state.zlp_write~q\);

-- Location: FF_X44_Y3_N17
\slwr_zlp_n_d~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	asdata => \current_zlp_state.zlp_write~q\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \slwr_zlp_n_d~_Duplicate_1_q\);

-- Location: FF_X1_Y12_N1
\data_gen_zlp[0]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[0]~93_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[0]~_Duplicate_1_q\);

-- Location: DDIOOUTCELL_X53_Y6_N25
\data_gen_zlp[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \ALT_INV_data_gen_zlp[0]~_Duplicate_1_q\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(0));

-- Location: LCCOMB_X1_Y12_N2
\data_gen_zlp[1]~31\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[1]~31_combout\ = (\data_gen_zlp[1]~_Duplicate_1_q\ & (\data_gen_zlp[0]~_Duplicate_1_q\ $ (VCC))) # (!\data_gen_zlp[1]~_Duplicate_1_q\ & (\data_gen_zlp[0]~_Duplicate_1_q\ & VCC))
-- \data_gen_zlp[1]~32\ = CARRY((\data_gen_zlp[1]~_Duplicate_1_q\ & \data_gen_zlp[0]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[1]~_Duplicate_1_q\,
	datab => \data_gen_zlp[0]~_Duplicate_1_q\,
	datad => VCC,
	combout => \data_gen_zlp[1]~31_combout\,
	cout => \data_gen_zlp[1]~32\);

-- Location: DDIOOUTCELL_X53_Y9_N11
\data_gen_zlp[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[1]~31_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(1));

-- Location: FF_X1_Y12_N5
\data_gen_zlp[2]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[2]~33_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[2]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N4
\data_gen_zlp[2]~33\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[2]~33_combout\ = (\data_gen_zlp[2]~_Duplicate_1_q\ & (!\data_gen_zlp[1]~32\)) # (!\data_gen_zlp[2]~_Duplicate_1_q\ & ((\data_gen_zlp[1]~32\) # (GND)))
-- \data_gen_zlp[2]~34\ = CARRY((!\data_gen_zlp[1]~32\) # (!\data_gen_zlp[2]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[2]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[1]~32\,
	combout => \data_gen_zlp[2]~33_combout\,
	cout => \data_gen_zlp[2]~34\);

-- Location: DDIOOUTCELL_X53_Y22_N4
\data_gen_zlp[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[2]~33_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(2));

-- Location: LCCOMB_X1_Y12_N6
\data_gen_zlp[3]~35\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[3]~35_combout\ = (\data_gen_zlp[3]~_Duplicate_1_q\ & (\data_gen_zlp[2]~34\ $ (GND))) # (!\data_gen_zlp[3]~_Duplicate_1_q\ & (!\data_gen_zlp[2]~34\ & VCC))
-- \data_gen_zlp[3]~36\ = CARRY((\data_gen_zlp[3]~_Duplicate_1_q\ & !\data_gen_zlp[2]~34\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[3]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[2]~34\,
	combout => \data_gen_zlp[3]~35_combout\,
	cout => \data_gen_zlp[3]~36\);

-- Location: DDIOOUTCELL_X53_Y6_N18
\data_gen_zlp[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[3]~35_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(3));

-- Location: FF_X1_Y12_N9
\data_gen_zlp[4]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[4]~37_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[4]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N8
\data_gen_zlp[4]~37\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[4]~37_combout\ = (\data_gen_zlp[4]~_Duplicate_1_q\ & (!\data_gen_zlp[3]~36\)) # (!\data_gen_zlp[4]~_Duplicate_1_q\ & ((\data_gen_zlp[3]~36\) # (GND)))
-- \data_gen_zlp[4]~38\ = CARRY((!\data_gen_zlp[3]~36\) # (!\data_gen_zlp[4]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[4]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[3]~36\,
	combout => \data_gen_zlp[4]~37_combout\,
	cout => \data_gen_zlp[4]~38\);

-- Location: DDIOOUTCELL_X51_Y0_N4
\data_gen_zlp[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[4]~37_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(4));

-- Location: LCCOMB_X1_Y12_N10
\data_gen_zlp[5]~39\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[5]~39_combout\ = (\data_gen_zlp[5]~_Duplicate_1_q\ & (\data_gen_zlp[4]~38\ $ (GND))) # (!\data_gen_zlp[5]~_Duplicate_1_q\ & (!\data_gen_zlp[4]~38\ & VCC))
-- \data_gen_zlp[5]~40\ = CARRY((\data_gen_zlp[5]~_Duplicate_1_q\ & !\data_gen_zlp[4]~38\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[5]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[4]~38\,
	combout => \data_gen_zlp[5]~39_combout\,
	cout => \data_gen_zlp[5]~40\);

-- Location: DDIOOUTCELL_X0_Y7_N11
\data_gen_zlp[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[5]~39_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(5));

-- Location: LCCOMB_X1_Y12_N12
\data_gen_zlp[6]~41\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[6]~41_combout\ = (\data_gen_zlp[6]~_Duplicate_1_q\ & (!\data_gen_zlp[5]~40\)) # (!\data_gen_zlp[6]~_Duplicate_1_q\ & ((\data_gen_zlp[5]~40\) # (GND)))
-- \data_gen_zlp[6]~42\ = CARRY((!\data_gen_zlp[5]~40\) # (!\data_gen_zlp[6]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[6]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[5]~40\,
	combout => \data_gen_zlp[6]~41_combout\,
	cout => \data_gen_zlp[6]~42\);

-- Location: DDIOOUTCELL_X53_Y20_N25
\data_gen_zlp[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[6]~41_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(6));

-- Location: FF_X1_Y12_N15
\data_gen_zlp[7]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[7]~43_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[7]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N14
\data_gen_zlp[7]~43\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[7]~43_combout\ = (\data_gen_zlp[7]~_Duplicate_1_q\ & (\data_gen_zlp[6]~42\ $ (GND))) # (!\data_gen_zlp[7]~_Duplicate_1_q\ & (!\data_gen_zlp[6]~42\ & VCC))
-- \data_gen_zlp[7]~44\ = CARRY((\data_gen_zlp[7]~_Duplicate_1_q\ & !\data_gen_zlp[6]~42\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[7]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[6]~42\,
	combout => \data_gen_zlp[7]~43_combout\,
	cout => \data_gen_zlp[7]~44\);

-- Location: DDIOOUTCELL_X0_Y8_N18
\data_gen_zlp[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[7]~43_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(7));

-- Location: FF_X1_Y12_N17
\data_gen_zlp[8]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[8]~45_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[8]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N16
\data_gen_zlp[8]~45\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[8]~45_combout\ = (\data_gen_zlp[8]~_Duplicate_1_q\ & (!\data_gen_zlp[7]~44\)) # (!\data_gen_zlp[8]~_Duplicate_1_q\ & ((\data_gen_zlp[7]~44\) # (GND)))
-- \data_gen_zlp[8]~46\ = CARRY((!\data_gen_zlp[7]~44\) # (!\data_gen_zlp[8]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[8]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[7]~44\,
	combout => \data_gen_zlp[8]~45_combout\,
	cout => \data_gen_zlp[8]~46\);

-- Location: DDIOOUTCELL_X0_Y29_N4
\data_gen_zlp[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[8]~45_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(8));

-- Location: FF_X1_Y12_N19
\data_gen_zlp[9]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[9]~47_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[9]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N18
\data_gen_zlp[9]~47\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[9]~47_combout\ = (\data_gen_zlp[9]~_Duplicate_1_q\ & (\data_gen_zlp[8]~46\ $ (GND))) # (!\data_gen_zlp[9]~_Duplicate_1_q\ & (!\data_gen_zlp[8]~46\ & VCC))
-- \data_gen_zlp[9]~48\ = CARRY((\data_gen_zlp[9]~_Duplicate_1_q\ & !\data_gen_zlp[8]~46\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[9]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[8]~46\,
	combout => \data_gen_zlp[9]~47_combout\,
	cout => \data_gen_zlp[9]~48\);

-- Location: DDIOOUTCELL_X5_Y0_N4
\data_gen_zlp[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[9]~47_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(9));

-- Location: FF_X1_Y12_N21
\data_gen_zlp[10]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[10]~49_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[10]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N20
\data_gen_zlp[10]~49\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[10]~49_combout\ = (\data_gen_zlp[10]~_Duplicate_1_q\ & (!\data_gen_zlp[9]~48\)) # (!\data_gen_zlp[10]~_Duplicate_1_q\ & ((\data_gen_zlp[9]~48\) # (GND)))
-- \data_gen_zlp[10]~50\ = CARRY((!\data_gen_zlp[9]~48\) # (!\data_gen_zlp[10]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[10]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[9]~48\,
	combout => \data_gen_zlp[10]~49_combout\,
	cout => \data_gen_zlp[10]~50\);

-- Location: DDIOOUTCELL_X0_Y11_N11
\data_gen_zlp[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[10]~49_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(10));

-- Location: LCCOMB_X1_Y12_N22
\data_gen_zlp[11]~51\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[11]~51_combout\ = (\data_gen_zlp[11]~_Duplicate_1_q\ & (\data_gen_zlp[10]~50\ $ (GND))) # (!\data_gen_zlp[11]~_Duplicate_1_q\ & (!\data_gen_zlp[10]~50\ & VCC))
-- \data_gen_zlp[11]~52\ = CARRY((\data_gen_zlp[11]~_Duplicate_1_q\ & !\data_gen_zlp[10]~50\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[11]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[10]~50\,
	combout => \data_gen_zlp[11]~51_combout\,
	cout => \data_gen_zlp[11]~52\);

-- Location: DDIOOUTCELL_X53_Y16_N11
\data_gen_zlp[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[11]~51_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(11));

-- Location: FF_X1_Y12_N25
\data_gen_zlp[12]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[12]~53_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[12]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N24
\data_gen_zlp[12]~53\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[12]~53_combout\ = (\data_gen_zlp[12]~_Duplicate_1_q\ & (!\data_gen_zlp[11]~52\)) # (!\data_gen_zlp[12]~_Duplicate_1_q\ & ((\data_gen_zlp[11]~52\) # (GND)))
-- \data_gen_zlp[12]~54\ = CARRY((!\data_gen_zlp[11]~52\) # (!\data_gen_zlp[12]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[12]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[11]~52\,
	combout => \data_gen_zlp[12]~53_combout\,
	cout => \data_gen_zlp[12]~54\);

-- Location: DDIOOUTCELL_X0_Y24_N25
\data_gen_zlp[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[12]~53_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(12));

-- Location: LCCOMB_X1_Y12_N26
\data_gen_zlp[13]~55\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[13]~55_combout\ = (\data_gen_zlp[13]~_Duplicate_1_q\ & (\data_gen_zlp[12]~54\ $ (GND))) # (!\data_gen_zlp[13]~_Duplicate_1_q\ & (!\data_gen_zlp[12]~54\ & VCC))
-- \data_gen_zlp[13]~56\ = CARRY((\data_gen_zlp[13]~_Duplicate_1_q\ & !\data_gen_zlp[12]~54\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[13]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[12]~54\,
	combout => \data_gen_zlp[13]~55_combout\,
	cout => \data_gen_zlp[13]~56\);

-- Location: DDIOOUTCELL_X40_Y0_N4
\data_gen_zlp[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[13]~55_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(13));

-- Location: FF_X1_Y12_N29
\data_gen_zlp[14]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[14]~57_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[14]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y12_N28
\data_gen_zlp[14]~57\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[14]~57_combout\ = (\data_gen_zlp[14]~_Duplicate_1_q\ & (!\data_gen_zlp[13]~56\)) # (!\data_gen_zlp[14]~_Duplicate_1_q\ & ((\data_gen_zlp[13]~56\) # (GND)))
-- \data_gen_zlp[14]~58\ = CARRY((!\data_gen_zlp[13]~56\) # (!\data_gen_zlp[14]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[14]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[13]~56\,
	combout => \data_gen_zlp[14]~57_combout\,
	cout => \data_gen_zlp[14]~58\);

-- Location: DDIOOUTCELL_X0_Y13_N18
\data_gen_zlp[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[14]~57_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(14));

-- Location: LCCOMB_X1_Y12_N30
\data_gen_zlp[15]~59\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[15]~59_combout\ = (\data_gen_zlp[15]~_Duplicate_1_q\ & (\data_gen_zlp[14]~58\ $ (GND))) # (!\data_gen_zlp[15]~_Duplicate_1_q\ & (!\data_gen_zlp[14]~58\ & VCC))
-- \data_gen_zlp[15]~60\ = CARRY((\data_gen_zlp[15]~_Duplicate_1_q\ & !\data_gen_zlp[14]~58\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[15]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[14]~58\,
	combout => \data_gen_zlp[15]~59_combout\,
	cout => \data_gen_zlp[15]~60\);

-- Location: DDIOOUTCELL_X40_Y0_N11
\data_gen_zlp[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[15]~59_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(15));

-- Location: FF_X1_Y11_N1
\data_gen_zlp[16]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[16]~61_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[16]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N0
\data_gen_zlp[16]~61\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[16]~61_combout\ = (\data_gen_zlp[16]~_Duplicate_1_q\ & (!\data_gen_zlp[15]~60\)) # (!\data_gen_zlp[16]~_Duplicate_1_q\ & ((\data_gen_zlp[15]~60\) # (GND)))
-- \data_gen_zlp[16]~62\ = CARRY((!\data_gen_zlp[15]~60\) # (!\data_gen_zlp[16]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[16]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[15]~60\,
	combout => \data_gen_zlp[16]~61_combout\,
	cout => \data_gen_zlp[16]~62\);

-- Location: DDIOOUTCELL_X0_Y14_N11
\data_gen_zlp[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[16]~61_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(16));

-- Location: FF_X1_Y11_N3
\data_gen_zlp[17]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[17]~63_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[17]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N2
\data_gen_zlp[17]~63\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[17]~63_combout\ = (\data_gen_zlp[17]~_Duplicate_1_q\ & (\data_gen_zlp[16]~62\ $ (GND))) # (!\data_gen_zlp[17]~_Duplicate_1_q\ & (!\data_gen_zlp[16]~62\ & VCC))
-- \data_gen_zlp[17]~64\ = CARRY((\data_gen_zlp[17]~_Duplicate_1_q\ & !\data_gen_zlp[16]~62\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[17]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[16]~62\,
	combout => \data_gen_zlp[17]~63_combout\,
	cout => \data_gen_zlp[17]~64\);

-- Location: DDIOOUTCELL_X53_Y21_N25
\data_gen_zlp[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[17]~63_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(17));

-- Location: FF_X1_Y11_N5
\data_gen_zlp[18]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[18]~65_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[18]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N4
\data_gen_zlp[18]~65\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[18]~65_combout\ = (\data_gen_zlp[18]~_Duplicate_1_q\ & (!\data_gen_zlp[17]~64\)) # (!\data_gen_zlp[18]~_Duplicate_1_q\ & ((\data_gen_zlp[17]~64\) # (GND)))
-- \data_gen_zlp[18]~66\ = CARRY((!\data_gen_zlp[17]~64\) # (!\data_gen_zlp[18]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[18]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[17]~64\,
	combout => \data_gen_zlp[18]~65_combout\,
	cout => \data_gen_zlp[18]~66\);

-- Location: DDIOOUTCELL_X0_Y30_N11
\data_gen_zlp[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[18]~65_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(18));

-- Location: LCCOMB_X1_Y11_N6
\data_gen_zlp[19]~67\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[19]~67_combout\ = (\data_gen_zlp[19]~_Duplicate_1_q\ & (\data_gen_zlp[18]~66\ $ (GND))) # (!\data_gen_zlp[19]~_Duplicate_1_q\ & (!\data_gen_zlp[18]~66\ & VCC))
-- \data_gen_zlp[19]~68\ = CARRY((\data_gen_zlp[19]~_Duplicate_1_q\ & !\data_gen_zlp[18]~66\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[19]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[18]~66\,
	combout => \data_gen_zlp[19]~67_combout\,
	cout => \data_gen_zlp[19]~68\);

-- Location: DDIOOUTCELL_X7_Y0_N11
\data_gen_zlp[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[19]~67_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(19));

-- Location: FF_X1_Y11_N9
\data_gen_zlp[20]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[20]~69_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[20]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N8
\data_gen_zlp[20]~69\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[20]~69_combout\ = (\data_gen_zlp[20]~_Duplicate_1_q\ & (!\data_gen_zlp[19]~68\)) # (!\data_gen_zlp[20]~_Duplicate_1_q\ & ((\data_gen_zlp[19]~68\) # (GND)))
-- \data_gen_zlp[20]~70\ = CARRY((!\data_gen_zlp[19]~68\) # (!\data_gen_zlp[20]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[20]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[19]~68\,
	combout => \data_gen_zlp[20]~69_combout\,
	cout => \data_gen_zlp[20]~70\);

-- Location: DDIOOUTCELL_X36_Y0_N25
\data_gen_zlp[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[20]~69_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(20));

-- Location: LCCOMB_X1_Y11_N10
\data_gen_zlp[21]~71\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[21]~71_combout\ = (\data_gen_zlp[21]~_Duplicate_1_q\ & (\data_gen_zlp[20]~70\ $ (GND))) # (!\data_gen_zlp[21]~_Duplicate_1_q\ & (!\data_gen_zlp[20]~70\ & VCC))
-- \data_gen_zlp[21]~72\ = CARRY((\data_gen_zlp[21]~_Duplicate_1_q\ & !\data_gen_zlp[20]~70\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[21]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[20]~70\,
	combout => \data_gen_zlp[21]~71_combout\,
	cout => \data_gen_zlp[21]~72\);

-- Location: DDIOOUTCELL_X0_Y30_N4
\data_gen_zlp[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[21]~71_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(21));

-- Location: LCCOMB_X1_Y11_N12
\data_gen_zlp[22]~73\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[22]~73_combout\ = (\data_gen_zlp[22]~_Duplicate_1_q\ & (!\data_gen_zlp[21]~72\)) # (!\data_gen_zlp[22]~_Duplicate_1_q\ & ((\data_gen_zlp[21]~72\) # (GND)))
-- \data_gen_zlp[22]~74\ = CARRY((!\data_gen_zlp[21]~72\) # (!\data_gen_zlp[22]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[22]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[21]~72\,
	combout => \data_gen_zlp[22]~73_combout\,
	cout => \data_gen_zlp[22]~74\);

-- Location: DDIOOUTCELL_X0_Y15_N4
\data_gen_zlp[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[22]~73_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(22));

-- Location: FF_X1_Y11_N15
\data_gen_zlp[23]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[23]~75_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[23]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N14
\data_gen_zlp[23]~75\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[23]~75_combout\ = (\data_gen_zlp[23]~_Duplicate_1_q\ & (\data_gen_zlp[22]~74\ $ (GND))) # (!\data_gen_zlp[23]~_Duplicate_1_q\ & (!\data_gen_zlp[22]~74\ & VCC))
-- \data_gen_zlp[23]~76\ = CARRY((\data_gen_zlp[23]~_Duplicate_1_q\ & !\data_gen_zlp[22]~74\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[23]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[22]~74\,
	combout => \data_gen_zlp[23]~75_combout\,
	cout => \data_gen_zlp[23]~76\);

-- Location: DDIOOUTCELL_X0_Y15_N11
\data_gen_zlp[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[23]~75_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(23));

-- Location: FF_X1_Y11_N17
\data_gen_zlp[24]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[24]~77_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[24]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N16
\data_gen_zlp[24]~77\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[24]~77_combout\ = (\data_gen_zlp[24]~_Duplicate_1_q\ & (!\data_gen_zlp[23]~76\)) # (!\data_gen_zlp[24]~_Duplicate_1_q\ & ((\data_gen_zlp[23]~76\) # (GND)))
-- \data_gen_zlp[24]~78\ = CARRY((!\data_gen_zlp[23]~76\) # (!\data_gen_zlp[24]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[24]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[23]~76\,
	combout => \data_gen_zlp[24]~77_combout\,
	cout => \data_gen_zlp[24]~78\);

-- Location: DDIOOUTCELL_X53_Y24_N25
\data_gen_zlp[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[24]~77_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(24));

-- Location: FF_X1_Y11_N19
\data_gen_zlp[25]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[25]~79_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[25]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N18
\data_gen_zlp[25]~79\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[25]~79_combout\ = (\data_gen_zlp[25]~_Duplicate_1_q\ & (\data_gen_zlp[24]~78\ $ (GND))) # (!\data_gen_zlp[25]~_Duplicate_1_q\ & (!\data_gen_zlp[24]~78\ & VCC))
-- \data_gen_zlp[25]~80\ = CARRY((\data_gen_zlp[25]~_Duplicate_1_q\ & !\data_gen_zlp[24]~78\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[25]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[24]~78\,
	combout => \data_gen_zlp[25]~79_combout\,
	cout => \data_gen_zlp[25]~80\);

-- Location: DDIOOUTCELL_X53_Y5_N25
\data_gen_zlp[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[25]~79_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(25));

-- Location: FF_X1_Y11_N21
\data_gen_zlp[26]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[26]~81_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[26]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N20
\data_gen_zlp[26]~81\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[26]~81_combout\ = (\data_gen_zlp[26]~_Duplicate_1_q\ & (!\data_gen_zlp[25]~80\)) # (!\data_gen_zlp[26]~_Duplicate_1_q\ & ((\data_gen_zlp[25]~80\) # (GND)))
-- \data_gen_zlp[26]~82\ = CARRY((!\data_gen_zlp[25]~80\) # (!\data_gen_zlp[26]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[26]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[25]~80\,
	combout => \data_gen_zlp[26]~81_combout\,
	cout => \data_gen_zlp[26]~82\);

-- Location: DDIOOUTCELL_X0_Y11_N4
\data_gen_zlp[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[26]~81_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(26));

-- Location: LCCOMB_X1_Y11_N22
\data_gen_zlp[27]~83\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[27]~83_combout\ = (\data_gen_zlp[27]~_Duplicate_1_q\ & (\data_gen_zlp[26]~82\ $ (GND))) # (!\data_gen_zlp[27]~_Duplicate_1_q\ & (!\data_gen_zlp[26]~82\ & VCC))
-- \data_gen_zlp[27]~84\ = CARRY((\data_gen_zlp[27]~_Duplicate_1_q\ & !\data_gen_zlp[26]~82\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[27]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[26]~82\,
	combout => \data_gen_zlp[27]~83_combout\,
	cout => \data_gen_zlp[27]~84\);

-- Location: DDIOOUTCELL_X0_Y14_N4
\data_gen_zlp[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[27]~83_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(27));

-- Location: FF_X1_Y11_N25
\data_gen_zlp[28]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[28]~85_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[28]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N24
\data_gen_zlp[28]~85\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[28]~85_combout\ = (\data_gen_zlp[28]~_Duplicate_1_q\ & (!\data_gen_zlp[27]~84\)) # (!\data_gen_zlp[28]~_Duplicate_1_q\ & ((\data_gen_zlp[27]~84\) # (GND)))
-- \data_gen_zlp[28]~86\ = CARRY((!\data_gen_zlp[27]~84\) # (!\data_gen_zlp[28]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[28]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[27]~84\,
	combout => \data_gen_zlp[28]~85_combout\,
	cout => \data_gen_zlp[28]~86\);

-- Location: DDIOOUTCELL_X0_Y5_N18
\data_gen_zlp[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[28]~85_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(28));

-- Location: LCCOMB_X1_Y11_N26
\data_gen_zlp[29]~87\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[29]~87_combout\ = (\data_gen_zlp[29]~_Duplicate_1_q\ & (\data_gen_zlp[28]~86\ $ (GND))) # (!\data_gen_zlp[29]~_Duplicate_1_q\ & (!\data_gen_zlp[28]~86\ & VCC))
-- \data_gen_zlp[29]~88\ = CARRY((\data_gen_zlp[29]~_Duplicate_1_q\ & !\data_gen_zlp[28]~86\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[29]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[28]~86\,
	combout => \data_gen_zlp[29]~87_combout\,
	cout => \data_gen_zlp[29]~88\);

-- Location: DDIOOUTCELL_X0_Y23_N18
\data_gen_zlp[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[29]~87_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(29));

-- Location: FF_X1_Y11_N29
\data_gen_zlp[30]~_Duplicate_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[30]~89_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \data_gen_zlp[30]~_Duplicate_1_q\);

-- Location: LCCOMB_X1_Y11_N28
\data_gen_zlp[30]~89\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[30]~89_combout\ = (\data_gen_zlp[30]~_Duplicate_1_q\ & (!\data_gen_zlp[29]~88\)) # (!\data_gen_zlp[30]~_Duplicate_1_q\ & ((\data_gen_zlp[29]~88\) # (GND)))
-- \data_gen_zlp[30]~90\ = CARRY((!\data_gen_zlp[29]~88\) # (!\data_gen_zlp[30]~_Duplicate_1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \data_gen_zlp[30]~_Duplicate_1_q\,
	datad => VCC,
	cin => \data_gen_zlp[29]~88\,
	combout => \data_gen_zlp[30]~89_combout\,
	cout => \data_gen_zlp[30]~90\);

-- Location: DDIOOUTCELL_X0_Y6_N25
\data_gen_zlp[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[30]~89_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(30));

-- Location: LCCOMB_X1_Y11_N30
\data_gen_zlp[31]~91\ : cycloneiii_lcell_comb
-- Equation(s):
-- \data_gen_zlp[31]~91_combout\ = \data_gen_zlp[31]~_Duplicate_1_q\ $ (!\data_gen_zlp[30]~90\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \data_gen_zlp[31]~_Duplicate_1_q\,
	cin => \data_gen_zlp[30]~90\,
	combout => \data_gen_zlp[31]~91_combout\);

-- Location: DDIOOUTCELL_X0_Y29_N11
\data_gen_zlp[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \data_gen_zlp[31]~91_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \slwr_zlp_n_d~_Duplicate_1_q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => data_gen_zlp(31));

-- Location: DDIOOUTCELL_X49_Y0_N11
\ddr_inst|ALTDDIO_OUT_component|auto_generated|ddio_outa[0]\ : cycloneiii_ddio_out
-- pragma translate_off
GENERIC MAP (
	async_mode => "none",
	power_up => "low",
	sync_mode => "none",
	use_new_clocking_model => "true")
-- pragma translate_on
PORT MAP (
	datainlo => VCC,
	datainhi => GND,
	clkhi => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	clklo => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	muxsel => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	dataout => \ddr_inst|ALTDDIO_OUT_component|auto_generated|dataout\(0));

-- Location: DDIOOUTCELL_X51_Y0_N18
slwr_zlp_n_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "high")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \ALT_INV_current_zlp_state.zlp_write~q\,
	asdata => VCC,
	aload => \pll_inst|altpll_component|auto_generated|ALT_INV_wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \slwr_zlp_n_d~q\);

-- Location: LCCOMB_X1_Y4_N22
\strob_cnt~4\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob_cnt~4_combout\ = (\current_zlp_state.zlp_idle~q\ & !strob_cnt(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_zlp_state.zlp_idle~q\,
	datac => strob_cnt(0),
	combout => \strob_cnt~4_combout\);

-- Location: LCCOMB_X1_Y4_N2
\Selector3~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector3~1_combout\ = (\Selector3~0_combout\) # ((\current_zlp_state.zlp_wait~q\ & ((!strob_cnt(3)) # (!\Add0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector3~0_combout\,
	datab => \Add0~0_combout\,
	datac => \current_zlp_state.zlp_wait~q\,
	datad => strob_cnt(3),
	combout => \Selector3~1_combout\);

-- Location: FF_X1_Y4_N3
\current_zlp_state.zlp_wait\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector3~1_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_zlp_state.zlp_wait~q\);

-- Location: LCCOMB_X1_Y4_N8
\strob_cnt[3]~3\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob_cnt[3]~3_combout\ = \current_zlp_state.zlp_idle~q\ $ (!\current_zlp_state.zlp_wait~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \current_zlp_state.zlp_idle~q\,
	datad => \current_zlp_state.zlp_wait~q\,
	combout => \strob_cnt[3]~3_combout\);

-- Location: FF_X1_Y4_N23
\strob_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \strob_cnt~4_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \strob_cnt[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => strob_cnt(0));

-- Location: LCCOMB_X1_Y4_N28
\process_4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_4~0_combout\ = (strob_cnt(2) & (strob_cnt(1) & (strob_cnt(0) & \current_zlp_state.zlp_wait~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => strob_cnt(2),
	datab => strob_cnt(1),
	datac => strob_cnt(0),
	datad => \current_zlp_state.zlp_wait~q\,
	combout => \process_4~0_combout\);

-- Location: LCCOMB_X1_Y4_N30
\Selector0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (\flaga_d~q\ & (((!\process_4~0_combout\)) # (!strob_cnt(3)))) # (!\flaga_d~q\ & (\current_zlp_state.zlp_idle~q\ & ((!\process_4~0_combout\) # (!strob_cnt(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \flaga_d~q\,
	datab => strob_cnt(3),
	datac => \current_zlp_state.zlp_idle~q\,
	datad => \process_4~0_combout\,
	combout => \Selector0~0_combout\);

-- Location: FF_X1_Y4_N31
\current_zlp_state.zlp_idle\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector0~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_zlp_state.zlp_idle~q\);

-- Location: LCCOMB_X1_Y4_N20
\strob_cnt~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob_cnt~2_combout\ = (\current_zlp_state.zlp_idle~q\ & (strob_cnt(0) $ (strob_cnt(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => strob_cnt(0),
	datac => strob_cnt(1),
	datad => \current_zlp_state.zlp_idle~q\,
	combout => \strob_cnt~2_combout\);

-- Location: FF_X1_Y4_N21
\strob_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \strob_cnt~2_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \strob_cnt[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => strob_cnt(1));

-- Location: LCCOMB_X1_Y4_N18
\Add0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = (strob_cnt(2) & (strob_cnt(1) & strob_cnt(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => strob_cnt(2),
	datab => strob_cnt(1),
	datac => strob_cnt(0),
	combout => \Add0~0_combout\);

-- Location: LCCOMB_X1_Y4_N24
\strob_cnt~5\ : cycloneiii_lcell_comb
-- Equation(s):
-- \strob_cnt~5_combout\ = (\current_zlp_state.zlp_idle~q\ & (\Add0~0_combout\ $ (strob_cnt(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010100000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_zlp_state.zlp_idle~q\,
	datab => \Add0~0_combout\,
	datac => strob_cnt(3),
	combout => \strob_cnt~5_combout\);

-- Location: FF_X1_Y4_N25
\strob_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \strob_cnt~5_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	ena => \strob_cnt[3]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => strob_cnt(3));

-- Location: LCCOMB_X1_Y4_N4
\process_5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_5~0_combout\ = (!strob_cnt(2) & (!strob_cnt(3) & (strob_cnt(0) & strob_cnt(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => strob_cnt(2),
	datab => strob_cnt(3),
	datac => strob_cnt(0),
	datad => strob_cnt(1),
	combout => \process_5~0_combout\);

-- Location: LCCOMB_X1_Y4_N14
\process_5~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_5~1_combout\ = (\strob~q\ & \process_5~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \strob~q\,
	datac => \process_5~0_combout\,
	combout => \process_5~1_combout\);

-- Location: DDIOOUTCELL_X0_Y4_N25
pktend_zlp_n_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "high")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \ALT_INV_process_5~1_combout\,
	asdata => VCC,
	aload => \pll_inst|altpll_component|auto_generated|ALT_INV_wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \pktend_zlp_n_d~q\);

-- Location: IOIBUF_X0_Y16_N15
\reset_in_n~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset_in_n,
	o => \reset_in_n~input_o\);

-- Location: IOIBUF_X53_Y19_N8
\flagc~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_flagc,
	o => \flagc~input_o\);

-- Location: IOIBUF_X53_Y19_N1
\flagd~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_flagd,
	o => \flagd~input_o\);

-- Location: IOIBUF_X53_Y6_N22
\fdata[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(0),
	o => \fdata[0]~input_o\);

-- Location: IOIBUF_X53_Y9_N8
\fdata[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(1),
	o => \fdata[1]~input_o\);

-- Location: IOIBUF_X53_Y22_N1
\fdata[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(2),
	o => \fdata[2]~input_o\);

-- Location: IOIBUF_X53_Y6_N15
\fdata[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(3),
	o => \fdata[3]~input_o\);

-- Location: IOIBUF_X51_Y0_N1
\fdata[4]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(4),
	o => \fdata[4]~input_o\);

-- Location: IOIBUF_X0_Y7_N8
\fdata[5]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(5),
	o => \fdata[5]~input_o\);

-- Location: IOIBUF_X53_Y20_N22
\fdata[6]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(6),
	o => \fdata[6]~input_o\);

-- Location: IOIBUF_X0_Y8_N15
\fdata[7]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(7),
	o => \fdata[7]~input_o\);

-- Location: IOIBUF_X0_Y29_N1
\fdata[8]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(8),
	o => \fdata[8]~input_o\);

-- Location: IOIBUF_X5_Y0_N1
\fdata[9]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(9),
	o => \fdata[9]~input_o\);

-- Location: IOIBUF_X0_Y11_N8
\fdata[10]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(10),
	o => \fdata[10]~input_o\);

-- Location: IOIBUF_X53_Y16_N8
\fdata[11]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(11),
	o => \fdata[11]~input_o\);

-- Location: IOIBUF_X0_Y24_N22
\fdata[12]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(12),
	o => \fdata[12]~input_o\);

-- Location: IOIBUF_X40_Y0_N1
\fdata[13]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(13),
	o => \fdata[13]~input_o\);

-- Location: IOIBUF_X0_Y13_N15
\fdata[14]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(14),
	o => \fdata[14]~input_o\);

-- Location: IOIBUF_X40_Y0_N8
\fdata[15]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(15),
	o => \fdata[15]~input_o\);

-- Location: IOIBUF_X0_Y14_N8
\fdata[16]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(16),
	o => \fdata[16]~input_o\);

-- Location: IOIBUF_X53_Y21_N22
\fdata[17]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(17),
	o => \fdata[17]~input_o\);

-- Location: IOIBUF_X0_Y30_N8
\fdata[18]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(18),
	o => \fdata[18]~input_o\);

-- Location: IOIBUF_X7_Y0_N8
\fdata[19]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(19),
	o => \fdata[19]~input_o\);

-- Location: IOIBUF_X36_Y0_N22
\fdata[20]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(20),
	o => \fdata[20]~input_o\);

-- Location: IOIBUF_X0_Y30_N1
\fdata[21]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(21),
	o => \fdata[21]~input_o\);

-- Location: IOIBUF_X0_Y15_N1
\fdata[22]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(22),
	o => \fdata[22]~input_o\);

-- Location: IOIBUF_X0_Y15_N8
\fdata[23]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(23),
	o => \fdata[23]~input_o\);

-- Location: IOIBUF_X53_Y24_N22
\fdata[24]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(24),
	o => \fdata[24]~input_o\);

-- Location: IOIBUF_X53_Y5_N22
\fdata[25]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(25),
	o => \fdata[25]~input_o\);

-- Location: IOIBUF_X0_Y11_N1
\fdata[26]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(26),
	o => \fdata[26]~input_o\);

-- Location: IOIBUF_X0_Y14_N1
\fdata[27]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(27),
	o => \fdata[27]~input_o\);

-- Location: IOIBUF_X0_Y5_N15
\fdata[28]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(28),
	o => \fdata[28]~input_o\);

-- Location: IOIBUF_X0_Y23_N15
\fdata[29]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(29),
	o => \fdata[29]~input_o\);

-- Location: IOIBUF_X0_Y6_N22
\fdata[30]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(30),
	o => \fdata[30]~input_o\);

-- Location: IOIBUF_X0_Y29_N8
\fdata[31]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => fdata(31),
	o => \fdata[31]~input_o\);
END structure;


