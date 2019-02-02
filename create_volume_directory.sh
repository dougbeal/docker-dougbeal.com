#!/bin/sh -x
export $(cat .env | xargs)


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


chown -R docksquash:docksquash volumes/*
chown -R dock-www-data:dock-www-data volumes/${SITE}/wp-content/
chown -R 166535 -R volumes/database
chown 166535 -R *
find volumes/ -name .gitignore -exec chmod g+rw {} \;
find volumes/ -type d -exec chmod g+rw {} \;
