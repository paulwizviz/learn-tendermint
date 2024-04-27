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
	db           *badger.DB
	currentBatch *badger.Txn
}

func NewApp(db *badger.DB) *App {
	return &App{
		db: db,
	}
}

func (App) Info(req types.RequestInfo) types.ResponseInfo {
	fmt.Println(req)
	return types.ResponseInfo{}
}

func (App) SetOption(req types.RequestSetOption) types.ResponseSetOption {
	fmt.Println(req)
	return types.ResponseSetOption{}
}

func (App) DeliverTx(req types.RequestDeliverTx) types.ResponseDeliverTx {
	fmt.Println(req)
	return types.ResponseDeliverTx{Code: 0}
}

func (App) CheckTx(req types.RequestCheckTx) types.ResponseCheckTx {
	fmt.Println(req)
	return types.ResponseCheckTx{Code: 0}
}

func (App) Commit() types.ResponseCommit {
	fmt.Println("--Commit--")
	return types.ResponseCommit{}
}

func (App) Query(req types.RequestQuery) types.ResponseQuery {
	fmt.Println(req)
	return types.ResponseQuery{Code: 0}
}

func (App) InitChain(req types.RequestInitChain) types.ResponseInitChain {
	fmt.Println(req)
	return types.ResponseInitChain{}
}

func (App) BeginBlock(req types.RequestBeginBlock) types.ResponseBeginBlock {
	fmt.Println(req)
	return types.ResponseBeginBlock{}
}

func (App) EndBlock(req types.RequestEndBlock) types.ResponseEndBlock {
	fmt.Println(req)
	return types.ResponseEndBlock{}
}

func (App) ListSnapshots(req types.RequestListSnapshots) types.ResponseListSnapshots {
	fmt.Println(req)
	return types.ResponseListSnapshots{}
}

func (App) OfferSnapshot(req types.RequestOfferSnapshot) types.ResponseOfferSnapshot {
	fmt.Println(req)
	return types.ResponseOfferSnapshot{}
}

func (App) LoadSnapshotChunk(req types.RequestLoadSnapshotChunk) types.ResponseLoadSnapshotChunk {
	fmt.Println(req)
	return types.ResponseLoadSnapshotChunk{}
}

func (App) ApplySnapshotChunk(req types.RequestApplySnapshotChunk) types.ResponseApplySnapshotChunk {
	fmt.Println(req)
	return types.ResponseApplySnapshotChunk{}
}

func main() {
	cfgFile := "/root/.tendermint/config/config.toml"
	cfg := config.DefaultConfig()
	cfg.RootDir = filepath.Dir(filepath.Dir(cfgFile))
	fmt.Println(cfg.ProxyApp)
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

	app := NewApp(db)

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
