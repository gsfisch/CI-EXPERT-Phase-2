#! /bin/sh
set -e
INSTALL_PATH=$HOME/Documents

sudo apt-get install \
    git \
    help2man \
    perl \
    python3 \
    make \
    g++ \
    libfl2 \
    libfl-dev \
    zlib1g \
    zlib1g-dev \
    ccache \
    mold \
    libgoogle-perftools-dev \
    numactl \
    perl-doc \
    autoconf \
    flex \
    bison \
    gtkwave

mkdir -p $INSTALL_PATH
if [ ! -d $INSTALL_PATH/verilator ]
then
    git clone https://github.com/verilator/verilator $INSTALL_PATH/verilator
fi
cd $INSTALL_PATH/verilator

unset VERILATOR_ROOT
echo "====== Running autoconf ====="
autoconf
echo "====== Running configure ====="
./configure
echo "====== Running make ====="
make -j `nproc`
echo "====== Running make test ====="
make test # optional
echo "====== Running sudo make install ====="
sudo make install