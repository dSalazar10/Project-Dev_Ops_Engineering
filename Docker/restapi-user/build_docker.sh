#!/usr/bin/env bash

# The repo and tag in Docker Hub
DOCKERPATH="dsalazar10/udagram:user"

# Build image and add a descriptive tag
docker build -t $DOCKERPATH .