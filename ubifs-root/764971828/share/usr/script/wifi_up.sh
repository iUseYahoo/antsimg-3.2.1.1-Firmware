amba_debug -g 26 -d 0x0
echo host > /proc/ambarella/usbphy0
sleep 1
amba_debug -g 110 -d 0x0
sleep 1
amba_debug -g 53 -d 0x0
sleep 1
modprobe mlan
modprobe usb8801

