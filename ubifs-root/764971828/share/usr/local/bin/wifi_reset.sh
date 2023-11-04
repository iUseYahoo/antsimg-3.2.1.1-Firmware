DEV=`ifconfig | grep mlan0 | awk '{print $1}' | wc -l`
#echo "dev=${DEV}"
if [ ${DEV} -eq 1 ]               
then                              
        echo "@@@ifconfig mlan0 down@@@"
        ifconfig mlan0 down                              
fi 

USB8801=`lsmod | awk '{print $1}' | grep usb8801 | wc -l`
if [ ${USB8801} -eq 1 ]
then
	echo "@@@rmmod usb8801@@@"
	rmmod usb8801
fi

MLAN=`lsmod | awk '{print $1}' | grep mlan | wc -l`
if [ ${MLAN} -eq 1 ]
then
	echo "@@@rmmod mlan@@@"
	rmmod mlan
fi

echo host > /proc/ambarella/usbphy0
modprobe mlan
modprobe usb8801
sleep 2
ifconfig mlan0 up
/usr/sbin/set_mac /tmp/productionread.inf

echo "######## set wifi wmm #######" 
/lib/firmware/mrvl/mlanutl mlan0 wmmparamcfg 0 2 3 2 150  1 2 3 2 150  2 2 3 2 150  3 2 3 2 150
/lib/firmware/mrvl/mlanutl mlan0 macctrl 0x13
/lib/firmware/mrvl/mlanutl mlan0 psmode 0

echo "######## set wifi countrycode ########"
/lib/firmware/mrvl/mlanutl mlan0 countrycode CN	

