#!/usr/bin/env bash

set -euxo pipefail

rm logs.txt

./install

EXPOSE_MAX_CONCURRENT=1 EXPOSE_LOG_LEVEL=1 EXPOSE_PRINT_PATHS=1 ./expoSE "./tests/mm/strictEquals.js" > logs.txt

