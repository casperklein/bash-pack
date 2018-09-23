#!/bin/bash

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
if [ "$(id -u)" == "0" ]; then
	"$SCRIPTS"/install.sh repair &&
	echo &&
	echo &&
	cd "$SCRIPTS" &&
	echo "Wiping local changes.." &&
	echo &&
	git fetch &&
	git reset --hard origin/master &&
	echo &&
	git status
	echo
else
	echo "Error: You must be root to run $0" >&2
	echo >&2
fi
