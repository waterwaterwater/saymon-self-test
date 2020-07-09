#!/bin/bash
if [ "$1" != "--json" ]
then
for a in "opentsdb" "kafka"
        do
        docker=$(docker inspect --format='{{ .State.Status }}' $a)
        if [ "$docker" != "running" ]
            then
                echo -e "$a":" " alarm""
            else
                echo -e "$a":" " working""
        fi
        done
for b in "mongod" "redis" "saymon-server" "chirpstack-network-server" "chirpstack-application-server" "chirpstack-gateway-bridge"
        do
        service=$(/usr/sbin/service $b status|grep Active|awk '{print $2}')
        if [ "$service" != "active" ]
            then
                echo -e "$b":" " alarm""
            else
                echo -e "$b":" " working""
        fi
done
else
rm /tmp/jservice 2>/dev/null
touch /tmp/jservice
        for a in "opentsdb" "kafka"
        do
        docker=$(docker inspect --format='{{ .State.Status }}' $a)
        if [ "$docker" != "running" ]
             then
                echo -e "$a":" " alarm"" >> /tmp/jservice

             else
                echo -e "$a":" " active"" >> /tmp/jservice

        fi
        done
for b in "mongod" "redis" "saymon-server" "chirpstack-network-server" "chirpstack-application-server" "chirpstack-gateway-bridge"
        do
        service=$(/usr/sbin/service $b status|grep Active|awk '{print $2}')
        if [ "$service" != "active" ]
            then
                echo -e "$b":" " alarm"" >> /tmp/jservice
            else
                echo -e "$b":" " active"" >>/tmp/jservice
        fi
done
cat /tmp/jservice|jq -s -R '[[ split("\n")[] | select(length > 0) | split(": +";"") | {(.[0]): .[1]}]| add]'|cut -c 2-

rm /tmp/jservice 2>/dev/null
fi
