# all targets are phony (no files to check)
.PHONY: default install copy-conf

SHELL := /bin/bash

ARCH := $(shell						\
	MASCHINE=$$(uname -m);				\
	if [ "$$MASCHINE" == "x86_64" ]; then		\
		echo "amd64";				\
	elif [ "$$MASCHINE" == "aarch64" ]; then	\
		echo "arm64";				\
	else						\
		echo "armhf";				\
	fi						\
)

default: install

install:
	@echo "Install tmux package.."
	@dpkg -i tmux*$(ARCH).deb
	@echo

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo
