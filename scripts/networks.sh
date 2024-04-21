#!/bin/bash

export DEV_NETWORK="learn-tendermint_dev"
export SOLO_NETWORK="learn-tendermint_solo"

export TMINT_PROD_CONTAINER="tmint_prod_container"
export TMINT_DEV_CONTAINER="tmint_dev_container"

function solo_network(){
    local cmd=$1
    case $cmd in
        "start")
            docker-compose -f ./deployments/solo/docker-compose.yml up
            ;;
        "shell")
            docker-compose -f ./deployments/solo/docker-compose.yml exec -it dev_node /bin/bash
            ;;
        "stop")
            docker-compose -f ./deployments/solo/docker-compose.yml down
            ;;
        "clean")
            docker-compose -f ./deployments/solo/docker-compose.yml down
            rm -rf ./deployments/solo/tmint
            docker rm -f ${TMINT_DEV_CONTAINER}
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
