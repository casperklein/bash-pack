# all targets are phony (no files to check)
.PHONY: default copy-conf install

default: install copy-conf

copy-conf:
	@echo "Copy config to: /etc/tmux.conf"
	@cp tmux.conf /etc
	@echo

install:
	@echo "Install tmux package.."
	@MASCHINE=$$(uname -m) ; [ "$$MASCHINE" == "x86_64" ] && ARCH=amd64 || [ "$MASCHINE" == "aarch64" ] && ARCH=arm64 || ARCH="armhf" \
	dpkg -i tmux*$$ARCH.deb
	@echo
