# Networks

In this section, we'll examine the different ways of deploying Tendermint core to form a network.

## Solo

In this project, you will find a network with a single tendermint core (solo) node.

The solo node is created from this [docker image](../build/solo.dockerfile). The executable tendermint is to derived from this [source code](https://github.com/tendermint/tendermint.git).

The network configuration is found in this [docker compose file](../deployments/solo/docker-compose.yml) for a working example.

To run the solo network follow this steps:

* STEP 1 - Build a solo docker image by running this command `./scripts/ops.sh image build`
* STEP 2 - Start the network by running this command `./scripts/ops.sh network solo start`

Use the solo node to learn how interact with tendermint. You find several examples to see how the interactions works:

* [ex 1](../examples/ex1/txn.sh), demonstrating the use of `curl`, In this example, you will use curl to:
    * Get status of the solo node.
    * Send a transaction.
    * Query the node.


