#!/bin/bash

export TMINT_EX_NETWORK="learn-cosmos_ex"

export TMINT_EX_CONTAINER="tmint_ex-container"

export TMINT_PROD_CONTAINER="tmint_prod-container"

function solo_network(){
    local cmd=$1
    case $cmd in
        "clean")
            docker-compose -f ./deployments/tmint/ex.yml down
            docker network rm ${TMINT_EX_NETWORK}
            ;;
        "start:ex")
            docker-compose -f ./deployments/tmint/ex.yml up
            ;;
        "stop:ex")
            docker-compose -f ./deployments/tmint/ex.yml down
            ;;
        "shell:ex")
            docker-compose -f ./deployments/tmint/ex.yml exec -it ex_node /bin/bash
            ;;
        *)
            echo "Usage: $0 solo [commands]
            
commands:
    clean     solo containers and network
    start:ex  solo experimental network
    stop:ex   solo experimental network
    shell:ex  solo experimental network"
            ;;
    esac
}
