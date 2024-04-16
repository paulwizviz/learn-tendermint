#!/bin/bash

export TENDERMINT_NODE_IMAGE="learn-tendermint/node:current"

function image(){
    local cmd=$1
    case $cmd in
        "build")
            docker-compose -f ./build/builder.yaml build
            ;;
        "clean")
            docker rmi -f ${TENDERMINT_NODE_IMAGE}
            docker rmi -f $(docker images --filter "dangling=true" -q)
            ;;
        *)
            echo "$0 image [command]

command:
    build   images
    clean   images"
            ;;
    esac
}