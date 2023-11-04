#!/bin/sh
export PATH=\
/bin:\
/sbin:\
/usr/bin:\
/usr/sbin:\
/usr/local/bin:\
/usr/local/sbin:\
/home/unit_test

check_interrupt()
{

last_pixel=`cat /proc/interrupts |grep vin0_idsp_last_pixel | awk '{print $2}'`
vdsp=`cat /proc/interrupts | grep vdsp | awk '{print $2}'`

sleep 0.5
last_pixel2=`cat /proc/interrupts |grep vin0_idsp_last_pixel | awk '{print $2}'`
vdsp2=`cat /proc/interrupts | grep vdsp | awk '{print $2}'`


diff_last_pixel=$(($last_pixel2-$last_pixel))
diff_vdsp=$(($vdsp2-$vdsp))


p2=${diff_last_pixel#-}
p3=${diff_vdsp#-}

if [ $p2 -eq 0 ] || [ $p3 -eq 0 ]; then
		killall  dsplog_cap
		date > /home/ambarella/stop_date.txt
		dsplog_cap -m all -b all -l 3 -o /home/ambarella/dsplog_capture_after_hang.bin -p 5000000 &
		cat /proc/interrupts > /home/ambarella/interrupt.txt
		sleep 1
		cat /proc/interrupts >> /home/ambarella/interrupt.txt
		dmesg > /home/ambarella/dmesg.txt
		lsmod > /home/ambarella/lsmod.txt 
		amba_debug -r 0x80000 -s 0x20000 -f /home/ambarella/dsplog_ambadebug.bin
		amba_debug -w 0xec118000 -d 0x1000 && amba_debug -r 0xec110000 -s 0x120 > /home/ambarella/vin_register.txt 
        amba_debug -r 0xec160020 -s 0x20 > /home/ambarella/0xec160020_0x20.txt 
		amba_debug -r 0xec160200 -s 0x200 > /home/ambarella/0xec160200_0x200.txt 
        amba_debug -r 0xec150028 -s 0x20 > /home/ambarella/0xec150028_0x20.txt 
		amba_debug -r 0xec101c00 -s 0x80 > /home/ambarella/0xec101c00_0x80.txt	
		cat /proc/ambarella/iav > /home/ambarella/iav.txt
		cat /proc/ambarella/clock > /home/ambarella/clock.txt
		cat /proc/meminfo > /home/ambarella/meminfo.txt
		free > /home/ambarella/free.txt &
		top -d 1 > /home/ambarella/top.txt &
		lsmod > /home/ambarella/lsmod.txt 
		test_encode --show-a > /home/ambarella/test_encode_show_a.txt &
		load_ucode /lib/firmware/ > /home/ambarella/ucode.txt
		killall top
		killall  dsplog_cap
		echo "==================   DSP HANG ============================================"
		echo " DSP log binary by dsplog_cap is /home/ambarella/dsplog_capture_*****.bin "
		echo " All the debug info have been captured on the /home/ "
		echo " Please help to parse the /home/ambarella/dsplog_capture.bin in the follow command : "
		echo " dsplog_cap -i /home/ambarella/dsplog_capture.bin -f /home/ambarella/dsplog_capture.txt "
		echo " Then send us the /home/ambarella/dsplog_capture.txt and all the files on the /home "
		echo "==================   DSP HANG ============================================"
		sleep 2
		dsplog_cap -i /home/ambarella/dsplog_capture_before_hang.bin.1 -f /home/ambarella/dsplog_capture_before_hang.1.txt
		dsplog_cap -i /home/ambarella/dsplog_capture_before_hang.bin.2 -f /home/ambarella/dsplog_capture_before_hang.2.txt
		dsplog_cap -i /home/ambarella/dsplog_capture_after_hang.bin.1 -f /home/ambarella/dsplog_capture_after_hang.1.txt
		dsplog_cap -i /home/ambarella/dsplog_ambadebug.bin -f /home/ambarella/dsplog_ambadebug.txt
		exit 1
fi
}
#_main
mkdir /home/ambarella
date > /home/ambarella/start_date.txt
dsplog_cap -m all -b all -l 3 -o /home/ambarella/dsplog_capture_before_hang.bin -p 10000000 &
while [ true ]
do
check_interrupt
done
