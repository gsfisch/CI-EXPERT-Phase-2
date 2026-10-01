# Design Constraints
set CLK_PORT  clk
set CLOCK_PERIOD 5
set CLOCK_UNCERTAINTY_SETUP 0.25
set CLOCK_UNCERTAINTY_HOLD  0.08
set CLOCK_LATENCY 0.25
set CLOCK_TRANSITION 0.13
set INPUT_DELAY 0.5
set OUTPUT_DELAY 0.25
set OUTPUT_LOAD [expr 30.0/1000]
set INPUT_TRANSITION 0.025

# BestCase & WorstCase Library Setup
set OC_MAX ss0p95v125c
set OC_MIN ff1p16vn40c
set OC_MAX_LIB saed32rvt_ss0p95v125c
set OC_MIN_LIB saed32rvt_ff1p16vn40c

# Apply Constraints
set ALL_IN_BUT_CLK [remove_from_collection [all_inputs] $CLK_PORT]
create_clock -period $CLOCK_PERIOD [get_port $CLK_PORT] -name MY_CLK 
set_clock_uncertainty -setup $CLOCK_UNCERTAINTY_SETUP MY_CLK
set_clock_uncertainty -hold  $CLOCK_UNCERTAINTY_HOLD  MY_CLK
set_clock_latency $CLOCK_LATENCY MY_CLK
set_clock_transition $CLOCK_TRANSITION MY_CLK

set_input_delay $INPUT_DELAY -clock MY_CLK $ALL_IN_BUT_CLK
set_output_delay $OUTPUT_DELAY -clock MY_CLK [all_outputs]

set_load $OUTPUT_LOAD [all_outputs]
set_input_transition $INPUT_TRANSITION  $ALL_IN_BUT_CLK

set_operating_condition -max $OC_MAX -max_lib $OC_MAX_LIB  -min $OC_MIN -min_lib $OC_MIN_LIB
