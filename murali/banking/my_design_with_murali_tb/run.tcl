rm -rf work/
vlog -sv -cover bcst -f run.f param.sv ram_pkg.sv top.sv 
vsim -gui -coverage -assertdebug -voptargs=+acc -onfinish stop work.top
run -all
coverage save -assert -directive -cvg -codeAll cov.ucdb
vcover report -html -output covhtmlreport -details -assert -directive -cvg -code bcefst -threshL 50 -threshH 90 cov.ucdb
google-chrome covhtmlreport/index.html &
quit
