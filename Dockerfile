FROM fedora
MAINTAINER jrhowd@gmail.com

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN dnf install -y squid python-setuptools && dnf clean all && rm -rf /var/cache/yum && \
    pip install flask flask_httpauth

COPY lists/ /etc/squid/
COPY entrypoint.sh /sbin/entrypoint.sh
COPY start-squid.sh /sbin/start-squid.sh
COPY flask_app /opt/flask_app
RUN chmod 755 /sbin/entrypoint.sh /sbin/start-squid.sh /opt/flask_app/squid/runapp.sh /opt/flask_app/squid/cronjob.sh &&\
    ln -sf /etc/squid/squid.conf.disable /etc/squid/squid.conf && dnf install procps -y

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]
