define git_in_volume =
	bash -c "DIR=${1}; (cd \"$DIR\" && git status) || (cd \"${DIR%/*}\" && git clone ${2} \"$DIR\")"
endef

update: git-update volumes-update-git wordpress-update-plugins


git-update:
	su dockerrun -c "git pull && git submodule update && git submodule foreach 'git pull || :'"

volumes-update-git:
	su dockerrun -c "find /home/dockerrun/docker-dougbeal.com/volumes/ -name .git -type d -print -execdir git pull \;"

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

VOLUMES = iw26 iw26-child org.foolscap.podcast

.PHONY: $(VOLUMES) volumes
volumes: $(VOLUMES)
	echo "volumes $@ $<"
	$(call git_in_volume ./volumes/wordpress_com_dougbeal_d/themes/iw26, https://github.com/dshanske/iw26.git)
	$(call git_in_volume ./volumes/wordpress_com_dougbeal_d/themes/iw26-child, https://github.com/dougbeal/iw26-child.git)
	$(call git_in_volume ./volumes/org.foolscap.podcast, https://github.com/foolscapcon/org.foolscap.podcast.git)
#volumes/wordpress_com_dougbeal_d/plugins/indieweb-post-kinds/.git
#volumes/wordpress_com_dougbeal_d/plugins/wiki-embed/.git
#volumes/wordpress_com_dougbeal_d/plugins/micropub/.git
#volumes/openspace/themes/hugo-theme-openspace/.git


