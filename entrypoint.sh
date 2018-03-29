#!/bin/bash
arg=''
if [ "$IPS" != "false" ]; then
	iptables -t mangle -I PREROUTING  -j NFQUEUE --queue-num=0 --queue-bypass
	arg='-Q -A console --daq nfq --daq-dir /usr/local/lib/daq/ --daq-var queue=0'
fi
/usr/bin/python /opt/jinja-pulledpork-conf.py > /etc/pulledpork/pulledpork.conf
snort -c /etc/snort/snort.conf $arg
