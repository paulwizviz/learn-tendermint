#!/bin/bash

export SOLO_NETWORK="learn-tendermint_solo"
export TENDERMINT_PROD_CONTAINER="solo_prod_container"
export TENDERMINT_DEV_CONTAINER="solo_dev_container"

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
