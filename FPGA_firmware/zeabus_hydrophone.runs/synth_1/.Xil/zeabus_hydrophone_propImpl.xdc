set_property SRC_FILE_INFO {cfile:c:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.srcs/sources_1/ip/clk_pll/clk_pll.xdc rfile:../../../zeabus_hydrophone.srcs/sources_1/ip/clk_pll/clk_pll.xdc id:1 order:EARLY scoped_inst:clk_gen/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.xdc rfile:../../../zeabus_hydrophone.xdc id:2} [current_design]
current_instance clk_gen/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.38461
current_instance
set_property src_info {type:XDC file:2 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.38461
set_property src_info {type:XDC file:2 line:24 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P15 [get_ports clk_in]
set_property src_info {type:XDC file:2 line:28 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P17 [get_ports ifclk_out]
set_property src_info {type:XDC file:2 line:34 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K17 [get_ports {DQ[0]}]        ;# DQ0
set_property src_info {type:XDC file:2 line:36 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K18 [get_ports {DQ[1]}]        ;# DQ1
set_property src_info {type:XDC file:2 line:38 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN L14 [get_ports {DQ[2]}]        ;# DQ2
set_property src_info {type:XDC file:2 line:40 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M14 [get_ports {DQ[3]}]        ;# DQ3
set_property src_info {type:XDC file:2 line:42 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN L18 [get_ports {DQ[4]}]        ;# DQ4
set_property src_info {type:XDC file:2 line:44 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M18 [get_ports {DQ[5]}]        ;# DQ5
set_property src_info {type:XDC file:2 line:46 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R12 [get_ports {DQ[6]}]        ;# DQ6
set_property src_info {type:XDC file:2 line:48 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R13 [get_ports {DQ[7]}]        ;# DQ7
set_property src_info {type:XDC file:2 line:50 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M13 [get_ports {DQ[8]}]        ;# DQ8
set_property src_info {type:XDC file:2 line:52 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R18 [get_ports {DQ[9]}]        ;# DQ9
set_property src_info {type:XDC file:2 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T18 [get_ports {DQ[10]}]       ;# DQ10
set_property src_info {type:XDC file:2 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N14 [get_ports {DQ[11]}]       ;# DQ11
set_property src_info {type:XDC file:2 line:58 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P14 [get_ports {DQ[12]}]       ;# DQ12
set_property src_info {type:XDC file:2 line:60 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P18 [get_ports {DQ[13]}]       ;# DQ13
set_property src_info {type:XDC file:2 line:62 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M16 [get_ports {DQ[14]}]       ;# DQ14
set_property src_info {type:XDC file:2 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M17 [get_ports {DQ[15]}]       ;# DQ15
set_property src_info {type:XDC file:2 line:67 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U12 [get_ports {SLCS}]         ;# CTL0/SLCS#/GPIO17
set_property src_info {type:XDC file:2 line:69 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U11 [get_ports {SLWR}]         ;# CTL1/SLWR#/GPIO18
set_property src_info {type:XDC file:2 line:71 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U13 [get_ports {SLOE}]         ;# CTL2/SLOE#/GPIO19
set_property src_info {type:XDC file:2 line:73 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V12 [get_ports {SLRD}]         ;# CTL3/SLRD#/GPIO20
set_property src_info {type:XDC file:2 line:75 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V11 [get_ports {FLAGA}]        ;# CTL4/FLAGA/GPIO21
set_property src_info {type:XDC file:2 line:77 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V14 [get_ports {FLAGB}]        ;# CTL5/FLAGB/GPIO22
set_property src_info {type:XDC file:2 line:79 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T14 [get_ports {RST}]  		;# CTL6/GPIO23/Module Soft-reset
set_property src_info {type:XDC file:2 line:81 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V10 [get_ports {PKTEND}]       ;# CTL7/PKTEND#/GPIO24
set_property src_info {type:XDC file:2 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U14 [get_ports {FIR_EN}]       ;# CTL9/GPIO26/Enable FIR module
set_property src_info {type:XDC file:2 line:87 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T15 [get_ports {A[1]}]        	;# CTL11/A1/GPIO28
set_property src_info {type:XDC file:2 line:89 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U16 [get_ports {A[0]}]        	;# CTL12/A0/GPIO29
set_property src_info {type:XDC file:2 line:124 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T11 [get_ports {LED_RED_n}]   ;# LED1:red (Active low)
set_property src_info {type:XDC file:2 line:126 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E17 [get_ports {LED_GREEN}]   ;# B13:LED2:Green
set_property src_info {type:XDC file:2 line:128 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D17 [get_ports {LED_BLUE}]    ;# B14:LED3:Blue
set_property src_info {type:XDC file:2 line:134 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P5 [get_ports {LED_RED_1}]      ;# D19 / P5~IO_L13N_T2_MRCC_34
set_property src_info {type:XDC file:2 line:136 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N5 [get_ports {LED_YELLOW_1}]   ;# D20 / N5~IO_L13P_T2_MRCC_34
set_property src_info {type:XDC file:2 line:138 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P4 [get_ports {LED_GREEN_1}]    ;# D21 / P4~IO_L14P_T2_SRCC_34
set_property src_info {type:XDC file:2 line:140 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P3 [get_ports {LED_RED_2}]      ;# D22 / P3~IO_L14N_T2_SRCC_34
set_property src_info {type:XDC file:2 line:142 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T1 [get_ports {LED_YELLOW_2}]   ;# D23 / T1~IO_L17N_T2_34
set_property src_info {type:XDC file:2 line:144 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R1 [get_ports {LED_GREEN_2}]    ;# D24 / R1~IO_L17P_T2_34
set_property src_info {type:XDC file:2 line:146 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R2 [get_ports {LED_RED_3}]      ;# D25 / R2~IO_L15N_T2_DQS_34
set_property src_info {type:XDC file:2 line:148 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P2 [get_ports {LED_YELLOW_3}]   ;# D26 / P2~IO_L15P_T2_DQS_34
set_property src_info {type:XDC file:2 line:150 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N2 [get_ports {LED_GREEN_3}]    ;# D27 / N2~IO_L3P_T0_DQS_34
set_property src_info {type:XDC file:2 line:157 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K16 [get_ports {OTR_1}]        ;# A3 / K16~IO_25_15 / Overflow
set_property src_info {type:XDC file:2 line:160 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K15 [get_ports {D_1[13]}]      ;# A4 / K15~IO_L24P_T3_RS1_15 / D13
set_property src_info {type:XDC file:2 line:162 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J15 [get_ports {D_1[12]}]      ;# A5 / J15~IO_L24N_T3_RS0_15 / D12
set_property src_info {type:XDC file:2 line:164 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H15 [get_ports {D_1[11]}]      ;# A6 / H15~IO_L19N_T3_A21_VREF_15 / D11
set_property src_info {type:XDC file:2 line:166 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN J14 [get_ports {D_1[10]}]      ;# A7 / J14~IO_L19P_T3_A22_15 / D10
set_property src_info {type:XDC file:2 line:168 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN H17 [get_ports {D_1[9]}]       ;# A8 / H17~IO_L18P_T2_A24_15 / D9
set_property src_info {type:XDC file:2 line:170 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G17 [get_ports {D_1[8]}]       ;# A9 / G17~IO_L18N_T2_A23_15 / D8
set_property src_info {type:XDC file:2 line:172 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G18 [get_ports {D_1[7]}]       ;# A10 / G18~IO_L22P_T3_A17_15 / D7
set_property src_info {type:XDC file:2 line:174 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F18 [get_ports {D_1[6]}]       ;# A11 / F18~IO_L22N_T3_A16_15 / D6
set_property src_info {type:XDC file:2 line:176 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E18 [get_ports {D_1[5]}]       ;# A12 / E18~IO_L21P_T3_DQS_15 / D5
set_property src_info {type:XDC file:2 line:178 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN D18 [get_ports {D_1[4]}]       ;# A13 / D18~IO_L21N_T3_DQS_A18_15 / D4
set_property src_info {type:XDC file:2 line:180 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN G13 [get_ports {D_1[3]}]       ;# A14 / G13~IO_0_15 / D3
set_property src_info {type:XDC file:2 line:182 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN F13 [get_ports {D_1[2]}]       ;# A18 / F13~IO_L5P_T0_AD9P_15 / D2
set_property src_info {type:XDC file:2 line:184 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN E16 [get_ports {D_1[1]}]       ;# A19 / E16~IO_L11N_T1_SRCC_15 / D1
set_property src_info {type:XDC file:2 line:186 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C17 [get_ports {D_1[0]}]       ;# A20 / C17~IO_L20N_T3_A19_15 / D0
set_property src_info {type:XDC file:2 line:189 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A18 [get_ports {CLKB_1}]       ;# A21 / A18~IO_L10N_T1_AD11N_15 / CLKB
set_property src_info {type:XDC file:2 line:191 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN C15 [get_ports {CLKA_1}]       ;# A22 / C15~IO_L12N_T1_MRCC_15 / CLKA
set_property src_info {type:XDC file:2 line:197 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U9 [get_ports {OTR_2}]         ;# C3 / U9~IO_L21P_T3_DQS_34 / Overflow
set_property src_info {type:XDC file:2 line:200 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U8 [get_ports {D_2[13]}]       ;# C4 / U8~IO_25_34 / D13
set_property src_info {type:XDC file:2 line:202 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U7 [get_ports {D_2[12]}]       ;# C5 / U7~IO_L22P_T3_34 / D12
set_property src_info {type:XDC file:2 line:204 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U6 [get_ports {D_2[11]}]       ;# C6 / U6~IO_L22N_T3_34 / D11
set_property src_info {type:XDC file:2 line:206 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T8 [get_ports {D_2[10]}]       ;# C7 / T8~IO_L24N_T3_34 / D10
set_property src_info {type:XDC file:2 line:208 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R8 [get_ports {D_2[9]}]        ;# C8 / R8~IO_L24P_T3_34 / D9
set_property src_info {type:XDC file:2 line:210 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R7 [get_ports {D_2[8]}]        ;# C9 / R7~IO_L23P_T3_34 / D8
set_property src_info {type:XDC file:2 line:212 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T6 [get_ports {D_2[7]}]        ;# C10 / T6~IO_L23N_T3_34 / D7
set_property src_info {type:XDC file:2 line:214 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R6 [get_ports {D_2[6]}]        ;# C11 / R6~IO_L19P_T3_34 / D6
set_property src_info {type:XDC file:2 line:216 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R5 [get_ports {D_2[5]}]        ;# C12 / R5~IO_L19N_T3_VREF_34 / D5
set_property src_info {type:XDC file:2 line:218 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN V2 [get_ports {D_2[4]}]        ;# C13 / V2~IO_L9N_T1_DQS_34 / D4
set_property src_info {type:XDC file:2 line:220 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U2 [get_ports {D_2[3]}]        ;# C14 / U2~IO_L9P_T1_DQS_34 / D3
set_property src_info {type:XDC file:2 line:222 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN K6 [get_ports {D_2[2]}]        ;# C15 / K6~IO_0_34 / D2
set_property src_info {type:XDC file:2 line:224 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N6 [get_ports {D_2[1]}]        ;# C19 / N6~IO_L18N_T2_34 / D1
set_property src_info {type:XDC file:2 line:226 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN M6 [get_ports {D_2[0]}]        ;# C20 / M6~IO_L18P_T2_34 / D0
set_property src_info {type:XDC file:2 line:229 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN L6 [get_ports {CLKB_2}]        ;# C21 / L6~IO_L6P_T0_34 / CLKB
set_property src_info {type:XDC file:2 line:231 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN L5 [get_ports {CLKA_2}]        ;# C22 / L5~IO_L6N_T0_VREF_34  / CLKA
set_property src_info {type:XDC file:2 line:237 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN B11 [get_ports {SCL}]          ;# SCL
set_property src_info {type:XDC file:2 line:239 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN A14 [get_ports {SDA}]          ;# SDA
