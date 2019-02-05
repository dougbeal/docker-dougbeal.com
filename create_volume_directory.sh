#!/bin/sh -x
export $(cat .env | xargs)
# require variables to be set
set -euo pipefail

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
find ./volumes -type d \( -path ${SITE} database \) -prune -o -print0 | xargs -0 chown docksquash:docksquash
# wp-content is writable by being owned by dock-www-data:dock-www-data
find ./volumes/${SITE}/wp-content/ -type d \( -path BANANA_FOR_SCALE \) -prune -o -print0 | xargs -0 chown dock-www-data:dock-www-data
# database is writble by docker-root (166535)
find ./volumes/dataase/ -type d \( -path BANANA_FOR_SCALE \) -prune -o -print0 chown 166535:166535 -R volumes/database
find . -type d \( -path volumes \) -prune -o -print0 | xargs -0 chown dockerrun:dockerrun
# make sure .gitgnore is writeble
find volumes/ -name .gitignore -exec chmod g+rw {} \;
# make sure directories are traversable
find volumes/ -type d -exec chmod g+rw {} \;
