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
SUBCOMMAND2=$3

function network(){
    local cmd=$1
    case $cmd in
        "solo")
            solo_network $SUBCOMMAND2
            ;;
        "clean")
            clean_network
            ;;
        *)
            echo "Usage: $0 network [type]

type:
    solo   network
    clean  network"
    esac
}

case $COMMAND in
    "image")
        image $SUBCOMMAND1
        ;;
    "network")
        network $SUBCOMMAND1
        ;;
    *)
        echo "$0 [command]

command:
    image    operation to build or clean images
    network  related operations"
        ;;
esac