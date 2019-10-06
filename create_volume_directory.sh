#!/bin/sh -x
export $(cat .env | xargs)
# require variables to be set
set -u

mkdir -p volumes/${SITE}
mkdir -p volumes/${SITE}_d/themes
mkdir -p volumes/${SITE}_d/plugins
mkdir -p volumes/import-database/
mkdir -p volumes/import-wordpress/
mkdir -p volumes/letsencrypt/
mkdir -p volumes/well-known/
mkdir -p volumes/database/
mkdir -p volumes/together/

mkdir -p volumes/openspace/public/
mkdir -p volumes/openspace/resources/
mkdir -p volumes/openspace/cache/

mkdir -p volumes/org.foolscap.podcast/public/
mkdir -p volumes/org.foolscap.podcast/resources/
mkdir -p volumes/org.foolscap.podcast/cache/
mkdir -p volumes/org.foolscap.podcast/media/ # mount point

mkdir -p volumes/org.foolscap.podcast_media/

mkdir -p volumes/com.dougbeal.hdc/public/
mkdir -p volumes/com.dougbeal.hdc/resources/
mkdir -p volumes/com.dougbeal.hdc/cache/


# general volumes owner is docksquash:docksquash
find ./volumes -mindepth 1 -maxdepth 1 -type d \( -path ./volumes/${SITE} -o -path ./volumes/database \) -prune -o -print0 | \
    xargs -0 chown -R docksquash:docksquash


# non wp-content
find ./volumes/${SITE}  -mindepth 1 -maxdepth 1 -type d \( -path ./volumes/${SITE}/wp-content \) -prune -o -print0 | \
    xargs -0 chown -R docksquash:docksquash

# wp-content is writable by being owned by dock-www-data:dock-www-data
chown -R dock-www-data:dock-www-data ./volumes/${SITE}/wp-content/
find ./volumes/${SITE} -name wp-config\* -print0 |
    xargs -0 chown dock-www-data:dock-www-data
# needs to write temp sed files to this directory ^---^
chown dock-www-data:dock-www-data ./volumes/${SITE}

chown -R dock-www-data:dock-www-data ./volumes/openspace/public/
chown -R dock-www-data:dock-www-data ./volumes/openspace/cache/
chown -R dock-www-data:dock-www-data ./volumes/openspace/resources/

chown -R docksquash:docksquash ./volumes/openspace/themes/*/assets/

chown -R docksquash:docksquash ./volumes/org.foolscap.podcast
chown -R dock-www-data:dock-www-data ./volumes/org.foolscap.podcast/public/
chown -R dock-www-data:dock-www-data ./volumes/org.foolscap.podcast/cache/
chown -R dock-www-data:dock-www-data ./volumes/org.foolscap.podcast/resources/
chown dock-www-data:dock-www-data ./volumes/org.foolscap.podcast/media/

chown -R docksquash:docksquash ./volumes/com.dougbeal.hdc/
chown -R dock-www-data:dock-www-data ./volumes/com.dougbeal.hdc/public/
chown -R dock-www-data:dock-www-data ./volumes/com.dougbeal.hdc/cache/
chown -R dock-www-data:dock-www-data ./volumes/com.dougbeal.hdc/resources/

chown -R docksquash:docksquash ./volumes/org.foolscap.podcast/themes/*/assets/

# git directeories are managed by dockerrun:dockerrun
find /home/dockerrun/docker-dougbeal.com/volumes/ -name .git -type d -print -execdir chown dockerrun:dockerrun -R .git \;

# database is writable by container mysql (uid 999) (mapped to uid 999+docksquash = 166535 on host)
chown -R $(( $(id -u docksquash ) + 999 )):$(( $(id -g docksquash ) + 999 )) ./volumes/database/


# everything excluding volumes is owned by dockerrun and stored in git
find .  -mindepth 1 -maxdepth 1 -type d \( -path ./volumes \) -prune -o -print0 | \
    xargs -0 chown dockerrun:dockerrun -R 

# make sure .gitgnore is writeble
find volumes/ -name .gitignore -exec chmod g+rw {} \;
# make sure directories are traversable
find volumes/ -type d -exec chmod g+rw {} \;
