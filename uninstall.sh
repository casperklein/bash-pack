#!/bin/bash
if [ "$(readlink -f ~/.bashrc)" == "/scripts/bashrc" ] && [ -f ~/.bashrc.backup ]; then
	rm ~/.bashrc &&
	mv ~/.bashrc.backup ~/.bashrc
fi
