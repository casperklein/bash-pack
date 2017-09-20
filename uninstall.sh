#!/bin/bash
if [ "$(readlink -f ~/.bashrc)" == "/scripts/bashrc" ] && [ -f ~/.bashrc.backup ]; then
	echo 'Restoring' ~/.bashrc.backup '->' ~/.bashrc
	rm ~/.bashrc &&
	mv ~/.bashrc.backup ~/.bashrc
fi

if [ "$(readlink -f /etc/vim/vimrc.local)" == "/scripts/vimrc.local" ]; then
	echo 'Removing symlink /etc/vim/vimrc.local -> /scripts/vimrc.local'
	rm /etc/vim/vimrc.local
fi
