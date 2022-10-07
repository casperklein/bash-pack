#!/bin/bash

# extract common archives

if [ $# -ne 1 ]; then
	echo -e "Extract common archives.\n" >&2
	echo -e "Syntax: ${0##*/} <archive>\n" >&2
	exit 1
fi

if [ -f "$1" ]; then
	case "$1" in
		(*.7z) 7za x "$1" ;;
		(*.ace) unace e "$1" ;;
		(*.tar.bz2) bzip2 -v -d "$1" ;;
		(*.bz2) bzip2 -d "$1" ;;
		(*.deb) ar -x "$1" ;;
		(*.tar.gz) tar -xvzf "$1" ;;
		(*.gz) gunzip -d "$1" ;;
		(*.lzh) lha x "$1" ;;
		(*.iso) 7z x -tiso "$1" ;;
		(*.rar) unrar x "$1" ;;
		(*.shar) sh "$1" ;;
		(*.tar) tar -xvf "$1" ;;
		(*.tbz2) tar -jxvf "$1" ;;
		(*.tgz) tar -xvzf "$1" ;;
		(*.xz) xz -dv "$1" ;;
		(*.zip) unzip "$1" ;;
		(*.Z) uncompress "$1" ;;
		(*) echo "Unknown compression type: $1" >&2;;
	esac
else
	echo "Error: File '$1' not a found."
fi
