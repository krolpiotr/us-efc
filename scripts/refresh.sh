#!/bin/bash

# refresh.sh

sudo apt-get update && sudo apt-get upgrade
sudo apt-get autoclean
echo ""
service cron restart
echo "done."
