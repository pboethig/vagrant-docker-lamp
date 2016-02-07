#!/bin/bash

if [ ! -f /.nano-installed ]; then
    apt-get install nano
    touch /.nano-installed
fi

if [ ! -f /.mysql_admin_created ]; then
    /create_mysql_admin_user.sh
fi

if [ ! -f /.webgrind-installed ]; then
    /install_webgrind.sh
fi

if [ ! -f /.n98-magerun-installed ]; then
    /install_n98-magerun.sh
fi

if [ ! -f /.composer-installed ]; then
    /install_composer.sh
fi

if [ ! -f /.database-installed ]; then
    /install_database.sh
fi

if [ ! -f /.configmagento-installed ]; then
    /config_magento.sh
fi
