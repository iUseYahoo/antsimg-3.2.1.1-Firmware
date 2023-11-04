modprobe ambad
/usr/local/bin/amba_debug -g 26 -d 0x1
modprobe ambarella_udc
modprobe g_ether
ifconfig usb0 192.168.11.33 up
echo device > /proc/ambarella/usbphy0

