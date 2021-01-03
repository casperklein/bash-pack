#!/bin/bash

set -ueo pipefail

trapCtrlC() {
	echo
	echo "Aborting.."
	echo
	exit 1
}

trap trapCtrlC SIGINT   # Catch CTRL-C

if [ $# -lt 2 ]; then
	APP=${0##*/}
	echo "Wait for a TCP port to be available."
	echo
	echo "Syntax: $APP <host> <port> [<timeout> <delay>]"
	echo
	exit 1
fi >&2

# 1 second default
TIMEOUT=${3:-1}
DELAY=${4:-1}

echo "Host:    $1"
echo "Port:    $2"
echo "Timeout: $TIMEOUT"
echo "Delay:   $DELAY"
echo

# inspired from: https://github.com/hassio-addons/bashio/blob/master/lib/net.sh
until (timeout "$TIMEOUT" bash -c "< /dev/tcp/$1/$2") &> /dev/null; do
	echo -n .
	sleep "$DELAY"
done

echo
echo ">> $1:$2 connected."
echo
