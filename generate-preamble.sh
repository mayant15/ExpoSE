#!/usr/bin/env bash

set -euxo pipefail

SILICON_DIR="/home/mayant/code/viper/silicon"
SILICON="$SILICON_DIR/silicon.sh"
LOG_FILE_OUT="/home/mayant/code/js-symbex/ExpoSE/preamble"

# "$SILICON" --numberOfParallelVerifiers 1 --proverLogFile "$LOG_FILE_OUT" "$1"
"$SILICON" --numberOfParallelVerifiers 1 --counterexample variables --exhaleMode 1 --proverLogFile "$LOG_FILE_OUT" "$1"

