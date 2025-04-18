onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/clka
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_wea
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_ena
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_dina
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/i_addra
add wave -noupdate -height 30 -expand -group port-a -radix unsigned /top/dut/o_douta
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/clkb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_web
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_enb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_dinb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/i_addrb
add wave -noupdate -height 30 -expand -group port-b -radix unsigned /top/dut/o_doutb
add wave -noupdate -expand -subitemconfig {/top/PORTA_RD_CHECK/PORTA_RD_CHECK_THREAD_MONITOR.count -expand} /top/PORTA_RD_CHECK
add wave -noupdate -expand -subitemconfig {/top/PORTB_RD_CHECK/PORTB_RD_CHECK_THREAD_MONITOR.count -expand} /top/PORTB_RD_CHECK
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 212
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
WaveRestoreZoom {765798 ns} {766769 ns}
