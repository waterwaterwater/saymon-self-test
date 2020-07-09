#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "You should be root or use sudo to run it" 
   exit 1
mkdir /opt/saymon-scripts/
cd /opt/saymon-scripts/
apt install git -y 2>/dev/null > /dev/null
git clone https://github.com/waterwaterwater/saymon-self-test.git
cp ./saymon-self-test/* /opt/saymon-scripts
rm -r ./saymon-self-test/
/opt/saymon-scripts/install.sh
#прописали в крон 
crontab -l > foocron
echo  "* * * * * /opt/saymon-scripts/saymon-state-check.sh --json > /usr/local/saymon/client/components_state.json" >> foocron
crontab foocron
rm foocron
