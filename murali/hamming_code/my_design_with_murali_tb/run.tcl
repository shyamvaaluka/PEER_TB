rm -rf work/
vlog ./rtl/4x1MUX.v +define+ECC+ERROR_INJECT                                     +cover 
vlog ./rtl/Controlling_Memory.v +define+ECC+ERROR_INJECT                         +cover 
vlog ./rtl/Decoder_enable_lines.v +define+ECC+ERROR_INJECT                       +cover 
vlog ./rtl/Demultiplexer1_address.v +define+ECC+ERROR_INJECT                     +cover 
vlog ./rtl/MEMORY_CONTROL_TOP.sv +define+ECC+ERROR_INJECT                        +cover 
vlog ./rtl/controller_interface.v +define+ECC+ERROR_INJECT                       +cover 
vlog ./rtl/demultiplexer_data.v +define+ECC+ERROR_INJECT                         +cover 
vlog -sv ./rtl/error_injector.sv +define+ECC+ERROR_INJECT                        +cover 
vlog -sv ./rtl/hamming.sv +define+ECC+ERROR_INJECT                               +cover 
vlog -sv ./rtl/hamming_dec.sv +define+ECC+ERROR_INJECT                           +cover 
vlog -sv ./rtl/hamming_top.sv +define+ECC+ERROR_INJECT                           +cover 
vlog -sv ./rtl/latency_module.sv +define+ECC+ERROR_INJECT                        +cover 
vlog -sv ./rtl/latency_ram_top.sv +define+ECC+ERROR_INJECT                       +cover 
vlog -sv ./rtl/modified_dual_mem.sv +define+ECC+ERROR_INJECT                     +cover 
vlog -sv ./rtl/sel_latency.sv +define+ECC+ERROR_INJECT                           +cover 
vlog -sv -cover bcst param.sv ram_pkg.sv top.sv +define+ECC +define+ERROR_INJECT
vsim -gui -coverage -assertdebug -voptargs=+acc -onfinish stop work.top
do exclusion.do
#vsim -voptargs=+acc work.top
do wave.do
run -all
coverage save -assert -directive -cvg -codeAll cov.ucdb
vcover report -html -output covhtmlreport -details -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 cov.ucdb
google-chrome covhtmlreport/index.html &
quit
