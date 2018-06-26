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

```

# BUG: webserver doesn't see certbot challenge files


# update/run loop
* ``` cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose up --build -d && docker-compose logs```

cd /home/dockerrun/docker-dougbeal.com/ && su dockerrun -c "git pull" && docker-compose up --build --force-recreate -d && docker-compose logs


# why is wordpress not installing? wrong phase?
