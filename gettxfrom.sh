#!/usr/bin/env bash

curl -X POST  http://127.0.0.1:8091/walletextension/gettransactionsfromthis -d '{"account" : {"address" : "$1"}, "offset": 0, "limit": 10}'
