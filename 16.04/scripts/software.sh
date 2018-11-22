#!/bin/bash

# software.sh
#
# Plik autoinstalacji pakietow

# ------------------------------------------------------------------------
# name: install_freeware() 
# desc: sprawdza czy zainstalowane zostaly pakiety, jesli nie to instaluje
# return: 0
# author: Piotr Krol, piotrkrol.px@gmail.com
# ------------------------------------------------------------------------
  function install_freeware() {  

# tutorial
#    if dpkg-query -W irssi > /dev/null  2>&1 ; then
#      echo "irssi :: zainstalowany"; 
#    else 
#      echo "irssi :: nie zainstalowany"
#      echo "instalacja ...."
#      sudo apt-get install irssi;
#    fi
echo '           Sprawdzanie pakietow....'
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
#    service apache2 restart

    list[22]=nano


# jesli taki plik nie istnieje tam to trzeba zrobic link
#cd /usr/lib/postfix
#ln -s postfix-mysql.so.1.0.1 dict_mysql.so

#sudo apt-cache search

    for kls in ${list[*]}; do

      if dpkg-query -W $kls > /dev/null  2>&1 ; then
        echo "${kls} :: zainstalowany"; 
      else 
        echo "${kls} :: nie zainstalowany"
        echo "instalacja ...."
        sudo apt-get install $kls;
      fi

    done

echo '           Sprawdzanie pakietow zakonczone.'

    return 0
  }
# ------------------------------------------------------------------------

install_freeware

# ------------------------------------------------------------------------
