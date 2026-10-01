vcs -f ./scripts/gate_list -R +v2k \
    -debug_acc+all +vpdfile+gate.vpd  \
    +notimingcheck +nospecify \
    +warn=noTFIPC \
    -l vcs_gate.log
