#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")

apt-get update &&
apt-get install aptitude boxes bsdmainutils ccze checkinstall colordiff colormake curl dcfldd git htop lynx most openssl procps pv tcpflow vim wget
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
	ln -sv "$DIR"/bashrc ~/.bashrc
fi

echo

# inputrc
if [ ! -f ~/.inputrc ]; then
	echo -n 'Creating symlink '
	ln -sv "$DIR"/inputrc ~/.inputrc
fi

echo

# vimrc
if [ -f /etc/vim/vimrc ] && [ ! -f /etc/vim/vimrc.backup ]; then
	echo 'Moving             /etc/vim/vimrc -> /etc/vimrc.backup'
	mv /etc/vim/vimrc /etc/vimrc.backup
fi
if [ ! -f /etc/vim/vimrc ]; then
	echo -n 'Creating symlink '
	ln -sv "$DIR"/vimrc /etc/vim/vimrc
fi
