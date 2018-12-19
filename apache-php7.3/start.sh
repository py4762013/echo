#!/bin/sh

# Handle the IP change
cat /etc/hosts | grep -v "inchoo.host.internal" > /etc/hosts
echo "`/sbin/ip route|awk '/default/ { print $3 }' | grep -v ppp` inchoo.host.internal" | tee -a /etc/hosts > /dev/null

# Setup Apache document root
sed "s#DOCUMENT_ROOT#${DOCUMENT_ROOT:-/var/www/html}#g" -i /etc/apache2/sites-available/000-default.conf

# Run services
nohup /usr/sbin/php-fpm7.3 &
/usr/sbin/apache2ctl -D FOREGROUND
