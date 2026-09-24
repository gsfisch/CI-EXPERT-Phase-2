onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_sen_clk
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_rcv_clk
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_sen_rst_n
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_rcv_rst_n
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_sen_data
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_sen_valid
add wave -noupdate -expand -group TB /tb_hds_4_phase/o_sen_ready
add wave -noupdate -expand -group TB /tb_hds_4_phase/o_rcv_data
add wave -noupdate -expand -group TB /tb_hds_4_phase/o_rcv_valid
add wave -noupdate -expand -group TB /tb_hds_4_phase/i_rcv_ready
add wave -noupdate -expand -group TB /tb_hds_4_phase/pass_count
add wave -noupdate -expand -group TB /tb_hds_4_phase/fail_count
add wave -noupdate -group DUT /tb_hds_4_phase/dut/DATA_WIDTH
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_sen_rst_n
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_sen_clk
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_sen_data
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_sen_valid
add wave -noupdate -group DUT /tb_hds_4_phase/dut/o_sen_ready
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_rcv_rst_n
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_rcv_clk
add wave -noupdate -group DUT /tb_hds_4_phase/dut/o_rcv_data
add wave -noupdate -group DUT /tb_hds_4_phase/dut/o_rcv_valid
add wave -noupdate -group DUT /tb_hds_4_phase/dut/i_rcv_ready
add wave -noupdate -group DUT /tb_hds_4_phase/dut/req
add wave -noupdate -group DUT /tb_hds_4_phase/dut/ack
add wave -noupdate -group DUT /tb_hds_4_phase/dut/data
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/DATA_WIDTH
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/i_rst_n
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/i_clk
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/i_data
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/i_valid
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/o_ready
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/o_req
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/i_ack
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/o_data
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/req_src_d
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/req_src_q
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/data_src_d
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/data_src_q
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/ack_synced
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/CS
add wave -noupdate -group SENDER /tb_hds_4_phase/dut/sender/NS
add wave -noupdate -group RECEIVER -label DATA_WIDTH /tb_hds_4_phase/dut/receiver/DATA_WIDTH
add wave -noupdate -group RECEIVER -label i_clk /tb_hds_4_phase/dut/receiver/i_clk
add wave -noupdate -group RECEIVER -label i_rst_n /tb_hds_4_phase/dut/receiver/i_rst_n
add wave -noupdate -group RECEIVER -label i_req /tb_hds_4_phase/dut/receiver/i_req
add wave -noupdate -group RECEIVER -label i_ready /tb_hds_4_phase/dut/receiver/i_ready
add wave -noupdate -group RECEIVER -label i_data /tb_hds_4_phase/dut/receiver/i_data
add wave -noupdate -group RECEIVER -label o_valid /tb_hds_4_phase/dut/receiver/o_valid
add wave -noupdate -group RECEIVER -label o_ack /tb_hds_4_phase/dut/receiver/o_ack
add wave -noupdate -group RECEIVER -label o_data /tb_hds_4_phase/dut/receiver/o_data
add wave -noupdate -group RECEIVER -label ack_dst_d /tb_hds_4_phase/dut/receiver/ack_dst_d
add wave -noupdate -group RECEIVER -label ack_dst_q /tb_hds_4_phase/dut/receiver/ack_dst_q
add wave -noupdate -group RECEIVER -label req_synced /tb_hds_4_phase/dut/receiver/req_synced
add wave -noupdate -group RECEIVER -label data_valid /tb_hds_4_phase/dut/receiver/data_valid
add wave -noupdate -group RECEIVER -label output_ready /tb_hds_4_phase/dut/receiver/output_ready
add wave -noupdate -group RECEIVER -label data_d /tb_hds_4_phase/dut/receiver/data_d
add wave -noupdate -group RECEIVER -label data_q /tb_hds_4_phase/dut/receiver/data_q
add wave -noupdate -group RECEIVER -label CS /tb_hds_4_phase/dut/receiver/CS
add wave -noupdate -group RECEIVER -label NS /tb_hds_4_phase/dut/receiver/NS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {66000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 277
configure wave -valuecolwidth 164
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
WaveRestoreZoom {0 ps} {848340 ps}
