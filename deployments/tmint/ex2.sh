#!/bin/sh

COMMAND=$1

case $COMMAND in
    "abci")
        ex2
        ;;
    "core")
        tendermint init validator
        tendermint node --proxy_app=unix:///var/ex2.socket --rpc.laddr=tcp://0.0.0.0:26657 --p2p.laddr=tcp://0.0.0.0:26656 --consensus.create_empty_blocks=false --db_backend=cleveldb --log_level=debug
        ;;
    *)
        echo "$0 [ abci | core ]"
        ;;
esac