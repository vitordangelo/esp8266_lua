#!/bin/bash

sudo sleep 20 && \
echo "-->" && \
sleep 3 && \
sudo chmod -R 777 /dev/ttyUSB0 && \
sudo esptool --port /dev/ttyUSB0 read_flash 0 0x200000 exported.bin
