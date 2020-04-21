onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mult_30b_18b_opt

do {wave.do}

view wave
view structure
view signals

do {mult_30b_18b.udo}

run -all

quit -force
