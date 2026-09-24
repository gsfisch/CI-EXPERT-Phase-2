# define design name rules
define_name_rules verilog -case_insensitive
report_name_rules verilog
change_names -rules verilog -hierarchy -verbose

# export files
write_verilog -no_core_filler_cells "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_final.v"

write_sdf "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_final.sdf"

write_sdc "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_final.sdc"

write_parasitics -format spef -output "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_final.spef"

# export gds
read_stream -format gds $STD_CELL_LIB_GDS

set_write_stream_options -output_pin text -output_net text -net_name_mag 0.05
write_stream -format gds "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_final.gds"
