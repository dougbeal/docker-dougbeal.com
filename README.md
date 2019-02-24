# security philosophy https://docs.docker.com/engine/security/userns-remap/
# https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1
```
apt update && apt upgrade
apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     docker-compose
curl -fsSL https://download.docker.com/linux/debian/gpg > /tmp/docker_key.gpg
sudo apt-key add /tmp/docker_key.gpg
sudo apt-key fingerprint 0EBFCD88
lsb_release -cs
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker dougbeal
 
```
Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.

# /etc/docker/daemon.json
```
{
    "userns-remap": "default"
}
```
```
systemctl restart docker
adduser dockerrun
git clone https://github.com/dougbeal/docker-dougbeal.com.git
apt-get install python-pip
pip install docker-compose
usermod -aG dockerrun dockremap
volumes needs to be owned by 165536.165536

www-data wants to update to wp-content
root@localhost:/home/dockerrun/docker-dougbeal.com/volumes/wordpress_com_dougbeal/wp-content# groupadd -g 165618 dock-www-data
root@localhost:/home/dockerrun/docker-dougbeal.com/volumes/wordpress_com_dougbeal/wp-content# useradd -u 165618 dock-www-data
useradd: group dock-www-data exists - if you want to add this user to that group, use -g.
root@localhost:/home/dockerrun/docker-dougbeal.com/volumes/wordpress_com_dougbeal/wp-content# useradd -u 165618 dock-www-data -g dock-www-data
```

# BUG: webserver doesn't see certbot challenge files


# update/run loop
* ``` cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose up --build -d && docker-compose logs```

cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose up --build --force-recreate -d && docker-compose logs

```
mysql --user=wordpress --password=wordpress wordpress < /docker-entrypoint-initdb.d/dougbeal_wp116_2018_06_26.sql
wp plugin --allow-root --path=/var/www/html install wordpress-importer indieweb webmention semantic-linkbacks micropub indieweb-post-kinds syndication-links indieauth --activate
wp import --allow-root --path=/var/www/html myblog.wordpress.2018-06-26.xml --authors=create
cd /home/dockerrun/docker-dougbeal.com/ && ./create_volume_directory.sh && su dockerrun -c "git pull" && docker-compose up --build -d && docker-compose logs



docker exec -i docker-dougbealcom_database_1 mysql --user=wordpress --password=wordpress -e "use wordpress_com_dougbeal; show tables"
```
```
wp plugin list --field=name
dougbeal@gritmonkey.com [~/dougbeal.com]# wp plugin list --field=name
auto-approve-comments
auto-post-thumbnail
bridgy-publish
crayon-syntax-highlighter
debug-bar
debug-bar-actions-and-filters-addon
debug-bar-console
dsgnwrks-instagram-importer
enlighter
hum
indieauth
wordpress-indieweb-hook-branch
indieweb
indieweb-press-this
jetpack
list-custom-taxonomy-widget
loginizer
micropub
wordpress-micropub-master
opengraph
indieweb-post-kinds
post-meta-inspector
press-this
pushpress
query-monitor
wp-rest-api-log
semantic-linkbacks
shortcode-reference
simple-location
subtome
syndication-links
wordpress-webactions-master
webmention
wordpress-webmention-for-comments-master
pubsubhubbub
wp-syntax


dougbeal@gritmonkey.com [~/dougbeal.com]# wp plugin list --status=active --field=name
auto-approve-comments
auto-post-thumbnail
bridgy-publish
crayon-syntax-highlighter
debug-bar
debug-bar-actions-and-filters-addon
hum
indieweb
indieweb-post-kinds
indieweb-press-this
list-custom-taxonomy-widget
micropub
opengraph
post-meta-inspector
press-this
pushpress
semantic-linkbacks
shortcode-reference
simple-location
syndication-links
webmention
wp-rest-api-log

docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin install  auto-approve-comments auto-post-thumbnail bridgy-publish crayon-syntax-highlighter debug-bar debug-bar-actions-and-filters-addon hum indieweb indieweb-post-kinds indieweb-press-this list-custom-taxonomy-widget micropub opengraph post-meta-inspector press-this pushpress semantic-linkbacks shortcode-reference simple-location syndication-links webmention wp-rest-api-log

docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin activate indieweb indieweb-post-kinds indieweb-press-this list-custom-taxonomy-widget micropub opengraph post-meta-inspector press-this pushpress semantic-linkbacks shortcode-reference simple-location syndication-links webmention wp-rest-api-log

git clone https://github.com/dougbeal/twentysixteen-indieweb.git
docker exec docker-dougbealcom_wordpress_1 wp --allow-root theme activate twentysixteen-indieweb

``` 


# regenerate letsencrypt certs
```
cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose -f docker-compose-letsencrypt.yml up --build

find /home/dockerrun/docker-dougbeal.com/volumes/letsencrypt/live/stage.dougbeal.com/ -name \*.pem | xargs -n 1 openssl x509 -text -noout -in

docker restart docker-dougbealcom_webserver-wordpress_1
```


# make sure body size is big enough for images https://stackoverflow.com/questions/2056124/nginx-client-max-body-size-has-no-effect


# wordpress updates
## core
```
 cd /home/dockerrun/docker-dougbeal.com/ && docker exec docker-dougbealcom_wordpress_1 wp --allow-root core update
 ```

## plugins
```
 cd /home/dockerrun/docker-dougbeal.com/ && docker exec docker-dougbealcom_wordpress_1 wp --allow-root plugin update hello
```

## build hugo
```
cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose -f docker-compose.yml -f docker-compose-build.yml up --build -d  build-org-foolscap-podcast && docker-compose -f docker-compose.yml -f docker-compose-build.yml logs build-org-foolscap-podcast
```
