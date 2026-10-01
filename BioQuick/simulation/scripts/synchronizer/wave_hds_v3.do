onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB /tb_cdc_4phase/src_clk_i
add wave -noupdate -expand -group TB /tb_cdc_4phase/dst_clk_i
add wave -noupdate -expand -group TB /tb_cdc_4phase/src_rst_ni
add wave -noupdate -expand -group TB /tb_cdc_4phase/dst_rst_ni
add wave -noupdate -expand -group TB /tb_cdc_4phase/src_data_i
add wave -noupdate -expand -group TB /tb_cdc_4phase/src_valid_i
add wave -noupdate -expand -group TB /tb_cdc_4phase/src_ready_o
add wave -noupdate -expand -group TB /tb_cdc_4phase/dst_data_o
add wave -noupdate -expand -group TB /tb_cdc_4phase/dst_valid_o
add wave -noupdate -expand -group TB /tb_cdc_4phase/dst_ready_i
add wave -noupdate -expand -group TB /tb_cdc_4phase/pass_count
add wave -noupdate -expand -group TB /tb_cdc_4phase/fail_count
add wave -noupdate -group DUT /tb_cdc_4phase/dut/DECOUPLED
add wave -noupdate -group DUT /tb_cdc_4phase/dut/SEND_RESET_MSG
add wave -noupdate -group DUT /tb_cdc_4phase/dut/RESET_MSG
add wave -noupdate -group DUT /tb_cdc_4phase/dut/src_rst_ni
add wave -noupdate -group DUT /tb_cdc_4phase/dut/src_clk_i
add wave -noupdate -group DUT /tb_cdc_4phase/dut/src_data_i
add wave -noupdate -group DUT /tb_cdc_4phase/dut/src_valid_i
add wave -noupdate -group DUT /tb_cdc_4phase/dut/src_ready_o
add wave -noupdate -group DUT /tb_cdc_4phase/dut/dst_rst_ni
add wave -noupdate -group DUT /tb_cdc_4phase/dut/dst_clk_i
add wave -noupdate -group DUT /tb_cdc_4phase/dut/dst_data_o
add wave -noupdate -group DUT /tb_cdc_4phase/dut/dst_valid_o
add wave -noupdate -group DUT /tb_cdc_4phase/dut/dst_ready_i
add wave -noupdate -group DUT /tb_cdc_4phase/dut/async_req
add wave -noupdate -group DUT /tb_cdc_4phase/dut/async_ack
add wave -noupdate -group DUT /tb_cdc_4phase/dut/async_data
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/SYNC_STAGES
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/DECOUPLED
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/SEND_RESET_MSG
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/RESET_MSG
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/rst_ni
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/clk_i
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/data_i
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/valid_i
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/ready_o
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/async_req_o
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/async_ack_i
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/async_data_o
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/req_src_d
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/req_src_q
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/data_src_d
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/data_src_q
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/ack_synced
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/state_d
add wave -noupdate -group SRC /tb_cdc_4phase/dut/i_src/state_q
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/SYNC_STAGES
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/DECOUPLED
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/rst_ni
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/clk_i
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/data_o
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/valid_o
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/ready_i
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/async_req_i
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/async_ack_o
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/async_data_i
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/ack_dst_d
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/ack_dst_q
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/req_synced
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/data_valid
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/output_ready
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/state_d
add wave -noupdate -group DST /tb_cdc_4phase/dut/i_dst/state_q
add wave -noupdate -group {SPILL FLUSH} -label Bypass /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/Bypass
add wave -noupdate -group {SPILL FLUSH} -label clk_i /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/clk_i
add wave -noupdate -group {SPILL FLUSH} -label rst_ni /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/rst_ni
add wave -noupdate -group {SPILL FLUSH} -label flush_i /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/flush_i
add wave -noupdate -group {SPILL FLUSH} -label valid_i /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/valid_i
add wave -noupdate -group {SPILL FLUSH} -label ready_i /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/ready_i
add wave -noupdate -group {SPILL FLUSH} -label data_i /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/data_i
add wave -noupdate -group {SPILL FLUSH} -label valid_o /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/valid_o
add wave -noupdate -group {SPILL FLUSH} -label ready_o /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/ready_o
add wave -noupdate -group {SPILL FLUSH} -label data_o /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/data_o
add wave -noupdate -group {SPILL FLUSH} -label a_data_q /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/a_data_q
add wave -noupdate -group {SPILL FLUSH} -label a_fill /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/a_fill
add wave -noupdate -group {SPILL FLUSH} -label a_full_q /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/a_full_q
add wave -noupdate -group {SPILL FLUSH} -label a_drain /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/a_drain
add wave -noupdate -group {SPILL FLUSH} -label b_data_q /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/b_data_q
add wave -noupdate -group {SPILL FLUSH} -label b_fill /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/b_fill
add wave -noupdate -group {SPILL FLUSH} -label b_full_q /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/b_full_q
add wave -noupdate -group {SPILL FLUSH} -label b_drain /tb_cdc_4phase/dut/i_dst/gen_decoupled/i_spill_register/spill_register_flushable_i/gen_spill_reg/b_drain
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52020 ps} 0}
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
