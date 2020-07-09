#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "You should be root or use sudo to run it" 
   exit 1
fi
r=$(getconf LONG_BIT)
if [ "$r" -eq "64" ]
then
        wget -q -O /opt/saymon-scripts/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
else 
        wget -q -O /opt/saymon-scripts/jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux32
fi
chmod 777 /opt/saymon-scripts/jq
