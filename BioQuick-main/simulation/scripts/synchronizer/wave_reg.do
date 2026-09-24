onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /tb_reg_sync/i_clk_s
add wave -noupdate -group TB /tb_reg_sync/i_clk_f
add wave -noupdate -group TB /tb_reg_sync/i_rst_s
add wave -noupdate -group TB /tb_reg_sync/i_rst_f
add wave -noupdate -group TB /tb_reg_sync/i_valid
add wave -noupdate -group TB /tb_reg_sync/i_data
add wave -noupdate -group TB /tb_reg_sync/o_valid
add wave -noupdate -group TB /tb_reg_sync/o_ready
add wave -noupdate -group TB /tb_reg_sync/o_data
add wave -noupdate -group TB /tb_reg_sync/pass_count
add wave -noupdate -group TB /tb_reg_sync/fail_count
add wave -noupdate -group DUT /tb_reg_sync/dut/i_clk_s
add wave -noupdate -group DUT /tb_reg_sync/dut/i_clk_f
add wave -noupdate -group DUT /tb_reg_sync/dut/i_rst_s
add wave -noupdate -group DUT /tb_reg_sync/dut/i_rst_f
add wave -noupdate -group DUT /tb_reg_sync/dut/i_valid
add wave -noupdate -group DUT /tb_reg_sync/dut/i_data
add wave -noupdate -group DUT /tb_reg_sync/dut/o_valid
add wave -noupdate -group DUT /tb_reg_sync/dut/o_ready
add wave -noupdate -group DUT /tb_reg_sync/dut/o_data
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/i_clk_s
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/i_rst_s
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/i_clk_f
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/i_rst_f
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/i_valid
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/o_valid
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/o_ready
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/pulse_mux
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/pulse_mux_sync
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/pulse_mux_sync_ffd
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/pulse_back
add wave -noupdate -expand -group HDS /tb_reg_sync/dut/hds_pulse_sync_inst/pulse_passed_in_dest
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47970 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
configure wave -valuecolwidth 290
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
WaveRestoreZoom {0 ps} {936040 ps}
