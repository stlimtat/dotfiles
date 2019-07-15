#!/usr/local/bin/bash

#docker system prune -a
docker ps -a | grep -v CONTAINER | awk '{ print $1 }' | xargs docker rm --force
docker images -a | grep none | awk '{ print $3 }' | xargs docker rmi --force
docker volume prune --force