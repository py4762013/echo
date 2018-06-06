#!/bin/sh

# Handle the IP change
cat /etc/hosts | grep -v "inchoo.host.internal" > /etc/hosts
echo -e "`/sbin/ip route|awk '/default/ { print $3 }' | grep -v ppp` inchoo.host.internal" | tee -a /etc/hosts > /dev/null

# Run services
nohup /usr/sbin/php-fpm7.0 &
/usr/sbin/apache2ctl -D FOREGROUND
