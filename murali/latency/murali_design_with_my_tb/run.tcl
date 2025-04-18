#vlog -sv normal_dual_port_ram.v +cover
rm -rf work/
vlog -sv -cover bcst  package2.sv trans_pkg.sv package.sv  top.sv 
vsim -gui -coverage -assertdebug -voptargs=+acc -onfinish stop work.top +TEST0
#vsim -voptargs=+acc work.top
do wave_latency_sv_tb.do
run -all
coverage save -assert -directive -cvg -codeAll cov.ucdb
vcover report -html -output covhtmlreport -details -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 cov.ucdb
google-chrome covhtmlreport/index.html &
quit
