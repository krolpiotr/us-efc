#!/bin/bash

# run.sh
#
# Starting to do everything on Ubuntu 16.04

# ------------------------------------------------------------------------
# name: start() 
# desc: Makes everything
# return: 0
# author : Piotr Krol, simonphoenix.px@gmail.com
# website: simon-phoenix.se
# ------------------------------------------------------------------------
  function start() {  

    echo "Version of Ubuntu"
    lsb_release -a
    echo '           '
    echo '           Start....'

    DIR="${BASH_SOURCE%/*}"
    if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
    . "$DIR/scripts/refresh.sh"
    echo '           '
    . "$DIR/scripts/software.sh"
    echo '           '
    . "$DIR/scripts/backups.sh"
    
    . "$DIR/scripts/backup.websites.sh"
    echo '           '
    . "$DIR/scripts/scripts/general.backup.sh"
 
    echo '           Done.'

    return 0
  }
# ------------------------------------------------------------------------

start

# ------------------------------------------------------------------------
