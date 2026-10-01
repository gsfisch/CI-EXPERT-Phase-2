onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /tb_pulse_sync/CLK_S_PERIOD
add wave -noupdate -expand -group TB /tb_pulse_sync/CLK_F_PERIOD
add wave -noupdate -expand -group TB /tb_pulse_sync/i_clk_s
add wave -noupdate -expand -group TB /tb_pulse_sync/i_rst_s
add wave -noupdate -expand -group TB /tb_pulse_sync/i_clk_f
add wave -noupdate -expand -group TB /tb_pulse_sync/i_rst_f
add wave -noupdate -expand -group TB /tb_pulse_sync/i_data
add wave -noupdate -expand -group TB /tb_pulse_sync/o_data
add wave -noupdate -expand -group TB /tb_pulse_sync/pass_count
add wave -noupdate -expand -group TB /tb_pulse_sync/fail_count
add wave -noupdate -expand -group TB /tb_pulse_sync/monitor_cycles
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/i_clk_s
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/i_rst_s
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/i_clk_f
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/i_rst_f
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/i_data
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/o_data
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/pulse_mux
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/pulse_mux_sync
add wave -noupdate -expand -group DUT /tb_pulse_sync/dut/ffd
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {55000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 193
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
WaveRestoreZoom {909130 ps} {1152160 ps}
