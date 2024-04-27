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
    "solo")
        solo_network $SUBCOMMAND1
        ;;
    "clean")
        solo_network clean
        tmint_image clean
        ;;
    *)
        echo "Usage: $0 [command]
        
command:
    image  build and clean images
    solo   network operations
    clean  removes all project artefacts"
    ;;
esac