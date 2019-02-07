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
mkdir -p volumes/openspace/



# general volumes owner is docksquash:docksquash
find ./volumes -maxdepth 1 -type d \( -path ./volumes/${SITE} -o -path ./volumes/database \) -prune -o -print0 | \
    xargs -0 chown -R docksquash:docksquash


# non wp-content
find ./volumes/${SITE} -maxdepth 1 -type d \( -path ./volumes/${SITE}/wp-content \) -prune -o -print0 | \
    xargs -0 chown -R docksquash:docksquash

# wp-content is writable by being owned by dock-www-data:dock-www-data
find ./volumes/${SITE}/wp-content/ -maxdepth 1 -type d \( -path BANANA_FOR_SCALE \) -prune -o -print0 | \
    xargs -0 chown -R dock-www-data:dock-www-data

find ./volumes/openspace/public/ -maxdepth 1 -type d \( -path BANANA_FOR_SCALE \) -prune -o -print0 | \
    xargs -0 chown -R dock-www-data:dock-www-data



# database is writable by container mysql (uid 999) (mapped to uid 999+docksquash = 166535 on host)
find ./volumes/database/ -maxdepth 1 -type d \( -path BANANA_FOR_SCALE \) -prune -o -print0 | \
    xargs -0 chown -R $(( $(id -u docksquash ) + 999 )):$(( $(id -g docksquash ) + 999 ))


# everything excluding volumes is owned by dockerrun and stored in git
find .  -maxdepth 1 -type d \( -path volumes \) -prune -o -print0 | \
    xargs -0 -R chown dockerrun:dockerrun

# make sure .gitgnore is writeble
find volumes/ -name .gitignore -exec chmod g+rw {} \;
# make sure directories are traversable
find volumes/ -type d -exec chmod g+rw {} \;
