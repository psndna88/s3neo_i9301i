#!/bin/bash

export KERNELDIR=`readlink -f .`
export ARCH=arm
export CROSS_COMPILE=/home/psndna88/WORKING_DIRECTORY/UBERTC/arm-eabi-4.9/bin/arm-eabi-

cd $KERNELDIR/
if [ ! -d $KERNELDIR/output ];
	then
	mkdir $KERNELDIR/output
fi
if [ ! -f $KERNELDIR/.config ];
	then
	#make msm8226-sec_defconfig VARIANT_DEFCONFIG=msm8226-sec_s3ve3g_eur_defconfig SELINUX_DEFCONFIG=selinux_defconfig
	cp $KERNELDIR/arch/arm/configs/s3ve3geur_psndna88_defconfig $KERNELDIR/.config
fi
rm $KERNELDIR/arch/arm/boot/*.dtb
make -j4

mv $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/output/
mv $KERNELDIR/drivers/scsi/scsi_wait_scan.ko $KERNELDIR/output/
mv $KERNELDIR/drivers/staging/prima/wlan.ko $KERNELDIR/output/pronto_wlan.ko
/home/psndna88/WORKING_DIRECTORY/UBERTC/arm-eabi-4.9/bin/arm-eabi-strip --strip-unneeded $KERNELDIR/output/*.ko

$KERNELDIR/tools/dtbtool -o $KERNELDIR/output/dt.img -s 2048 -p $KERNELDIR/scripts/dtc/ $KERNELDIR/arch/arm/boot/