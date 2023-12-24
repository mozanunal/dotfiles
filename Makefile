
PWD="$(shell pwd)"
USER="$(shell whoami)"
SEP="\e[1;32m-------------------------------------------\e[0m"

######## Tools #########
sync_sh_server: install_bash install_vim_lite
sync_sh_dev: sync_sh_server install_neovim install_helix install_zellij
sync_gui: sync_sh_dev install_font install_alacritty \
					install_wallpapers install_rofi install_moz_gui install_gui_tools
sync_qtile: sync_gui install_qtile_wm
sync_sway: sync_gui install_sway
sync_de: sync_qtile

###### Shells #########
install_bash:
	@echo $(SEP) install_bash
	sudo apt install -qq -y \
		htop git vim tmux ripgrep bat \
		ncal dict calc aspell fd-find unzip
	sudo rm -r ~/.fzf || true
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --all
	ln -s -f $(PWD)/confs/.gitconfig ~/.gitconfig
	ln -s -f $(PWD)/confs/.inputrc ~/.inputrc
	ln -s -f $(PWD)/confs/.tmux.conf ~/.tmux.conf
	ln -s -f $(PWD)/confs/.bash_aliases ~/.bash_aliases
	rm ~/.local/bin/moz_* || true

###### Editors ########
install_vim_lite:
	@echo $(SEP) install_vim_lite
	sudo apt install -qq -y vim
	ln -s -f $(PWD)/confs/.vimrc ~/.vimrc

install_zellij:
	@echo $(SEP) install_zellij
	brew install zellij
	mkdir -p ~/.config/zellij
	ln -s -f $(PWD)/confs/zellij/config.kdl ~/.config/zellij/config.kdl

install_neovim:
	@echo $(SEP) install_neovim
	brew install neovim
	rm -rf ~/.config/nvim
	# mkdir -p ~/.config/nvim/
	ln -s -f $(PWD)/confs/nvim/ ~/.config/

install_helix:
	@echo $(SEP) install_helix
	brew install helix
	mkdir -p ~/.config/helix/
	ln -s -f $(PWD)/confs/helix/config.toml ~/.config/helix/config.toml
	ln -s -f $(PWD)/confs/helix/languages.toml ~/.config/helix/languages.toml

###### Terminal ########
install_font:
	@echo $(SEP) install_font
	sudo apt install -qq -y fonts-symbola fonts-noto-color-emoji fonts-croscore 
	wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Cousine.zip 
	mkdir -p ~/.local/share/fonts/Cousine
	unzip -o Cousine.zip -d ~/.local/share/fonts/Cousine
	rm Cousine.zip
	wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/NerdFontsSymbolsOnly.zip 
	mkdir -p ~/.local/share/fonts/NerdFontsSymbolsOnly
	unzip -o NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts/NerdFontsSymbolsOnly
	rm NerdFontsSymbolsOnly.zip
	ln -s -f $(PWD)/confs/.icons ~/.icons

install_alacritty:
	@echo $(SEP) install_alacritty
	ln -s -f $(PWD)/confs/alacritty.yml ~/.alacritty.yml

install_wezterm:
	@echo $(SEP) install_wezterm
	ln -s -f $(PWD)/confs/wezterm.lua ~/.wezterm.lua

###### Window Manager and Gui #########
install_gui_tools:
	@echo $(SEP) install_gui_tools
	sudo apt install -qq -y volumeicon-alsa pavucontrol rofi \
				lxappearance arandr xclip maim light acpi lm-sensors \
				zim-tools kiwix-tools kiwix feh \
				mupdf pass pcmanfm sxiv nitrogen
	sudo usermod -aG video $(USER)

install_moz_gui:
	@echo $(SEP) install_gui_bins
	sudo ln -s -f $(PWD)/bin/moz_emoji /usr/local/bin/moz_emoji
	sudo ln -s -f $(PWD)/bin/moz_sync /usr/local/bin/moz_sync
	sudo ln -s -f $(PWD)/bin/moz_power /usr/local/bin/moz_power
	sudo ln -s -f $(PWD)/bin/moz_wiki /usr/local/bin/moz_wiki
	sudo ln -s -f $(PWD)/bin/moz_passmenu /usr/local/bin/moz_passmenu
	sudo ln -s -f $(PWD)/bin/dmenu_run_i /usr/local/bin/dmenu_run_i

install_rofi:
	@echo $(SEP) install_rofi
	rm -rf ~/.config/rofi
	ln -s -f $(PWD)/confs/rofi/ ~/.config/

install_wallpapers:
	@echo $(SEP) install_wallpapers
	sudo rm -rf /usr/share/backgrounds/moz
	sudo cp -r wallpapers /usr/share/backgrounds/moz

##### Qtile #################
install_qtile_wm:
	sudo cp confs/qtile/qtile.desktop /usr/share/xsessions/qtile.desktop
	python -m venv ~/.qtile
	. ~/.qtile/bin/activate && \
		pip install -r confs/qtile/requirements.txt
	ln -s -f $(PWD)/confs/qtile/ ~/.config/

##### Sway ##################
install_sway:
	@echo $(SEP) install_sway
	sudo apt install -qq -y \
		i3 i3blocks i3lock-fancy xss-lock \
		sway sway* xwayland wireplumber \
		xdg-desktop-portal-wlr wofi wlr-randr \
		grim grimshot wdisplays
	mkdir -p ~/.config/i3/
	mkdir -p ~/.config/sway/
	mkdir -p ~/.config/i3blocks/
	ln -s -f $(PWD)/confs/sway/config ~/.config/i3/config
	ln -s -f $(PWD)/confs/sway/config ~/.config/sway/config
	ln -s -f $(PWD)/confs/i3blocks/config ~/.config/i3blocks/config

default: sync_sh
