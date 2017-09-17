#!/bin/bash

apt-get update &&
apt-get install aptitude boxes bsdmainutils ccze checkinstall colordiff colormake curl dcfldd git htop lynx most openssl procps pv tcpflow vim

if [ ! -f ~/.bashrc.local ]; then
	echo 'Creating' ~/.bashrc.local
	echo 'return' > ~/.bashrc.local
	cat ~/.bashrc >> ~/.bashrc.local
fi

if [ ! -f ~/.bashrc.backup ]; then
	mv ~/.bashrc ~/.bashrc.backup
	echo 'Creating symlink /scripts/bashrc --> ' ~/.bashrc
	ln -s /scripts/bashrc ~/.bashrc
fi
