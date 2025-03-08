vlog -sv */*.sv

vsim -voptargs=+acc work.lab7_tb

add wave sim:/lab7_tb/dut/*

run -all

quit
