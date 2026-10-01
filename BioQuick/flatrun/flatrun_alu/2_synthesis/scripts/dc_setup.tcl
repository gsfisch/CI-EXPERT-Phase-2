# library dir & path
set STD_LIB_PATH        "../inp_data/library/sclib/db_nldm"
set SOURCE_PATH         "../inp_data/source"

# search path for all files
set search_path         "$search_path . $STD_LIB_PATH $SOURCE_PATH"

# library settings
set synthetic_library   "dw_foundation.sldb"
set target_library      "saed32rvt_ss0p95v125c.db"
set link_library        "* $target_library $synthetic_library"

set_min_library -min_version saed32rvt_ff1p16vn40c.db saed32rvt_ss0p95v125c.db

# design setting
set TOP_MODULE_NAME TOP

# output dir
set PRE_LAYOUT_DIR	"../out_data/pre_layout"
set REPORT_DIR  	"../out_data/reports"
