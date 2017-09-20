#!/bin/bash
if [ "$(readlink -f ~/.bashrc)" == "/scripts/bashrc" ] && [ -f ~/.bashrc.backup ]; then
	echo 'Restoring' ~/.bashrc.backup '->' ~/.bashrc
	rm ~/.bashrc &&
	mv ~/.bashrc.backup ~/.bashrc
else
	echo 'Error:' ~/.bashrc 'symlink or' ~/.bashrc.backup 'not found.' >&2
fi

if [ "$(readlink -f /etc/vim/vimrc.local)" == "/scripts/vimrc.local" ]; then
	echo 'Removing symlink /etc/vim/vimrc.local -> /scripts/vimrc.local'
	rm /etc/vim/vimrc.local
else
	echo 'Error: /etc/vim/vimrc.local not found.' >&2
fi

if [ "$(readlink -f ~/.inputrc)" == "/scripts/inputrc" ]; then
	echo 'Removing symlink' ~/.inputrc '-> /scripts/inputrc'
	rm ~/.inputrc
else
	echo 'Error: /etc/vim/vimrc.local not found.' >&2
fi

[ -f ~/.bashrc.local ] && echo && rm -i ~/.bashrc.local
