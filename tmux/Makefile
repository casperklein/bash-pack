# all targets are phony (no files to check)
.PHONY: default copy-conf install

default: instal

copy-conf:
	cp tmux.conf /etc

install:
	dpkg -i tmux*.deb
