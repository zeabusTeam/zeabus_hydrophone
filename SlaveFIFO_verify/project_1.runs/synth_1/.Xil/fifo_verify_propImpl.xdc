set_property SRC_FILE_INFO {cfile:c:/Users/akrap/Google/AUV/zeabus_hydrophone/SlaveFIFO_verify/project_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc rfile:../../../project_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:clk_gen/inst} [current_design]
set_property SRC_FILE_INFO {cfile:C:/Users/akrap/Google/AUV/zeabus_hydrophone/SlaveFIFO_verify/FIFO_verify.xdc rfile:../../../FIFO_verify.xdc id:2} [current_design]
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
set_property src_info {type:XDC file:2 line:87 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T15 [get_ports {A[1]}]        	;# CTL11/A1/GPIO28
set_property src_info {type:XDC file:2 line:89 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U16 [get_ports {A[0]}]        	;# CTL12/A0/GPIO29
set_property src_info {type:XDC file:2 line:124 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T11 [get_ports {LED_RED_n}]   ;# LED1:red (Active low)
set_property src_info {type:XDC file:2 line:127 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P5 [get_ports {LED_GREEN_3}]      ;# D19 / P5~IO_L13N_T2_MRCC_34
set_property src_info {type:XDC file:2 line:129 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N5 [get_ports {LED_YELLOW_3}]      ;# D20 / N5~IO_L13P_T2_MRCC_34
set_property src_info {type:XDC file:2 line:131 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P4 [get_ports {LED_RED_3}]      ;# D21 / P4~IO_L14P_T2_SRCC_34
set_property src_info {type:XDC file:2 line:133 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P3 [get_ports {LED_GREEN_2}]      ;# D22 / P3~IO_L14N_T2_SRCC_34
set_property src_info {type:XDC file:2 line:135 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN T1 [get_ports {LED_YELLOW_2}]      ;# D23 / T1~IO_L17N_T2_34
set_property src_info {type:XDC file:2 line:137 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R1 [get_ports {LED_RED_2}]      ;# D24 / R1~IO_L17P_T2_34
set_property src_info {type:XDC file:2 line:139 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN R2 [get_ports {LED_GREEN_1}]      ;# D25 / R2~IO_L15N_T2_DQS_34
set_property src_info {type:XDC file:2 line:141 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN P2 [get_ports {LED_YELLOW_1}]      ;# D26 / P2~IO_L15P_T2_DQS_34
set_property src_info {type:XDC file:2 line:143 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN N2 [get_ports {LED_RED_1}]      ;# D27 / N2~IO_L3P_T0_DQS_34
