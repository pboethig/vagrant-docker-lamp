FROM ubuntu:15.04

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install nano ssh bash sudo supervisor git apache2 memcached libapache2-mod-php5 mysql-server php5-mysql php5-curl php5-gd php5-mcrypt php5-xdebug php5-xmlrpc php5-memcache php5-intl php5-xsl phpmyadmin pwgen drush unzip && /usr/sbin/php5enmod mcrypt

# Add image configuration and scripts

ADD startscripts/start-apache2.sh /startscripts/start-apache2.sh
ADD startscripts/start-mysqld.sh /startscripts/start-mysqld.sh
ADD startscripts/start-sshd.sh /start-sshd.sh
ADD startscripts/shutdown /sbin/shutdown
ADD startscripts/run.sh /run.sh

ADD installscripts/firstrun.sh /firstrun.sh
RUN chmod 755 /*.sh

ADD etc/php.ini /etc/php5/apache2/php.ini
ADD etc/xdebug.ini /etc/php5/apache2/conf.d/xdebug.ini
ADD etc/sshd_config /etc/ssh/sshd_config
ADD etc/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD etc/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD etc/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf

# Add MySQL users
ADD installscripts/create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD bin/database/database.sql /database.sql
ADD installscripts/install_database.sh /install_database.sh

ADD installscripts/install_webgrind.sh /install_webgrind.sh
ADD installscripts/install_n98-magerun.sh /install_n98-magerun.sh
ADD installscripts/install_composer.sh /install_composer.sh

#configures magento
ADD installscripts/config_magento.sh /config_magento.sh

RUN chmod 755 /*.sh /sbin/shutdown

# Apache config
ADD etc/apache_default /etc/apache2/sites-available/000-default.conf
ADD etc/apache_webgrind /etc/apache2/sites-enabled/webgrind.conf
ADD etc/ports.conf /etc/apache2/ports.conf
RUN a2enmod rewrite headers

# PHPMyAdmin config
RUN echo "\n# Include PHPMyAdmin configuration\nInclude /etc/phpmyadmin/apache.conf\n" >> /etc/apache2/apache2.conf
RUN sed -i -e "s/\/\/ \$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/\$cfg\['Servers'\]\[\$i\]\['AllowNoPassword'\]/g" /etc/phpmyadmin/config.inc.php

# SSHD
RUN mkdir /var/run/sshd
RUN echo 'root:vagrant' |chpasswd
RUN /firstrun.sh

EXPOSE 22 80 443 3306 9000