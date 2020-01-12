# all targets are phony (no files to check)
.PHONY: default copy-conf install

SHELL = /bin/bash

ARCH := $(shell MASCHINE=$$(uname -m); \
	[ "$$MASCHINE" == "ix86_64" ] && echo "amd64" || { \
		[ "$$MASCHINE" == "aarch64" ] && echo "arm64" || \
			echo "armhf"; \
	})

default: install copy-conf

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo

install:
	@echo "Install tmux package.."
	@dpkg -i tmux*$(ARCH).deb
	@echo
