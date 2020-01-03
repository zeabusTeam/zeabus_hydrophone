onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_arrival_64x16b_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_arrival_64x16b.udo}

run -all

quit -force
