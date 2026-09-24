# Clock Tree Synthesis
check_physical_design -stage pre_clock_opt -display
set_delay_calculation_options -routed_clock arnoldi
check_clock_tree

remove_clock_uncertainty [all_clocks]
clock_opt -only_cts -no_clock_route

save_mw_cel -as ${TOP_MODULE_NAME}_clock_opt_cts

# Incremental CTS
set_fix_hold [all_clocks]
#set_max_area 0

extract_rc
clock_opt -only_psyn -area_recovery -no_clock_route

save_mw_cel -as ${TOP_MODULE_NAME}_clock_opt_psyn
