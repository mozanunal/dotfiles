
USER := $(shell whoami)
PWD := $(shell pwd)

all: update add_user_to_groups stow install_apt_pkgs install_brew_pkgs

update:
	@sudo apt update && \
		sudo apt upgrade -y && \
		sudo apt autoclean -y && \
		sudo apt autoremove -y

add_user_to_groups:
	@sudo usermod -aG video $(USER)

stow:
	stow conf

install_apt_pkgs:
	@sudo apt install \
		python-is-python3 \
		python3-pip \
		python3-venv \
		lua5.1 \
		sudo \
		htop \
		git \
		vim \
		tmux \
		ripgrep \
		bat \
		fd-find \
		unzip \
		fzf \
		volumeicon-alsa \
		pavucontrol \
		rofi \
		lxappearance \
		arandr \
		xclip \
		maim \
		light \
		acpi \
		lm-sensors \
		zim-tools \
		kiwix-tools \
		kiwix \
		feh \
		mupdf \
		pass \
		pcmanfm \
		sxiv \
		nitrogen \
		i3 \
		i3blocks \
		i3lock-fancy \
		xss-lock \
		sway \
		swaybg \
		swayidle \
		swaylock \
		xwayland \
		wireplumber \
		xdg-desktop-portal-wlr \
		wofi \
		wlr-randr \
		grim \
		grimshot \
		wdisplays \
		mako-notifier \
		waybar \
		fonts-symbola \
		fonts-noto-color-emoji \
		fonts-croscore \
		alacritty \
		foot \
		foot-themes \

install_brew_pkgs:
	@brew install \
		neovim \
		zellij \
		helix \
		lazygit \
		awscli \
		lazygit \
		lf \
		duckdb \
		pyright \
		marksman \
		awscli \
		kubectl \

