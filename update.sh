#!/bin/bash

# running as root?
if [ "$(id -u)" == "0" ]; then
	cd /scripts &&
	git pull
else
	echo "Error: You must be root to run $0" >&2
	echo
fi
