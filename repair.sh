#!/bin/bash

set -ueo pipefail

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
if [ "$(id -u)" == "0" ]; then
	cd "$SCRIPTS"
	echo "Wiping local changes.."
	echo

	if [ "${1:-}" == "--hard" ]; then
		# save origin if possible
		ORIGIN=$(git remote get-url origin 2>/dev/null || echo 'https://github.com/casperklein/bash-pack.git')
		# complete wipe
		rm -rf .git
		# start from scratch
		git init --quiet
		git remote add origin "$ORIGIN"
		git fetch --depth=1 origin
		git remote set-head -a origin
		git reset --hard origin/master
		git branch --set-upstream-to=origin/master
	else
		# shellcheck disable=2015
		git fetch && git reset --hard origin/master || {
			echo
			echo "Something went wrong. You may try: $0 --hard"
			exit 1
		} >&2
	fi

	echo
	"$SCRIPTS"/install.sh
	echo
	git status
	echo
else
	echo "Error: You must be root to run '$0'" >&2
	echo >&2
fi
