onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /tb_counter/UPTO
add wave -noupdate -group TB /tb_counter/CLK_PERIOD
add wave -noupdate -group TB /tb_counter/clk
add wave -noupdate -group TB /tb_counter/rst
add wave -noupdate -group TB /tb_counter/i_en
add wave -noupdate -group TB /tb_counter/o_done
add wave -noupdate -group TB /tb_counter/o_crc_en
add wave -noupdate -group TB /tb_counter/pass_count
add wave -noupdate -group TB /tb_counter/fail_count
add wave -noupdate -group DUT /tb_counter/dut/UPTO
add wave -noupdate -group DUT /tb_counter/dut/clk
add wave -noupdate -group DUT /tb_counter/dut/rst
add wave -noupdate -group DUT /tb_counter/dut/i_en
add wave -noupdate -group DUT /tb_counter/dut/o_done
add wave -noupdate -group DUT /tb_counter/dut/o_crc_en
add wave -noupdate -group DUT /tb_counter/dut/counter
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
WaveRestoreZoom {514110 ps} {515050 ps}
