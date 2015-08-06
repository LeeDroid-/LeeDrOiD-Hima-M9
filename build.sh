#!/bin/bash

#Define Paths
dir=${HOME}/Hima-M9/
dest=${HOME}/Output/

#Kernel build START
VER="LeeDrOiD-Hima-V4"

DATE_START=$(date +"%s")
export LOCALVERSION="-"`echo $VER`
export KBUILD_BUILD_USER=LeeDrOiD
export ARCH=arm64
export CROSS_COMPILE=/home/lee/toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-

make "leedroid_defconfig"

make -j8

#in kernel folder
dtbTool -o dt.img -s 4096 -p scripts/dtc/ arch/arm/boot/dts/


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
mv dt.img ../Output/
cp arch/arm64/boot/Image ../Output/
