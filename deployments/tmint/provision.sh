#!/bin/sh

COMMAND=$1

case $COMMAND in
    "ex1")
        tendermint init validator
        ex1
        ;;
    "ex2")
        tendermint init validator
        ex2
        tendermint node --proxy_app=unix://var/abci/ex2.socket --rpc.laddr=tcp://0.0.0.0:26657 --p2p.laddr=tcp://0.0.0.0:26656 --consensus.create_empty_blocks=false --db_backend=cleveldb --log_level=debug
        ;;
    *)
        echo "Usage: $0 [ ex1 | ex2 ]"
        ;;
esac