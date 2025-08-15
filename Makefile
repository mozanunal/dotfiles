SHELL := /bin/bash
USER := $(shell whoami)
PWD := $(shell pwd)

APT_SERVER = sudo apt install -y $(shell cat pkgs/apt_server.txt)
APT_DEV = sudo apt install -y $(shell cat pkgs/apt_dev.txt)
APT_WAYLAND = sudo apt install -y $(shell cat pkgs/apt_wayland.txt)
APT_X11 = sudo apt install -y $(shell cat pkgs/apt_x11.txt)
MAC_BREW = brew install $(shell cat pkgs/mac_brew.txt)
MAC_CASK = brew install --cask $(shell cat pkgs/mac_cask.txt)

## update
update_linux:
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

update_mac:
	brew upgrade

## conf
stow:
	stow conf

user_conf:
	sudo usermod -aG video $(USER)

font_conf:
	wget -qO /tmp/NF-Symbols.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
	mkdir -p ~/.local/share/fonts/NF-Symbols && unzip -o /tmp/NF-Symbols.zip -d ~/.local/share/fonts/NF-Symbols
	fc-cache -f

## sync
sync_headless: update_linux stow
	$(APT_SERVER)

sync_headless_dev: update_linux stow
	$(APT_SERVER)
	$(APT_DEV)

sync_x11: update_linux stow user_conf
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_X11)

sync_wayland: update_linux stow user_conf
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_WAYLAND)

sync_mac: stow
	$(MAC_BREW)
	$(MAC_CASK)
