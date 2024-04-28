#!/bin/sh

export TMINT_EX_IMAGE="learn-cosmos/tmintex:current"
export TMINT_BASE_IMAGE="learn-cosmos/tmintprod:current"

function tmint_image(){
    local cmd=$1
    case $cmd in
        "build:base")
            docker-compose -f ./build/tmint/builder.yaml build base
            ;;
        "build:ex")
             docker-compose -f ./build/tmint/builder.yaml build ex
            ;;
        "build")
            docker-compose -f ./build/tmint/builder.yaml build base
            docker-compose -f ./build/tmint/builder.yaml build ex
            ;;
        "clean:base")
            docker rmi -f ${TMINT_BASE_IMAGE}
            ;;
        "clean:ex")
            docker rmi -f ${TMINT_EX_IMAGE}
            ;;
        "clean")
            docker rmi -f ${TMINT_BASE_IMAGE}
            docker rmi -f ${TMINT_EX_IMAGE}
            docker rmi -f $(docker images --filter "dangling=true" -q)
            ;;
        *)
            echo "Usage: $0 image [command]
            
command:
    build:base   base image
    build:ex     experimental image
    build        all images
    clean:base   base image
    clean:ex     experimental image
    clean        all images"
    esac
}

