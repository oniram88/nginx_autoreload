# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM oniram88/base-build:1.0.0

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


##Preparo l'inserimento del watcher
RUN mkdir /etc/service/nginx-watch
ADD nginxwatch.sh /etc/service/nginx-watch/run
RUN chmod +x /etc/service/nginx-watch/run

## inserisco nginx come altro demone
RUN mkdir /etc/service/nginx
ADD nginx_start.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run


#Eseguendo la build di nginx e lo installo, la versionde del pacchetto è ferma alla 1.4.3
RUN apt-get update &&\
    apt-get -y install libpcre3 libpcre3-dev libssl-dev inotify-tools &&\

    cd /tmp && wget http://nginx.org/download/nginx-1.6.0.tar.gz &&\
    tar -xvzf nginx-1.6.0.tar.gz &&\

    cd /tmp/nginx-1.6.0 &&\
    ./configure \
    --with-http_ssl_module  &&\
    make && make install &&\

# Clean up APT when done.
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nginx.conf /usr/local/nginx/conf/nginx.conf
RUN ln -s /usr/local/nginx/sbin/nginx /etc/init.d/nginx

EXPOSE 80
RUN mkdir -p /var/nginx/sites_enabled
ENV WWW_DIR /var/nginx/sites_enabled









