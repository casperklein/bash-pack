#!/bin/bash

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
if [ "$(id -u)" -eq 0 ]; then
	cd "$SCRIPTS" &&
	git fetch &> /dev/null || {
		echo "Error: 'git fetch' failed."
		echo
		exit 1
	} >&2
	DIFF=$(PAGER="cat" git log HEAD..origin)
	if [ -n "$DIFF" ]; then
	       	echo "Commits to pull:"
		echo
		echo "$DIFF"
		echo
		read -r -p "Press ENTER to continue.."
		echo
	fi
	git pull
	echo
	"$SCRIPTS"/install.sh -u
#	if aptitude -s -y install $(<"$SCRIPTS"/packages) | grep -q "The following NEW packages will be installed"; then
#		echo "Installing new packages.."
#		echo
#		aptitude update
#		aptitude install $(<"$SCRIPTS"/packages)
#	fi
else
	echo "Error: You must be root to run $0" >&2
	echo >&2
fi
