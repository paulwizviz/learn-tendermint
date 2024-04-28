#!/bin/sh

COMMAND=$1

case $COMMAND in
    "tx-kv-send")
        curl -s 'localhost:26657/broadcast_tx_commit?tx="name=satoshi"'
        ;;
    "tx-kv-query")
        curl -s 'localhost:26657/abci_query?data="name"'
        ;;
    "tx-send")
        curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'
        ;;
    "tx-query")
        curl -s 'localhost:26657/abci_query?data="abcd"'
        ;;
    *)
        echo "$0 tx-kv-send | tx-kv-query | tx-send | tx-query"
        ;;
esac