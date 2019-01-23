#!/bin/bash

sudo ifconfig wlp2s0 192.168.0.1
sudo wpa_supplicant -D nl80211 -c ap.conf -i wlp2s0
sleep 5
