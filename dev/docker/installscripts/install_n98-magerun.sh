#!/bin/bash

if [ -f /.n98-magerun-installed ]; then
    echo "n98-magerun already installed"
    exit 0
fi

echo "=> Instaling n98-magerun"
cd /tmp
/usr/bin/wget -q http://files.magerun.net/n98-magerun-latest.phar -O n98-magerun.phar >NULL
/bin/chmod +x ./n98-magerun.phar
cp ./n98-magerun.phar /usr/local/bin/n98-magerun


echo "=> Done!"
touch /.n98-magerun-installed
