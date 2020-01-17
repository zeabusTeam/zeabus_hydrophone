// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Jan 13 20:36:00 2020
// Host        : DESKTOP-MDIICNE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.srcs/sources_1/ip/c_counter_binary_0/c_counter_binary_0_sim_netlist.v
// Design      : c_counter_binary_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a15tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_counter_binary_0,c_counter_binary_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module c_counter_binary_0
   (CLK,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [5:0]Q;

  wire CLK;
  wire [5:0]Q;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "6" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "0" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_counter_binary_0_c_counter_binary_v12_0_13 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_SINIT = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_THRESH0 = "0" *) 
(* C_IMPLEMENTATION = "0" *) (* C_LATENCY = "1" *) (* C_LOAD_LOW = "0" *) 
(* C_RESTRICT_COUNT = "0" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_THRESH0_VALUE = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "6" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* ORIG_REF_NAME = "c_counter_binary_v12_0_13" *) (* downgradeipidentifiedwarnings = "yes" *) 
module c_counter_binary_0_c_counter_binary_v12_0_13
   (CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    UP,
    LOAD,
    L,
    THRESH0,
    Q);
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  input UP;
  input LOAD;
  input [5:0]L;
  output THRESH0;
  output [5:0]Q;

  wire \<const1> ;
  wire CLK;
  wire [5:0]Q;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "6" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_count_by = "1" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "0" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_counter_binary_0_c_counter_binary_v12_0_13_viv i_synth
       (.CE(1'b0),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_i_synth_THRESH0_UNCONNECTED),
        .UP(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
hkYW+OZm6k9gF5yAUfXGm/n8kfXYD6tjFQYha968Ws0SqrM/NNAjCrrtMG8kIqTbkipnmceefxNr
sB0PtSpUrw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NEPpD4CxNBVJLV3hg1agn83QnqiCz3YuR89MlVuNyQGERKVJ+uGolFDqHFzBKLQArFTiHBWivkzK
A2DQ42XdOxp30NKOgHjrjgmF+fZMjDs24rn3Ue1INLHwTS5RT84Kih7Jx/7R0dl03/COJq+33l9u
7l+ArdY7mLwqqI9iIjU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cfBwEwc95LpKuxDGqpON2gGac620iHNKrm/QNXYg3/OFA5ZQNdpdhRz4vCTQRVbOg7b1nIox6GR8
TD/cf0JW38RU0NuY+TR6CkFT19NCdy67gR6JTDdXifhr/zTKjOL5gvp0XjT9PSLwwPyDirNX4TMa
9y9X5pf4gEnt0dikHNgySZO+Qpr30MP7n6oAjuxowlf45cfmPqZthYPnIjBSCdQGBPfSF+kZ2F1N
XCDEja5xE4CQshPPodH5njadc6kj7/qp9C4PfKcyNtDug+qsws9UK25Z2IFc8vk6/15HlIkQHkXv
Wq0iHaPLidqh3035FinHyPD/FDnfGGa5Oa2qcg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QmjD3HAHcP+h0RsjR0iH8h2N6drNxei50nfQN9RC8HobMEaARq/6rKjZEhHXMSCStQeCMhyVKRmN
HM7ZrqMf3W0s/8U4QMqp3M1VuYXVjEe2PCIpvtRcMY3JngdSWOydG2dH6dDA16ehxinMKgIr0TjA
PXA+lfyX6yTs1FWrne/6ufrl6ZAPpNG7EDKQ2aHqSm8DEXT1BJYMblBfAjAajwaJmPEu1aDlQeNo
onryTiFJkKP92pcZLCCufZL8ZAJ5uMvZZxiZRsiLd0BnCfOe3rl9AON+q53U+iK11EvAkpIBT+Cc
VYb5NqVAVaqXbQrqo3+YHEW5ft3fM9kZnlFDew==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FkHW107swc8fPv4xOTlQJU6PWERObturlywl6rsGCswc/v367bmQ1Maze/8QdmUPjEYwhAcHKVMu
7U4o3CvYhmrDpYiUQdQQ0B7gAbMZbJ8MFY5jRxn7KYDk+Bi9Ov8092IdW1a51FPWEVPmF4Kn6z4E
DSqpQDL58qieEUnrU2Ltb4GLJc3NrWTLvnbvRtHUUuQWTMZTQ7WqX4iH2dZ/EICpbRjlAF50iMAS
YHuuFTRKXcIFQlKYRyeQV4nyaA5JGbb3RC3N/Q2IZjdSXqQ9EOpmdhttpxReCnsdJiD/pPCtf7ZN
d/TheLy1Va2FZR+p4MozZorVui5/FtcCwKy6aw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NgZm/7Jvy0UZQRVxBVxeZ/odxMd59IlnRFHjM+6Bof6o6u4Qy4u9MOoQ3Sr2paPuGq+B+5EhdcD8
a5WGiurBrPW0qF+L2CoUJsDqz0WonRehZECQynibSUlmctvvMyr790pwb+C78gtW47p8uALYdUCJ
NhcDkV8fE3jFdDEYmfQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TxQNdd2WOThZCBZEYNgXxai4jK9AqWD/GRadYnarEfzmLUfcNDUoG7DxVWHCdTVuW8i2qZpouT1H
FUHt76rzZk8vI2tFLfUbKyTaRqik1aYwOCp1ZdqbgqQEDhBRWJjGxcJuxZbSQ2z8IUgiJ0eT148+
nf9UmzvYS1jrIsN/a7K4EjyRNMk0V917y85rxdk7itlisaUw4Cm72z9slByFtALj6/077uPjcK9U
mbWm7PbXk8PT44eQeaJl990wlWvD5/8BZS6AHqjg8520Xs+jftSeB6aNqTiYxfp21FJqmexwo7cG
G3BH/DRHhP7ZIsXHqSaJJFo20Nx9VgpLuF5t2g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
j6wLwU3JMaoT/oeZwN1AaX+ihKwXyqDXFv5gKEMoUfdW4UnoK9bFrGYncHr09pzRiSA3E8jvD52X
DjE8Oo21meK7QF3dSI/FJvz1DXXnc+NCz/9LnSF8aWFfVnzHZDwwlx89aesnWRwqd/gmTcvpozdq
T6nkfz3zey9HTJvGAn3JCOkQSSDJcdD9UuYiWT3xFSMRE/+ithgMvBbsiRytJPo1kbBDnL6zLE2L
98k+3T8w+fw/70Q1ms7E5LvBOfzpE8yOUWyaGNMr+cSilHDgSlTOxburm8VIult/y6fK3cl1pOH7
glFWJkpCxq5roghBchwvpN6MIOtNQ9WCN0WHcg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bHrM45ZHOlI6W8Gp6culu3/09eZM7N8rS0MoqM05HI/0ISaogYZFcHWcPDLUt5GdYTszBogiK31G
eCSHsWloFjSpyOCaO0Iz1JtJjPJ5bpm2VBQKnJ7xsS8s9Etr90Ni1KAykDUe+z0S4ehsqMZ4XBDS
RMO23HEhhTOrpxcrKNemMOVNrPg4SOne3FNUlMKjPOR+0tB6PYfr2R3pF+BOj58ABVqF1cHid3lc
xtoGuH5G7eMlipMKcJrm4NCzxMVcA5qXCDJNVKbKt1iuYfsdDHQgAJbP8FqNzy5/th4NejB3WAnQ
0aIHrLBz1JGjHQ6v8tioUQDnGxUr1L6comnpdw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6176)
`pragma protect data_block
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
OPOu41vtehjVNr2qign0dZsJXQc=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
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

endmodule
`endif
