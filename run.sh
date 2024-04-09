#!/usr/bin/env bash

set -euxo pipefail

rm -rf test_*
rm logs.txt

# pushd ../eslint
# git clean -f
# popd

./install

# EXPOSE_MAX_CONCURRENT=1 EXPOSE_LOG_LEVEL=0 EXPOSE_PRINT_PATHS=1 ./expoSE ../demo-regex/demo.custom.js > logs.txt
# EXPOSE_MAX_CONCURRENT=1 EXPOSE_LOG_LEVEL=1 EXPOSE_PRINT_PATHS=1 ./expoSE ../demo-regex/demo.symbolic.js > logs.txt
EXPOSE_MAX_CONCURRENT=1 EXPOSE_LOG_LEVEL=1 EXPOSE_PRINT_PATHS=1 ./expoSE "./strictEquals.js" > logs.txt

# EXPOSE_PRINT_PATHS=1 ./expoSE ./test.js > logs.txt
# EXPOSE_PRINT_PATHS=1 Z3_PATH=/home/mayant/code/js-bugs/ExpoSE/Analyser/node_modules/z3javascript/bin/libz3.so EXPOSE_OUT_PATH=/home/mayant/code/js-bugs/ExpoSE/out.txt EXPOSE_COVERAGE_PATH=/home/mayant/code/js-bugs/ExpoSE/coverage.txt ./scripts/play /home/mayant/code/js-bugs/ExpoSE/test.js {\"_bound\":0} > logs.txt
# node ./test.js
