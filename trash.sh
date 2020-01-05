#!/bin/bash

# trash
# A script similar to the recycle bin feature on windows platforms.
# It moves files/directorys to a defined directory instead of removing them from the filesystem.
# If you really want to get rid of them, you can use the trash-empty.sh or trash-empty-shred.sh command.

# Version:  0.3
# Build:    2020-01-04
# Author:   Heiko Barth
# Licence:  Beer-Ware (See: http://en.wikipedia.org/wiki/Beerware)

APP=${0##*/}
VER=0.3

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

[ $# -eq 0 ] && {
	echo "$APP $VER"
	echo
	echo "Syntax: $APP <directory/file> [<another directory/file>]"
	echo
	exit 1
} >&2

checkBinarys "basename" "mkdir" "mv" "stat"

mkdir -p "$TRASHDIR" 2> /dev/null || {
	echo "Error: Failed to create directory '$TRASHDIR'."
	echo
	exit 1
} >&2

FAIL=0

# Set your desired date format; See 'man date' for details
TODAY=$(date +%Y-%m-%d)

for i in "$@"; do
	# Abort if file does not exist and is no symbolic link (there can be symbolic links pointing to files that does not exist)
	if [ ! -e "$i" ] && [ "$(stat -c %F "$i" 2>/dev/null)" != "symbolic link" ]; then
		echo "Error: File/Directory '$i' does not exist." >&2
		FAIL=1
		continue
	fi

	# basename of file or directory
	NAME=$(basename "$i")

	# Create target directory
	mkdir -p -m 700 "$TRASHDIR/$TODAY" 2> /dev/null || {
		echo "Error: Failed to create directory '$TRASHDIR/$TODAY'."
		echo
		exit 1
	} >&2

	# If target exist, find an alternate name
	if [ -e "$TRASHDIR/$TODAY/$NAME" ] || [ -h "$TRASHDIR/$TODAY/$NAME" ]; then
		j=0
		while :; do
			((++j))
			if [ ! -e "$TRASHDIR/$TODAY/$NAME.$j" ] && [ ! -h "$TRASHDIR/$TODAY/$NAME.$j" ]; then
				mv "$i" "$TRASHDIR/$TODAY/$NAME.$j" || {
					echo "Error: Failed to move '$i' --> '$TRASHDIR/$TODAY/$NAME.$j'"
					FAIL=1
				} >&2
				break
			fi
		done
	else
		mv "$i" "$TRASHDIR/$TODAY/$NAME" || {
			echo "Error: Failed move '$i' --> '$TRASHDIR/$TODAY/$NAME'"
			FAIL=1
		} >&2
	fi
done

[ $FAIL -gt 0 ] && exit 1 || exit 0
