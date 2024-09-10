#!/bin/bash

if (( $# < 1 )); then
	echo "Extract common archive formats."
	echo
	echo "Syntax: ${0##*/} <archive>"
	echo
	exit 1
fi >&2

if [ -f "$1" ]; then
	case "$1" in
		(*.tar.bz2) tar -xjvf "$1"                              ;;
		(*.tar.gz)  tar -xzvf "$1"                              ;;
		(*.tar.zst) tar --use-compress-program="zstd" -xvf "$1" ;; # or --zstd; 'zstd -T0' --> decompression does not support multi-threading

		(*.7z)   7za x "$1"      ;;
		(*.ace)  unace e "$1"    ;;
		(*.bz2)  bzip2 -d "$1"   ;;
		(*.deb)  ar -x "$1"      ;;
		(*.gz)   gunzip -d "$1"  ;;
		(*.lzh)  lha x "$1"      ;;
		(*.iso)  7z x -tiso "$1" ;;
		(*.rar)  unrar x "$1"    ;;
		(*.tar)  tar -xvf "$1"   ;;
		(*.tbz2) tar -xjvf "$1"  ;;
		(*.tgz)  tar -xzvf "$1"  ;;
		(*.xz)   xz -dv "$1"     ;;
		(*.zip)  unzip "$1"      ;;
		(*.zst)  zstd -d "$1"    ;;
		(*.Z)    uncompress "$1" ;;

		(*) echo -e "Error: Unknown compression type.\n" >&2 ;;
	esac
else
	{
		echo "Error: File '$1' does not exist."
		echo
		exit 1
	} >&2
fi
