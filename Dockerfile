FROM fedora
MAINTAINER jrhowd@gmail.com

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid \
    SQUID_ETC=/etc/squid \
    SQUID_BIN=/sbin/squid \
    GIN_MODE=release

RUN dnf install -y squid procps && dnf clean all && rm -rf /var/cache/yum

COPY lists/ /etc/squid/
COPY entrypoint.sh /sbin/entrypoint.sh
COPY start-squid.sh /sbin/start-squid.sh
COPY squid-api-conf/ /etc/squid-api/
COPY squid-api /bin/squid-api
RUN chmod 755 /sbin/entrypoint.sh /sbin/start-squid.sh /bin/squid-api

VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
