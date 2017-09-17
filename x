#!/bin/bash

# extract common archives

if [ $# -ne 1 ]; then
	echo -e "Extract common archives.\n" >&2
	echo -e "Syntax: $(basename "$0") <archive>\n" >&2
	exit 1
fi

if [[ -f "$1" ]]; then
	case "$1" in
		(*.tar.bz2) bzip2 -v -d "$1" ;;
		(*.tar.gz) tar -xvzf "$1" ;;
		(*.tgz) tar -xvzf "$1" ;;
		(*.ace) unace e "$1" ;;
		(*.rar) unrar x "$1" ;;
		(*.deb) ar -x "$1" ;;
		(*.bz2) bzip2 -d "$1" ;;
		(*.lzh) lha x "$1" ;;
		(*.gz) gunzip -d "$1" ;;
		(*.tar) tar -xvf "$1" ;;
		(*.tbz2) tar -jxvf "$1" ;;
		(*.zip) unzip "$1" ;;
		(*.Z) uncompress "$1" ;;
		(*.shar) sh "$1" ;;
		(*.7z) 7za x "$1" ;;
		(*) echo "Unknown compression type: $1" >&2;;
	esac
else
	echo "Error: File '"$1"' not a found."
fi
