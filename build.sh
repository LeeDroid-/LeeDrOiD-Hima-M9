#!/bin/bash

VER="LeeDrOiD-Hima-V4.0.0"

DATE_START=$(date +"%s")
export LOCALVERSION="-"`echo $VER`
export ARCH=arm64
export SUBARCH=arm64
export PATH=$PATH:/home/lee/toolchains/android-toolchain-eabi/bin
export CROSS_COMPILE=aarch64-linux-android-
export KBUILD_BUILD_USER=LeeDrOiD

make "leedroid_defconfig"

make -j4

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))

echo
if (( $(($DIFF / 60)) == 0 )); then
	echo "  Build completed in $(($DIFF % 60)) seconds."
elif (( $(($DIFF / 60)) == 1 )); then
	echo "  Build completed in $(($DIFF / 60)) minute and $(($DIFF % 60)) seconds."
else
	echo "  Build completed in $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds."
fi
echo "  Finish time: $(date +"%r")"
echo
#Kernel build END
#Find modules and kernel image then move to Output
find "$dir" -name "*.ko" -exec cp -v {} $dest \; -printf "Found .ko Module\n"
mv ~/Hima-M9/arch/arm64/boot/Image.gz "$dest"
