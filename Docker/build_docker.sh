#!/bin/bash

# Be sure to execute this command with the following:
# . ./build_docker.sh

FOLDERS=("front-end" "restapi-feed" "restapi-user" "reverse-proxy")
WDIR=$PWD
#echo "Working directory = ${WDIR}"
for FOLDER in ${FOLDERS[@]}
do
    #echo "Changing to ${FOLDER} dir:"
    cd $FOLDER
    #echo "Uploading..."
    ./build_docker.sh
    cd $WDIR
done