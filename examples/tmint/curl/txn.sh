#!/bin/sh

COMMAND=$1

case $COMMAND in
    "send")
        curl -s 'localhost:26657/broadcast_tx_commit?tx="name=satoshi"'
        ;;
    "query")
        curl -s 'localhost:26657/abci_query?data="name"'
        ;;
    *)
        echo "$0 [ send | query ]"
        ;;
esac