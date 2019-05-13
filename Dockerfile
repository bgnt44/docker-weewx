FROM jgoerzen/debian-base-security:stretch
MAINTAINER John Goerzen <jgoerzen@complete.org>
COPY setup/ /tmp/setup/
ENV WEEWX_VERSION 3.9.1
# The font file is used for the generated images
RUN mv /usr/sbin/policy-rc.d.disabled /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get -y --no-install-recommends install ssh rsync fonts-freefont-ttf && \
    apt-get -y install python-pip && \
    /tmp/setup/setup.sh && \
    apt-get -y -u dist-upgrade && \
    apt-get clean && rm -rf /tmp/setup /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /usr/local/bin/docker-wipelogs && \
    mv /usr/sbin/policy-rc.d /usr/sbin/policy-rc.d.disabled && \
    mkdir -p /var/www/html/weewx && \
	pip install paho-mqtt


VOLUME ["/var/lib/weewx"]
VOLUME ["/var/www/html/weewx"]
VOLUME ["/etc/weewx"]
CMD ["/usr/local/bin/boot-debian-base"]
