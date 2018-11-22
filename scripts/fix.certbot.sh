#!/bin/bash

# fix.certbot.sh
#
# version 1.0.0
#
# Installing Certbot on your Ubuntu Server 16.04
# author: Piotr Krol, simonphoenix.px@gmail.com

# ------------------------------------------------------------------------
# name: install_certbot() 
# desc: Install
# args: 
# return: 0
# ------------------------------------------------------------------------
install_certbot() {
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-apache
sudo certbot --apache -d zf3.simon-phoenix.se
}
# ------------------------------------------------------------------------

echo '# -----------------------------------------------------------------------#'
echo '#          Installing Certbot                                            #'
echo '# -----------------------------------------------------------------------#'


install_certbot


echo '# -----------------------------------------------------------------------#'
echo '#          Installing Certbot done.                                      #'
echo '# -----------------------------------------------------------------------#'
