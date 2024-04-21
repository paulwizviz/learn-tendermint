#!/bin/bash

export TMINT_DEV_IMAGE="learn-tendermint/devnode:current"
export TMINT_PROD_IMAGE="learn-tendermint/prodnode:current"

function image(){
    local cmd=$1
    case $cmd in
        "build")
            docker-compose -f ./build/builder.yaml build
            ;;
        "clean")
            docker rmi -f ${TMINT_DEV_IMAGE}
            docker rmi -f ${TMINT_PROD_IMAGE}
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