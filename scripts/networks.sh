#!/bin/bash

export TMINT_EX1_NETWORK="tmint_ex1-network"
export TMINT_EX1_CONTAINER="tmint_ex1-node"
export TMINT_EX1_VOL_ONE="tmint_ex1-vol"

export TMINT_PROD_CONTAINER="tmint_prod-container"

function solo_ex1_network(){
    local cmd=$1
    case $cmd in
        "clean")
            docker-compose -f ./deployments/tmint/solo_ex1.yml down
            docker volume rm ${TMINT_EX1_VOL_ONE}
            docker network rm ${TMINT_EX1_NETWORK}
            ;;
        "start")
            docker-compose -f ./deployments/tmint/solo_ex1.yml up
            ;;
        "stop")
            docker-compose -f ./deployments/tmint/solo_ex1.yml down
            ;;
        "shell")
            docker-compose -f ./deployments/tmint/solo_ex1.yml exec -it ex_node /bin/sh
            ;;
        *)
            echo "Usage: $0 solo:ex1 [commands]
            
commands:
    clean  solo ex1 containers and network
    start  solo ex1 network
    stop   solo ex1 network
    shell  solo ex1 network"
            ;;
    esac
}
