#!/bin/bash

set -ueo pipefail

# set default directory if $TRASHDIR is not given
TRASHDIR=${TRASHDIR:-~/.trash}

checkBinarys() {
	for i in "$@"; do
		hash "$i" 2>/dev/null || {
			echo "Error: Binary '$i' is missing."
			echo
			exit 1
		} >&2
	done
}

checkBinarys "find" "shred" "rm"

# shred all files?
if [ $# -eq 0 ]; then
	# shred files, skip if link count is > 1
	find "$TRASHDIR" -type f -links 1 -exec shred -vn 1 "{}" \;
else
	# get file extensions from command line arguments
	SHRED=("$@")
	for i in "${SHRED[@]}"; do
		find "$TRASHDIR" -type f -links 1 -iname "*.$i" -exec shred -vn 1 -s 100K "{}" \;
	done
fi

echo Deleting files..
rm -rf "$TRASHDIR"
