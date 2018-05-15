#!/bin/bash

sudo sleep 20 && \
sudo chmod -R 777 /dev/ttyUSB0 && \
nodemcu-uploader --port /dev/ttyUSB0 terminal
