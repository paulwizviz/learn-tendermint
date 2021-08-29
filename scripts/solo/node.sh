#!/bin/bash

export TENDERMINT_NODE_IMAGE="learn-tendermint/tendermint:current"
export TENDERMINT_SOLO_CONTAINER="tendermint-solo-container"
export NETWORK_NAME="learn-tendermint_network"

COMMAND=$1

case $COMMAND in
    "clean")
        docker rmi -f ${TENDERMINT_NODE_IMAGE}
        docker rmi -f $(docker images --filter "dangling=true" -q)
        ;;
    "run")
        docker-compose -f ./deployments/solo/docker-compose.yml up
        ;;
    "shell")
        docker exec -it $TENDERMINT_SOLO_CONTAINER /bin/bash
        ;;
    "status")
        curl -s localhost:26657/status
        ;;
    "stop")
        docker-compose -f ./deployments/solo/docker-compose.yml down
        ;;
    *)
        echo "$0 clean | run | shell | status | stop"
        ;;
esac