#!/bin/bash

git submodule update --recursive --remote

docker compose build

docker compose up
# docker compose up -d

# docker builder prune --all --force
# docker image prune --all --force