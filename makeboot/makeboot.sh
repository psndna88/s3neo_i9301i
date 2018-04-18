#!/bin/bash

./mkbootimg --kernel zImage --ramdisk boot.img-ramdisk.gz --dt dt.img --cmdline "console=null androidboot.console=null androidboot.hardware=qcom user_debug=23" --base 00000000 --pagesize 2048 --ramdisk_offset 02000000 --kernel_offset 00008000 --second_offset 00f00000 --tags_offset 01e00000 --hash sha1 --output boot.img