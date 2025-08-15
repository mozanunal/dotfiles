SHELL := /bin/bash
USER := $(shell whoami)
PWD := $(shell pwd)
APT_PKGS_HEADLESS := $(shell cat conf/pkgs_apt.txt)
APT_PKGS_WAYLAND := $(shell cat conf_wayland/pkgs_apt.txt)
BREW_PKGS := $(shell cat conf/pkgs_brew.txt)
CASK_PKGS := $(shell cat conf_mac/pkgs_cask.txt)

sync_headless: update_linux --stow_headless --install_apt_headless
sync_wayland: update_linux --stow_headless --stow_de_linux --add_user_to_groups --install_apt_headless --install_apt_de --install_brew_se
sync_mac: update_mac --stow_se --stow_de_mac --install_brew_se --install_brew_de

#  --install_brew_se

### headless
update_linux:
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

--stow_headless:
	stow conf

--install_apt_headless:
	sudo apt install $(APT_PKGS_HEADLESS)

### x11


### wayland

### mac
update_mac:
	brew upgrade

--add_user_to_groups:
	sudo usermod -aG video $(USER)



--stow_de_linux:
	stow conf_de_linux

--stow_de_mac:
	stow conf_de_mac

--install_apt_de:
	sudo apt install $(APT_PKGS_WAYLAND)



--install_brew_de:
	brew install --cask $(CASK_PKGS)

--install_brew_se:
	brew install $(BREW_PKGS)

