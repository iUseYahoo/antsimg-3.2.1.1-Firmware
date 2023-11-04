echo host > /proc/ambarella/usbphy0
modprobe mlan
modprobe usb8801 cal_data_cfg=mrvl/WlanCalData_ext.conf

