// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Sat Feb  1 16:18:27 2020
// Host        : DESKTOP-MDIICNE running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/akrap/Google/AUV/zeabus_hydrophone/FPGA_firmware/zeabus_hydrophone.srcs/sources_1/ip/c_counter_binary_0/c_counter_binary_0_sim_netlist.v
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
    SCLR,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 sclr_intf RST" *) (* x_interface_parameter = "XIL_INTERFACENAME sclr_intf, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) input SCLR;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [5:0]Q;

  wire CLK;
  wire [5:0]Q;
  wire SCLR;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
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
        .SCLR(SCLR),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule

(* C_AINIT_VAL = "0" *) (* C_CE_OVERRIDES_SYNC = "0" *) (* C_COUNT_BY = "1" *) 
(* C_COUNT_MODE = "0" *) (* C_COUNT_TO = "1" *) (* C_FB_LATENCY = "0" *) 
(* C_HAS_CE = "0" *) (* C_HAS_LOAD = "0" *) (* C_HAS_SCLR = "1" *) 
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
  wire SCLR;
  wire NLW_i_synth_THRESH0_UNCONNECTED;

  assign THRESH0 = \<const1> ;
  VCC VCC
       (.P(\<const1> ));
  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "1" *) 
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
        .SCLR(SCLR),
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
aYP/7KpkkThKre24R00wOFueajRcclbxQMw+VgtVH4xvGTOYmUT7WBn2kU0CWwQXRUEYRpi7D0qv
7r2DT4608uZ+USTfbl4nKcdH0WYoeZe3tP36GYdtNR1olYI2jwGwBHEXmgEyXKpKjn2U+Hm2NdxF
P4O6M3seaEGszAaJOTVHnpWH53eoVbarKt+3yh42WgDrAOUj5xYKFOiqwYFBgbkkt/MaTWXfFAFJ
PuR/eJTol3EAI0d4Y+FBXagaih8AowhqyhoGW1G/+lgR7rHtpjQcEXAGjjs4YWG6TlcIsUXu0jVY
FKI3/9aNjeLGETpgZENYw8iooCijRCdZyyuj2g==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Y+Q0z6V+GhJ/7MxAIMh1m8ibDvQvZfi9m2P0SipUWFyaycA50qU/5XE06xAx3obWvV5ITQyW1GsB
momErjeIVSvhsX21cHgnK3BuiqH0Ci4wfQRso9BV77Ddtonr/bjuSH4AVcQDJTi45ECSuJ7XrOZK
Ne5EXv8V0g6bmwC9Vh+lzq5B/VSi9QB+DNuljuRAL6XyLqeSXuMKJ7FFOGLwB75hMyhOVLINBjo5
iSvvCGzy2cP7GKomah3h0T1AOA7PUZ8OfjEr/3soa+e6BWTG3UXRP4YEbacqdoBgUuo4cWa7xk7o
y+DWNP9Z4NERe7D0foSdszFtkNRiGlvTT4Gq0A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 6480)
`pragma protect data_block
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
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
