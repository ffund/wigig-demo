# wigig-demo

Scripts and other materials for wil6210 Wigig demo

## Applications


To get `ping` with timestamp and in nice format:

```

sudo ping -i 0.25 192.168.0.1 | while read line; do echo `date +%s.%N` $line | awk -F '[ =]' '{print $1","$12}'; done | tee /tmp/ping.csv

```

To get `wil6210` data:

```
while true; do sudo ./parse-bf.sh sample-bf.txt ; sleep 0.25; done  | tee /tmp/bf.csv
```

Also generate a flow with `iperf3`.


