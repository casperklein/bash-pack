#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")

# running as root?
[ "$(id -u)" == "0" ] && ROOT=true

# bashrc
if [ "$(readlink -f ~/.bashrc)" == "$DIR/bashrc" ] && [ -f ~/.bashrc.backup ]; then
	echo 'Restoring' ~/.bashrc.backup '->' ~/.bashrc
	rm ~/.bashrc &&
	mv ~/.bashrc.backup ~/.bashrc
else
	echo 'Error:' ~/.bashrc 'symlink or' ~/.bashrc.backup 'not found.' >&2
	echo 'Error: NOT removing' ~/.bashrc >&1
fi

# inputrc
if [ "$(readlink -f ~/.inputrc)" == "$DIR/inputrc" ]; then
	echo 'Removing symlink' ~/.inputrc "-> $DIR/inputrc"
	rm ~/.inputrc
else
	echo 'Error:' ~/.inputrc 'not found.' >&2
fi

# vimrc
if [ $ROOT ]; then
	if [ "$(readlink -f /etc/vim/vimrc)" == "$DIR/vimrc" ]; then
		echo 'Restoring /etc/vim/vimrc.backup -> /etc/vim/vimrc'
		rm /etc/vim/vimrc &&
		mv /etc/vim/vimrc.backup /etc/vim/vimrc
	else
		echo 'Error: /etc/vim/vimrc not found.' >&2
	fi
fi

# temp
if [ $ROOT ]; then
	if [ "$(readlink -f /etc/vim/vimrc.local)" == "$DIR/vimrc.local" ]; then
		echo "Removing symlink /etc/vim/vimrc.local -> $DIR/vimrc.local"
		rm /etc/vim/vimrc.local
	else
		echo 'Error: /etc/vim/vimrc.local not found.' >&2
	fi
fi

# bashrc.local
[ -f ~/.bashrc.local ] && echo && rm -i ~/.bashrc.local
