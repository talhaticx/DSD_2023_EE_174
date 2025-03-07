vlog -sv */*.sv

vsim -voptargs=+acc work.lab_tb

add wave sim:/lab_tb/dut/*

run -all

quit
