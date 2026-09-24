onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /tb_top/i_clk_a
add wave -noupdate -group TB /tb_top/i_clk_b
add wave -noupdate -group TB /tb_top/i_rst_n_a
add wave -noupdate -group TB /tb_top/i_rst_n_b
add wave -noupdate -group TB /tb_top/i_sck
add wave -noupdate -group TB /tb_top/i_cpol
add wave -noupdate -group TB /tb_top/i_cpha
add wave -noupdate -group TB /tb_top/i_bit_order
add wave -noupdate -group TB /tb_top/i_ss
add wave -noupdate -group TB /tb_top/i_mosi
add wave -noupdate -group TB /tb_top/o_miso
add wave -noupdate -group TB /tb_top/o_spi_busy
add wave -noupdate -group TB /tb_top/i_PREADY
add wave -noupdate -group TB /tb_top/i_PSLVERR
add wave -noupdate -group TB /tb_top/i_PRDATA
add wave -noupdate -group TB /tb_top/o_PWRITE
add wave -noupdate -group TB /tb_top/o_PSEL0
add wave -noupdate -group TB /tb_top/o_PADDR
add wave -noupdate -group TB /tb_top/o_PWDATA
add wave -noupdate -group SPI /tb_top/dut/SPI/DATA_WIDTH
add wave -noupdate -group SPI /tb_top/dut/SPI/i_clk
add wave -noupdate -group SPI /tb_top/dut/SPI/i_rst_n
add wave -noupdate -group SPI /tb_top/dut/SPI/i_data
add wave -noupdate -group SPI /tb_top/dut/SPI/o_data
add wave -noupdate -group SPI /tb_top/dut/SPI/i_sck
add wave -noupdate -group SPI /tb_top/dut/SPI/i_cpol
add wave -noupdate -group SPI /tb_top/dut/SPI/i_cpha
add wave -noupdate -group SPI /tb_top/dut/SPI/i_bit_order
add wave -noupdate -group SPI /tb_top/dut/SPI/i_ss
add wave -noupdate -group SPI /tb_top/dut/SPI/i_mosi
add wave -noupdate -group SPI /tb_top/dut/SPI/o_miso
add wave -noupdate -group SPI /tb_top/dut/SPI/o_spi_busy
add wave -noupdate -group SPI /tb_top/dut/SPI/o_crc_error
add wave -noupdate -group SPI /tb_top/dut/SPI/o_ss
add wave -noupdate -group SPI /tb_top/dut/SPI/i_sen_ready
add wave -noupdate -group SPI /tb_top/dut/SPI/i_rcv_valid
add wave -noupdate -group SPI /tb_top/dut/SPI/o_rcv_ready
add wave -noupdate -group SPI /tb_top/dut/SPI/o_sen_valid
add wave -noupdate -group APB /tb_top/dut/APB/APB_DATA
add wave -noupdate -group APB /tb_top/dut/APB/DATA_WIDTH
add wave -noupdate -group APB /tb_top/dut/APB/i_clk
add wave -noupdate -group APB /tb_top/dut/APB/i_rst_n
add wave -noupdate -group APB /tb_top/dut/APB/i_data
add wave -noupdate -group APB /tb_top/dut/APB/o_data
add wave -noupdate -group APB /tb_top/dut/APB/i_PREADY
add wave -noupdate -group APB /tb_top/dut/APB/i_PSLVERR
add wave -noupdate -group APB /tb_top/dut/APB/i_PRDATA
add wave -noupdate -group APB /tb_top/dut/APB/o_PWRITE
add wave -noupdate -group APB /tb_top/dut/APB/o_PSEL0
add wave -noupdate -group APB /tb_top/dut/APB/o_PADDR
add wave -noupdate -group APB /tb_top/dut/APB/o_PWDATA
add wave -noupdate -group APB /tb_top/dut/APB/i_crc_error
add wave -noupdate -group APB /tb_top/dut/APB/i_ss
add wave -noupdate -group APB /tb_top/dut/APB/i_sen_ready
add wave -noupdate -group APB /tb_top/dut/APB/i_rcv_valid
add wave -noupdate -group APB /tb_top/dut/APB/o_rcv_ready
add wave -noupdate -group APB /tb_top/dut/APB/o_sen_valid
add wave -noupdate -group ffd_sync_crc_error /tb_top/dut/ffd_sync_crc_error/i_clk
add wave -noupdate -group ffd_sync_crc_error /tb_top/dut/ffd_sync_crc_error/i_rst_n
add wave -noupdate -group ffd_sync_crc_error /tb_top/dut/ffd_sync_crc_error/i_data
add wave -noupdate -group ffd_sync_crc_error /tb_top/dut/ffd_sync_crc_error/o_data
add wave -noupdate -group ffd_sync_crc_error /tb_top/dut/ffd_sync_crc_error/sync
add wave -noupdate -group ffd_sync_ss_spi /tb_top/dut/ffd_sync_ss_spi/i_clk
add wave -noupdate -group ffd_sync_ss_spi /tb_top/dut/ffd_sync_ss_spi/i_rst_n
add wave -noupdate -group ffd_sync_ss_spi /tb_top/dut/ffd_sync_ss_spi/i_data
add wave -noupdate -group ffd_sync_ss_spi /tb_top/dut/ffd_sync_ss_spi/o_data
add wave -noupdate -group ffd_sync_ss_spi /tb_top/dut/ffd_sync_ss_spi/sync
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/DATA_WIDTH
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_sen_clk
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_sen_rst_n
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_sen_valid
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_sen_data
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/o_sen_ready
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_rcv_clk
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_rcv_rst_n
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/i_rcv_ready
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/o_rcv_valid
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/o_rcv_data
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/req
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/ack
add wave -noupdate -group hds_spi_apb /tb_top/dut/hds_spi_apb/data
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/DATA_WIDTH
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_sen_clk
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_sen_rst_n
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_sen_valid
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_sen_data
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/o_sen_ready
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_rcv_clk
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_rcv_rst_n
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/i_rcv_ready
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/o_rcv_valid
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/o_rcv_data
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/req
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/ack
add wave -noupdate -group hds_apb_spi /tb_top/dut/hds_apb_spi/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
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
WaveRestoreZoom {0 ps} {1119300 ps}
