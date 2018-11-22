#!/bin/bash

# software.sh
#
# Package autoinstallation file

# ------------------------------------------------------------------------
# name: install_freeware() 
# desc: check if packages have been installed, if not installs
# return: 0
# author : Piotr Krol, simonphoenix.px@gmail.com
# website: simon-phoenix.se
# ------------------------------------------------------------------------
  function install_freeware() {  

# tutorial
#    if dpkg-query -W irssi > /dev/null  2>&1 ; then
#      echo "irssi :: installed"; 
#    else 
#      echo "irssi :: not installed"
#      echo "instalacja ...."
#      sudo apt-get install irssi;
#    fi
echo '           Checking packages....'
    # lista pakietow
    list[0]=apache2
    list[1]=proftpd
    list[2]=mysql-server
    list[3]=php-mysql
    list[4]=phpmyadmin
    list[5]=php

    # http://www.geoffstratton.com/ubuntu-mail-server-postfix-dovecot-and-mysql
    list[6]=postfix
    list[7]=postfix-mysql
    list[8]=dovecot-core
    list[9]=dovecot-imapd
    list[10]=dovecot-lmtpd
    list[11]=dovecot-mysql
    list[12]=zip
    list[13]=telnet
    list[14]=mailutils
    # echo "Message Body" | mail -s "Message Subject" receiver@example.com

    list[15]=dovecot-common
    list[16]=dovecot-imapd
    list[17]=dovecot-pop3d
    list[18]=dovecot-lmtpd

    # to fix mbstring on Ubuntu 16.04
    list[19]=php-mbstring
    list[20]=php7.0-mbstring
    list[21]=php-gettext
    # service apache2 restart

    list[22]=nano


    # if such a file does not exist there then you have to make a link
    #cd /usr/lib/postfix
    #ln -s postfix-mysql.so.1.0.1 dict_mysql.so

    #sudo apt-cache search

    for kls in ${list[*]}; do

      if dpkg-query -W $kls > /dev/null  2>&1 ; then
        echo "${kls} :: installed"; 
      else 
        echo "${kls} :: not installed"
        echo "instalacja ...."
        sudo apt-get install $kls;
      fi

    done

echo '           Package checking completed.'

    return 0
  }
# ------------------------------------------------------------------------

install_freeware

# ------------------------------------------------------------------------
