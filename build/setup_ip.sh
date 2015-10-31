#!/bin/sh

apis=$(cd /etc/monit/conf.d && ls *.conf | grep -v common.conf | sed "s/\.conf$//" -)

for api in $apis
do
    IP=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $api`
    if [ $? -eq 0 ]
    then
        file="/etc/monit/conf.d/$api.conf"
        grep -q 'CONTAINER_IP' $file
        if [ $? -eq 0 ]
        then
            sed -i "s/CONTAINER_IP/$IP/g" $file
            echo "  $api -> $IP"
        else
            echo "  $api -> $IP (already updated)"            
        fi
    else
        echo "Can't find service $api yet. Wait a moment"
        (sleep 3; /srv/monit/setup_ip.sh) &
        break
    fi
done
