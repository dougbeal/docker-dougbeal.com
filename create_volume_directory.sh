#!/bin/sh
export $(cat .env | xargs)


mkdir -p volumes/${SITE_FOLDER}
mkdir -p volumes/${SITE_FOLDER}_d/themes
mkdir -p volumes/${SITE_FOLDER}_d/plugins
mkdir -p volumes/import-database/
mkdir -p volumes/import-wordpress/
mkdir -p volumes/letsencrypt/
mkdir -p volumes/well-known/
mkdir -p volumes/database
