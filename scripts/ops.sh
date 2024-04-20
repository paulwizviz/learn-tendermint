#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-tendermint" ]; then
    echo "You are outside of the project"
    exit 0
else
    . ./scripts/images.sh
    . ./scripts/networks.sh
fi

COMMAND=$1
SUBCOMMAND1=$2

case $COMMAND in
    "clean")
        solo_network clean
        image clean
        ;;
    "dev")
        docker run --name ${TENDERMINT_DEV_CONTAINER} -it --rm ${TENDERMINT_DEV_IMAGE} /bin/bash
        ;;
    "image")
        image $SUBCOMMAND1
        ;;
    "solo")
        solo_network $SUBCOMMAND1
        ;;
    *)
        echo "$0 [command]

command:
    clean  containers and images
    dev    shell into a developer container
    image  operation to build or clean images
    solo   a network with solo tendermint node"
        ;;
esac