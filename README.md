# wigig-demo

Scripts and other materials for wil6210 Wigig demo

## Set up link

To set up a link between the two hosts,

On wigig-1 (the AP), run

```
./reset-wigig.sh
```

then 

```
./start-ap-wigig.sh
```

The client (wigig-2) should connect automatically. If it doesn't, you can run

```
./reset-wigig.sh
```

on the client, then

```
sudo service NetworkManager start
```

and then use Network Manager to connect to the "demo60" network.

## Applications


To set up the demo, you'll run four applications on wigig-2 (client) and one on wigig-1 (AP).

On wigig-1 (AP), start an `iperf3` server:

```
iperf3 -s -i 5
```

On wigig-2 (client), you will run four applications - open a `terminator` window and split it into four parts, then `cd` to `~/Desktop/wigig-demo` in each.

Some additional setup is required on the client to access the `debugfs` to get the BF sector. On the client, run

```
sudo sysctl -w kernel.sysrq=1
```

Then press Alt+SysRq+x. In the system log (`sudo tail --lines=10 /var/log/syslog`), you should see

```
sysrq: SysRq: Disabling Secure Boot restrictions
Lifting lockdown
```

Now we are ready to start collecting data.

To get `ping` with timestamp and in nice format:

```

sudo ping -i 0.25 192.168.0.1 | while read line; do echo `date +%s.%N` $line | awk -F '[ =]' '{print $1","$12}'; done | tee /tmp/ping.csv

```

or, if the last column says `ms`, use this alternative:

```
sudo ping -i 0.25 192.168.0.1 | while read line; do echo `date +%s.%N` $line | awk -F '[ =]' '{print $1","$11}'; done | tee /tmp/ping.csv
```

To get `wil6210` data, first find the path to the `bf` file - it will be different each time the NIC is reset, because the PHY name is different. Then run a loop to get the data:

```
BFNAME=$(sudo find /sys/kernel/debug/ieee80211/ -maxdepth 3 -name "bf")
while true; do sudo ./parse-bf.sh $BFNAME ; sleep 0.25; done  | tee /tmp/bf.csv
```

Also generate a flow with `iperf3`:


```
iperf3 -c 192.168.0.1 -i 5 -t 10000
```

Finally, start the visualization:

```
Rscript run-shiny-app.R
```

After it starts, it will give you a URL which you should open in a browser to see the visualization.

Anytime the axes get a little messed up, stop the `Rscript` process and run it again.
