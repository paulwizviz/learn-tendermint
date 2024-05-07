#!/bin/bash

export TMINT_EX1_NETWORK="tmint_ex1-network"
export TMINT_EX1_CONTAINER="tmint_ex1-node"
export TMINT_EX1_VOL_ONE="tmint_ex1-vol"

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

export TMINT_EX2_NETWORK="tmint_ex2-network"
export TMINT_EX2_1="tmint_ex2-node-1"
export TMINT_EX2_2="tmint_ex2-node-2"
export TMINT_EX2_VOL="tmint_ex2-vol"

function solo_ex2_network(){
    local cmd=$1
    case $cmd in
        "clean")
            docker-compose -f ./deployments/tmint/solo_ex2.yml down
            docker volume rm ${TMINT_EX2_VOL}
            docker network rm ${TMINT_EX2_NETWORK}
            ;;
        "start")
            docker-compose -f ./deployments/tmint/solo_ex2.yml up
            ;;
        "stop")
            docker-compose -f ./deployments/tmint/solo_ex2.yml down
            docker volume rm -f ${TMINT_EX2_VOL}
            ;;
        *)
            echo "Usage: $0 solo:ex1 [commands]
            
commands:
    clean  solo ex2 containers and network
    start  solo ex2 network
    stop   solo ex2 network"
            ;;
    esac
}

export TMINT_CLUSTER_NETWORK="tmint_cluster-network"

function cluster_network(){
    local cmd=$1
    case $cmd in
        "clean")
            docker-compose -f ./deployments/tmint/cluster.yml down
            docker network rm ${TMINT_CLUSTER_NETWORK}
            ;;
        "start")
            docker-compose -f ./deployments/tmint/cluster.yml up
            ;;
        "stop")
            docker-compose -f ./deployments/tmint/cluster.yml down
            ;;
        *)
            echo "Usage: $0 cluster [commands]
            
commands:
    clean  cluster containers and network
    start  cluster
    stop   cluster"
            ;;
    esac
}