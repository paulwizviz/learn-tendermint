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
    "image")
        image $SUBCOMMAND1
        ;;
    "solo")
        solo_network $SUBCOMMAND1
        ;;
    "clean")
        solo_network clean
        image clean
        ;;
    *)
        echo "$0 [command]

command:
    image  operation to build or clean images
    solo   a network with solo tendermint node
    clean  containers and images"
        ;;
esac