/usr/local/bin/init.sh --na && modprobe mn34220pl
/usr/local/bin/test_tuning -a 0 &
/usr/local/bin/test_encode -A -i 1920x1080 --bitrate 1200000 -f 25 --enc-mode 4 --hdr-expo 2 --hdr-mode 1 -J --btype off  -K --btype off -X --bmaxsize 1920x1080 --bsize 1920x1080 --smaxsize 1920x1080 -Y --bmaxsize 640x360 --bsize 640x360 -B -m 640x360 --smaxsize 640x360 --lens-warp 1 --max-padding-width 256
/usr/local/bin/rtsp_server &
/usr/local/bin/test_encode -A -h 1080p -e --bitrate 1200000
/usr/local/bin/test_warp -a0 -i 1632x1080 -s 148x0 -o 1920x1080 -S 0x0 -g 31x35 -f /etc/ldc/ldc_hor -p 2x1 -G 31x35 -F /etc/ldc/ldc_ver -P 2x1 --me1-grid 16x18 --me1-space 1x0 --me1-file /etc/ldc/ldc_me1_ver


