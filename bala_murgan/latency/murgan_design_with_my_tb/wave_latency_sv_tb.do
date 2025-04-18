onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group port-a /top/DUT/clka
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_ena
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_wea
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_addra
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/i_dina
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/DUT/o_douta
add wave -noupdate -height 30 -expand -group port-b /top/DUT/clkb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_enb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_web
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_addrb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/i_dinb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/DUT/o_doutb
add wave -noupdate -radix unsigned -childformat {{{/top/DUT/D1/mem[15]} -radix unsigned} {{/top/DUT/D1/mem[14]} -radix unsigned} {{/top/DUT/D1/mem[13]} -radix unsigned} {{/top/DUT/D1/mem[12]} -radix unsigned} {{/top/DUT/D1/mem[11]} -radix unsigned} {{/top/DUT/D1/mem[10]} -radix unsigned} {{/top/DUT/D1/mem[9]} -radix unsigned} {{/top/DUT/D1/mem[8]} -radix unsigned} {{/top/DUT/D1/mem[7]} -radix unsigned} {{/top/DUT/D1/mem[6]} -radix unsigned} {{/top/DUT/D1/mem[5]} -radix unsigned} {{/top/DUT/D1/mem[4]} -radix unsigned} {{/top/DUT/D1/mem[3]} -radix unsigned} {{/top/DUT/D1/mem[2]} -radix unsigned} {{/top/DUT/D1/mem[1]} -radix unsigned} {{/top/DUT/D1/mem[0]} -radix unsigned}} -subitemconfig {{/top/DUT/D1/mem[15]} {-radix unsigned} {/top/DUT/D1/mem[14]} {-radix unsigned} {/top/DUT/D1/mem[13]} {-radix unsigned} {/top/DUT/D1/mem[12]} {-radix unsigned} {/top/DUT/D1/mem[11]} {-radix unsigned} {/top/DUT/D1/mem[10]} {-radix unsigned} {/top/DUT/D1/mem[9]} {-radix unsigned} {/top/DUT/D1/mem[8]} {-radix unsigned} {/top/DUT/D1/mem[7]} {-radix unsigned} {/top/DUT/D1/mem[6]} {-radix unsigned} {/top/DUT/D1/mem[5]} {-radix unsigned} {/top/DUT/D1/mem[4]} {-radix unsigned} {/top/DUT/D1/mem[3]} {-radix unsigned} {/top/DUT/D1/mem[2]} {-radix unsigned} {/top/DUT/D1/mem[1]} {-radix unsigned} {/top/DUT/D1/mem[0]} {-radix unsigned}} /top/DUT/D1/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110675 ns} 0}
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
WaveRestoreZoom {110498 ns} {110831 ns}
