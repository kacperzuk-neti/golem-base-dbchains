#!/bin/sh

set -euo pipefail

cd "$(dirname "$0")"/golembase-op-geth/cmd/golembase

./golembase entity create --data "$(date): data that will expire almost immediately" --btl 1 -s key1:value1 -n key2:123

./golembase entity create --data "$(date): data with annotations" --btl 1000 -s key1:value1 -n key2:123

deleteme=$(./golembase entity create --data "$(date): data that will be deleted" --btl 1000 | awk '{ print $NF }')
./golembase entity delete --key $deleteme

updateme=$(./golembase entity create --data "$(date): data that will be updated" --btl 1000 | awk '{ print $NF }')
./golembase entity update --key $updateme --data "$(date): data that was updated" --btl 2000
