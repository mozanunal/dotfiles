
SHELL := /bin/bash
USER := $(shell whoami)
PWD := $(shell pwd)
APT_PKGS_SE := $(shell cat pkgs_apt_se.txt)
APT_PKGS_DE := $(shell cat pkgs_apt_de.txt)
BREW_PKGS := $(shell cat pkgs_brew.txt)
CASK_PKGS := $(shell cat pkgs_cask.txt)

linux_se: update_linux stow_se install_apt_se install_brew_se
linux_de: update_linux stow_se stow_de_linux add_user_to_groups install_apt_se install_apt_de install_brew_se
mac_de: update_mac stow_se stow_de_mac install_brew_se install_brew_de

update_linux:
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

update_mac:
	brew upgrade

add_user_to_groups:
	sudo usermod -aG video $(USER)

stow_se:
	stow conf_se

stow_de_linux:
	stow conf_de_linux

stow_de_mac:
	stow conf_de_mac

install_apt_de:
	sudo apt install $(APT_PKGS_DE)

install_apt_se:
	sudo apt install $(APT_PKGS_SE)

install_brew_de:
	brew install --cask $(CASK_PKGS)

install_brew_se:
	brew install $(BREW_PKGS)

