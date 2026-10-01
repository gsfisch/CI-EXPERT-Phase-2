onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_clk_s
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_clk_f
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_rst_s
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_rst_f
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_valid
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/i_ack
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/o_valid
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/o_ready
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/pass_count
add wave -noupdate -expand -group TB /tb_hds_pulse_sync/fail_count
add wave -noupdate -expand -group DUT -label i_clk_s /tb_hds_pulse_sync/dut/i_clk_s
add wave -noupdate -expand -group DUT -label i_clk_f /tb_hds_pulse_sync/dut/i_clk_f
add wave -noupdate -expand -group DUT -label i_rst_s /tb_hds_pulse_sync/dut/i_rst_s
add wave -noupdate -expand -group DUT -label i_rst_f /tb_hds_pulse_sync/dut/i_rst_f
add wave -noupdate -expand -group DUT -label i_valid /tb_hds_pulse_sync/dut/i_valid
add wave -noupdate -expand -group DUT -label i_ack /tb_hds_pulse_sync/dut/i_ack
add wave -noupdate -expand -group DUT -label o_valid /tb_hds_pulse_sync/dut/o_valid
add wave -noupdate -expand -group DUT -label o_ready /tb_hds_pulse_sync/dut/o_ready
add wave -noupdate -expand -group DUT -label pulse_mux /tb_hds_pulse_sync/dut/pulse_mux
add wave -noupdate -expand -group DUT -label pulse_mux_sync /tb_hds_pulse_sync/dut/pulse_mux_sync
add wave -noupdate -expand -group DUT -label pulse_mux_sync_ffd /tb_hds_pulse_sync/dut/pulse_mux_sync_ffd
add wave -noupdate -expand -group DUT -label pulse_back /tb_hds_pulse_sync/dut/pulse_back
add wave -noupdate -expand -group DUT -label pulse_passed_in_dest /tb_hds_pulse_sync/dut/pulse_passed_in_dest
add wave -noupdate -expand -group DUT -label ack_received /tb_hds_pulse_sync/dut/ack_received
add wave -noupdate -expand -group DUT -label busy /tb_hds_pulse_sync/dut/busy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6065000 ps} 0}
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
WaveRestoreZoom {5384980 ps} {6311320 ps}
