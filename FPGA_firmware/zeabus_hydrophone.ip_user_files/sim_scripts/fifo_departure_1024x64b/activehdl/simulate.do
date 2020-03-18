onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+fifo_departure_1024x64b -L xpm -L fifo_generator_v13_2_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.fifo_departure_1024x64b xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {fifo_departure_1024x64b.udo}

run -all

endsim

quit -force
