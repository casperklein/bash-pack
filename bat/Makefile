# all targets are phony (no files to check)
.PHONY: default install uninstall

SHELL := /bin/bash
APP := bat

ARCH := ${shell			\
	MACHINE=$$(uname -m);	\
	case "$$MACHINE" in	\
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
	@echo "Install $(APP) package.."
	@dpkg -i $(APP)*$(ARCH).deb
	@echo

uninstall:
	@echo "Uninstall $(APP) package.."
	@apt-get purge "$(APP)"
