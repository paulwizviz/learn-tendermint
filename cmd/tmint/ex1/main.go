package main

import (
	"fmt"
	"os"
	"os/signal"
	"path/filepath"
	"syscall"

	"github.com/dgraph-io/badger"
	"github.com/tendermint/tendermint/abci/types"
	"github.com/tendermint/tendermint/config"
	"github.com/tendermint/tendermint/libs/log"
	"github.com/tendermint/tendermint/node"
	"github.com/tendermint/tendermint/p2p"
	"github.com/tendermint/tendermint/privval"
	"github.com/tendermint/tendermint/proxy"
)

type App struct {
	db *badger.DB
	//currentBatch *badger.Txn
	logger log.Logger
}

func NewApp(db *badger.DB, logger log.Logger) *App {
	return &App{
		db:     db,
		logger: logger,
	}
}

func (a App) Info(req types.RequestInfo) types.ResponseInfo {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseInfo{}
}

func (a App) SetOption(req types.RequestSetOption) types.ResponseSetOption {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseSetOption{}
}

func (a App) DeliverTx(req types.RequestDeliverTx) types.ResponseDeliverTx {
	a.logger.Info(fmt.Sprintf("--DeliverTx-- Request: %v", req))
	return types.ResponseDeliverTx{Code: 0}
}

func (a App) CheckTx(req types.RequestCheckTx) types.ResponseCheckTx {
	a.logger.Info(fmt.Sprintf("--CheckTx-- Request: %v", req))
	return types.ResponseCheckTx{Code: 0}
}

func (a App) Commit() types.ResponseCommit {
	a.logger.Info("--Commit--")
	return types.ResponseCommit{}
}

func (a App) Query(req types.RequestQuery) types.ResponseQuery {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseQuery{Code: 0}
}

func (a App) InitChain(req types.RequestInitChain) types.ResponseInitChain {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseInitChain{}
}

func (a App) BeginBlock(req types.RequestBeginBlock) types.ResponseBeginBlock {
	a.logger.Info(fmt.Sprintf("--BeginBlock-- Request: %v", req))
	//a.currentBatch = a.db.NewTransaction(true) // Starts a DB session
	return types.ResponseBeginBlock{}
}

func (a App) EndBlock(req types.RequestEndBlock) types.ResponseEndBlock {
	a.logger.Info(fmt.Sprintf("--EndBlock-- Request: %v", req))
	return types.ResponseEndBlock{}
}

func (a App) ListSnapshots(req types.RequestListSnapshots) types.ResponseListSnapshots {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseListSnapshots{}
}

func (a App) OfferSnapshot(req types.RequestOfferSnapshot) types.ResponseOfferSnapshot {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseOfferSnapshot{}
}

func (a App) LoadSnapshotChunk(req types.RequestLoadSnapshotChunk) types.ResponseLoadSnapshotChunk {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseLoadSnapshotChunk{}
}

func (a App) ApplySnapshotChunk(req types.RequestApplySnapshotChunk) types.ResponseApplySnapshotChunk {
	a.logger.Info(fmt.Sprintf("Request: %v", req))
	return types.ResponseApplySnapshotChunk{}
}

func main() {
	cfgFile := "/root/.tendermint/config/config.toml"
	cfg := config.DefaultConfig()
	cfg.RootDir = filepath.Dir(filepath.Dir(cfgFile))

	cfg.Consensus.CreateEmptyBlocks = false
	cfg.RPC.ListenAddress = "tcp://0.0.0.0:26657"

	logger := log.NewTMLogger(log.NewSyncWriter(os.Stdout))

	pv := privval.LoadFilePV(
		cfg.PrivValidatorKeyFile(),
		cfg.PrivValidatorStateFile(),
	)

	nodeKey, err := p2p.LoadNodeKey(cfg.NodeKeyFile())
	if err != nil {
		fmt.Printf("failed to load node's key: %v", err)
		os.Exit(1)
	}

	db, err := badger.Open(badger.DefaultOptions("/tmp/badger"))
	if err != nil {
		fmt.Fprintf(os.Stderr, "failed to open badger db: %v", err)
		os.Exit(1)
	}
	defer db.Close()

	app := NewApp(db, logger)

	n, err := node.NewNode(
		cfg,
		pv,
		nodeKey,
		proxy.NewLocalClientCreator(app),
		node.DefaultGenesisDocProviderFunc(cfg),
		node.DefaultDBProvider,
		node.DefaultMetricsProvider(cfg.Instrumentation),
		logger)
	if err != nil {
		fmt.Println("new node", err)
		os.Exit(1)
	}

	n.Start()
	defer func() {
		n.Stop()
		n.Wait()
	}()

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c
	os.Exit(0)
}
