onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /tb_hds_pulse_sync/i_clk_a
add wave -noupdate -group TB /tb_hds_pulse_sync/i_clk_b
add wave -noupdate -group TB /tb_hds_pulse_sync/rstn
add wave -noupdate -group TB /tb_hds_pulse_sync/i_data
add wave -noupdate -group TB /tb_hds_pulse_sync/i_valid
add wave -noupdate -group TB /tb_hds_pulse_sync/o_busy
add wave -noupdate -group TB /tb_hds_pulse_sync/o_valid
add wave -noupdate -group TB /tb_hds_pulse_sync/o_data
add wave -noupdate -group TB /tb_hds_pulse_sync/expected
add wave -noupdate -group TB /tb_hds_pulse_sync/result
add wave -noupdate -group TB /tb_hds_pulse_sync/ref_data
add wave -noupdate -group TB /tb_hds_pulse_sync/i_count
add wave -noupdate -group TB /tb_hds_pulse_sync/o_count
add wave -noupdate -group TB /tb_hds_pulse_sync/error_count
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_clk_a
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_clk_b
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_rst_n_a
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_rst_n_b
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_valid
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/i_data
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/o_busy
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/o_valid
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/o_data
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/REQ
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/ACK
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/Sync_REQ
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/Sync_ACK
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/req_sync_0
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/ack_sync_0
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/data_sync
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/current_state
add wave -noupdate -expand -group DUT /tb_hds_pulse_sync/dut/next_state
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
WaveRestoreZoom {0 ps} {926340 ps}
