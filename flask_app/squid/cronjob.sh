#!/bin/bash
set -e
cd /opt/flask_app/squid
if [ -f command ] ; then
  contents=`head -n1 command`
  if [[ $contents = 'disable' ]]; then
    echo "disabling rules"
    ln -sf /etc/squid/squid.conf.disable /etc/squid/squid.conf
    #systemctl reload squid
    echo "disabled" > /opt/flask_app/squid/state
    chmod 744 /opt/flask_app/squid/state
    squid -k reconfigure
  elif [[ $contents = 'enable' ]]; then
    echo "enabling rules"
    ln -sf /etc/squid/squid.conf.enable /etc/squid/squid.conf
    #systemctl reload squid
    echo "enabled" > /opt/flask_app/squid/state
    chmod 744 /opt/flask_app/squid/state
    squid -k reconfigure
  fi
  rm -f command
else
  echo "no pending commands"
fi
