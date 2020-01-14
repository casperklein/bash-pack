# all targets are phony (no files to check)
.PHONY: default copy-conf install color-patch

SHELL = /bin/bash

ARCH := $(shell MASCHINE=$$(uname -m); \
	[ "$$MASCHINE" == "x86_64" ] && echo "amd64" || { \
		[ "$$MASCHINE" == "aarch64" ] && echo "arm64" || \
			echo "armhf"; \
	})

default: install

install:
	@echo "Install tmux package.."
	@dpkg -i tmux*$(ARCH).deb
	@echo

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo

color-patch:
	@patch /etc/tmux.conf -i tmux-color.patch
	
