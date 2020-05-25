#!/bin/bash

set -ueo pipefail

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
[ "$(id -u)" == "0" ] && ROOT=true || ROOT=false

[ "${1:-}" == "-y" ] && YES=-y || YES=

if [ "$ROOT" = true ]; then
	if [ "${1:-}" == "-u" ]; then
		# update --> more silent
		apt-get update > /dev/null &&
		if aptitude -s -y install $(<"$SCRIPTS"/packages) | grep -q "The following NEW packages will be installed"; then
			echo "Installing new packages.."
			echo
			aptitude install $(<"$SCRIPTS"/packages)
	        fi
	else
		# install
		apt-get update &&
		apt-get $YES install $(<"$SCRIPTS"/packages)
	fi

	# install bat if not installed or outdated
	VERSION=$(dpkg-query -f='${Version}' --show bat 2>/dev/null || echo -n "0")
	TARGET=0.15.2
	if dpkg --compare-versions "$VERSION" "lt" "$TARGET"; then
		# install bat package
		MASCHINE=$(uname -m)
		case "$MASCHINE" in
			x86_64)
				ARCH="amd64"
			       ;;
			aarch64)
				ARCH="arm64"
				;;
			*)
				ARCH="armhf"
				;;
		esac
		dpkg -i "$SCRIPTS"/bat/bat_${TARGET}_$ARCH.deb
	fi
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

# bash_completion
if [ ! -f ~/.bash_completion ]; then
	echo -n 'Creating symlink '
	ln -sv "$SCRIPTS"/bash_completion ~/.bash_completion
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
	{
		echo "Warning: 'unattended-upgrades' package is installed!"
		echo
	} >&2
else
	exit 0
fi
