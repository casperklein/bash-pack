#!/bin/bash
if [ "$(readlink -f ~/.bashrc)" == "/scripts/bashrc" ] && [ -f ~/.bashrc.backup ]; then
	echo hooray
fi
