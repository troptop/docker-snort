#!/bin/bash

/usr/bin/python /opt/jinja-pulledpork-conf.py > /etc/pulledpork/pulledpork.conf
snort -c /etc/snort/etc/snort.conf
