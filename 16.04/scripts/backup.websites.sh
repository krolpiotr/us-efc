#!/bin/bash

# backup.websites.sh
#
# version 1.0.2
#
# Backup of websites on your Ubuntu Server 16.04
# author : Piotr Krol, simonphoenix.px@gmail.com
# website: simon-phoenix.se

# ------------------------------------------------------------------------
# Configuration
# directory for websites
WEBDIR="/home/phoenix/Server"
BACKUPSDIR="/home/phoenix/Backups/home/Server"
# ------------------------------------------------------------------------
# name: backup_website() 
# desc: Backup website
# args: project name,mysql database,mysql host,mysql user,mysql password
# return: 0
# ------------------------------------------------------------------------
backup_website() {

    PROJECT=$1
    DATABASE=$2
    DBHOST=$3
    DBUSERNAME=$4
    DBPASSWORD=$5


    if [ ! -d "$WEBDIR" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your websites doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    if [ ! -d "$BACKUPSDIR" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your backups doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    if [ -z "$DATABASE" ]
      then
        echo "           Backup of $PROJECT"
    else
        echo "           Backup of $PROJECT and database $DATABASE"
    fi

    if [ ! -d "$WEBDIR/$PROJECT" ]; then
       # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
       echo "           Directory of your project doesn't exist."
       echo "           Check configuration."
       return 0
    fi

    # for humans
    OFPX=$PROJECT.zip
    OF=$PROJECT-`date +%Y-%m-%d`.zip
    cd $BACKUPSDIR

    # if project doesn't exist, function don't do anything
    if [ -e $OF ]
      then
        # if backup already exist
        echo "           Backup of $PROJECT - done"
      else
        # backup doesn't exist, we are creating backup then...
        echo "           Backup of $PROJECT - not done... creating backup..."


        # database
        # ----------------------------------------------------------------
        # backup of database must be first
        # if database parameter doesn't exist
          if [ -z "$DATABASE" ]
            then
              echo "           Doesn't exist any database for this project."
          else

              # we will check if database exist and access
              RESULT=`mysql -h$DBHOST -u$DBUSERNAME -p$DBPASSWORD -e "SHOW DATABASES" | grep -Fo $DATABASE`
              if [ "$RESULT" == "$DATABASE" ]; then

                  # we need to check if directory for mysql file exist
                  # if not we gonna create one

                  if [ ! -d "$WEBDIR/$PROJECT/sql" ]; then
                    # Control will enter here if "$WEBDIR/$PROJECT/sql" doesn't exist.
                    mkdir "$WEBDIR/$PROJECT/sql"
                  fi

                  cd "$WEBDIR/$PROJECT/sql"
                  echo "           Database $DATABASE first"
                  rm $DATABASE-dev-*
                  mysqldump -h $DBHOST -u $DBUSERNAME --password=$DBPASSWORD $DATABASE > "$WEBDIR/$PROJECT/sql/$DATABASE-dev-`date +%y-%m-%d`.sql"

              else
                  echo "           Database does not exist. Check configuration."
              fi

          fi
        # ----------------------------------------------------------------


        cd $WEBDIR
        # we are creating zip archive
        zip -r $OF "$PROJECT"
        # we are checking if backup exist
          if [ -e $OF ]
            then
            # if archive exist we must to copy backup file and delete temporary file
            cd $BACKUPSDIR
            # we are copying file and removing temporary
            cp "$WEBDIR/"$OF "$BACKUPSDIR/"$OF
            rm "$WEBDIR/"$OF
          fi
    fi
}
# ------------------------------------------------------------------------
# name: clean_backups() 
# desc: Backups older than 0 days are deleted
# return: 0
# ------------------------------------------------------------------------
clean_backups() {
    dird="$BACKUPSDIR/"
    days=0
    echo -n "           removing files in $BACKUPSDIR that are older than $days days: "
    find "$dird" -mtime +$days -type f -exec echo {} \; -exec rm {} \; | wc -l
}
# ------------------------------------------------------------------------

echo '# -----------------------------------------------------------------------#'
echo '#          Buckup Websites                                               #'
echo '# -----------------------------------------------------------------------#'

# backup_website "project_name" "databasename" "localhost"  "gandalf" "password"
# backup_website "project_name"

backup_website "yourpersonal.se" "personal_database" "localhost"  "root" "your_password"
echo ''
backup_website "someweb.se" "someweb_database" "localhost"  "root" "your_password"
echo ''

clean_backups


echo '# -----------------------------------------------------------------------#'
echo '#          Buckup Websites done.                                         #'
echo '# -----------------------------------------------------------------------#'
