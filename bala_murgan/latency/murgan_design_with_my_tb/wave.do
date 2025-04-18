onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top/in0/clka
add wave -noupdate -radix unsigned /top/in0/clkb
add wave -noupdate -radix unsigned /top/in0/wea
add wave -noupdate -radix unsigned /top/in0/web
add wave -noupdate -radix unsigned /top/in0/ena
add wave -noupdate -radix unsigned /top/in0/enb
add wave -noupdate -radix unsigned /top/in0/dina
add wave -noupdate -radix unsigned /top/in0/dinb
add wave -noupdate -radix unsigned /top/in0/addra
add wave -noupdate -radix unsigned /top/in0/addrb
add wave -noupdate -radix unsigned /top/in0/douta
add wave -noupdate -radix unsigned /top/in0/doutb
add wave -noupdate -radix unsigned /top/in0/drv_porta/addra
add wave -noupdate -radix unsigned /top/in0/drv_porta/dina
add wave -noupdate -radix unsigned /top/in0/drv_porta/ena
add wave -noupdate -radix unsigned /top/in0/drv_porta/wea
add wave -noupdate -radix unsigned /top/in0/drv_porta/drv_porta_event
add wave -noupdate -radix unsigned /top/in0/mon_porta/douta
add wave -noupdate -radix unsigned /top/in0/mon_porta/addra
add wave -noupdate -radix unsigned /top/in0/mon_porta/dina
add wave -noupdate -radix unsigned /top/in0/mon_porta/ena
add wave -noupdate -radix unsigned /top/in0/mon_porta/wea
add wave -noupdate -radix unsigned /top/in0/mon_porta/mon_porta_event
add wave -noupdate -radix unsigned /top/in0/drv_portb/addrb
add wave -noupdate -radix unsigned /top/in0/drv_portb/dinb
add wave -noupdate -radix unsigned /top/in0/drv_portb/enb
add wave -noupdate -radix unsigned /top/in0/drv_portb/web
add wave -noupdate -radix unsigned /top/in0/drv_portb/drv_portb_event
add wave -noupdate -radix unsigned /top/in0/mon_portb/doutb
add wave -noupdate -radix unsigned /top/in0/mon_portb/addrb
add wave -noupdate -radix unsigned /top/in0/mon_portb/dinb
add wave -noupdate -radix unsigned /top/in0/mon_portb/enb
add wave -noupdate -radix unsigned /top/in0/mon_portb/web
add wave -noupdate /top/in0/mon_portb/mon_portb_event
add wave -noupdate -height 40 -expand -group {port-a dut} -radix unsigned /top/DUT/clka
add wave -noupdate -height 40 -expand -group {port-a dut} -color Yellow -radix unsigned /top/DUT/ena
add wave -noupdate -height 40 -expand -group {port-a dut} -color Orange -radix unsigned /top/DUT/wea
add wave -noupdate -height 40 -expand -group {port-a dut} -radix unsigned /top/DUT/dina
add wave -noupdate -height 40 -expand -group {port-a dut} -radix unsigned /top/DUT/addra
add wave -noupdate -height 40 -expand -group {port-a dut} -radix unsigned /top/DUT/douta
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/clkb
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/web
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/enb
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/dinb
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/addrb
add wave -noupdate -expand -group {port-b dut} -radix unsigned /top/DUT/doutb
add wave -noupdate -radix unsigned -childformat {{{/top/DUT/D1/mem[15]} -radix unsigned} {{/top/DUT/D1/mem[14]} -radix unsigned} {{/top/DUT/D1/mem[13]} -radix unsigned} {{/top/DUT/D1/mem[12]} -radix unsigned} {{/top/DUT/D1/mem[11]} -radix unsigned} {{/top/DUT/D1/mem[10]} -radix unsigned} {{/top/DUT/D1/mem[9]} -radix unsigned} {{/top/DUT/D1/mem[8]} -radix unsigned} {{/top/DUT/D1/mem[7]} -radix unsigned} {{/top/DUT/D1/mem[6]} -radix unsigned} {{/top/DUT/D1/mem[5]} -radix unsigned} {{/top/DUT/D1/mem[4]} -radix unsigned} {{/top/DUT/D1/mem[3]} -radix unsigned} {{/top/DUT/D1/mem[2]} -radix unsigned} {{/top/DUT/D1/mem[1]} -radix unsigned} {{/top/DUT/D1/mem[0]} -radix unsigned}} -expand -subitemconfig {{/top/DUT/D1/mem[15]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[14]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[13]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[12]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[11]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[10]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[9]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[8]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[7]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[6]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[5]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[4]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[3]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[2]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[1]} {-height 16 -radix unsigned} {/top/DUT/D1/mem[0]} {-height 16 -radix unsigned}} /top/DUT/D1/mem
add wave -noupdate -radix unsigned /top/DUT/D1/ena_rd
add wave -noupdate -radix unsigned /top/DUT/D1/rd_a
add wave -noupdate -radix unsigned /top/DUT/D1/addra_rd
add wave -noupdate -radix unsigned /top/DUT/D1/douta
add wave -noupdate -radix unsigned /top/DUT/D1/ena_wr
add wave -noupdate -radix unsigned /top/DUT/D1/we_a
add wave -noupdate -radix unsigned /top/DUT/D1/din_a
add wave -noupdate -radix unsigned /top/DUT/D1/addra_wr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {315 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
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
WaveRestoreZoom {223 ns} {367 ns}
