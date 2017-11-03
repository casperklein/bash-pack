#!/bin/bash

# running as root?
if [ "$(id -u)" == "0" ]; then
	cd /scripts &&
	git fetch &> /dev/null || {
		echo "Error: 'git fetch' failed." >&2
		echo >&2
		exit 1
	}
	DIFF=$(PAGER=cat git log HEAD..origin)
	if [ ! -z "$DIFF" ]; then
	       	echo "Commits to pull:"
		echo
		echo "$DIFF"
		echo
		read -p "Press ENTER to continue.."
		echo
	fi
	git pull
else
	echo "Error: You must be root to run $0" >&2
	echo
fi
