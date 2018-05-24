FROM fedora
MAINTAINER jrhowd@gmail.com

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN dnf install -y squid procps && dnf clean all && rm -rf /var/cache/yum

COPY lists/ /etc/squid/
COPY entrypoint.sh /sbin/entrypoint.sh
COPY start-squid.sh /sbin/start-squid.sh
COPY squid-api-conf/ /etc/squid-api-conf/
COPY squid-api /bin/squid-api
RUN chmod 755 /sbin/entrypoint.sh /sbin/start-squid.sh /bin/squid-api &&\
    rm -f /etc/squid/squid.conf &&\
    ln -sf  /etc/squid/squid.conf.disable /etc/squid/squid.conf

VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
