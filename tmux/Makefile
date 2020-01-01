# all targets are phony (no files to check)
.PHONY: default copy-conf install

default: install copy-conf

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo

install:
	@echo "Install tmux package.."
	@dpkg -i tmux*.deb
	@echo
