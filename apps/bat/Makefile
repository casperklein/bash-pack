# all targets are phony (no files to check)
.PHONY: default install uninstall

SHELL := /bin/bash
APP := bat

ARCH := $(shell dpkg --print-architecture)

default: install

install:
	@echo "Install $(APP) package.."
	@dpkg -i $(APP)*$(ARCH).deb
	@echo

uninstall:
	@echo "Uninstall $(APP) package.."
	@apt-get purge "$(APP)"
