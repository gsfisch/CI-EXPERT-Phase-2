if {[file isdirectory work]} { vdel -all -lib work }

vlib work
vmap work work

set comp_files "../../src/rtl/spill_register.sv \
                ../../src/rtl/ffd_sync.sv \
                ../../src/rtl/hds_4_phase_sen.sv \
                ../../src/rtl/hds_4_phase_rcv.sv \
                ../../src/rtl/hds_4_phase.sv \
                ../../src/rtl/pulse_sync.sv \
                ../../src/tb/tb_hds_4_phase.sv"
                #../../src/tb/tb_ffd_sync.sv"
                #../../src/tb/tb_hds_4_phase.sv"
                #../../src/tb/tb_pulse_sync.sv"
                #../../src/tb/tb_reg_sync.sv"

vlog -cover sbcefx -sv {*}$comp_files

vsim -coverage -voptargs=+acc -t 10ps work.tb_hds_4_phase

#do wave_ffd.do
do wave_hds.do
#do wave_pulse.do
#do wave_reg.do

set StdArithNoWarnings 1
#set StdVitalGlitchNoWarnings 1

run -all

coverage save coverage
coverage report -output report.txt -srcfile=* -assert -directive -cvg -codeAll

