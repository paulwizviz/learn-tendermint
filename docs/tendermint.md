# Tendermint

The term `tendermint` is confusing; it refers to many things depending on your point of view. Let's unpack what that term means.

* Tendermint vs Cosmos
* Tendermint from a developer's perspective

The comparison between Tendermint vs Cosmos discussed in [Tendermint & Cosmos SDK Demystified](https://medium.com/coinmonks/tendermint-cosmos-sdk-demystified-47385cf77cf6). The subject of CosmosSDK is left for discuss later. For now, just think of CosmosSDK as a superset of Tendermint.

Fron a developer's perspective, Tendermint is:

* an open source Go based projects;
* a collecion of tools to help you develop replicated application (i.e. the basis for Layer 1 of a blockchain stack);
* an orchestrator to instantiate practical Byzantine Fault Tolerant (pBFT) consensus engine;
* a library for the creation of Application BlockChain Interface (ABCI) applications.

## Tendermint source code

The project\s source code is [(https://github.com/tendermint/tendermint.git](https://github.com/tendermint/tendermint.git).

From the source code, you derived:

* a `ABCI-CLI` tool;
* an orchesttration tool named `tendermint` to execute an engine known as `tendermint core`;
* a series of cli tools. also known as `tendermint`, to diagnose a running `tendermint core`;
* a set of Go based packages (or libraries) to help you build `ABCI` application.

## Tendermint core

The tendermint core is an executable process comprise of these elements:

* a pBFT consensus engine;
* a P2P networking protocol;
* an JSON RPC protocol.

### The pBFT consensus engine

The pBFT consensus engine ensures that transactions sent to a network of nodes, and all nodes record the transactions in the right order. The pBFT consensus algorithm is described in [what is tendermint?](https://docs.tendermint.com/v0.34/introduction/what-is-tendermint.html).

### The P2P protocol

The P2P protocol enable nodes hosting the tendermint core, is the basis for nodes to communicate with each other on a peer-to-peer basis.

### The JSON RPC protocol

The JSON RPC protocol enable client applications to communicate (i.e. send transactions) with the tendermint core.

## `ABCI` application

The ABCI application, not be confused with client applications, is an application to accompanying the tendermint core (see Figure 1).

![Figure 1](../assets/img/tendermint-arch.png)<br>
Figure 1: Tendermint architecture

The ABCI application provides business logic to process transactions sent to the core via the tendermint core.