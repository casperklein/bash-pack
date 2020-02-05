# all targets are phony (no files to check)
.PHONY: default install copy-conf

SHELL := /bin/bash

ARCH := ${shell			\
	MASCHINE=$$(uname -m);	\
	case "$$MASCHINE" in	\
	x86_64)			\
		echo "amd64"	\
		;;		\
	aarch64)		\
		echo "arm64"	\
		;;		\
	*)			\
		echo "armhf"	\
		;;		\
	esac			\
}

default: install

install:
	@echo "Install tmux package.."
	@dpkg -i tmux*$(ARCH).deb
	@echo

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo
