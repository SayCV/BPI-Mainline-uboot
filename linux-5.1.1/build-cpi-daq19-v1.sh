#!/bin/bash
nproc=$(cat /proc/cpuinfo | grep processor | wc -l )
echo nproc=$nproc
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-
export KBUILD_OUTPUT=output/cpi-all
mkdir -p $KBUILD_OUTPUT
make cpi_daq19_v1_defconfig
make -j$nproc dtbs
LOADADDR=0x40008000 make -j$nproc uImage
make -j$nproc modules
make -j$nproc INSTALL_MOD_PATH=out modules_install

#make headers_install
