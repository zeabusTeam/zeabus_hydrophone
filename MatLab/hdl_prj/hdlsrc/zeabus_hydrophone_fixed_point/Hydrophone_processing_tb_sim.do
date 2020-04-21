onbreak resume
onerror resume
vsim -voptargs=+acc work.Hydrophone_processing_tb

add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/clk
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/reset
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/clk_enable
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ADC1_In
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ADC2_In
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ADC3_In
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ADC4_In
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Threshold
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Q_Carrier
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/I_Carrier
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ce_out_0
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/ce_out_1
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch1_I_Out
add wave sim:/Hydrophone_processing_tb/Ch1_I_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch1_Q_Out
add wave sim:/Hydrophone_processing_tb/Ch1_Q_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch2_I_Out
add wave sim:/Hydrophone_processing_tb/Ch2_I_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch2_Q_out
add wave sim:/Hydrophone_processing_tb/Ch2_Q_out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch3_I_Out
add wave sim:/Hydrophone_processing_tb/Ch3_I_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch3_Q_Out
add wave sim:/Hydrophone_processing_tb/Ch3_Q_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch4_I_Out
add wave sim:/Hydrophone_processing_tb/Ch4_I_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Ch4_Q_Out
add wave sim:/Hydrophone_processing_tb/Ch4_Q_Out_ref
add wave sim:/Hydrophone_processing_tb/u_Hydrophone_processing/Trigged
add wave sim:/Hydrophone_processing_tb/Trigged_ref
run -all
