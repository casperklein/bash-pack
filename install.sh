#!/bin/bash

apt-get update &&
apt-get install aptitude boxes bsdmainutils ccze checkinstall colordiff colormake curl dcfldd git htop lynx most openssl procps pv tcpflow vim
echo

if [ ! -f ~/.bashrc.local ]; then
	echo 'Creating        ' ~/.bashrc.local
	echo 'return' > ~/.bashrc.local
	cat ~/.bashrc >> ~/.bashrc.local
fi

if [ ! -f ~/.bashrc.backup ]; then
	echo 'Moving          ' ~/.bashrc '->' ~/.bashrc.backup
	mv ~/.bashrc ~/.bashrc.backup
	echo -n 'Creating symlink '
	ln -sv /scripts/bashrc ~/.bashrc
fi

echo

if [ ! -f /etc/vim/vimrc.local ]; then
	echo -n 'Creating symlink '
	ln -sv /scripts/vimrc.local /etc/vim/vimrc.local
fi
