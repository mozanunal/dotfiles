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
help: ## Show available make targets
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*##/ {printf "  %-24s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

stow: ## Symlink dotfiles with stow
	stow conf

############ Linux ##############
linux_update: ## Update and clean apt packages
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

linux_user_conf: ## Add current user to video group
	sudo usermod -aG video $(USER)

linux_font_conf: ## Install Nerd Font symbols
	wget -qO /tmp/NF-Symbols.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip
	mkdir -p ~/.local/share/fonts/NF-Symbols && unzip -o /tmp/NF-Symbols.zip -d ~/.local/share/fonts/NF-Symbols
	fc-cache -f

linux_sync_headless: linux_update stow ## Sync headless server packages
	$(APT_SERVER)

linux_sync_dev: linux_update stow ## Sync development packages
	$(APT_SERVER)
	$(APT_DEV)

linux_sync_x11: linux_update stow linux_user_conf ## Sync X11 desktop packages
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_X11)

linux_sync_wayland: linux_update stow linux_user_conf ## Sync Wayland desktop packages
	$(APT_SERVER)
	$(APT_DEV)
	$(APT_WAYLAND)

############ Mac ##############
mac_update: ## Update Homebrew packages
	brew upgrade

mac_sync: stow ## Install macOS packages and casks
	$(MAC_BREW)
	$(MAC_CASK)
