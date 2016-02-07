#!/bin/bash

if [ -f /.database-installed ]; then
    echo "Database already installed. rm -rf /.database-installed on the client and run firstrun.sh to reinstall database."
    exit 0
fi

cd /

DATABASENAME=magento

BACKUPSTORAGE=/vagrant/dev/docker/backups/database

BACKUPFILENAME=$DATABASENAME.$(date "+%Y.%m.%d-%H.%M.%S").sql

BACKUPFILEPATH=$BACKUPSTORAGE/$BACKUPFILENAME

RESTOREFILEPATH=/vagrant/dev/docker/database/database.sql

echo " "
echo " "
echo " "

echo "++++++++++++++++++++Creating Database $DATABASENAME+++++++++++++++++++++"

if [ ! -d "$BACKUPSTORAGE" ]; then
        mkdir -p $BACKUPSTORAGE
fi

RESULT=`mysqlshow --user=root magento| grep -v Wildcard | grep -o magento`

if [ "$RESULT" == $DATABASENAME ]; then

    echo "Database $DATABASENAME exists. 1) Making a backup under $BACKUPSTORAGE/"
    mysqldump -u root magento > $BACKUPFILEPATH

    echo "=> 2) Drop database $DATABASENAME"
    mysql -uroot -e "DROP DATABASE IF EXISTS $DATABASENAME"
fi

echo "=> 3) Creating Database $DATABASENAME"
mysql -uroot -e "CREATE DATABASE $DATABASENAME"

echo "=> 4) Importing Database $DATABASENAME from $RESTOREFILEPATH"
mysql -uroot $DATABASENAME <$RESTOREFILEPATH


echo "=> Done! Database $DATABASENAME imported"
touch /.database-installed