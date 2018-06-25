#!/bin/sh
docker-compose -f docker-compose-letsencrypt.yml up
dhparam_file="/home/dockerrun/docker-dougbeal.com/volumes/letsencrypt/nginx-certs/dhparam.pem"
if [ ! -f $dhparam_file ]; then
    openssl dhparam -out $dhparam_file 4096
fi
