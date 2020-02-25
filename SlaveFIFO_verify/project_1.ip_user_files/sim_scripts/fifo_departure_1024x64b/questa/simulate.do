onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_departure_1024x64b_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_departure_1024x64b.udo}

run -all

quit -force
