#!/bin/bash
echo "---InstalLing Docker---"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
docker --version
sudo usermod -a -G docker $USER


echo "---Installing Docker-compose ---"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version



echo "--- Installing Jq ---"
sudo apt install jq



echo " --- Installing Golang ---"
curl -O https://dl.google.com/go/go1.21.0.linux-amd64.tar.gz
tar xvf go1.21.0.linux-amd64.tar.gz
export GOPATH=$PWD/go
echo $GOPATH
export PATH=$PATH:$GOPATH/bin



