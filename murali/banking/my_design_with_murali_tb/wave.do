onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/clka
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_wea
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_ena
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_addra
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_data_in_a
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/o_dout_a
add wave -noupdate /top/PORTA_RD_CHECK
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/clkb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_web
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_enb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_addrb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_data_in_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/o_dout_b
add wave -noupdate /top/PORTB_RD_CHECK
add wave -noupdate -height 30 -expand -group {port-a banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKA_1
add wave -noupdate -height 30 -expand -group {port-a banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKA_2
add wave -noupdate -height 30 -expand -group {port-a banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKA_3
add wave -noupdate -height 30 -expand -group {port-a banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKA_4
add wave -noupdate -height 30 -expand -group {port-b banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKB_1
add wave -noupdate -height 30 -expand -group {port-b banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKB_2
add wave -noupdate -height 30 -expand -group {port-b banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKB_3
add wave -noupdate -height 30 -expand -group {port-b banks} -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANKB_4
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_1/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_2/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_3/DP_RAM/mem
add wave -noupdate -radix unsigned /top/dut/MEMORY_BANKS_UNIT/BANK_4/DP_RAM/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 189
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {764421 ns} {765397 ns}
