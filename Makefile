define git_in_volume =
	bash -c "DIR=${1}; (cd \"$DIR\" && git status) || (cd \"${DIR%/*}\" && git clone --recurse-submodules -j8 ${2} \"$DIR\")"
endef

update: git-update volumes-update-git wordpress-update-plugins


git-update:
	su dockerrun -c "git pull && git submodule update --recursive && git submodule foreach 'git pull || :'"

# git-ownership:
# 	su dockerrun -c "find /home/dockerrun/docker-dougbeal.com/volumes/ -name .git -type d -print -execdir git pull \;"

volumes-update-git:
	su dockerrun -c "find /home/dockerrun/docker-dougbeal.com/volumes/ -name .git -type d -print -execdir git pull \;"

letsencrypt-regenerate: git-update
	docker-compose -f docker-compose-letsencrypt.yml up --build
	docker restart docker-dougbealcom_webserver-wordpress_1

wordpress-update-plugins: wordpress-update-git
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin update --all

wordpress-update: wordpress-update-plugins wordpress-update-core wordpress-update-theme

wordpress-update-git:
	su dockerrun -c "find volumes/wordpress_com_dougbeal_d/ -name .git -type d -print -execdir git pull \;"

wordpress-update-core: 
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root core update

wordpress-update-theme: 
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root theme update --all

wordpress-status:
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root core check-update
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin status
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root theme status

org-foolscap-podcast: org-foolscap-podcast-yarn org-foolscap-podcast-hugo

org-foolscap-podcast-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-yarn

org-foolscap-podcast-hugo:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-hugo

org-foolscap-open: org-foolscap-open-yarn

org-foolscap-open-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-open-yarn

com-dougbeal-hwc: com-dougbeal-hwc-git com-dougbeal-hwc-yarn com-dougbeal-hwc-hugo 

com-dougbeal-hwc-git:
	su dockerrun -c "cd /home/dockerrun/docker-dougbeal.com/volumes/com.dougbeal.hwc && (git pull || git clone https://github.com/dougbeal/us.wa.seattle.indieweb.git)"

com-dougbeal-hwc-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-com-dougbeal-hwc-yarn

com-dougbeal-hwc-hugo:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-com-dougbeal-hwc-hugo


com-dougbeal-wp-plugins-git:
	su dockerrun -c "find volumes/wordpress_com_dougbeal_d/ -name .git -type d -print -execdir git pull \;"

com-dougbeal-wp-plugins:
	docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin update --all

com-dougbeal-wp-webserver:
	docker-compose -f docker-compose.yml up --build --detach webserver-wordpress && docker restart docker-dougbealcom_webserver-wordpress_1

VOLUMES = iw26 iw26-child org.foolscap.podcast com.dougbeal.hwc

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
