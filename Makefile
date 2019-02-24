update:
	su dockerrun -c "git pull && git submodule update"

org-foolscap-podcast: org-foolscap-podcast-yarn org-foolscap-podcast-hugo

org-foolscap-podcast-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-yarn

org-foolscap-podcast-hugo:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-podcast-hugo

org-foolscap-open: org-foolscap-open-yarn

org-foolscap-open-yarn:
	 docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build   build-org-foolscap-open-yarn	
