# antsimg-3.2.1.1-Firmware

## How to dump camera firmware
### YI Home Camera 2 (USA)


Step 1: Download the firmware here directly: http://download.us.xiaoyi.com/yifirmware/smarthomecam/2.1.1_20171024151200home or via their site https://yitechnology.com/firmware/ and downloading the YI Home Camera 2 USA version of the firmware

Note: When I downloaded mine I named it `yihomecam` for simplicity.

Step 2: You'll need to have binwalk, python.
To install binwalk type in your terminal: `sudo apt-get install -y binwalk`

To install python type: `sudo apt-get install -y python3-pip`

After python is installed you'll need to install a tool to unpack the ubi image firmware that we get later, run this: `pip install python-lzo ubi_reader`

Now lets dump the firmware with binwalk: `sudo binwalk -e <firmware you downloaded> --run-as=root`

Now we have a folder named `_<firmware>`, so lets `cd` into it with `cd <firmware>`

Now that we are in the dumped firmware's folder we see it has a `200.ubi` file image, this is where the python tool comes into play, lets run `ubireader_extract_files 200.ubi`. That will give us a new folder in here called `ubifs-root/`, note that some files are unaccessable so trying to upload it someone or turn this dump into a zip you'll need to figure out a way to do so with those unaccessable files or just delete them.