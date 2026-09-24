# Derive Power Ground Connection
source ./scripts/derive_pg.tcl 
check_mv_design -power_nets

# Create Floorplan
create_floorplan -left_io2core 4.0 -bottom_io2core 4.0 -right_io2core 4.0 -top_io2core 4.0 -start_first_row -flip_first_row -core_utilization 0.7

# Derive Power Ground Connection
source ./scripts/derive_pg.tcl

# floorplan
create_fp_placement -timing_driven
remove_ideal_network [all_fanout -flat -clock_tree]
set_route_mode_options -zroute true
route_zrt_global -congestion_map_only true -effort low

# Save floorplan
save_mw_cel -as ${TOP_MODULE_NAME}_init_floorplan 

# PNS
source ./scripts/derive_pg.tcl
check_mv_design -power_nets

set_fp_rail_constraints -add_layer -layer M7 -direction horizontal -max_strap 2 -min_strap 0 -max_width 0.5 -min_width 0.160 -spacing minimum
set_fp_rail_constraints -add_layer -layer M8 -direction vertical -max_strap 2 -min_strap 0 -max_width 0.5 -min_width 0.160 -spacing minimum

set_fp_rail_constraints -set_ring -horizontal_ring_layer {M7} -vertical_ring_layer {M8} -ring_max_width 2 -ring_min_width 0.5 -extend_strap core_ring 

synthesize_fp_rail -nets {VDD VSS} -synthesize_power_plan -synthesize_power_pads -power_budget 300

commit_fp_rail

# Preroute pad and standard cell
#preroute_instances -select_net_by_type tieup_and_tiedown -primary_routing_layer specified -specified_horizontal_layer {M7} -specified_vertical_layer {M8}
#preroute_instances -select_net_by_type pg -primary_routing_layer specified -specified_horizontal_layer MRDL -specified_vertical_layer MRDL
#preroute_standard_cells -fill_empty_rows -remove_floating_pieces

# PNA
#analyze_fp_rail -nets {VDD VSS} -power_budget 1000 -read_pad_master_file ./pna_output/core.padmaster

# save
save_mw_cel -as ${TOP_MODULE_NAME}_pns
