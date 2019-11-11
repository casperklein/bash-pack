# all targets are phony (no files to check)
.PHONY: default install uninstall repair update

default: build

install:
	./install.sh

uninstall:
	./uninstall.sh

repair:
	./repair.sh

update:
	./update.sh
