#!/bin/bash

# backups.sh
#
# Databases backup
#
# v. 1.0.2
#
# next version: add: hostname, mailname, group, mysql

##########################################################################
# ------------------------------------------------------------------------
# BACKUPS
# ------------------------------------------------------------------------
# file: backups.sh
#
# Ubuntu 16.04 Backup
# - apache2 configuration files
# - postfix configuration files
# - dovecot configuration files
# - php configuration files
# - hosts configuration
# - crontab configuration
# - /usr/local/bin files --
# - /home/phoenix/System
# - /var/mail
#
##########################################################################

# ------------------------------------------------------------------------
# name: diroctory() 
# desc: Check folders
# return: 0
# author: Piotr Krol, simonphoenix.px@gmail.com
# ------------------------------------------------------------------------
  function directory() {  

    echo '           Start directory....'

    DIR="${BASH_SOURCE%/*}"


#   if [ -d "$DIR" ]; then 
#      if [ -L "$DIR" ]; then
#      # It is a symlink!
#      # Symbolic link specific commands go here.
#      rm "$DIR"
#    else
#      # It's a directory!
#      # Directory command goes here.
#      rmdir "$DIR"
#      fi
#    fi

    if [ -d "/home/phoenix/Backups" ]; then
      echo '           Backups destination exist....'
    else
      echo '           Backups destination not exist....'
      echo '           Creating "Backups" here....'
      mkdir -p "/home/phoenix/Backups"
    fi

    if [ -d "/home/phoenix/Backups/etc" ]; then
      echo '           Backups/etc destination exist....'
    else
      echo '           Backups/etc destination not exist....'
      echo '           Creating "Backups/etc" here....'
      mkdir -p "/home/phoenix/Backups/etc"
    fi

    if [ -d "/home/phoenix/Backups/home" ]; then
      echo '           Backups/home destination exist....'
    else
      echo '           Backups/home destination not exist....'
      echo '           Creating "Backups/home" here....'
      mkdir -p "/home/phoenix/Backups/home"
    fi

    if [ -d "/home/phoenix/Backups/var" ]; then
      echo '           Backups/var destination exist....'
    else
      echo '           Backups/home destination not exist....'
      echo '           Creating "Backups/var" here....'
      mkdir -p "/home/phoenix/Backups/var"
    fi

    if [ -d "/home/phoenix/Backups/home/Server" ]; then
      echo '           Backups/home/Server destination exist....'
    else
      echo '           Backups/home/Server destination not exist....'
      echo '           Creating "Backups/home/Server" here....'
      mkdir -p "/home/phoenix/Backups/home/Server"
    fi

#    if [ -d "/home/phoenix/Backups/System" ]; then
#      echo '           Backups/System destination exist....'
#    else
#      echo '           Backups/System destination not exist....'
#      echo '           Creating "Backups/System" here....'
#      mkdir -p "/home/phoenix/Backups/System"
#    fi

    # tworzy folder tymczasowy dla backupow
    if [ -d "/home/phoenix/Backups/tmp" ]; then
      echo '           Backups/tmp destination exist....'
    else
      echo '           Backups/tmp destination not exist....'
      echo '           Creating "Backups/tmp" here....'
      mkdir -p "/home/phoenix/Backups/tmp"
    fi

    echo '           Directory done.'

    return 0
  }
# ------------------------------------------------------------------------
# name: cleaning() 
# desc: Cleaning old back up files
# return: 0
# ------------------------------------------------------------------------
  function cleaning() {  

    echo '           Cleaning....'
    echo ''


    cd "/home/phoenix/Backups/etc"
    dird="/home/phoenix/Backups/etc/"
    days=0
    echo -n "           removing files in $dird that are older than $days days: "
    find "$dird" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l


    cd "/home/phoenix/Backups/home"
    dird="/home/phoenix/Backups/home/"
    days=0
    echo -n "           removing files in $dird that are older than $days days: "
    find "$dird" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l


    cd "/home/phoenix/Backups/var"
    dird="/home/phoenix/Backups/var/"
    days=0
    echo -n "           removing files in $dird that are older than $days days: "
    find "$dird" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l



    #if [ -e $OF ]
    #  then
      # dzis juz zrobiono backup
   #   echo "           Backup of $OF - done"
   # else    
    #echo '           Ubuntu Final Backup....'
    #fi

    echo ''
    echo '           Cleaning done.'

    return 0
  }
# ------------------------------------------------------------------------
# name: backup_directory() 
# desc: Back up directory
# args: name of directory,source directory,destination directory
# return: 0
# ------------------------------------------------------------------------
  function backup_directory() {  

    PROJECT=$1
    SOURCE=$2
    DESTINATION=$3

    #$PROJECT="$PROJECT"
    BACKUPFILE=$PROJECT-`date +%Y-%m-%d`.tar.gz


    if [ ! -d "$SOURCE/"$PROJECT ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your $PROJECT doesn't exist in"
       echo "           $SOURCE"
       echo "           Check configuration."
       return 0
    fi

    if [ ! -d "$DESTINATION" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your backup"
       echo "           $DESTINATION"
       echo "           doesn't exist."
       echo "           Check configuration."
       return 0
    fi


    echo "           Backup $PROJECT directory...."

    cd "$DESTINATION"

    if [ -e "$DESTINATION/"$BACKUPFILE ]
      then
      # we did backup today
      echo "           Backup of $BACKUPFILE - done"
    else
      # we will make a backup
      echo "           Backup of $PROJECT - not done... creating backup..."
      cp -rf "$SOURCE/"$PROJECT "$DESTINATION/../tmp/"$PROJECT
      cd "$DESTINATION/../tmp"
      #zip -r $OF "$DOVECOTCONF"
      tar czfP "$BACKUPFILE" "$PROJECT"

      cp -rf "$DESTINATION/../tmp/"$BACKUPFILE "$DESTINATION/"$BACKUPFILE
      # usuwanie folderu apache2 z tmp
      rm -rf "$DESTINATION/../tmp/"$PROJECT
      rm -rf "$DESTINATION/../tmp/"$BACKUPFILE
    fi

    echo "           Backup $PROJECT directory done."

    return 0
  }
# ------------------------------------------------------------------------
# name: backup_file() 
# desc: Back up file
# args: name of file,source directory,destination directory
# return: 0
# ------------------------------------------------------------------------
  function backup_file() {  

    PROJECT=$1
    SOURCE=$2
    DESTINATION=$3

    #$PROJECT="$PROJECT"
    BACKUPFILE=$PROJECT-`date +%Y-%m-%d`.tar.gz


    if [ ! -f "$SOURCE/$PROJECT" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           File of your $PROJECT doesn't exist in"
       echo "           $SOURCE"
       echo "           Check configuration."
       return 0
    fi

    if [ ! -d "$DESTINATION" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your backup"
       echo "           $DESTINATION"
       echo "           doesn't exist."
       echo "           Check configuration."
       return 0
    fi


    echo "           Backup $PROJECT file...."

    cd "$DESTINATION"

    if [ -e "$DESTINATION/"$BACKUPFILE ]
      then
      # we did backup today
      echo "           Backup of $BACKUPFILE - done"
    else
      # we will make a backup
      echo "           Backup of $PROJECT - not done... creating backup..."
      cp -r "$SOURCE/"$PROJECT "$DESTINATION/../tmp/"$PROJECT
      cd "$DESTINATION/../tmp"
      #zip -r $OF "$DOVECOTCONF"
      tar czfP "$BACKUPFILE" "$PROJECT"

      cp -r "$DESTINATION/../tmp/"$BACKUPFILE "$DESTINATION/"$BACKUPFILE
      # usuwanie folderu apache2 z tmp
      rm -r "$DESTINATION/../tmp/"$PROJECT
      rm -r "$DESTINATION/../tmp/"$BACKUPFILE
    fi

    echo "           Backup $PROJECT file done."

    return 0
  }
# ------------------------------------------------------------------------

echo '# -----------------------------------------------------------------------#'
echo '#          System Configuration Backup                                   #'
echo '# -----------------------------------------------------------------------#'
directory
echo '# -----------------------------------------------------------------------#'
echo '#          Start system configuration backup...                          #'
echo '# -----------------------------------------------------------------------#'
backup_directory "php" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_directory "apache2" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_directory "dovecot" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_directory "postfix" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_file "hosts" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_file "crontab" "/etc" "/home/phoenix/Backups/etc"
echo ''
backup_directory "efc" "/home/phoenix" "/home/phoenix/Backups/home"
echo ''
backup_directory "System" "/home/phoenix" "/home/phoenix/Backups/home"
echo ''
backup_directory "mail" "/var" "/home/phoenix/Backups/var"
echo ''
cleaning
echo ''
echo '# -----------------------------------------------------------------------#'
echo '#          System configuration done.                                    #'
echo '# -----------------------------------------------------------------------#'
# ------------------------------------------------------------------------
