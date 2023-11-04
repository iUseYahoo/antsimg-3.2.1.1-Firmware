fileprodinfo=/tmp/productionwrite.inf
/usr/sbin/flash_eraseall /dev/mtd3
/usr/sbin/device write 1024 $fileprodinfo
