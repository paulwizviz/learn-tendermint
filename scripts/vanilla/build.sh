#!/bin/bash

export TENDERMINT_BUILD_IMAGE="learn-tendermint/venilla-builder:current"
export TENDERMINT_BUILD_CONTAINER="vanilla-container"

COMMAND=$1

case $COMMAND in
    "native")
        docker-compose -f ./build/vanilla/docker-compose.yml build
        docker-compose -f ./build/vanilla/docker-compose.yml up
        ;;
    "clean")
        rm -rf ./build/vanilla/native
        docker-compose -f ./build/vanilla/docker-compose.yml down
        docker rmi -f ${TENDERMINT_BUILD_IMAGE}
        docker rmi -f $(docker images --filter "dangling=true" -q)
        ;;
    *)
        echo "$0 native | clean"
        ;;
esac
