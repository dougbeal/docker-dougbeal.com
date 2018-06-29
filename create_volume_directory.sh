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


chown -R docksquash:docksquash volumes/*
find volumes/ -name .gitignore -exec chmod g+rw {} \;
find volumes/ -type d -exec chmod g+rw {} \;
