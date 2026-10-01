# Makefile converted from Bash script for running xrun simulation

# Get the directory of the Makefile
CURRENT_PATH := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

# Define RTL and TB paths relative to the Makefile's parent directory
SRC_PATH := $(abspath $(CURRENT_PATH)/../src)
RTL_PATH := $(abspath $(CURRENT_PATH)/../src/rtl)
TB_PATH := $(abspath $(CURRENT_PATH)/../src/tb)

# Define HAL folders
HAL := $(abspath $(CURRENT_PATH)/hal)
HAL_RULES := $(abspath $(CURRENT_PATH)/hal_rules)

# Set seed (fixed value as in script)
SEED := 10

# Default top module name (can be overridden via command line)
TOP_MODULE ?= top

export CURRENT_PATH
export SRC_PATH
export RTL_PATH
export TB_PATH

# Default target
.PHONY: all linting sim

all:
	@echo "THIS: $(CURRENT_PATH)"
	@echo $(SRC_PATH)
	@echo $(RTL_PATH)
	@echo $(TB_PATH)
	@echo $(TOP_MODULE)

linting:
	@ echo 'Linting via HAL'
	module load xcelium && \
	xrun -hal -gui -halargs "+halprofile $(HAL)/prof.log" -rulefile $(HAL_RULES)/$(TOP_MODULE).def \
	-log_hal $(HAL)/hal.log -DESign_facts_file  $(HAL)/$(TOP_MODULE).design_facts -rules_checked \
	-lwdgen -access rwc -timescale 1ns/1ps -top $(TOP_MODULE) -sv -f file_list_sv.f

sim:
	@ echo 'Simulating via Xcelium'
	module load xcelium && \
	xrun -lwdgen -access rwc -svseed $(SEED) -coverage all -covoverwrite -timescale 1ns/1ps -top tb_$(TOP_MODULE) -sv -f file_list_sv.f




# REPO_ROOT=$(shell pwd)

# .PHONY: app

# OUTPUT=./app/output/
# #OUTPUT=./app/output_test_3/

# # .vhd TB file
# VHDL_TB_SOURCE=$(addprefix $(OUTPUT), accelerator_tb.vhd)

# # .vhd rtl files
# #VHDL_RTL_SOURCE=$(abspath ./app/output/accelerator_pkg.vhd) $(abspath ./app/output/register_bank.vhd)
# VHDL_RTL_SOURCE=$(addprefix $(OUTPUT), accelerator_pkg.vhd register_bank.vhd)

# # .ktreet expected_output file
# EXPE_OUT_SOURCE=$(addprefix $(OUTPUT), *_expected_output.ktreet)

# # .sv verif files
# SV_VERIF_OBJ_SOURCE=$(addprefix $(OUTPUT), accel_item.sv accel_base_seq.sv)
# SV_VERIF_SOURCE=$(addprefix $(OUTPUT), accel_if.sv accel_pkg.sv)
# #SV_VERIF_SOURCE=$(wildcard ./app/output/*.sv)

# # .c ref model file
# REF_MODEL_SOURCE=$(addprefix $(OUTPUT), ref_model.c)

# all: sim

# app:
# 	@ echo 'Creating the decision tree'
# 	cd app/ && \
# 	source venv/bin/activate && \
# 	cd converter/ && \
# 	python3.9 __main__.py

# copy: app
# 	@ echo 'Copying files from app/out'
# 	cp -f $(VHDL_RTL_SOURCE) rtl/vhdl/
# 	cp -f $(VHDL_TB_SOURCE) sim/
# 	cp -f $(EXPE_OUT_SOURCE) sim/output/
# 	cp -f $(SV_VERIF_OBJ_SOURCE) verif/objects/
# 	cp -f $(SV_VERIF_SOURCE) verif/
# 	cp -f $(REF_MODEL_SOURCE) app/DPI/

# sim: copy
# 	@ echo 'Simulating via Questa'
# 	cd sim/questa/ && \
# 	module load questasim && \
# 	rm -rf flex* && \
# 	vsim -c -do sim_batch.do

# verif: copy
# 	@ echo 'Verifying the design'
# 	cd verif/ && \
# 	module load xcelium && \
# 	./run.sh | tee logs.log

# genus: sim
# 	@ echo 'Simulating via Questa'
# 	cd synthesis/genus/ && \
# 	module load genus && \
# 	rm -rf genus.* && \
# 	genus -f ../scripts/run_logical_synthesis.tcl