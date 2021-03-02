# all targets are phony (no files to check)
.PHONY: default install copy-conf uninstall

SHELL := /bin/bash
APP := tmux

ARCH := $(shell dpkg --print-architecture)

default: install

install:
	@echo "Install $(APP) package.."
	@dpkg -i $(APP)*$(ARCH).deb
	@echo

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo "Copy APT pinning to: /etc/apt/preferences.d/tmux"
	@cp tmux.pin  /etc/apt/preferences.d/tmux
	@echo

uninstall:
	@echo "Uninstall $(APP) package.."
	@apt-get purge "$(APP)"
	@echo "Remove APT pinning.."
	@rm /etc/apt/preferences.d/tmux
