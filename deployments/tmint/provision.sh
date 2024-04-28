#!/bin/sh

COMMAND=$1

case $COMMAND in
    "ex1")
        tendermint init validator
        ex1
        ;;
    "ex2")
        tendermint init
        ex2
        tendermint start --proxy_app=unix://example.sock --rpc.laddr=tcp://0.0.0.0:26657 --p2p.laddr=tcp://0.0.0.0:26656 --consensus.create_empty_blocks=false --db_backend=cleveldb --log_level=debug
        ;;
    *)
        echo "Usage: $0 [ ex1 | ex2 ]"
        ;;
esac