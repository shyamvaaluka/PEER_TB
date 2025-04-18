onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/clka
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/i_wea
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/i_ena
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/i_addra
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/i_data_in_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/ERROR_CORRECTION/HAM_ENCODER/i_data_in_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/ERROR_CORRECTION/HAM_ENCODER/o_hamming_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/i_err_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/ERROR_CORRECTION/ERROR_INJECTOR/i_data_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/ERROR_CORRECTION/ERROR_INJECTOR/o_err_out_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/HAM_DECODER/i_data_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/HAM_DECODER/o_dout_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/o_dbit_err_a
add wave -noupdate -height 30 -expand -group {port-a } -radix unsigned /top/dut/o_dout_a
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/clkb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_web
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_enb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_addrb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_data_in_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/ERROR_CORRECTION/HAM_ENCODER/i_data_in_b
add wave -noupdate -height 30 -expand -group port-b -radix binary /top/dut/ERROR_CORRECTION/HAM_ENCODER/o_hamming_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_err_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/ERROR_CORRECTION/ERROR_INJECTOR/i_data_b
add wave -noupdate -height 30 -expand -group port-b -radix binary /top/dut/ERROR_CORRECTION/ERROR_INJECTOR/o_err_out_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/HAM_DECODER/i_data_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/HAM_DECODER/o_dout_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/o_dbit_err_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/o_dout_b
add wave -noupdate -radix unsigned -childformat {{{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[7]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[6]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[5]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[4]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[3]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[2]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[1]} -radix binary} {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[0]} -radix binary}} -expand -subitemconfig {{/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[7]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[6]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[5]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[4]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[3]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[2]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[1]} {-height 16 -radix binary} {/top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem[0]} {-height 16 -radix binary}} /top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_2/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_3/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_4/DP_RAM/mem
add wave -noupdate -radix unsigned -childformat {{{/ram_pkg::ram_ref::ref_mem[0]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[1]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[2]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[3]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[4]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[5]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[6]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[7]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[8]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[9]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[10]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[11]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[12]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[13]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[14]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[15]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[16]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[17]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[18]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[19]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[20]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[21]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[22]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[23]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[24]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[25]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[26]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[27]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[28]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[29]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[30]} -radix unsigned} {{/ram_pkg::ram_ref::ref_mem[31]} -radix unsigned}} -subitemconfig {{/ram_pkg::ram_ref::ref_mem[0]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[1]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[2]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[3]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[4]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[5]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[6]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[7]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[8]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[9]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[10]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[11]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[12]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[13]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[14]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[15]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[16]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[17]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[18]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[19]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[20]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[21]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[22]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[23]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[24]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[25]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[26]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[27]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[28]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[29]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[30]} {-height 16 -radix unsigned} {/ram_pkg::ram_ref::ref_mem[31]} {-height 16 -radix unsigned}} /ram_pkg::ram_ref::ref_mem
add wave -noupdate -radix unsigned -childformat {{{/top/clk[0]} -radix unsigned} {/top/intf0/en -radix unsigned} {/top/intf0/we -radix unsigned} {/top/intf0/error -radix unsigned} {/top/intf0/l_ref_dout -radix unsigned} {/top/intf0/dout -radix unsigned} {/param::R_LAT -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.count -radix unsigned -childformat {{/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.0 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.1 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.2 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.3 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.4 -radix unsigned}}}} -subitemconfig {{/top/clk[0]} {-height 16 -radix unsigned} /top/intf0/en {-height 16 -radix unsigned} /top/intf0/we {-height 16 -radix unsigned} /top/intf0/error {-height 16 -radix unsigned} /top/intf0/l_ref_dout {-height 16 -radix unsigned} /top/intf0/dout {-height 16 -radix unsigned} /param::R_LAT {-height 16 -radix unsigned} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.count {-height 16 -radix unsigned -childformat {{/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.0 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.1 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.2 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.3 -radix unsigned} {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.4 -radix unsigned}} -expand} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.0 {-height 16 -radix unsigned} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.1 {-height 16 -radix unsigned} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.2 {-height 16 -radix unsigned} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.3 {-height 16 -radix unsigned} /top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.4 {-height 16 -radix unsigned}} /top/PORTA_RD_CHECK
add wave -noupdate -radix unsigned /top/PORTB_RD_CHECK
add wave -noupdate /top/intf0/error
add wave -noupdate /top/intf1/error
add wave -noupdate -radix binary /top/dut/MEMORY_BANKS_UNIT/i_data_in_a
add wave -noupdate -radix binary /top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/i_din_a
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {330 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 404
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {313 ns} {403 ns}
