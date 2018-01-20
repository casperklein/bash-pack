#!/bin/bash

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
if [ "$(id -u)" == "0" ]; then
	cd $SCRIPTS &&
	git fetch --all &&
	git reset --hard origin/master &&
	echo &&
	git status
else
	echo "Error: You must be root to run $0" >&2
	echo >&2
fi
