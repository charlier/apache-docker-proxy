#!/bin/bash
set -e

HOST=$(openssl x509 -noout -subject -in /ssl/certificate.crt | sed 's/.*CN=//')
HOST=${HOST/'*.'/} # in case we're a wildcard

sed -i "s/hostname/$HOST/g" /etc/apache2/sites-enabled/000-default.conf
sed -i "s/proxyhost/$proxyhost/g" /etc/apache2/sites-enabled/000-default.conf

/usr/sbin/apache2ctl -D FOREGROUND
