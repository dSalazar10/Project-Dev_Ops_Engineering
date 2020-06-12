#!/usr/bin/env bash

# The repo and tag in Docker Hub
DOCKERPATH="dsalazar10/udagram:frontend"
 
# Run service
docker run -it -p 8100:8100 --rm $DOCKERPATH