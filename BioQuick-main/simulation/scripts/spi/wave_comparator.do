onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /tb_comparator/WIDTH
add wave -noupdate -group TB /tb_comparator/CLK_PERIOD
add wave -noupdate -group TB /tb_comparator/clk
add wave -noupdate -group TB /tb_comparator/i_recv
add wave -noupdate -group TB /tb_comparator/i_expc
add wave -noupdate -group TB /tb_comparator/o_eq
add wave -noupdate -group TB /tb_comparator/pass_count
add wave -noupdate -group TB /tb_comparator/fail_count
add wave -noupdate -expand -group DUT /tb_comparator/dut/WIDTH
add wave -noupdate -expand -group DUT /tb_comparator/dut/clk
add wave -noupdate -expand -group DUT /tb_comparator/dut/i_recv
add wave -noupdate -expand -group DUT /tb_comparator/dut/i_expc
add wave -noupdate -expand -group DUT /tb_comparator/dut/o_eq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 244
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
configure wave -timelineunits ps
update
WaveRestoreZoom {314050 ps} {314990 ps}
