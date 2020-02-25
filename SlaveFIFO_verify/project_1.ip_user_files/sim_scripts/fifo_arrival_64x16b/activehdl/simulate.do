onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+fifo_arrival_64x16b -L xil_defaultlib -L xpm -L fifo_generator_v13_2_4 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.fifo_arrival_64x16b xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {fifo_arrival_64x16b.udo}

run -all

endsim

quit -force
