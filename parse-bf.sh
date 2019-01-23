#!/bin/bash

BFPATH=sample-bf.txt

bf=$(cat $BFPATH)
sector=$(echo "$bf"| grep "Sectors"  | cut -d":" -f3 | awk '{print $1}')
sqi=$(echo "$bf" | grep "SQI"  | cut -d"=" -f2 | awk '{print $1}')
rssi=$(echo "$bf" | grep "RSSI"  | cut -d"=" -f2 | awk '{print $1}')
txmcs=$(echo "$bf" | grep "TxMCS"  | cut -d"=" -f2 | awk '{print $1}')
txtput=$(echo "$bf" | grep "TxTpt"  | cut -d"=" -f3 | awk '{print $1}')
goodrx=$(echo "$bf" | grep "Goodput" | cut -d":" -f2 | awk '{print $2}')
goodtx=$(echo "$bf" | grep "Goodput" | cut -d":" -f3 | awk '{print $1}')
echo "$sector,$sqi,$rssi,$txmcs,$txtput,$goodrx,$goodtx"
