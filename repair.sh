#!/bin/bash

set -ueo pipefail

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
if [ "$(id -u)" == "0" ]; then
	cd "$SCRIPTS"
	echo "Wiping local changes.."
	echo
	git fetch
	git reset --hard origin/master
	echo
	git status
	echo
	"$SCRIPTS"/install.sh
else
	echo "Error: You must be root to run '$0'" >&2
	echo >&2
fi
