#!/bin/bash

# create a network
# podman network create --subnet 192.168.242.64/28 --gateway 192.168.242.65 play-titracka

# pod with shared setup over all containers
podman pod create --name play-titracka \
  --publish=3000:3000 \
  --label=group=titracka-playground

podman create --pod play-titracka --name play-titracka-redis \
  --volume play-titracka-redis:/data \
  docker.io/library/redis:latest

podman create --pod play-titracka --name play-titracka-postgres \
  --volume=play-titracka-postgres:/var/lib/postgresql/data \
  --env-file=env.playground \
  --health-cmd="/usr/local/bin/pg_isready -q -d postgres -U postgres" \
  --health-interval=10s \
  --health-timeout=45s \
  --health-retries=10 \
  docker.io/postgres:16.3

podman create --pod play-titracka --name play-titracka-app \
  --requires=play-titracka-redis,play-titracka-postgres \
  --env-file=env.playground \
  --env="FORCE_SSL=false" \
  --restart=on-failure \
  --volume=play-titracka-storage:/rails/storage \
  ghcr.io/swobspace/titracka:latest
