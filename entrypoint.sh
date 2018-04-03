#!/bin/bash
arg=''
if [ "$IPS" != "false" ]; then
	res=$(iptables -L -t mangle | grep -o 'NFQUEUE')
	if [ "$res" == "" ]; then
		#iptables -t mangle -I PREROUTING  -j NFQUEUE --queue-num=0 --queue-bypass
		iptables -I FORWARD -j NFQUEUE --queue-num=0 --queue-bypass
	fi
	arg='-Q --daq nfq --daq-dir /usr/local/lib/daq/ --daq-var queue=0'
fi
/usr/bin/python /opt/jinja-pulledpork-conf.py > /etc/pulledpork/pulledpork.conf
/usr/bin/python /opt/jinja-snort-conf.py > /etc/snort/snort.conf
snort -c /etc/snort/snort.conf $arg
