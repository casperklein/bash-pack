#!/bin/bash

SCRIPTS=$(dirname "$(readlink -f "$0")")

# running as root?
[ "$(id -u)" == "0" ] && ROOT=true

if [ $ROOT ]; then
	apt-get update &&
	apt-get install $(<"$SCRIPTS"/packages)
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
fi

echo

# vimrc
if [ $ROOT ]; then
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
