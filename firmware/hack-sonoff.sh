#!/bin/bash

sudo sleep 20 && \
sudo chmod -R 777 /dev/ttyUSB0 && \
sudo esptool --port /dev/ttyUSB0 --baud 115200 write_flash -fs 1MB -fm dout 0x0 hack.bin