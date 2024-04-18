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
        "clean")
            docker-compose -f ./deployments/solo/docker-compose.yml down
            docker rm -f ${SOLO_NODE_CONTAINER}
            docker network rm ${SOLO_NETWORK}
            ;;
        *)
            echo "Usage: $0 solo [commands]
            
commands:
    clean  solo containers and network
    start  solo network
    stop   solo network"
            ;;
    esac
}
