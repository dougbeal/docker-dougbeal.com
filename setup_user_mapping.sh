#!/bin/sh -x

# references:
# https://success.docker.com/article/introduction-to-user-namespaces-in-docker-engine
# https://docs.docker.com/engine/security/userns-remap/

# isolating continers with use namespace

# docker files are owned by dockerrun

# When you configure Docker to use the userns-remap feature, you can optionally specify an existing user and/or group, or you can specify default. If you specify default, a user and group dockremap is created and used for this purpose.

# root@localhost:/etc/docker# cat daemon.json
# {
# "userns-remap": "default"
# }

# default settings, root (uid 0) maps to dockremap [named docksquash]
# container root (uid 0) - host docksquash (uid 165536)

# passwd
# dockremap:x:108:113::/home/dockremap:/bin/false
# dockerrun:x:1001:1001:,,,:/home/dockerrun:/bin/bash
# docksquash:x:1f65536:165536::/home/docksquash:/bin/bash
# dock-www-data:x:165618:165618::/home/dock-www-data:
# cat /etc/subuid
# dougbeal:100000:65536
# dockremap:165536:65536
# dockerrun:231072:65536
# subgid
# dougbeal:100000:65536
# dockremap:165536:65536
# dockerrun:231072:65536

# docker image user inventory

# docker-compose ps --services

# database
# run database cat /etc/passwd
# mysql:x:999:999::/home/mysql:/bin/sh


# together
# open-hugo
# wordpress  php-fpm    www-data
# webserver-wordpress   nginx   www-data
# open

# webserver-wordpress/nginx - www-data
# wordpress/php-fpm - www-data
