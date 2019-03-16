git-update:
	su dockerrun -c "git pull && git submodule update && git submodule foreach 'git pull || :'"

wordpress-update-git:
	su dockerrun -c "find volumes/wordpress_com_dougbeal_d/ -name .git -type d -print -execdir git pull; git submodule --recurisve udpate \;"

wordpress-update-plugins: wordpress-update-git
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin update --all



org-foolscap-podcast: org-foolscap-podcast-yarn org-foolscap-podcast-hugo

org-foolscap-podcast-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-yarn

org-foolscap-podcast-hugo:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-hugo

org-foolscap-open: org-foolscap-open-yarn

org-foolscap-open-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-open-yarn

com-dougbeal-wp-plugins-git:
	su dockerrun -c "find volumes/wordpress_com_dougbeal_d/ -name .git -type d -print -execdir git pull \;"

com-dougbeal-wp-plugins:
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin update --all

com-dougbeal-wp-webserver:
	docker-compose -f docker-compose.yml up --build --detach webserver-wordpress && docker restart docker-dougbealcom_webserver-wordpress_1
