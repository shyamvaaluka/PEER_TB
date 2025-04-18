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
add wave -noupdate -radix unsigned /top/in0/mon_portb/mon_portb_event
add wave -noupdate -radix unsigned /top/DUT/DATA_A
add wave -noupdate -radix unsigned /top/DUT/DATA_B
add wave -noupdate -radix unsigned /top/DUT/ADDR_A
add wave -noupdate -radix unsigned /top/DUT/ADDR_B
add wave -noupdate -radix unsigned /top/DUT/MEM_DEPTH
add wave -noupdate -radix unsigned /top/DUT/MEM_WIDTH
add wave -noupdate -radix unsigned /top/DUT/clka
add wave -noupdate -radix unsigned /top/DUT/clkb
add wave -noupdate -radix unsigned /top/DUT/wea
add wave -noupdate -radix unsigned /top/DUT/web
add wave -noupdate -radix unsigned /top/DUT/ena
add wave -noupdate -radix unsigned /top/DUT/enb
add wave -noupdate -radix unsigned /top/DUT/dina
add wave -noupdate -radix unsigned /top/DUT/dinb
add wave -noupdate -radix unsigned /top/DUT/addra
add wave -noupdate -radix unsigned /top/DUT/addrb
add wave -noupdate -radix unsigned /top/DUT/douta
add wave -noupdate -radix unsigned /top/DUT/doutb
add wave -noupdate -radix unsigned /top/DUT/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {1050 ns}
