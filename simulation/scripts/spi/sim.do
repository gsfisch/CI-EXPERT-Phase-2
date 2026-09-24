if {[file isdirectory work]} { vdel -all -lib work }

vlib work
vmap work work

set comp_files "../../src/rtl/counter.sv \
                ../../src/rtl/comparator.sv \
                ../../src/rtl/crc.sv \
                ../../src/rtl/deserializer.sv \
                ../../src/rtl/serializer.sv \
                ../../src/tb/tb_counter.sv"
                #../../src/tb/tb_counter.sv"
                #../../src/tb/tb_comparator.sv"
                #../../src/tb/tb_crc.sv"
                #../../src/tb/tb_deserializer.sv"
                #../../src/tb/tb_spi_frontend.sv"

vlog -cover sbcefx -sv {*}$comp_files

vsim -coverage -voptargs=+acc -t 10ps work.tb_counter

do wave_counter.do
#do wave_comparator.do
#do wave_spi_front.do

set StdArithNoWarnings 1
#set StdVitalGlitchNoWarnings 1

run -all

coverage save coverage
coverage report -output report.txt -srcfile=* -assert -directive -cvg -codeAll

