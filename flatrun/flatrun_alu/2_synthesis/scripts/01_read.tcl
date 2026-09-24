# read in design
# do not put testbench in the list below
read_file $SOURCE_PATH  -autoread -recursive -top ${TOP_MODULE_NAME}

# build gtech design
current_design $TOP_MODULE_NAME
link
write -f ddc -hier -out  $PRE_LAYOUT_DIR/${TOP_MODULE_NAME}_unmapped.ddc
