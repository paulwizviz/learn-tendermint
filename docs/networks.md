# Networks

You will find several locally executable networks in this project. The networks are intended for you to learn about the operations behind tendermint.

## Solo

The solo network has one running tendermint node in a setup intended for you to experiment with configuration. The node is based on docker image derived from this [dockerfile](../build/solo.dockerfile). In the dockerfile an executable `tendermint` is derived from this [source code](https://github.com/tendermint/tendermint.git).

The network configuration is found in this [docker compose file](../deployments/solo/docker-compose.yml).

To experiment with the network, use the scripts provided and run the following commands.

* `./scripts/ops.sh image build` to create the solo node.
* `./scripts/ops.sh network solo start` to activate the network.
* `./scripts/ops.sh network solo stop` to de-activate the network.

You will also find example scripts and application (see ) using curl to simulate a client application.

* [ex 1](../examples/ex1/txn.sh) is a client application based on `curl` to:
    * Get status of the solo node.
    * Send a transaction.
    * Query the node.


