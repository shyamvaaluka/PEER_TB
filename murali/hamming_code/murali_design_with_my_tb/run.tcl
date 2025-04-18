#vlog -sv normal_dual_port_ram.v +cover
rm -rf work/
vlog -sv ./rtl/ecc.sv +define+ECC +define+ERROR_INJECT                +cover 
vlog -sv ./rtl/hamming_encoder.sv +define+ECC +define+ERROR_INJECT          +cover 
vlog -sv ./rtl/hamming_decoder.sv +define+ECC +define+ERROR_INJECT          +cover 
vlog -sv ./rtl/latency.sv +define+ECC +define+ERROR_INJECT            +cover 
vlog -sv ./rtl/dual_port_ram.sv +define+ECC +define+ERROR_INJECT      +cover 
vlog -sv ./rtl/address_decode.sv +define+ECC +define+ERROR_INJECT     +cover 
vlog -sv ./rtl/multi_bank.sv +define+ECC +define+ERROR_INJECT         +cover 
vlog -sv ./rtl/memory_controller.sv +define+ECC +define+ERROR_INJECT  +cover 
vlog -sv -cover bcst package2.sv trans_pkg.sv package.sv  top.sv +define+ECC +define+ERROR_INJECT
vsim -gui -coverage -assertdebug -voptargs=+acc -onfinish stop work.top +TEST0 
#vsim -voptargs=+acc work.top
do wave_memory_banks.do
run -all
coverage save -assert -directive -cvg -codeAll cov.ucdb
vcover report -html -output covhtmlreport -details -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 cov.ucdb
google-chrome covhtmlreport/index.html &
quit
