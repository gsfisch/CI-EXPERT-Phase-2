# optimize design
set_fix_hold [all_clocks]
set_fix_multiple_port_nets -all -buffer_constants
set verilogout_no_tri true
compile_ultra

# generate reports
redirect -file "$REPORT_DIR/dc_constraints.rpt" {report_constraints -all}
redirect -file "$REPORT_DIR/dc_timing_max.rpt"  {report_timing -max 10}
redirect -file "$REPORT_DIR/dc_timing_min.rpt"  {report_timing -delay min -max 10}
redirect -file "$REPORT_DIR/dc_qor.rpt"         {report_qor}
redirect -file "$REPORT_DIR/dc_power.rpt"       {report_power}

# save design data
change_names -rule verilog -hier
write -f ddc -hier -out     "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.ddc"
write -f verilog -hier -out "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.v"
write_sdc                   "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.sdc"
