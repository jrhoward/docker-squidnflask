#!/bin/bash
set -e
# quick and dirty start script
# Start the first process
/sbin/start-squid.sh &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start squid: $status"
  exit $status
fi

# Start the second process
/bin/squid-api &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start squid-api: $status"
  exit $status
fi


while sleep 60; do
  ps aux |grep squid |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep squid-api |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 ]; then
  # if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "squid has exited."
    exit 1
  fi
  if [ $PROCESS_2_STATUS -ne 0 ]; then
  # if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "squid-api has exited."
    exit 1
  fi
done
