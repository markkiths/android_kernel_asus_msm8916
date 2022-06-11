#!/bin/bash
BUILD_START=$(date +"%s")

# Colours
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

# Kernel details
KERNEL_NAME="revolt"
VERSION="A11"
DATE=$(date +"%d-%m-%Y-%I-%M")
DEVICE="Z00L"
FINAL_ZIP=$KERNEL_NAME-$VERSION-$DATE-$DEVICE.zip
defconfig=Z00L_defconfig

# Dirs
KERNEL_DIR=$(pwd)
ANYKERNEL_DIR=$KERNEL_DIR/AnyKernel3
KERNEL_IMG=$KERNEL_DIR/arch/arm64/boot/Image.gz-dtb
UPLOAD_DIR=$KERNEL_DIR/$DEVICE

# Export
export ARCH=arm64
export CROSS_COMPILE=$KERNEL_DIR/aarch64-elf-gcc/bin/aarch64-elf-

# Toolchain Used: https://github.com/kdrag0n/aarch64-elf-gcc
## Functions ##
# Clone
# Toolchain
git clone https://github.com/kdrag0n/aarch64-elf-gcc

## Functions ##

# Make kernel
function make_kernel() {
  echo -e "$cyan***********************************************"
  echo -e "          Initializing defconfig          "
  echo -e "***********************************************$nocol"
  make $defconfig
  echo -e "$cyan***********************************************"
  echo -e "             Building kernel          "
  echo -e "***********************************************$nocol"
  make -j8
  if ! [ -a $KERNEL_IMG ];
  then
    echo -e "$red Kernel Compilation failed! Fix the errors! $nocol"
    exit 1
  fi
}

# Making zip
function make_zip() {
cp $KERNEL_IMG $ANYKERNEL_DIR
mkdir -p $UPLOAD_DIR
cd $ANYKERNEL_DIR
zip -r9 UPDATE-AnyKernel2.zip * -x README UPDATE-AnyKernel2.zip
mv $ANYKERNEL_DIR/UPDATE-AnyKernel2.zip $UPLOAD_DIR/$FINAL_ZIP
}

# Options
function options() {
echo -e "$cyan***********************************************"
  echo "          Compiling FireKernel kernel          "
  echo -e "***********************************************$nocol"
  echo -e " "
  echo -e " Select one of the following types of build : "
  echo -e " 1.Dirty"
  echo -e " 2.Clean"
  echo -n " Your choice : ? "
  read ch

  echo -e " Select if you want zip or just kernel : "
  echo -e " 1.Get flashable zip"
  echo -e " 2.Get kernel only"
  echo -n " Your choice : ? "
  read ziporkernel

case $ch in
  1) echo -e "$cyan***********************************************"
     echo -e "          	Dirty          "
     echo -e "***********************************************$nocol"
     make_kernel;;
  2) echo -e "$cyan***********************************************"
     echo -e "          	Clean          "
     echo -e "***********************************************$nocol"
     make clean
     make mrproper
     make_kernel;;
esac

if [ "$ziporkernel" = "1" ]; then
     echo -e "$cyan***********************************************"
     echo -e "     Making flashable zip        "
     echo -e "***********************************************$nocol"
     make_zip
else
     echo -e "$cyan***********************************************"
     echo -e "     Building Kernel only        "
     echo -e "***********************************************$nocol"
fi
}

# Clean Up
function cleanup(){
rm -rf $ANYKERNEL_DIR/Image.gz-dtb
}

options
cleanup
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
