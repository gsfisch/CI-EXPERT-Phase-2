# Remove ideal networks, enable Zroute, and save design
#remove_ideal_network 
set_route_mode_options -zroute true
save_mw_cel -as ${TOP_MODULE_NAME}_pre_route 

# Route
check_legality
verify_pg_nets
preroute_standard_cells -remove_floating_pieces
preroute_instances -ignore_pads

#initial route
verify_pg_nets
set_propagated_clock [all_clocks]
route_opt -initial_route_only
route_zrt_group -all_clock_nets -reuse_existing_global_route true

source -echo -verbose ./scripts/derive_pg.tcl

save_mw_cel -as ${TOP_MODULE_NAME}_clock_opt_route

# route
#route_zrt_global -effort high 
#route_zrt_track
#route_zrt_detail -incremental true
route_opt -initial_route_only

source -echo -verbose ./scripts/derive_pg.tcl
verify_zrt_route
verify_lvs

save_mw_cel -as ${TOP_MODULE_NAME}_init_route

# incremental route
route_zrt_eco -open_net_driven true
route_opt -incremental -only_design_rule -effort high

source -echo -verbose ./scripts/derive_pg.tcl
verify_zrt_route
verify_lvs

save_mw_cel -as ${TOP_MODULE_NAME}_route_opt 
