#!/bin/bash

set -ueo pipefail

# set default directory if $TRASHDIR is not given
TRASHDIR=${TRASHDIR:-~/.trash}

hash rm 2>/dev/null || { echo "Error: Binary 'rm' is missing."; echo; exit 1; } >&2

echo Deleting files..
rm -rf "$TRASHDIR"
