if {[file isdirectory work]} { vdel -all -lib work }

vlib work
vmap work work

set comp_files "../../src/rtl/spill_register.sv \
                ../../src/rtl/ffd_sync.sv \
                ../../src/rtl/hds_4_phase_sen.sv \
                ../../src/rtl/hds_4_phase_rcv.sv \
                ../../src/rtl/hds_4_phase.sv \
                ../../src/rtl/wrap_apb.sv \
                ../../src/rtl/wrap_spi.sv \
                ../../src/rtl/top.sv \
                ../../verification/tb_top.sv"

vlog -cover sbcefx -sv {*}$comp_files

vsim -coverage -voptargs=+acc -t 10ps work.tb_top

do wave.do

set StdArithNoWarnings 1
#set StdVitalGlitchNoWarnings 1

run -all

coverage save coverage
coverage report -output report.txt -srcfile=* -assert -directive -cvg -codeAll

