onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/clka
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_ena
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_wea
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_addra
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_data_in_a
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/o_dout_a
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/clkb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_enb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_web
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_addrb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_data_in_b
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/o_dout_b
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w1
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w2
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w3
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w4
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w5
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w6
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w7
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w8
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w9
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w10
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w11
add wave -noupdate -group {Internal signals} -radix unsigned /top/DUT/w12
add wave -noupdate -height 20 -expand -group {memory-banks port-a} -radix unsigned /top/DUT/D1/BANKA_1
add wave -noupdate -height 20 -expand -group {memory-banks port-a} -radix unsigned /top/DUT/D1/BANKA_2
add wave -noupdate -height 20 -expand -group {memory-banks port-a} -radix unsigned /top/DUT/D1/BANKA_3
add wave -noupdate -height 20 -expand -group {memory-banks port-a} -radix unsigned /top/DUT/D1/BANKA_4
add wave -noupdate -height 20 -expand -group {memory banks port-b} -radix unsigned /top/DUT/D1/BANKB_1
add wave -noupdate -height 20 -expand -group {memory banks port-b} -radix unsigned /top/DUT/D1/BANKB_2
add wave -noupdate -height 20 -expand -group {memory banks port-b} -radix unsigned /top/DUT/D1/BANKB_3
add wave -noupdate -height 20 -expand -group {memory banks port-b} -radix unsigned /top/DUT/D1/BANKB_4
add wave -noupdate -height 20 -expand -group Memories -radix unsigned /top/DUT/D1/D1/D1/mem
add wave -noupdate -height 20 -expand -group Memories -radix unsigned /top/DUT/D1/D2/D1/mem
add wave -noupdate -height 20 -expand -group Memories -radix unsigned -childformat {{{/top/DUT/D1/D3/D1/mem[15]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[14]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[13]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[12]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[11]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[10]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[9]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[8]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[7]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[6]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[5]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[4]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[3]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[2]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[1]} -radix unsigned} {{/top/DUT/D1/D3/D1/mem[0]} -radix unsigned}} -subitemconfig {{/top/DUT/D1/D3/D1/mem[15]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[14]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[13]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[12]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[11]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[10]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[9]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[8]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[7]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[6]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[5]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[4]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[3]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[2]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[1]} {-radix unsigned} {/top/DUT/D1/D3/D1/mem[0]} {-radix unsigned}} /top/DUT/D1/D3/D1/mem
add wave -noupdate -height 20 -expand -group Memories -radix unsigned /top/DUT/D1/D4/D1/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1257469 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {1257259 ns} {1257671 ns}
