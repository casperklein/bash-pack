#!/bin/bash

set -ueo pipefail

SCRIPTS=$(dirname "$(readlink -f "$0")")

_installLatest() {
	# $1	package
	# $2..	make actions
	local app version arch target
	app=$1
	shift
	version=$(dpkg-query -f='${Version}' --show "$app" 2>/dev/null || echo -n "0")
	arch=$(dpkg --print-architecture)
	target=$(echo "$SCRIPTS/apps/$app/$app"_*_"$arch.deb" | cut -d_ -f2)
	if dpkg --compare-versions "$version" lt "$target"; then
		# install package
		MAKEFLAGS= make -C "$SCRIPTS/apps/$app/" "$@"
		echo
	else
		echo "$app is up-to-date."
	fi
}

# running as root?
[ "$(id -u)" == "0" ] && ROOT=true || ROOT=false

[ "${1:-}" == "-y" ] && YES=-y || YES=

if [ "$ROOT" = true ]; then
	if [ "${1:-}" == "-u" ]; then
		# update --> more silent
		apt-get update > /dev/null
		if aptitude -s -y install $(cut -d' ' -f1 "$SCRIPTS"/packages) | grep -q "The following NEW packages will be installed"; then
			echo "Installing new packages.."
			echo
			aptitude install $(cut -d' ' -f1 "$SCRIPTS"/packages)
	        fi
	else
		# install
		apt-get update
		apt-get $YES install $(cut -d' ' -f1 "$SCRIPTS"/packages)
	fi

	# install/update custom packages
	_installLatest bat install
	_installLatest duf install
	_installLatest tmux install copy-conf

	# todo remove in the future; see also uninstall.sh
	# remove .bash_completion symlink from previous version
	if [ "$(readlink -f ~/.bash_completion)" == "$DIR/bash_completion" ]; then
		echo 'Removing symlink' ~/.bash_completion "-> $DIR/bash_completion"
		rm ~/.bash_completion
	fi
else
	echo "Warning: You are not root. Package installation skipped." >&2
fi
echo

# bashrc
if [ ! -f ~/.bashrc.local ]; then
	echo 'Creating         ' ~/.bashrc.local
	echo 'return' > ~/.bashrc.local
	cat ~/.bashrc >> ~/.bashrc.local
fi

if [ ! -f ~/.bashrc.backup ] && [ -f ~/.bashrc ]; then
	echo 'Moving           ' ~/.bashrc '->' ~/.bashrc.backup
	mv ~/.bashrc ~/.bashrc.backup
fi

if [ ! -f ~/.bashrc ]; then
	echo -n 'Creating symlink '
	ln -sv "$SCRIPTS"/bashrc ~/.bashrc
fi

echo

# inputrc
if [ ! -f ~/.inputrc ]; then
	echo -n 'Creating symlink '
	ln -sv "$SCRIPTS"/inputrc ~/.inputrc
	echo
fi

# vimrc
if [ "$ROOT" = true ]; then
	if [ -f /etc/vim/vimrc ] && [ ! -f /etc/vim/vimrc.backup ]; then
		echo 'Moving            /etc/vim/vimrc -> /etc/vim/vimrc.backup'
		mv /etc/vim/vimrc /etc/vim/vimrc.backup
	fi
	if [ ! -f /etc/vim/vimrc ]; then
		echo -n 'Creating symlink '
		ln -sv "$SCRIPTS"/vimrc /etc/vim/vimrc
	fi
fi

echo 'Done.'
echo

if aptitude search ~iunattended-upgrades &> /dev/null; then
	echo "Warning: 'unattended-upgrades' package is installed!"
	echo
fi >&2
