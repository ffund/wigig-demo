#!/bin/bash

# Backup
sudo cp /lib/firmware/wil6210.brd wil6210-old.brd
sudo cp /lib/firmware/wil6210.fw wil6210-old.fw

sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/wil6210.fw -O /lib/firmware/wil6210.fw
sudo wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/wil6210.brd -O /lib/firmware/wil6210.brd

