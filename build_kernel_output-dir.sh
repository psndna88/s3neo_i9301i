#!/bin/bash

export ARCH=arm
export CROSS_COMPILE=/home/psndna88/WORKING_DIRECTORY/UBERTC/arm-eabi-4.9/bin/arm-eabi-
#make -C $(pwd) O=output msm8226-sec_defconfig VARIANT_DEFCONFIG=msm8228-sec_atlantic3geur_defconfig SELINUX_DEFCONFIG=selinux_defconfig
if [ ! -d output ];
	then
	mkdir output
fi
if [ ! -f output/.config ];
	then
	#make -C $(pwd) O=output msm8226-sec_defconfig VARIANT_DEFCONFIG=msm8226-sec_s3ve3g_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig
	cp arch/arm/configs/s3ve3geur_psndna88_defconfig output/.config
fi
rm output/arch/arm/boot/*.dtb
make -j4 -C $(pwd) O=output

mv output/arch/arm/boot/zImage output/
mv output/drivers/scsi/scsi_wait_scan.ko output/
mv output/drivers/staging/prima/wlan.ko output/pronto_wlan.ko
/home/psndna88/WORKING_DIRECTORY/UBERTC/arm-eabi-4.9/bin/arm-eabi-strip --strip-unneeded *.ko

./tools/dtbtool -o output/dt.img -s 2048 -p output/scripts/dtc/ output/arch/arm/boot/