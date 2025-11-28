SHELL := /bin/bash
USER := $(shell whoami)
PWD := $(shell pwd)

APT_SERVER = sudo apt install -y $(shell cat pkgs/apt_server.txt)
APT_DEV = sudo apt install -y $(shell cat pkgs/apt_dev.txt)
APT_WAYLAND = sudo apt install -y $(shell cat pkgs/apt_wayland.txt)
APT_X11 = sudo apt install -y $(shell cat pkgs/apt_x11.txt)
MAC_BREW = brew install $(shell cat pkgs/mac_brew.txt)
MAC_CASK = brew install --cask $(shell cat pkgs/mac_cask.txt)

.PHONY: help
help:
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*##/ {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

stow:
	stow conf

############ Linux ##############
linux_update:
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

linux_user_conf:
	sudo usermod -aG video $(USER)

linux_font_conf:
	wget -qO /tmp/NF-Symbols.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
	mkdir -p ~/.local/share/fonts/NF-Symbols && unzip -o /tmp/NF-Symbols.zip -d ~/.local/share/fonts/NF-Symbols
	fc-cache -f

linux_sync_headless: linux_update stow
	$(APT_SERVER)

linux_sync_dev: linux_update stow
	$(APT_SERVER)
	$(APT_DEV)

linux_sync_x11: linux_update stow linux_user_conf
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_X11)

linux_sync_wayland: linux_update stow linux_user_conf
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_WAYLAND)

############ Mac ##############
mac_update:
	brew upgrade

mac_sync: stow
	$(MAC_BREW)
	$(MAC_CASK)
