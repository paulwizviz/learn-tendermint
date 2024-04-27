#!/bin/bash

export SOLO_NETWORK="learn-cosmos_solo"

export TMINT_DEV_CONTAINER="tmint_dev-container"
export TMINT_PROD_CONTAINER="tmint_prod-container"

function solo_network(){
    local cmd=$1
    case $cmd in
        "start")
            docker-compose -f ./deployments/tmint/solo.yml up
            ;;
        "shell")
            docker-compose -f ./deployments/tmint/solo.yml exec -it dev_node /bin/bash
            ;;
        "stop")
            docker-compose -f ./deployments/tmint/solo.yml down
            ;;
        "clean")
            docker-compose -f ./deployments/tmint/solo.yml down
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
