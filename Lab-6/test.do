vlog -sv */*.sv

vsim -voptargs=+acc work.lab6_tb

add wave sim:/lab6_tb/dut/*

run -all

quit
