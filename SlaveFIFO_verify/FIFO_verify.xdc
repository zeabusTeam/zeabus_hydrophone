##################################################################################################
##
## Clocks
##
##################################################################################################
# CLK : Master clock of 26MHz
create_clock -name clk_in -period 38.462 [get_ports clk_in]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.38461
set_property PHASESHIFT_MODE WAVEFORM [get_cells -hierarchical *adv*]


# IFCLK (FX3S generates the clock)
#create_clock -name ifclk_in -period 10 [get_ports ifclk_in]

##################################################################################################
##
## Physical properties
##
##################################################################################################
##################################################################################################
## Clock pins
##################################################################################################
# Master clock
set_property PACKAGE_PIN P15 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]

# IFCLK (aka. FPGA <-> FX3S communication clock)
set_property PACKAGE_PIN P17 [get_ports ifclk_out]
set_property IOSTANDARD LVCMOS33 [get_ports ifclk_out]

##################################################################################################
## FPGA <-> FX3S interface
##################################################################################################
set_property PACKAGE_PIN K17 [get_ports {DQ[0]}]        ;# DQ0
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[0]}]
set_property PACKAGE_PIN K18 [get_ports {DQ[1]}]        ;# DQ1
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[1]}]
set_property PACKAGE_PIN L14 [get_ports {DQ[2]}]        ;# DQ2
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[2]}]
set_property PACKAGE_PIN M14 [get_ports {DQ[3]}]        ;# DQ3
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[3]}]
set_property PACKAGE_PIN L18 [get_ports {DQ[4]}]        ;# DQ4
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[4]}]
set_property PACKAGE_PIN M18 [get_ports {DQ[5]}]        ;# DQ5
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[5]}]
set_property PACKAGE_PIN R12 [get_ports {DQ[6]}]        ;# DQ6
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[6]}]
set_property PACKAGE_PIN R13 [get_ports {DQ[7]}]        ;# DQ7
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[7]}]
set_property PACKAGE_PIN M13 [get_ports {DQ[8]}]        ;# DQ8
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[8]}]
set_property PACKAGE_PIN R18 [get_ports {DQ[9]}]        ;# DQ9
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[9]}]
set_property PACKAGE_PIN T18 [get_ports {DQ[10]}]       ;# DQ10
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[10]}]
set_property PACKAGE_PIN N14 [get_ports {DQ[11]}]       ;# DQ11
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[11]}]
set_property PACKAGE_PIN P14 [get_ports {DQ[12]}]       ;# DQ12
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[12]}]
set_property PACKAGE_PIN P18 [get_ports {DQ[13]}]       ;# DQ13
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[13]}]
set_property PACKAGE_PIN M16 [get_ports {DQ[14]}]       ;# DQ14
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[14]}]
set_property PACKAGE_PIN M17 [get_ports {DQ[15]}]       ;# DQ15
set_property IOSTANDARD LVCMOS33 [get_ports {DQ[15]}]

set_property PACKAGE_PIN U12 [get_ports {SLCS}]         ;# CTL0/SLCS#/GPIO17
set_property IOSTANDARD LVCMOS33 [get_ports {SLCS}]
set_property PACKAGE_PIN U11 [get_ports {SLWR}]         ;# CTL1/SLWR#/GPIO18
set_property IOSTANDARD LVCMOS33 [get_ports {SLWR}]
set_property PACKAGE_PIN U13 [get_ports {SLOE}]         ;# CTL2/SLOE#/GPIO19
set_property IOSTANDARD LVCMOS33 [get_ports {SLOE}]
set_property PACKAGE_PIN V12 [get_ports {SLRD}]         ;# CTL3/SLRD#/GPIO20
set_property IOSTANDARD LVCMOS33 [get_ports {SLRD}]
set_property PACKAGE_PIN V11 [get_ports {FLAGA}]        ;# CTL4/FLAGA/GPIO21
set_property IOSTANDARD LVCMOS33 [get_ports {FLAGA}]
set_property PACKAGE_PIN V14 [get_ports {FLAGB}]        ;# CTL5/FLAGB/GPIO22
set_property IOSTANDARD LVCMOS33 [get_ports {FLAGB}]
set_property PACKAGE_PIN T14 [get_ports {RST}]  		;# CTL6/GPIO23/Module Soft-reset
set_property IOSTANDARD LVCMOS33 [get_ports {RST}]
set_property PACKAGE_PIN V10 [get_ports {PKTEND}]       ;# CTL7/PKTEND#/GPIO24
set_property IOSTANDARD LVCMOS33 [get_ports {PKTEND}]
#set_property PACKAGE_PIN V16 [get_ports {FLAGD}]        ;# CTL8/FLAGD/GPIO25
#set_property IOSTANDARD LVCMOS33 [get_ports {FLAGD}]
#set_property PACKAGE_PIN U14 [get_ports {CTL9}]         ;# CTL9/GPIO26
#set_property IOSTANDARD LVCMOS33 [get_ports {CTL9}]
set_property PACKAGE_PIN T15 [get_ports {A[1]}]        	;# CTL11/A1/GPIO28
set_property IOSTANDARD LVCMOS33 [get_ports {A[1]}]
set_property PACKAGE_PIN U16 [get_ports {A[0]}]        	;# CTL12/A0/GPIO29
set_property IOSTANDARD LVCMOS33 [get_ports {A[0]}]
#set_property PACKAGE_PIN T13 [get_ports {CTL15}]        ;# INT#/CTL15
#set_property IOSTANDARD LVCMOS33 [get_ports {CTL15}]

#set_property PACKAGE_PIN R16 [get_ports {GPIO38}]       ;# GPIO38/RDWR_B
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO38}]
#set_property PACKAGE_PIN V15 [get_ports {GPIO39}]       ;# GPIO39/CSI_B
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO39}]

#set_property PACKAGE_PIN T16 [get_ports {GPIO46}]       ;# GPIO46/UART_RTS
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO46}]
#set_property PACKAGE_PIN U18 [get_ports {GPIO47}]       ;# GPIO47/UART_CTS
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO47}]
#set_property PACKAGE_PIN U17 [get_ports {GPIO48}]       ;# GPIO48/UART_TX
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO48}]
#set_property PACKAGE_PIN V17 [get_ports {GPIO49}]       ;# GPIO49/UART_RX
#set_property IOSTANDARD LVCMOS33 [get_ports {GPIO49}]
#set_property PACKAGE_PIN T10 [get_ports {S_SCL}]        ;# Slave SCL
#set_property IOSTANDARD LVCMOS33 [get_ports {S_SCL}]
#set_property PACKAGE_PIN T9 [get_ports {S_SDA}]         ;# Slave SDA
#set_property IOSTANDARD LVCMOS33 [get_ports {S_SDA}]

#set_property PACKAGE_PIN R17 [get_ports {SPI_CLK}]      ;# FPGA_CLK
#set_property IOSTANDARD LVCMOS33 [get_ports {SPI_CLK}]
#set_property PACKAGE_PIN N17 [get_ports {SPI_CS_N}]     ;# FPGA_CS#
#set_property IOSTANDARD LVCMOS33 [get_ports {SPI_CS_N}]
#set_property PACKAGE_PIN N16 [get_ports {SPI_MISO}]     ;# FPGA_MISO
#set_property IOSTANDARD LVCMOS33 [get_ports {SPI_MISO}]
#set_property PACKAGE_PIN L16 [get_ports {SPI_MOSI}]     ;# FPGA_MOSI
#set_property IOSTANDARD LVCMOS33 [get_ports {SPI_MOSI}]

##################################################################################################
## LED
##################################################################################################
set_property PACKAGE_PIN T11 [get_ports {LED_RED_n}]   ;# LED1:red (Active low)
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_n}]

set_property PACKAGE_PIN P5 [get_ports {LED_GREEN_3}]      ;# D19 / P5~IO_L13N_T2_MRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_3}]
set_property PACKAGE_PIN N5 [get_ports {LED_YELLOW_3}]      ;# D20 / N5~IO_L13P_T2_MRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_3}]
set_property PACKAGE_PIN P4 [get_ports {LED_RED_3}]      ;# D21 / P4~IO_L14P_T2_SRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_3}]
set_property PACKAGE_PIN P3 [get_ports {LED_GREEN_2}]      ;# D22 / P3~IO_L14N_T2_SRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_2}]
set_property PACKAGE_PIN T1 [get_ports {LED_YELLOW_2}]      ;# D23 / T1~IO_L17N_T2_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_2}]
set_property PACKAGE_PIN R1 [get_ports {LED_RED_2}]      ;# D24 / R1~IO_L17P_T2_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_2}]
set_property PACKAGE_PIN R2 [get_ports {LED_GREEN_1}]      ;# D25 / R2~IO_L15N_T2_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_1}]
set_property PACKAGE_PIN P2 [get_ports {LED_YELLOW_1}]      ;# D26 / P2~IO_L15P_T2_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_1}]
set_property PACKAGE_PIN N2 [get_ports {LED_RED_1}]      ;# D27 / N2~IO_L3P_T0_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_1}]


##################################################################################################
## Controller 0
## Memory Device: DDR3_SDRAM->Components->MT41J128M16XX-125
## Data Width: 16
## Time Period: 2500
## Data Mask: 1
##################################################################################################
#set_property PACKAGE_PIN H1 [get_ports {ddr3_dq[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[0]}]
#set_property SLEW FAST [get_ports {ddr3_dq[0]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[0]}]
#set_property PACKAGE_PIN F1 [get_ports {ddr3_dq[1]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[1]}]
#set_property SLEW FAST [get_ports {ddr3_dq[1]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[1]}]
#set_property PACKAGE_PIN E2 [get_ports {ddr3_dq[2]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[2]}]
#set_property SLEW FAST [get_ports {ddr3_dq[2]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[2]}]
#set_property PACKAGE_PIN E1 [get_ports {ddr3_dq[3]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[3]}]
#set_property SLEW FAST [get_ports {ddr3_dq[3]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[3]}]
#set_property PACKAGE_PIN F4 [get_ports {ddr3_dq[4]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[4]}]
#set_property SLEW FAST [get_ports {ddr3_dq[4]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[4]}]
#set_property PACKAGE_PIN C1 [get_ports {ddr3_dq[5]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[5]}]
#set_property SLEW FAST [get_ports {ddr3_dq[5]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[5]}]
#set_property PACKAGE_PIN F3 [get_ports {ddr3_dq[6]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[6]}]
#set_property SLEW FAST [get_ports {ddr3_dq[6]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[6]}]
#set_property PACKAGE_PIN D2 [get_ports {ddr3_dq[7]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[7]}]
#set_property SLEW FAST [get_ports {ddr3_dq[7]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[7]}]
#set_property PACKAGE_PIN G4 [get_ports {ddr3_dq[8]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[8]}]
#set_property SLEW FAST [get_ports {ddr3_dq[8]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[8]}]
#set_property PACKAGE_PIN H5 [get_ports {ddr3_dq[9]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[9]}]
#set_property SLEW FAST [get_ports {ddr3_dq[9]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[9]}]
#set_property PACKAGE_PIN G3 [get_ports {ddr3_dq[10]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[10]}]
#set_property SLEW FAST [get_ports {ddr3_dq[10]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[10]}]
#set_property PACKAGE_PIN H6 [get_ports {ddr3_dq[11]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[11]}]
#set_property SLEW FAST [get_ports {ddr3_dq[11]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[11]}]
#set_property PACKAGE_PIN J2 [get_ports {ddr3_dq[12]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[12]}]
#set_property SLEW FAST [get_ports {ddr3_dq[12]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[12]}]
#set_property PACKAGE_PIN J3 [get_ports {ddr3_dq[13]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[13]}]
#set_property SLEW FAST [get_ports {ddr3_dq[13]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[13]}]
#set_property PACKAGE_PIN K1 [get_ports {ddr3_dq[14]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[14]}]
#set_property SLEW FAST [get_ports {ddr3_dq[14]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[14]}]
#set_property PACKAGE_PIN K2 [get_ports {ddr3_dq[15]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dq[15]}]
#set_property SLEW FAST [get_ports {ddr3_dq[15]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dq[15]}]

#set_property PACKAGE_PIN C5 [get_ports {ddr3_addr[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[0]}]
#set_property SLEW FAST [get_ports {ddr3_addr[0]}]
#set_property PACKAGE_PIN B6 [get_ports {ddr3_addr[1]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[1]}]
#set_property SLEW FAST [get_ports {ddr3_addr[1]}]
#set_property PACKAGE_PIN C7 [get_ports {ddr3_addr[2]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[2]}]
#set_property SLEW FAST [get_ports {ddr3_addr[2]}]
#set_property PACKAGE_PIN D5 [get_ports {ddr3_addr[3]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[3]}]
#set_property SLEW FAST [get_ports {ddr3_addr[3]}]
#set_property PACKAGE_PIN A3 [get_ports {ddr3_addr[4]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[4]}]
#set_property SLEW FAST [get_ports {ddr3_addr[4]}]
#set_property PACKAGE_PIN E7 [get_ports {ddr3_addr[5]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[5]}]
#set_property SLEW FAST [get_ports {ddr3_addr[5]}]
#set_property PACKAGE_PIN A4 [get_ports {ddr3_addr[6]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[6]}]
#set_property SLEW FAST [get_ports {ddr3_addr[6]}]
#set_property PACKAGE_PIN C6 [get_ports {ddr3_addr[7]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[7]}]
#set_property SLEW FAST [get_ports {ddr3_addr[7]}]
#set_property PACKAGE_PIN A6 [get_ports {ddr3_addr[8]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[8]}]
#set_property SLEW FAST [get_ports {ddr3_addr[8]}]
#set_property PACKAGE_PIN D8 [get_ports {ddr3_addr[9]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[9]}]
#set_property SLEW FAST [get_ports {ddr3_addr[9]}]
#set_property PACKAGE_PIN B2 [get_ports {ddr3_addr[10]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[10]}]
#set_property SLEW FAST [get_ports {ddr3_addr[10]}]
#set_property PACKAGE_PIN A5 [get_ports {ddr3_addr[11]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[11]}]
#set_property SLEW FAST [get_ports {ddr3_addr[11]}]
#set_property PACKAGE_PIN B3 [get_ports {ddr3_addr[12]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[12]}]
#set_property SLEW FAST [get_ports {ddr3_addr[12]}]
#set_property PACKAGE_PIN B7 [get_ports {ddr3_addr[13]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[13]}]
#set_property SLEW FAST [get_ports {ddr3_addr[13]}]

#set_property PACKAGE_PIN E5 [get_ports {ddr3_ba[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[0]}]
#set_property SLEW FAST [get_ports {ddr3_ba[0]}]
#set_property PACKAGE_PIN A1 [get_ports {ddr3_ba[1]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[1]}]
#set_property SLEW FAST [get_ports {ddr3_ba[1]}]
#set_property PACKAGE_PIN E6 [get_ports {ddr3_ba[2]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[2]}]
#set_property SLEW FAST [get_ports {ddr3_ba[2]}]

#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_p[0]}]
#set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
#set_property PACKAGE_PIN H2 [get_ports {ddr3_dqs_p[0]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dqs_p[0]}]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_n[0]}]
#set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
#set_property PACKAGE_PIN G2 [get_ports {ddr3_dqs_n[0]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dqs_n[0]}]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_p[1]}]
#set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
#set_property PACKAGE_PIN J4 [get_ports {ddr3_dqs_p[1]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dqs_p[1]}]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_dqs_n[1]}]
#set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
#set_property PACKAGE_PIN H4 [get_ports {ddr3_dqs_n[1]}]
#set_property IN_TERM UNTUNED_SPLIT_40 [get_ports {ddr3_dqs_n[1]}]

#set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]
#set_property SLEW FAST [get_ports {ddr3_cas_n}]
#set_property PACKAGE_PIN D3 [get_ports {ddr3_cas_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]
#set_property SLEW FAST [get_ports {ddr3_ras_n}]
#set_property PACKAGE_PIN E3 [get_ports {ddr3_ras_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]
#set_property SLEW FAST [get_ports {ddr3_we_n}]
#set_property PACKAGE_PIN D4 [get_ports {ddr3_we_n}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[0]}]
#set_property SLEW FAST [get_ports {ddr3_cke[0]}]
#set_property PACKAGE_PIN B1 [get_ports {ddr3_cke[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
#set_property SLEW FAST [get_ports {ddr3_odt[0]}]
#set_property PACKAGE_PIN F5 [get_ports {ddr3_odt[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[0]}]
#set_property SLEW FAST [get_ports {ddr3_dm[0]}]
#set_property PACKAGE_PIN G1 [get_ports {ddr3_dm[0]}]
#set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[1]}]
#set_property SLEW FAST [get_ports {ddr3_dm[1]}]
#set_property PACKAGE_PIN G6 [get_ports {ddr3_dm[1]}]

#set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]
#set_property SLEW FAST [get_ports {ddr3_reset_n}]
#set_property PACKAGE_PIN J5 [get_ports {ddr3_reset_n}]

#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]
#set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
#set_property PACKAGE_PIN C4 [get_ports {ddr3_ck_p[0]}]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
#set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
#set_property PACKAGE_PIN B4 [get_ports {ddr3_ck_n[0]}]

