#!/bin/bash

_animationStart() {
	if [ -n "${APID:-}" ]; then
		echo
		echo "Error: Animation already running. Call stopAnimation() first." >&2
		echo
		exit 1
	fi
	tty -s || return 0 # no tty? no animation!

	tput civis # hide cursor

	# shellcheck disable=SC2016
	local CODE='
		ANIMATION=("\\" "|" "/" "-")
		DELETE=$(echo -ne "\033[1D")
		while :; do
			for i in "${ANIMATION[@]}"; do
				echo -n "$i"
				sleep 0.2
				echo -n "$DELETE"
			done
		done
	'

	echo "$CODE" | bash &
	APID=$!
}

_animationStop() {
	tput cnorm # show cursor

	if [ -n "${APID:-}" ]; then
		kill -9 "$APID" &>/dev/null
		wait "$APID" &>/dev/null || true	# hide kill message from background job: https://stackoverflow.com/a/5722850/568737
		echo -ne "\033[1D\033[K"
		APID=
		# [ -n "$APIDFILE" ] && rm "$APIDFILE"
	fi
}

# EXIT trap already set?
if [ -z "$(trap -p EXIT)" ]; then
	trap _animationStop EXIT
else
	# append _animationStop() to existing trap
	# shellcheck disable=SC2064
	trap "$(trap -p EXIT | cut -d"'" -f2); _animationStop" EXIT
fi

# not sourced? show demo
if [ "${BASH_SOURCE[0]}" == "$0" ]; then
	echo -n "Working hard.. "
	_animationStart
	sleep 3
	_animationStop
	echo
fi
