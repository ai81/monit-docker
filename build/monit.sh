#!/bin/sh

echo "restart monit"

/srv/monit/setup_ip.sh

pid=`cat /var/run/monit.pid`
kill -s HUP $pid

