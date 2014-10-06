# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM onitam88/base_build:1.0.0

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Eseguendo la build di nginx e lo installo, la versionde le pacchetto è ferma alla 1.4.3

RUN apt-get update
RUN apt-get -y install libpcre3 libpcre3-dev libssl-dev

RUN cd /tmp && wget http://nginx.org/download/nginx-1.6.0.tar.gz && tar -xvzf nginx-1.6.0.tar.gz

RUN cd /tmp/nginx-1.6.0 &&\
    ./configure \
    --with-http_ssl_module  &&\
    make && make install


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD nginx-watch/nginxwatch.sh /sbin/nginx_watch/run.sh











