#!/bin/bash

sudo iwlist wlp2s0 scan
sleep 5
sudo iwconfig wlp2s0 essid "demo60"
sleep 15
iwconfig wlp2s0
sudo ifconfig wlp2s0 192.168.0.2 netmask 255.255.255.0
