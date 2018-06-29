exec wait-for ${WORDPRESS_DB_HOST:-database}:${DATABASE_PORT:-3306} -- $@
