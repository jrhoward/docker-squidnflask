#!/bin/bash
set -e

create_log_dir() {
  mkdir -p ${SQUID_LOG_DIR}
  chmod -R 755 ${SQUID_LOG_DIR}
  chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_LOG_DIR}
}

create_cache_dir() {
  mkdir -p ${SQUID_CACHE_DIR}
  chown -R ${SQUID_USER}:${SQUID_USER} ${SQUID_CACHE_DIR}
}

create_log_dir
create_cache_dir

if [[ ! -d ${SQUID_CACHE_DIR}/00 ]]; then
  echo "Initializing cache..."
  squid -N -f /etc/squid/squid.conf -z
fi
echo "Starting squid..."
exec squid -f /etc/squid/squid.conf -NYCd 1
