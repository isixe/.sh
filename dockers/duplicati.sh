#!/bin/bash

# set volume path
read -p "Set docker volume path (default /data/docker)：" -i "/data/docker" volumePath
if [[ -z "$volumePath" ]]; then
   echo "-> No volume path provided, using default /data/docker"
   volumePath="/data/docker"
fi

# volume path prapare
mkdir -p $volumePath
root=$(echo $volumePath | awk -F '/' '{print $2}')

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
