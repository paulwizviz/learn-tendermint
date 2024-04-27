#!/bin/bash

export TMINT_DEV_IMAGE="learn-cosmos/tmintdev:current"
export TMINT_PROD_IMAGE="learn-cosmos/tmintprod:current"

function tmint_image(){
    local cmd=$1
    case $cmd in
        "build")
            docker-compose -f ./build/tmint/builder.yaml build
            ;;
        "clean")
            docker rmi -f ${TMINT_DEV_IMAGE}
            docker rmi -f ${TMINT_PROD_IMAGE}
            docker rmi -f $(docker images --filter "dangling=true" -q)
            ;;
        *)
            echo "Usage: $0 image [command]
            
command:
    build  tendermint images
    clean  tendermint images"
    esac
}

