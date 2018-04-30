FROM ubuntu:16.04

RUN apt-get -y -qq update && \
  apt-get -y -qq upgrade && \
  apt-get -y -qq install apache2 curl tzdata && \
  ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  mkdir -p /ssl && \
  a2enmod rewrite ssl proxy proxy_http && \
  ln -sfT /dev/stderr /var/log/apache2/error.log && \
  ln -sfT /dev/stdout /var/log/apache2/access.log && \
  ln -sfT /dev/stdout /var/log/apache2/other_vhosts_access.log

HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

ADD 000-default.conf /etc/apache2/sites-enabled/000-default.conf
ADD run.sh /run.sh

EXPOSE 80 443

CMD ["bash", "run.sh"]
