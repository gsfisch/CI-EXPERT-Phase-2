# Placement
check_physical_design -stage pre_place_opt
check_physical_constraints

set_pnet_options -partial {M7 M8}
set_auto_disable_drc -constant false

# place_opt
place_opt -area_recovery -effort low 

save_mw_cel -as ${TOP_MODULE_NAME}_place_opt

# psyn_opt
#psynopt -area_recovery -congestion

#save_mw_cel -as ${TOP_MODULE_NAME}_psyn 
