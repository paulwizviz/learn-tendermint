#!/bin/bash

export SOLO_NETWORK="learn-tendermint_solo"
export SOLO_NODE_CONTAINER="solo_container"

function solo_network(){
    local cmd=$1
    case $cmd in
        "start")
            docker-compose -f ./deployments/solo/docker-compose.yml up
            ;;
        "stop")
            docker-compose -f ./deployments/solo/docker-compose.yml down
            ;;
        *)
            echo "Usage: $0 network [type]
            
type:
    start  solo network
    stop   solo network"
            ;;
    esac
}

function clean_network(){
    docker rm -f ${SOLO_NODE_CONTAINER}
    docker network rm ${SOLO_NETWORK}
}