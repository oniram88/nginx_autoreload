# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.14

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Eseguendo la build di nginx e lo installo, la versionde le pacchetto è ferma alla 1.4.3
RUN apt-get update &&\
    apt-get install wget &&\
    cd /tmp && wget http://nginx.org/download/nginx-1.6.0.tar.gz && tar -xvzf nginx-1.6.0.tar.gz &&\
    cd nginx-1.6.0 && ./configure && make && make install


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*











