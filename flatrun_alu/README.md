# Tutorial
Tutorial Module		: ASIC Flatrun Design Flow (ALU Design without IO Pad)
Revision		: 2.0
Author			: Lim Yang Wei
Created Date		: 20 Oct 2017
Modified Date		: 04 Jul 2025

# Design Specification
Design Name		: ALU and Counter Design
Features Description	: (1) 8-bit ALU with Add, Subtract, Multiply Operation
                          (2) 8-bit Up Counter with Data Load Enable
HDL Used		: Verilog
Top Module Name		: TOP (Top Design)

# Library Information
Process	Design Kit	: SAED 32/28nm
Standard Cell Library	: SAED 32/28nm Generic Standard Cell RVT Library 
I/O Cell Library	: None

# Design Flow
Flow Name		: ASIC Flat Run Design Flow

# EDA Tools Used
1. RTL Simulation	 : Synopsys VCS
2. Synthesis		 : Synopsys Design Compiler
3. Gate-level Simulation : Synopsys VCS
4. Physical Design	 : Synopsys IC Compiler

# Directories
├── 1_rtl_sim			(RTL Simulation Directory)
│   ├── clean.sh
│   ├── dve_run.sh		(Run DVE after Simulation)
│   ├── scripts			(Scripts Directory)
│   │   ├── dve.tcl
│   │   └── src_list
│   └── vcs_run.sh		(Run VCS Simulation)
├── 2_synthesis			(Synthesis Directory)
│   ├── clean.csh
│   ├── dc_run.sh		(Run DC Synthesis Flow)
│   └── scripts			(Scripts Directory)
│       ├── 01_read.tcl
│       ├── 02_constraint.tcl
│       ├── 03_compile.tcl
│       ├── dc_setup.tcl
│       └── dc_top.tcl
├── 3_pre_gls			(Pre Layout Gate-level Simulation)
│   ├── clean.sh
│   ├── dve_run.sh		(Run DVE after Simulation)
│   ├── scripts			(Scripts Directory)
│   │   ├── dve.tcl
│   │   └── gate_list
│   └── vcs_run.sh		(Run VCS Simulation)
├── 4_layout			(Physical Design Directory)
│   ├── clean.sh
│   ├── icc_run.sh		(Run ICC Design Flow)
│   └── scripts			(Scripts Directory)
│       ├── 01-create_lib.tcl
│       ├── 02-floorplan.tcl
│       ├── 03-placement.tcl
│       ├── 04-cts.tcl
│       ├── 05-route.tcl
│       ├── 06-dfm.tcl
│       ├── 07-export.tcl
│       ├── derive_pg.tcl
│       ├── fixpad.tcl
│       ├── icc_setup.tcl
│       └── icc_top.tcl
├── README.md			(This README file)
├── inp_data			
│   ├── library			(Libraries)
│   │   ├── iolib		(I/O Library Data)
│   │   ├── sclib		(Std Cell Library Data)
│   │   └── tech		(APR Kit for Synopsys Tools)
│   ├── source			(Design Source Files)
│   │   ├── ADDER4.v
│   │   ├── COUNTER.v
│   │   ├── TOP.v
│   └── testbench		(Design Testbench Files for Simulation)
│       └── TEST_TOP.v
└── out_data
    ├── post_layout		(Post-Layout Data)
    ├── pre_layout		(Pre-Layout Data)
    └── reports			(Report Data)
