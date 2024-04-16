# Local Node

This section looks at:

* process to build node from source;
* features of a tendermint node via a working local node.

## Building node from source code

The tendermint source code is found [here](https://github.com/tendermint/tendermint.git).

The process to build tendermint from source is [here](../build/localbuild.dockerfile).

## Solo network

You will find a network with a solo node [here](../deployments/solo/docker-compose.yml).

To run the solo network follow this steps:

* STEP 1 - Build a solo docker image by running this command `./scripts/ops.sh image build`
* STEP 2 - Start the network by running this command `./scripts/ops.sh network solo start`

To learn what the tendermint node offer you can run the following commands:

* `curl -s localhost:26657/status` - return the status of the node
* Sending Transactions
    * `curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'`
    * `curl -s 'localhost:26657/abci_query?data="abcd"'`
    * `curl -s 'localhost:26657/broadcast_tx_commit?tx="name=satoshi"'`
    * `curl -s 'localhost:26657/abci_query?data="name"'`

