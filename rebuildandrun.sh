#!/bin/bash

docker build -t squidnflask .
docker rm -f squid
docker run --restart always -d -p3128:3128 -p80:8080 --name squid  squidnflask
