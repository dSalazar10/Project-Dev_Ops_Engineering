#!/usr/bin/env bash

## Complete the following steps to get Docker running locally
DOCKERPATH="dsalazar10/udagram:jenkins"

# Run service
docker run -it -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock --rm $DOCKERPATH
