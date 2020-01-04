#!/bin/bash

[ -z "$TRASHDIR" ] && TRASHDIR=~/.trash

set -ueo pipefail

hash rm 2>/dev/null || { echo "Error: Binary 'rm' is missing."; echo; exit 1; } >&2

echo Deleting files..
rm -rf "$TRASHDIR"
