#!/bin/bash

echo "THIS: $(dirname -- $(readlink -fn -- "$0"))"

export CURRENT_PATH=$(dirname -- $(readlink -fn -- "$0"))

export RTL_PATH="$(realpath $(pwd)/../src/rtl)"
echo $RTL_PATH

export TB_PATH="$(realpath $(pwd)/../src/tb)"
echo $TB_PATH

# seed=$(((RANDOM % 999999999 )  + 100000000))
seed=10

echo "Running seed: $seed"

xrun -hal -gui -lwdgen -access rwc \
  -timescale 1ns/1ps -sv -top hds_4_phase -f file_list_sv.f

# xrun -lwdgen -access rwc -svseed $seed -coverage all -covoverwrite \
#   -timescale 1ns/1ps -sv -top tb_hds_4_phase -f file_list_sv.f

