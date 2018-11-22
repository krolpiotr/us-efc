#!/bin/bash

# refresh.sh

# to ma robic restart cron, update i upgrade systemu
# czyszczenie systemu rowniez
sudo apt-get update && sudo apt-get upgrade
sudo apt-get autoclean
echo ""
service cron restart
echo "done."