vlog -sv -cover bcst -f run.f packages.sv interface.sv assertions.sv top_modules.sv
#vsim -voptargs=+acc dual_tbb
vsim -gui -coverage -assertdebug -voptargs=+acc -onfinish stop work.dual_tbb
run -all
coverage save -assert -directive -cvg -codeAll cov.ucdb
vcover report -html -output covhtmlreport -details -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 cov.ucdb
google-chrome covhtmlreport/index.html &
quit
