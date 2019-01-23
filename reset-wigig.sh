#!/bin/bash

sudo service NetworkManager stop
sudo ifconfig wlp2s0 down
sudo rmmod wil6210
sleep 5
sudo modprobe wil6210
sudo ifconfig wlp2s0 up

