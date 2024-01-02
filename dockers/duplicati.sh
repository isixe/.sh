#!/bin/bash

# set volume path
read -p "Set docker volume path (default /data/docker)：" -i "/data/docker" volumePath
volumePath="${volumePath:-/data/docker}"
echo "-> volume: $volumePath"

# volume path prapare
mkdir -p $volumePath
cd $volumePath
root=$(echo $volumePath | awk -F '/' '{print $2}')
echo "-> root: /$root"

docker run \
 --name=duplicati \
 -e PUID=0 \
 -e PGID=0 \
 -e TZ=Asia/Shanghai \
 -e CLI_ARGS= \
 -v ./config:/config \
 -v ./backups:/backups \
 -v $root:/source \
 -p 8200:8200 \
 --restart unless-stopped \
 lscr.io/linuxserver/duplicati:latest
