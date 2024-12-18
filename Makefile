
SHELL := /bin/bash
USER := $(shell whoami)
PWD := $(shell pwd)
APT_PKGS := $(shell cat pkgs_apt.txt)
BREW_PKGS := $(shell cat pkgs_brew.txt)
CASK_PKGS := $(shell cat pkgs_cask.txt)

all: update add_user_to_groups stow install_apt_pkgs install_brew_pkgs install_py_pkgs
mac: stow install_brew_pkgs install_cask_pkgs

update:
	sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

add_user_to_groups:
	sudo usermod -aG video $(USER)

stow:
	stow conf

install_apt_pkgs:
	sudo apt install $(APT_PKGS)

install_brew_pkgs:
	brew install $(BREW_PKGS)

install_cask_pkgs:
	brew install --cask $(CASK_PKGS)

install_py_pkgs:
	python -m venv ~/.moz_py || true
	source ~/.moz_py/bin/activate && pip install -r pkgs_py.txt
