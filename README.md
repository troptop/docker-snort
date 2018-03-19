# docker-snort-pulledpork

[Snort](https://www.snort.org/) in Docker for Network Functions Virtualization (NFV)

The Snort Version 2.9.8.0 and DAQ Version 2.0.6

# Docker Usage
You may need to run as `sudo`
Attach the snort in container to have full access to the network

```
$ docker run -it --rm --net=host -v /path/snortdir:/etc/snort/etc troptop/docker-snort-pulledpork /bin/bash
```

List of configuration file:
```
ls /etc/snort/etc/
classification.config  reference.config       sid-msg.map            snort.conf             threshold.conf         unicode.map
```

```
$ docker run -it --rm --net=host -v /path/snortrules:/etc/snort/rules troptop/docker-snort-pulledpork /bin/bash
```
List of Rules Files
```
ls /etc/snort/rules/
black_list.rules       iplists/default.blacklist               iplistsIPRVersion.dat  local.rules            snort.rules            white_list.rules
```
`iplists/default.blacklist, snort.rules and iplistsIPRVersion.dat` are automatically updated by pullepork every night (check crontrab)
You can export the `black_list.rules, white_list.rules and local.rules` to specify your own rules

```
$ docker run -d --rm --net=host -v /path/snortrules/local.rules:/etc/snort/rules/local.rules -v /path/snortdir/snort.conf:/etc/snort/etc/snort.conf troptop/docker-snort-pulledpork /bin/bash
```

Or you may need to add --cap-add=NET_ADMIN or --privileged (unsafe)

```
$ docker run -it --rm --net=host --cap-add=NET_ADMIN troptop/docker-snort-pulledpork /bin/bash
```


```
docker run -it -v /Path/SNORT/etc/:/etc/snort/ -v /Path/SNORT/log/:/var/log/snort --rm \
--net=host troptop/docker-snort-pulledpork snort -c /etc/snort/etc/snort.conf
```
# Snort Usage

For testing it's work. Add this rule in the file at `/etc/snort/rules/local.rules`

```
alert icmp any any -> any any (msg:"Pinging...";sid:1000004;)
```

Running Snort and alerts output to the console (screen).

```
$ snort -i eth0 -c /etc/snort/etc/snort.conf -A console
```

Running Snort and alerts output to the UNIX socket

```
$ snort -i eth0 -A unsock -l /tmp -c /etc/snort/etc/snort.conf
```

Ping in the container then the alert message will show on the console

```
ping 8.8.8.8
```
