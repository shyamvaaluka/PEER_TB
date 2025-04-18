rm -rf work/
vlog -sv param.sv top.sv
vsim work.top
run -all
