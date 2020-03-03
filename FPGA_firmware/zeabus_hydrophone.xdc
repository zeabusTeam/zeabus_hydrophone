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
set_property PACKAGE_PIN U14 [get_ports {FIR_EN}]       ;# CTL9/GPIO26/Enable FIR module
set_property IOSTANDARD LVCMOS33 [get_ports {FIR_EN}]
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
set_property PACKAGE_PIN E17 [get_ports {LED_GREEN}]   ;# B13:LED2:Green
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN}]
set_property PACKAGE_PIN D17 [get_ports {LED_BLUE}]    ;# B14:LED3:Blue
set_property IOSTANDARD LVCMOS33 [get_ports {LED_BLUE}]

##################################################################################################
## Debug LEDs
##################################################################################################
set_property PACKAGE_PIN P5 [get_ports {LED_RED_1}]      ;# D19 / P5~IO_L13N_T2_MRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_1}]
set_property PACKAGE_PIN N5 [get_ports {LED_YELLOW_1}]   ;# D20 / N5~IO_L13P_T2_MRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_1}]
set_property PACKAGE_PIN P4 [get_ports {LED_GREEN_1}]    ;# D21 / P4~IO_L14P_T2_SRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_1}]
set_property PACKAGE_PIN P3 [get_ports {LED_RED_2}]      ;# D22 / P3~IO_L14N_T2_SRCC_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_2}]
set_property PACKAGE_PIN T1 [get_ports {LED_YELLOW_2}]   ;# D23 / T1~IO_L17N_T2_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_2}]
set_property PACKAGE_PIN R1 [get_ports {LED_GREEN_2}]    ;# D24 / R1~IO_L17P_T2_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_2}]
set_property PACKAGE_PIN R2 [get_ports {LED_RED_3}]      ;# D25 / R2~IO_L15N_T2_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_RED_3}]
set_property PACKAGE_PIN P2 [get_ports {LED_YELLOW_3}]   ;# D26 / P2~IO_L15P_T2_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_YELLOW_3}]
set_property PACKAGE_PIN N2 [get_ports {LED_GREEN_3}]    ;# D27 / N2~IO_L3P_T0_DQS_34
set_property IOSTANDARD LVCMOS33 [get_ports {LED_GREEN_3}]


##################################################################################################
## ADC1
##################################################################################################
set_property PACKAGE_PIN K16 [get_ports {OTR_1}]        ;# A3 / K16~IO_25_15 / Overflow
set_property IOSTANDARD LVCMOS33 [get_ports {OTR_1}]

set_property PACKAGE_PIN K15 [get_ports {D_1[13]}]      ;# A4 / K15~IO_L24P_T3_RS1_15 / D13
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[13]}]
set_property PACKAGE_PIN J15 [get_ports {D_1[12]}]      ;# A5 / J15~IO_L24N_T3_RS0_15 / D12
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[12]}]
set_property PACKAGE_PIN H15 [get_ports {D_1[11]}]      ;# A6 / H15~IO_L19N_T3_A21_VREF_15 / D11
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[11]}]
set_property PACKAGE_PIN J14 [get_ports {D_1[10]}]      ;# A7 / J14~IO_L19P_T3_A22_15 / D10
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[10]}]
set_property PACKAGE_PIN H17 [get_ports {D_1[9]}]       ;# A8 / H17~IO_L18P_T2_A24_15 / D9
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[9]}]
set_property PACKAGE_PIN G17 [get_ports {D_1[8]}]       ;# A9 / G17~IO_L18N_T2_A23_15 / D8
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[8]}]
set_property PACKAGE_PIN G18 [get_ports {D_1[7]}]       ;# A10 / G18~IO_L22P_T3_A17_15 / D7
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[7]}]
set_property PACKAGE_PIN F18 [get_ports {D_1[6]}]       ;# A11 / F18~IO_L22N_T3_A16_15 / D6
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[6]}]
set_property PACKAGE_PIN E18 [get_ports {D_1[5]}]       ;# A12 / E18~IO_L21P_T3_DQS_15 / D5
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[5]}]
set_property PACKAGE_PIN D18 [get_ports {D_1[4]}]       ;# A13 / D18~IO_L21N_T3_DQS_A18_15 / D4
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[4]}]
set_property PACKAGE_PIN G13 [get_ports {D_1[3]}]       ;# A14 / G13~IO_0_15 / D3
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[3]}]
set_property PACKAGE_PIN F13 [get_ports {D_1[2]}]       ;# A18 / F13~IO_L5P_T0_AD9P_15 / D2
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[2]}]
set_property PACKAGE_PIN E16 [get_ports {D_1[1]}]       ;# A19 / E16~IO_L11N_T1_SRCC_15 / D1
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[1]}]
set_property PACKAGE_PIN C17 [get_ports {D_1[0]}]       ;# A20 / C17~IO_L20N_T3_A19_15 / D0
set_property IOSTANDARD LVCMOS33 [get_ports {D_1[0]}]

set_property PACKAGE_PIN A18 [get_ports {CLKB_1}]       ;# A21 / A18~IO_L10N_T1_AD11N_15 / CLKB
set_property IOSTANDARD LVCMOS33 [get_ports {CLKB_1}]
set_property PACKAGE_PIN C15 [get_ports {CLKA_1}]       ;# A22 / C15~IO_L12N_T1_MRCC_15 / CLKA
set_property IOSTANDARD LVCMOS33 [get_ports {CLKA_1}]

##################################################################################################
## ADC2
##################################################################################################
set_property PACKAGE_PIN U9 [get_ports {OTR_2}]         ;# C3 / U9~IO_L21P_T3_DQS_34 / Overflow
set_property IOSTANDARD LVCMOS33 [get_ports {OTR_2}]

set_property PACKAGE_PIN U8 [get_ports {D_2[13]}]       ;# C4 / U8~IO_25_34 / D13
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[13]}]
set_property PACKAGE_PIN U7 [get_ports {D_2[12]}]       ;# C5 / U7~IO_L22P_T3_34 / D12
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[12]}]
set_property PACKAGE_PIN U6 [get_ports {D_2[11]}]       ;# C6 / U6~IO_L22N_T3_34 / D11
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[11]}]
set_property PACKAGE_PIN T8 [get_ports {D_2[10]}]       ;# C7 / T8~IO_L24N_T3_34 / D10
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[10]}]
set_property PACKAGE_PIN R8 [get_ports {D_2[9]}]        ;# C8 / R8~IO_L24P_T3_34 / D9
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[9]}]
set_property PACKAGE_PIN R7 [get_ports {D_2[8]}]        ;# C9 / R7~IO_L23P_T3_34 / D8
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[8]}]
set_property PACKAGE_PIN T6 [get_ports {D_2[7]}]        ;# C10 / T6~IO_L23N_T3_34 / D7
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[7]}]
set_property PACKAGE_PIN R6 [get_ports {D_2[6]}]        ;# C11 / R6~IO_L19P_T3_34 / D6
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[6]}]
set_property PACKAGE_PIN R5 [get_ports {D_2[5]}]        ;# C12 / R5~IO_L19N_T3_VREF_34 / D5
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[5]}]
set_property PACKAGE_PIN V2 [get_ports {D_2[4]}]        ;# C13 / V2~IO_L9N_T1_DQS_34 / D4
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[4]}]
set_property PACKAGE_PIN U2 [get_ports {D_2[3]}]        ;# C14 / U2~IO_L9P_T1_DQS_34 / D3
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[3]}]
set_property PACKAGE_PIN K6 [get_ports {D_2[2]}]        ;# C15 / K6~IO_0_34 / D2
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[2]}]
set_property PACKAGE_PIN N6 [get_ports {D_2[1]}]        ;# C19 / N6~IO_L18N_T2_34 / D1
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[1]}]
set_property PACKAGE_PIN M6 [get_ports {D_2[0]}]        ;# C20 / M6~IO_L18P_T2_34 / D0
set_property IOSTANDARD LVCMOS33 [get_ports {D_2[0]}]

set_property PACKAGE_PIN L6 [get_ports {CLKB_2}]        ;# C21 / L6~IO_L6P_T0_34 / CLKB
set_property IOSTANDARD LVCMOS33 [get_ports {CLKB_2}]
set_property PACKAGE_PIN L5 [get_ports {CLKA_2}]        ;# C22 / L5~IO_L6N_T0_VREF_34  / CLKA
set_property IOSTANDARD LVCMOS33 [get_ports {CLKA_2}]

##################################################################################################
## Amplifier-gain control
##################################################################################################
set_property PACKAGE_PIN B11 [get_ports {SCL}]          ;# SCL
set_property IOSTANDARD LVCMOS33 [get_ports {SCL}]
set_property PACKAGE_PIN A14 [get_ports {SDA}]          ;# SDA
set_property IOSTANDARD LVCMOS33 [get_ports {SDA}]

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

##################################################################################################
## external I/O (unused)
##################################################################################################
#set_property PACKAGE_PIN B17 [get_ports {IO_A[17]}]     ;# A23 / B17~IO_L7N_T1_AD2N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[17]}]
#set_property PACKAGE_PIN C14 [get_ports {IO_A[18]}]     ;# A24 / C14~IO_L1N_T0_AD0N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[18]}]
#set_property PACKAGE_PIN D13 [get_ports {IO_A[19]}]     ;# A25 / D13~IO_L6N_T0_VREF_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[19]}]
#set_property PACKAGE_PIN A16 [get_ports {IO_A[20]}]     ;# A26 / A16~IO_L8N_T1_AD10N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[20]}]
#set_property PACKAGE_PIN B14 [get_ports {IO_A[21]}]     ;# A27 / B14~IO_L2N_T0_AD8N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[21]}]
#set_property PACKAGE_PIN B12 [get_ports {IO_A[22]}]     ;# A28 / B12~IO_L3N_T0_DQS_AD1N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[22]}]
#set_property PACKAGE_PIN A14 [get_ports {IO_A[23]}]     ;# A29 / A14~IO_L9N_T1_DQS_AD3N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[23]}]
#set_property PACKAGE_PIN B11 [get_ports {IO_A[24]}]     ;# A30 / B11~IO_L4P_T0_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_A[24]}]

#set_property PACKAGE_PIN J18 [get_ports {IO_B[0]}]      ;# B3 / J18~IO_L23N_T3_FWE_B_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[0]}]
#set_property PACKAGE_PIN J17 [get_ports {IO_B[1]}]      ;# B4 / J17~IO_L23P_T3_FOE_B_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[1]}]
#set_property PACKAGE_PIN K13 [get_ports {IO_B[2]}]      ;# B5 / K13~IO_L17P_T2_A26_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[2]}]
#set_property PACKAGE_PIN J13 [get_ports {IO_B[3]}]      ;# B6 / J13~IO_L17N_T2_A25_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[3]}]
#set_property PACKAGE_PIN H14 [get_ports {IO_B[4]}]      ;# B7 / H14~IO_L15P_T2_DQS_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[4]}]
#set_property PACKAGE_PIN G14 [get_ports {IO_B[5]}]      ;# B8 / G14~IO_L15N_T2_DQS_ADV_B_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[5]}]
#set_property PACKAGE_PIN G16 [get_ports {IO_B[6]}]      ;# B9 / G16~IO_L13N_T2_MRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[6]}]
#set_property PACKAGE_PIN H16 [get_ports {IO_B[7]}]      ;# B10 / H16~IO_L13P_T2_MRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[7]}]
#set_property PACKAGE_PIN F16 [get_ports {IO_B[8]}]      ;# B11 / F16~IO_L14N_T2_SRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[8]}]
#set_property PACKAGE_PIN F15 [get_ports {IO_B[9]}]      ;# B12 / F15~IO_L14P_T2_SRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[9]}]
#set_property PACKAGE_PIN F14 [get_ports {IO_B[12]}]     ;# B18 / F14~IO_L5N_T0_AD9N_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[12]}]
#set_property PACKAGE_PIN E15 [get_ports {IO_B[13]}]     ;# B19 / E15~IO_L11P_T1_SRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[13]}]
#set_property PACKAGE_PIN C16 [get_ports {IO_B[14]}]     ;# B20 / C16~IO_L20P_T3_A20_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[14]}]
#set_property PACKAGE_PIN B18 [get_ports {IO_B[15]}]     ;# B21 / B18~IO_L10P_T1_AD11P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[15]}]
#set_property PACKAGE_PIN D15 [get_ports {IO_B[16]}]     ;# B22 / D15~IO_L12P_T1_MRCC_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[16]}]
#set_property PACKAGE_PIN B16 [get_ports {IO_B[17]}]     ;# B23 / B16~IO_L7P_T1_AD2P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[17]}]
#set_property PACKAGE_PIN D14 [get_ports {IO_B[18]}]     ;# B24 / D14~IO_L1P_T0_AD0P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[18]}]
#set_property PACKAGE_PIN D12 [get_ports {IO_B[19]}]     ;# B25 / D12~IO_L6P_T0_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[19]}]
#set_property PACKAGE_PIN A15 [get_ports {IO_B[20]}]     ;# B26 / A15~IO_L8P_T1_AD10P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[20]}]
#set_property PACKAGE_PIN B13 [get_ports {IO_B[21]}]     ;# B27 / B13~IO_L2P_T0_AD8P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[21]}]
#set_property PACKAGE_PIN C12 [get_ports {IO_B[22]}]     ;# B28 / C12~IO_L3P_T0_DQS_AD1P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[22]}]
#set_property PACKAGE_PIN A13 [get_ports {IO_B[23]}]     ;# B29 / A13~IO_L9P_T1_DQS_AD3P_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[23]}]
#set_property PACKAGE_PIN A11 [get_ports {IO_B[24]}]     ;# B30 / A11~IO_L4N_T0_15
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_B[24]}]

#set_property PACKAGE_PIN N4 [get_ports {IO_C[17]}]      ;# C23 / N4~IO_L16N_T2_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[17]}]
#set_property PACKAGE_PIN M4 [get_ports {IO_C[18]}]      ;# C24 / M4~IO_L16P_T2_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[18]}]
#set_property PACKAGE_PIN M3 [get_ports {IO_C[19]}]      ;# C25 / M3~IO_L4P_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[19]}]
#set_property PACKAGE_PIN M2 [get_ports {IO_C[20]}]      ;# C26 / M2~IO_L4N_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[20]}]
#set_property PACKAGE_PIN K5 [get_ports {IO_C[21]}]      ;# C27 / K5~IO_L5P_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[21]}]
#set_property PACKAGE_PIN L4 [get_ports {IO_C[22]}]      ;# C28 / L4~IO_L5N_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[22]}]
#set_property PACKAGE_PIN L3 [get_ports {IO_C[23]}]      ;# C29 / L3~IO_L2N_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[23]}]
#set_property PACKAGE_PIN K3 [get_ports {IO_C[24]}]      ;# C30 / K3~IO_L2P_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_C[24]}]

#set_property PACKAGE_PIN V9 [get_ports {IO_D[0]}]       ;# D3 / V9~IO_L21N_T3_DQS_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[0]}]
#set_property PACKAGE_PIN V7 [get_ports {IO_D[1]}]       ;# D4 / V7~IO_L20P_T3_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[1]}]
#set_property PACKAGE_PIN V6 [get_ports {IO_D[2]}]       ;# D5 / V6~IO_L20N_T3_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[2]}]
#set_property PACKAGE_PIN V5 [get_ports {IO_D[3]}]       ;# D6 / V5~IO_L10P_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[3]}]
#set_property PACKAGE_PIN V4 [get_ports {IO_D[4]}]       ;# D7 / V4~IO_L10N_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[4]}]
#set_property PACKAGE_PIN T5 [get_ports {IO_D[5]}]       ;# D8 / T5~IO_L12P_T1_MRCC_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[5]}]
#set_property PACKAGE_PIN T4 [get_ports {IO_D[6]}]       ;# D9 / T4~IO_L12N_T1_MRCC_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[6]}]
#set_property PACKAGE_PIN U4 [get_ports {IO_D[7]}]       ;# D10 / U4~IO_L8P_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[7]}]
#set_property PACKAGE_PIN U3 [get_ports {IO_D[8]}]       ;# D11 / U3~IO_L8N_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[8]}]
#set_property PACKAGE_PIN V1 [get_ports {IO_D[9]}]       ;# D12 / V1~IO_L7N_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[9]}]
#set_property PACKAGE_PIN U1 [get_ports {IO_D[10]}]      ;# D13 / U1~IO_L7P_T1_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[10]}]
#set_property PACKAGE_PIN T3 [get_ports {IO_D[11]}]      ;# D14 / T3~IO_L11N_T1_SRCC_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[11]}]
#set_property PACKAGE_PIN R3 [get_ports {IO_D[12]}]      ;# D15 / R3~IO_L11P_T1_SRCC_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[12]}]
#set_property PACKAGE_PIN N1 [get_ports {IO_D[22]}]      ;# D28 / N1~IO_L3N_T0_DQS_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[22]}]
#set_property PACKAGE_PIN M1 [get_ports {IO_D[23]}]      ;# D29 / M1~IO_L1N_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[23]}]
#set_property PACKAGE_PIN L1 [get_ports {IO_D[24]}]      ;# D30 / L1~IO_L1P_T0_34
#set_property IOSTANDARD LVCMOS33 [get_ports {IO_D[24]}]

