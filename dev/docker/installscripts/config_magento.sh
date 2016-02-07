#!/bin/bash

echo "+++++++++++++++++Magento Configuration in +++++++++++++++++++"



if [ -f /.magentoconfig-installed ]; then
    echo "Magento was configured. Nothing to do"
    exit 0
fi

#just for easyness
chmod -R 777 /var/www/html

echo "=> Magento is configured under /var/www/html"
#touch /cd .magentoconfig-installed