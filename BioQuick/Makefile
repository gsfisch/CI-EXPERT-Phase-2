# Project Name
PROJ ?= bioquick
TARGET ?=

# Directories
RTL_DIR = ./src/rtl
TB_DIR = ./src/tb
BUILD_DIR = ./.verilator

# Source Files
RTL_SRCS = $(wildcard $(RTL_DIR)/*.v) $(wildcard $(RTL_DIR)/*.sv)
TB_SRCS = $(wildcard $(TB_DIR)/*.v) $(wildcard $(TB_DIR)/*.sv)
CPP_TESTBENCH = $(wildcard $(TB_DIR)/*.cpp)

# Verilator settings
VERILATOR_FLAGS = --Mdir $(BUILD_DIR) --timing --timescale 1ns/1ps -I$(RTL_DIR)
LINT_FLAGS = $(VERILATOR_FLAGS) --lint-only #-Wall
BUILD_FLAGS = $(VERILATOR_FLAGS) --cc --trace --binary -j 0
# BUILD_FLAGS += --coverage
# BUILD_FLAGS += --debug -V


# Default Rule
all: run

files:
	@echo "Verilog sources: $(RTL_SRCS) $(TB_SRCS)"

lint:
	@echo "\n----- Linting Verilog files -----\n"
ifdef TARGET
	verilator $(LINT_FLAGS) $(RTL_DIR)/$(TARGET) $(TB_DIR)/tb_$(TARGET) --top tb_$(TARGET)
else
	verilator $(LINT_FLAGS) $(RTL_SRCS) $(TB_SRCS) --top tb_$(PROJ)
endif
	@echo "----- Successfull linting -----\n"

compile: lint
	@mkdir -p $(BUILD_DIR)
	@echo "\n----- Compiling Verilog files -----\n"
ifdef TARGET
	verilator $(BUILD_FLAGS) $(TB_DIR)/tb_$(TARGET) --top tb_$(TARGET)
else
	verilator $(BUILD_FLAGS) $(TB_DIR)/tb_$(PROJ) --top tb_$(PROJ)
endif
	@echo "----- Successfull compiling -----\n"

# Implement a skip compilation mechanism if no change is detected
run: compile
	@echo "\n----- Running simulation -----\n"
ifdef TARGET
	$(BUILD_DIR)/Vtb_$(TARGET)
else
	$(BUILD_DIR)/Vtb_$(PROJ)
endif
	@echo "----- Successfull simulation -----\n"

waveform:
	@echo "Opening waveform..."
	gtkwave .verilator/waveform.vcd &

clean:
	@echo "Cleaning up..."
	rm -rf $(BUILD_DIR) *.vcd coverage.dat

.PHONY: all lint compile run waveform clean