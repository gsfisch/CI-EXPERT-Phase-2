# Library Creation, TLU+, verilog and DEF import
file delete -force $ICC_MW_LIB 

create_mw_lib $ICC_MW_LIB \
	-technology $TECH_FILE \
	-mw_reference_library $MW_SC_LIB \
	-open

set_tlu_plus_files \
	-max_tluplus $TLUP_MAX \
	-min_tluplus $TLUP_MIN \
	-tech2itf_map  $TLUP_MAP
check_tlu_plus_files

# read in design 
import_designs $PRE_LAYOUT_VER_NETLIST \
	-format verilog \
	-cel $TOP_MODULE_NAME  \
	-top $TOP_MODULE_NAME 
	
# check library
check_library
check_tlu_plus_files
list_libs

#save milkyway library
save_mw_cel -as ${TOP_MODULE_NAME}_initial

#read in constraint file
read_sdc $SDC_FILE 
