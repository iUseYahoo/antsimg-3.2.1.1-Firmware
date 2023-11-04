/usr/local/bin/init.sh --na && modprobe mn34220pl
/usr/local/bin/test_tuning -a 0 &
/usr/local/bin/test_encode -A -i 1920x1080 --bitrate 1200000 -f 25 --enc-mode 4 --hdr-expo 2 --hdr-mode 1 -J --btype off  -K --btype off -X --bmaxsize 1920x1080 --bsize 1920x1080 --smaxsize 1920x1080 -Y --bmaxsize 640x360 --bsize 640x360 -B -m 640x360 --smaxsize 640x360
/usr/local/bin/rtsp_server &
/usr/local/bin/test_encode -A -h 1080p -e --bitrate 1200000


