-- Copyright (C) 1991-2013 Altera Corporation
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
-- VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"

-- DATE "10/27/2014 16:03:15"

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

ENTITY 	slaveFIFO2b_streamOUT IS
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
END slaveFIFO2b_streamOUT;

-- Design Ports Information
-- reset_in_n	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_out	=>  Location: PIN_U18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slcs	=>  Location: PIN_R17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- faddr[0]	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- faddr[1]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slrd	=>  Location: PIN_M14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sloe	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- slwr	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flaga	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flagb	=>  Location: PIN_R5,	 I/O Standard: 2.5 V,	 Current Strength: Default
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
-- flagd	=>  Location: PIN_H17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- flagc	=>  Location: PIN_H18,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF slaveFIFO2b_streamOUT IS
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
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_flagc_rcvd~q\ : std_logic;
SIGNAL \oe_delay_cnt[1]~0_combout\ : std_logic;
SIGNAL \oe_delay_cnt[0]~1_combout\ : std_logic;
SIGNAL \flagc_d~q\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_idle~q\ : std_logic;
SIGNAL \next_stream_out_state.stream_out_flagc_rcvd~0_combout\ : std_logic;
SIGNAL \Selector0~1_combout\ : std_logic;
SIGNAL \reset_in_n~input_o\ : std_logic;
SIGNAL \flaga~input_o\ : std_logic;
SIGNAL \flagb~input_o\ : std_logic;
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
SIGNAL \flagc~input_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_fbout\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \flagd~input_o\ : std_logic;
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_locked\ : std_logic;
SIGNAL \flagd_d~q\ : std_logic;
SIGNAL \Selector1~0_combout\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_wait_flagd~q\ : std_logic;
SIGNAL \next_stream_out_state.stream_out_read~0_combout\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_read~q\ : std_logic;
SIGNAL \rd_oe_delay_cnt[0]~0_combout\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\ : std_logic;
SIGNAL \process_0~2_combout\ : std_logic;
SIGNAL \Selector3~0_combout\ : std_logic;
SIGNAL \current_stream_out_state.stream_out_read_oe_delay~q\ : std_logic;
SIGNAL \process_1~1_combout\ : std_logic;
SIGNAL rd_oe_delay_cnt : std_logic_vector(1 DOWNTO 0);
SIGNAL oe_delay_cnt : std_logic_vector(1 DOWNTO 0);
SIGNAL \pll_inst|altpll_component|auto_generated|wire_pll1_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ddr_inst|ALTDDIO_OUT_component|auto_generated|dataout\ : std_logic_vector(0 DOWNTO 0);
SIGNAL \ALT_INV_process_1~1_combout\ : std_logic;
SIGNAL \ALT_INV_process_0~2_combout\ : std_logic;

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
\ALT_INV_process_1~1_combout\ <= NOT \process_1~1_combout\;
\ALT_INV_process_0~2_combout\ <= NOT \process_0~2_combout\;

-- Location: FF_X52_Y19_N15
\oe_delay_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \oe_delay_cnt[1]~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => oe_delay_cnt(1));

-- Location: FF_X52_Y19_N1
\oe_delay_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \oe_delay_cnt[0]~1_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => oe_delay_cnt(0));

-- Location: LCCOMB_X52_Y19_N10
\Selector0~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = (!oe_delay_cnt(1) & !oe_delay_cnt(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => oe_delay_cnt(1),
	datad => oe_delay_cnt(0),
	combout => \Selector0~0_combout\);

-- Location: FF_X52_Y19_N13
\current_stream_out_state.stream_out_flagc_rcvd\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \next_stream_out_state.stream_out_flagc_rcvd~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_stream_out_state.stream_out_flagc_rcvd~q\);

-- Location: LCCOMB_X52_Y19_N14
\oe_delay_cnt[1]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \oe_delay_cnt[1]~0_combout\ = (\current_stream_out_state.stream_out_read_oe_delay~q\ & ((oe_delay_cnt(0) & ((oe_delay_cnt(1)))) # (!oe_delay_cnt(0) & (\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)))) # 
-- (!\current_stream_out_state.stream_out_read_oe_delay~q\ & ((\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\) # ((oe_delay_cnt(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_read_oe_delay~q\,
	datab => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	datac => oe_delay_cnt(1),
	datad => oe_delay_cnt(0),
	combout => \oe_delay_cnt[1]~0_combout\);

-- Location: LCCOMB_X52_Y19_N0
\oe_delay_cnt[0]~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \oe_delay_cnt[0]~1_combout\ = (oe_delay_cnt(0) & (\current_stream_out_state.stream_out_read_oe_delay~q\ $ (((!\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\))))) # (!oe_delay_cnt(0) & (\current_stream_out_state.stream_out_read_oe_delay~q\ & 
-- (oe_delay_cnt(1) & !\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000001011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_read_oe_delay~q\,
	datab => oe_delay_cnt(1),
	datac => oe_delay_cnt(0),
	datad => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	combout => \oe_delay_cnt[0]~1_combout\);

-- Location: FF_X53_Y19_N10
flagc_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \flagc~input_o\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \flagc_d~q\);

-- Location: FF_X52_Y19_N7
\current_stream_out_state.stream_out_idle\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector0~1_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_stream_out_state.stream_out_idle~q\);

-- Location: LCCOMB_X52_Y19_N12
\next_stream_out_state.stream_out_flagc_rcvd~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \next_stream_out_state.stream_out_flagc_rcvd~0_combout\ = (!\current_stream_out_state.stream_out_idle~q\ & \flagc_d~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_idle~q\,
	datad => \flagc_d~q\,
	combout => \next_stream_out_state.stream_out_flagc_rcvd~0_combout\);

-- Location: LCCOMB_X52_Y19_N6
\Selector0~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector0~1_combout\ = (\current_stream_out_state.stream_out_read_oe_delay~q\ & (!\Selector0~0_combout\ & ((\current_stream_out_state.stream_out_idle~q\) # (\flagc_d~q\)))) # (!\current_stream_out_state.stream_out_read_oe_delay~q\ & 
-- (((\current_stream_out_state.stream_out_idle~q\) # (\flagc_d~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011101110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_read_oe_delay~q\,
	datab => \Selector0~0_combout\,
	datac => \current_stream_out_state.stream_out_idle~q\,
	datad => \flagc_d~q\,
	combout => \Selector0~1_combout\);

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
	i => VCC,
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
	i => VCC,
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
	i => \ALT_INV_process_0~2_combout\,
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
	i => \ALT_INV_process_1~1_combout\,
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
	i => VCC,
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
	i => VCC,
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
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(0));

-- Location: IOOBUF_X53_Y9_N9
\fdata[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(1));

-- Location: IOOBUF_X53_Y22_N2
\fdata[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(2));

-- Location: IOOBUF_X53_Y6_N16
\fdata[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(3));

-- Location: IOOBUF_X51_Y0_N2
\fdata[4]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(4));

-- Location: IOOBUF_X0_Y7_N9
\fdata[5]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(5));

-- Location: IOOBUF_X53_Y20_N23
\fdata[6]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(6));

-- Location: IOOBUF_X0_Y8_N16
\fdata[7]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(7));

-- Location: IOOBUF_X0_Y29_N2
\fdata[8]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(8));

-- Location: IOOBUF_X5_Y0_N2
\fdata[9]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(9));

-- Location: IOOBUF_X0_Y11_N9
\fdata[10]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(10));

-- Location: IOOBUF_X53_Y16_N9
\fdata[11]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(11));

-- Location: IOOBUF_X0_Y24_N23
\fdata[12]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(12));

-- Location: IOOBUF_X40_Y0_N2
\fdata[13]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(13));

-- Location: IOOBUF_X0_Y13_N16
\fdata[14]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(14));

-- Location: IOOBUF_X40_Y0_N9
\fdata[15]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(15));

-- Location: IOOBUF_X0_Y14_N9
\fdata[16]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(16));

-- Location: IOOBUF_X53_Y21_N23
\fdata[17]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(17));

-- Location: IOOBUF_X0_Y30_N9
\fdata[18]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(18));

-- Location: IOOBUF_X7_Y0_N9
\fdata[19]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(19));

-- Location: IOOBUF_X36_Y0_N23
\fdata[20]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(20));

-- Location: IOOBUF_X0_Y30_N2
\fdata[21]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(21));

-- Location: IOOBUF_X0_Y15_N2
\fdata[22]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(22));

-- Location: IOOBUF_X0_Y15_N9
\fdata[23]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(23));

-- Location: IOOBUF_X53_Y24_N23
\fdata[24]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(24));

-- Location: IOOBUF_X53_Y5_N23
\fdata[25]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(25));

-- Location: IOOBUF_X0_Y11_N2
\fdata[26]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(26));

-- Location: IOOBUF_X0_Y14_N2
\fdata[27]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(27));

-- Location: IOOBUF_X0_Y5_N16
\fdata[28]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(28));

-- Location: IOOBUF_X0_Y23_N16
\fdata[29]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(29));

-- Location: IOOBUF_X0_Y6_N23
\fdata[30]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => fdata(30));

-- Location: IOOBUF_X0_Y29_N9
\fdata[31]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "true")
-- pragma translate_on
PORT MAP (
	i => VCC,
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
	pll_compensation_delay => 3382,
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

-- Location: FF_X53_Y19_N3
flagd_d : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \flagd~input_o\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \flagd_d~q\);

-- Location: LCCOMB_X52_Y19_N2
\Selector1~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector1~0_combout\ = (\current_stream_out_state.stream_out_flagc_rcvd~q\) # ((\current_stream_out_state.stream_out_wait_flagd~q\ & !\flagd_d~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_flagc_rcvd~q\,
	datac => \current_stream_out_state.stream_out_wait_flagd~q\,
	datad => \flagd_d~q\,
	combout => \Selector1~0_combout\);

-- Location: FF_X52_Y19_N3
\current_stream_out_state.stream_out_wait_flagd\ : dffeas
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
	q => \current_stream_out_state.stream_out_wait_flagd~q\);

-- Location: LCCOMB_X52_Y19_N16
\next_stream_out_state.stream_out_read~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \next_stream_out_state.stream_out_read~0_combout\ = (\flagd_d~q\ & ((\current_stream_out_state.stream_out_wait_flagd~q\) # (\current_stream_out_state.stream_out_read~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_stream_out_state.stream_out_wait_flagd~q\,
	datac => \current_stream_out_state.stream_out_read~q\,
	datad => \flagd_d~q\,
	combout => \next_stream_out_state.stream_out_read~0_combout\);

-- Location: FF_X52_Y19_N17
\current_stream_out_state.stream_out_read\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \next_stream_out_state.stream_out_read~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_stream_out_state.stream_out_read~q\);

-- Location: LCCOMB_X52_Y19_N20
\rd_oe_delay_cnt[0]~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \rd_oe_delay_cnt[0]~0_combout\ = (\current_stream_out_state.stream_out_read~q\) # ((rd_oe_delay_cnt(0) & !\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_stream_out_state.stream_out_read~q\,
	datac => rd_oe_delay_cnt(0),
	datad => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	combout => \rd_oe_delay_cnt[0]~0_combout\);

-- Location: FF_X52_Y19_N21
\rd_oe_delay_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \rd_oe_delay_cnt[0]~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => rd_oe_delay_cnt(0));

-- Location: LCCOMB_X52_Y19_N18
\Selector2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (\current_stream_out_state.stream_out_read~q\ & (((rd_oe_delay_cnt(0) & \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)) # (!\flagd_d~q\))) # (!\current_stream_out_state.stream_out_read~q\ & (rd_oe_delay_cnt(0) & 
-- (\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \current_stream_out_state.stream_out_read~q\,
	datab => rd_oe_delay_cnt(0),
	datac => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	datad => \flagd_d~q\,
	combout => \Selector2~0_combout\);

-- Location: FF_X52_Y19_N19
\current_stream_out_state.stream_out_read_rd_and_oe_delay\ : dffeas
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
	q => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\);

-- Location: LCCOMB_X52_Y19_N28
\process_0~2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_0~2_combout\ = (\current_stream_out_state.stream_out_read~q\) # (\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_stream_out_state.stream_out_read~q\,
	datad => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	combout => \process_0~2_combout\);

-- Location: LCCOMB_X52_Y19_N22
\Selector3~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \Selector3~0_combout\ = (\Selector0~0_combout\ & (!rd_oe_delay_cnt(0) & ((\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\)))) # (!\Selector0~0_combout\ & ((\current_stream_out_state.stream_out_read_oe_delay~q\) # ((!rd_oe_delay_cnt(0) & 
-- \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Selector0~0_combout\,
	datab => rd_oe_delay_cnt(0),
	datac => \current_stream_out_state.stream_out_read_oe_delay~q\,
	datad => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	combout => \Selector3~0_combout\);

-- Location: FF_X52_Y19_N23
\current_stream_out_state.stream_out_read_oe_delay\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \pll_inst|altpll_component|auto_generated|wire_pll1_clk[0]~clkctrl_outclk\,
	d => \Selector3~0_combout\,
	clrn => \pll_inst|altpll_component|auto_generated|wire_pll1_locked\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \current_stream_out_state.stream_out_read_oe_delay~q\);

-- Location: LCCOMB_X52_Y19_N24
\process_1~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \process_1~1_combout\ = (\current_stream_out_state.stream_out_read~q\) # ((\current_stream_out_state.stream_out_read_oe_delay~q\) # (\current_stream_out_state.stream_out_read_rd_and_oe_delay~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \current_stream_out_state.stream_out_read~q\,
	datac => \current_stream_out_state.stream_out_read_oe_delay~q\,
	datad => \current_stream_out_state.stream_out_read_rd_and_oe_delay~q\,
	combout => \process_1~1_combout\);

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


