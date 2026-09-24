########################################
#      LOAD AND ANALYZE DESIGN         #
#######################################
set_route_mode_options -zroute true

# Check for DRC violations
verify_zrt_route

# Check for LVS violations
verify_lvs -ignore_floating_port -ignore_min_area

# Check for constraint violations
report_constraints -all

########################################
#      CRITICAL AREA REDUCTION         #
########################################
spread_zrt_wires
widen_zrt_wires

# DRC & LVS
verify_zrt_route
verify_lvs

save_mw_cel -as ${TOP_MODULE_NAME}_chip_finish

##############################################
# FIXING ANTENNA RULE VIOLATIONS WITH DIODES  #
##############################################
source -echo -verbose $ANTENNA_RULE_FILE

report_antenna_rules	
verify_zrt_route
set_route_zrt_detail_options -insert_diodes_during_routing true \
-antenna_fixing_preference use_diodes \
-diode_libcell_names $ANTENNA_CELL

route_zrt_detail -incremental true

source -echo -verbose ./scripts/derive_pg.tcl

# DRC & LVS
verify_zrt_route
verify_lvs -ignore_floating_port -ignore_min_area

save_mw_cel -as ${TOP_MODULE_NAME}_antenna

########################################
# INSERT REDUNDANT VIAS                #
########################################
report_design_physical -route
insert_zrt_redundant_vias -list_only
insert_zrt_redundant_vias -effort medium
report_design_physical -route

# DRC & LVS
verify_zrt_route
verify_lvs -ignore_floating_port -ignore_min_area

# search and repair (for DRC violation)
set_route_zrt_detail_options -force_max_number_iterations true
route_opt -only_design_rule -incremental -effort high

# parasitic extraction
extract_rc -coupling_cap > extract_log
write_parasitics -format SPEF -output $SPEF_FILE 
write_sdf $SDF_FILE 
write_verilog $POST_LAYOUT_VER_NETLIST 


########################################
# INSERT STANDARD CELL FILLERS         #
########################################
insert_stdcell_filler -cell_with_metal $METAL_FILLER -connect_to_power $MW_POWER_NET -connect_to_ground $MW_GROUND_NET -between_std_cells_only
insert_stdcell_filler -cell_without_metal $FILLER -connect_to_power $MW_POWER_NET -connect_to_ground $MW_GROUND_NET -between_std_cells_only

# DRC & LVS
verify_zrt_route
verify_lvs -ignore_floating_port -ignore_min_area


########################################
#     INSERT METAL FILL                #
########################################
insert_metal_filler -routing_space 2 -timing_driven

source -echo -verbose ./scripts/derive_pg.tcl

# search and repair (for DRC violation)
set_route_zrt_detail_options -force_max_number_iterations true
route_opt -only_design_rule -incremental -effort high

########################################
#            FINAL DESIGN CHECKS       #
########################################
verify_zrt_route
verify_lvs -ignore_floating_port -ignore_min_area

########################################
#       SAVE DESIGN AND STREAM OUT     #
########################################
save_mw_cel -as ${TOP_MODULE_NAME}_metal_fill

# report file
report_timing -net -cap -path full_clock_expanded -input > $ICC_MAX_TIMING_RPT 
report_timing -delay min > $ICC_MIN_TIMING_RPT
report_qor > $ICC_QOR_RPT
report_constraint -all > $ICC_CONSTRAINTS_RPT
