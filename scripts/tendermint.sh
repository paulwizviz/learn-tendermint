#!/bin/sh

if [ "$(basename $(realpath .))" != "learn-cosmos" ]; then
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
        tmint_image $SUBCOMMAND1
        ;;
    "solo:ex1")
        solo_ex1_network $SUBCOMMAND1
        ;;
    "solo:ex2")
        solo_ex2_network $SUBCOMMAND1
        ;;
    "clean")
        solo_ex1_network clean
        tmint_image clean
        ;;
    *)
        echo "Usage: $0 [command]
        
command:
    image     build and clean images
    solo:ex1  network operations
    solo:ex2  network operations
    clean     removes all project artefacts"
    ;;
esac