#!/bin/bash

startAnimation() {
	if [ -n "$APID" ]; then
		echo
		echo "Error: Animation already running. Call stopAnimation() first." >&2
		echo
		exit 1
	fi
	(tty -s) || return # no tty? no animation!
	CODE='
		DELETE="\033[1D"
		SLEEP=0.5
		while :; do
		echo -en "\\"
		sleep $SLEEP
		echo -en "$DELETE|"
		sleep $SLEEP
		echo -en "$DELETE/"
		sleep $SLEEP
		echo -en "$DELETE-"
		sleep $SLEEP
		echo -en "$DELETE"
		done
	'

	echo "$CODE" | bash &
	APID=$!
	APIDFILE=$(mktemp /tmp/${0##*/}.animation.XXX.pid)
	echo $APID > "$APIDFILE"
}

stopAnimation() {
	if [ -n "$APID" ]; then
		kill -9 $APID &>/dev/null
		wait $APID &>/dev/null	# hide kill message from background job: https://stackoverflow.com/a/5722850/568737
		echo -ne "\033[1D\033[K"
		APID=
		[ -n "$APIDFILE" ] && rm "$APIDFILE"
	fi
}

<<"comment"
# if argument is given, start a 5 second demo
if [ ! -z "$1" ]; then
	trap stopAnimation EXIT

	echo -n "Working hard.. "
	startAnimation
	#startAnimation # fore error
	sleep 5
	stopAnimation && echo
fi
comment
