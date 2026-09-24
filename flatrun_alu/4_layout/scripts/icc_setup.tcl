# top design name
set TOP_MODULE_NAME 	"TOP"

# data directory
set SOURCE_DIR  	"../inp_data/source"
set REPORT_DIR  	"../out_data/reports"
set PRE_LAYOUT_DIR	"../out_data/pre_layout"
set POST_LAYOUT_DIR	"../out_data/post_layout"
set SYN_TECH_DIR	"../inp_data/library/tech"
set STD_CELL_LIB_DIR	"../inp_data/library/sclib"

# File names
set ANTENNA_RULE_FILE	"$SYN_TECH_DIR/saed32nm_ant_1p9m.tcl"	

set PRE_LAYOUT_VER_NETLIST  "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.v"
set PRE_LAYOUT_DDC_NETLIST  "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.ddc"
set SDC_FILE                "$PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.sdc"

set POST_LAYOUT_VER_NETLIST "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.v"
set SPEF_FILE               "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.spef"
set SDF_FILE                "$POST_LAYOUT_DIR/${TOP_MODULE_NAME}_mapped.sdf"

# ICC reports
set ICC_MAX_TIMING_RPT   "$REPORT_DIR/icc_timing_max.rpt"
set ICC_MIN_TIMING_RPT   "$REPORT_DIR/icc_timing_min.rpt"
set ICC_QOR_RPT          "$REPORT_DIR/icc_qor.rpt"
set ICC_CONSTRAINTS_RPT  "$REPORT_DIR/icc_constraints.rpt"

# library path
set SC_LIB_PATH		"$STD_CELL_LIB_DIR/db_nldm"

# search path for all files
set search_path         "$search_path . $SC_LIB_PATH"

# library settings
set synthetic_library   "dw_foundation.sldb"
set target_library      "saed32rvt_ss0p95v125c.db"
set link_library	"* $target_library $synthetic_library"

set_min_library -min_version saed32rvt_ff1p16vn40c.db saed32rvt_ss0p95v125c.db

# milkyway reference libraries
set ICC_MW_LIB CORE.mw
set MW_SC_LIB 	"$STD_CELL_LIB_DIR/milkyway/saed32nm_rvt_1p9m"

set TECH_FILE	"$SYN_TECH_DIR/saed32nm_1p9m_mw.tf"
set TLUP_MAP	"$SYN_TECH_DIR/saed32nm_tf_itf_tluplus.map"
set TLUP_MAX	"$SYN_TECH_DIR/saed32nm_1p9m_Cmax.tluplus"
set TLUP_MIN	"$SYN_TECH_DIR/saed32nm_1p9m_Cmin.tluplus"

# power & ground nets
set MW_POWER_NET                  "VDD"
set MW_POWER_PORT                 "VDD"
set MW_GROUND_NET                 "VSS"
set MW_GROUND_PORT                "VSS"

set mw_logic1_net ${MW_POWER_NET}
set mw_logic0_net ${MW_GROUND_NET}

# cell name
set METAL_FILLER	"SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT"          ;# space separated list of filler cells 
set FILLER	   	"SHFILL1_RVT"         				
set ANTENNA_CELL	"ANTENNA"
set PAD_FILLER		"FILLER50 FILLER40 FILLER35 FILLER20 FILLER15 FILLER10 FILLER5 FILLER1"

# gds file
set STD_CELL_LIB_GDS	"$STD_CELL_LIB_DIR/gds/saed32nm_rvt_oa.gds"
