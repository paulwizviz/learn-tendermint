#!/bin/bash

COMMAND=$1

case $COMMAND in
    run)
        docker-compose -f ./deployments/four-node/docker-compose.yml up
        ;;
    *)
        ;;
esac
