## README
This is the version 3 of Zeabus hydrophone system. The system is built around
an FPGA. The system takes the input from 4 hydrophones and performs signal 
conditioning and filtering before sending the outputs to the host computer via 
a USB high-speed connection. The basic specifications of the system are:
- Maximum input frequency is 45 kHz
- Minimum ADC sampling rate is 4.5 mega-sample per second (MSPS)
- Each sample has at least 14-bit resolution
- Utilizes "averaging" sampling mode to down-sampling to the appropriate rate
- Supports variable gain in pre-amplifier unit
- Maximum ADC input voltage is 2 Vp-p
- Supports variable trigger voltage.
- At least 32k samples/channel buffer length
- Perform online FIR filter with user-provided FIR table.
  - FIR filter is an odd-symetric filter (i.e., type1 linear-phase FIR)
  - Each coefficient is 2'complement 32-bit integer

## Concrete specification
ADC: AD9248BSTZ-65 (65 MSPS max)
FPGA: Xilinx Artix 7 XC7A15T (ZTEX FPGA v2.14a)
Clock Buffer: IDT-553S (1:4 Distribute)
OP-AMP: OPA2365 (Dual Op-Amp), OPA365 (Single Op-Amp) [May use -Q1 version for thougher devices]
Digital Potentiometer: MAX5413 (10k), MAX5414 (50k), MAX5415 (100k) (May use MAX5387 as alternative)
Transformer: ADT1-1WT+ (from Mini-Circuit) (for converting single-ended to differential signal)
