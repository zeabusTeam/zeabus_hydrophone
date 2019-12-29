onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_1024x64b_bram_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_1024x64b_bram.udo}

run -all

quit -force
