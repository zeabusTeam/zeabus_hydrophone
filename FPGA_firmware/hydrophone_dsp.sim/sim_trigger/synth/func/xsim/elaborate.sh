#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Jun 14 14:59:38 +07 2022
# SW Build 3064766 on Wed Nov 18 09:12:47 MST 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab -wto ec079b6cd65744dc85c8b52c13f319ce --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot hydrophone_trigger_tb_func_synth xil_defaultlib.hydrophone_trigger_tb xil_defaultlib.glbl -log elaborate.log"
xelab -wto ec079b6cd65744dc85c8b52c13f319ce --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L secureip --snapshot hydrophone_trigger_tb_func_synth xil_defaultlib.hydrophone_trigger_tb xil_defaultlib.glbl -log elaborate.log

