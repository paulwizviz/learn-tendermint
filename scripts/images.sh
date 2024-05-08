#!/bin/sh

export TMINT_BASE_IMAGE="learn-cosmos/tmintbase:current"
export TMINT_SOLO_IMAGE="learn-cosmos/tmintsolo:current"
export TMINT_LOCAL_IMAGE="learn-cosmos/tmintlocal:current"

function tmint_image(){
    local cmd=$1
    case $cmd in
        "build:base")
            docker-compose -f ./build/tmint/builder.yaml build base
            ;;
        "build:solo")
            docker-compose -f ./build/tmint/builder.yaml build solo
            ;;
        "build:local")
            docker-compose -f ./build/tmint/builder.yaml build local
            ;;
        "build")
            docker-compose -f ./build/tmint/builder.yaml build base
            docker-compose -f ./build/tmint/builder.yaml build solo
            docker-compose -f ./build/tmint/builder.yaml build local
            ;;
        "clean:base")
            docker rmi -f ${TMINT_BASE_IMAGE}
            ;;
        "clean:solo")
            docker rmi -f ${TMINT_SOLO_IMAGE}
            ;;
        "clean:local")
            docker rmi -f ${TMINT_LOCAL_IMAGE}
            ;;
        "clean")
            tmint_image clean:base
            tmint_image clean:solo
            tmint_image clean:local
            docker rmi -f $(docker images --filter "dangling=true" -q)
            ;;
        *)
            echo "Usage: $0 image [command]
            
command:
    build:base   base image
    build:solo   solo node image
    build:local  local node image
    build        all images
    clean:base   base image
    clean:solo   solo image
    clean        all images"
    esac
}

