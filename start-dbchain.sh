#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

git submodule update --init

cd blockscout-rs-neti/golem-base-tools/
cargo build

cd ../../golembase-op-geth
patch -N <../golembase-op-geth-enable-txpool-api.diff || true
patch -N <../golembase-op-geth-rpclorer-external-port.diff || true
patch -N <../golembase-op-geth-all-interfaces.diff || true
docker compose up -d --build

cd cmd/golembase
go build -o golembase
./golembase account create
./golembase account fund

echo
echo "Running. Visit http://localhost:9000/ to verify."
echo "RPC endpoint available at http://localhost:8545 and ws://localhost:8545"
