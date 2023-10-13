
PWD="$(shell pwd)"
USER="$(shell whoami)"
SEP="\e[1;32m-------------------------------------------\e[0m"

######## Tools #########
sync_sh_server: install_bash install_vim_lite
sync_sh_dev: sync_sh_server install_neovim install_helix 
sync_term: sync_sh_dev install_font install_zellij
sync_de_dwm: sync_term install_moz_gui install_gui_tools \
	install_sl_tools install_dwm install_st install_dmenu \
	install_slstatus install_slock

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
				autorandr lxappearance arandr \
				xclip maim light acpi lm-sensors \
				zim-tools kiwix-tools kiwix feh \
				mupdf pass pcmanfm sxiv nitrogen

	sudo usermod -aG video $(USER)

install_moz_gui:
	@echo $(SEP) install_gui_bins
	ln -s -f $(PWD)/bin/moz_emoji ~/.local/bin/moz_emoji
	ln -s -f $(PWD)/bin/moz_sync ~/.local/bin/moz_sync
	ln -s -f $(PWD)/bin/moz_power ~/.local/bin/moz_power
	ln -s -f $(PWD)/bin/moz_wiki ~/.local/bin/moz_wiki
	ln -s -f $(PWD)/bin/passmenu ~/.local/bin/passmenu
	ln -s -f $(PWD)/bin/dmenu_run_i ~/.local/bin/dmenu_run_i

##### Suckless Tools #################
install_sl_tools:
	@echo $(SEP) install_sl_tools
	sudo apt install -qq -y git patch diffutils \
		build-essential libglib2.0-dev \
		libxft-dev libimlib2-dev libxrandr-dev \
		libxinerama-dev

install_dwm:
	sudo rm -r build/dwm | true
	mkdir -p build
	cd build && git clone --depth=1 -b 6.3 git://git.suckless.org/dwm
	cp sl/dwm/* build/dwm/
	cd build/dwm \
		&& patch -i dwm-winicon-6.3-v2.1.diff \
		&& patch -i dwm-focusmaster-return-6.2.diff \
		&& patch -i dwm-cool-autostart-6.2.diff \
		&& patch -i dwm-scratchpad-6.2.diff \
		&& patch -i dwm-pertag-6.2.diff \
		&& patch -i dwm-r1615-selfrestart.diff \
		&& sudo make clean install

install_st:
	sudo rm -r build/st | true
	mkdir -p build
	cd build && git clone --depth=1 -b 0.9 git://git.suckless.org/st
	cp sl/st/* build/st/
	cd build/st \
		&& patch -i st-font2-0.8.5.diff \
		&& patch -i st-w3m-0.8.3.diff \
		&& patch -i st-scrollback-0.8.5.diff \
		&& patch -i st-desktopentry-0.8.5.diff \
		&& sudo make clean install

install_dmenu:
	sudo rm -r build/dmenu | true
	mkdir -p build
	cd build && git clone --depth=1 -b 5.2 git://git.suckless.org/dmenu
	cp sl/dmenu/* build/dmenu/
	cd build/dmenu \
		&& patch -i border-center-fuzzymatch.diff \
		&& sudo make clean install

install_slstatus:
	sudo rm -r build/slstatus | true
	mkdir -p build
	cd build && git clone --depth=1 -b master git://git.suckless.org/slstatus
	cp sl/slstatus/* build/slstatus/
	cd build/slstatus && sudo make clean install

install_slock:
	sudo rm -r build/slock | true
	mkdir -p build
	cd build && git clone --depth=1 -b 1.5 git://git.suckless.org/slock
	cp sl/slock/* build/slock/
	cd build/slock \
		&& patch -i slock-blur_pixelated_screen-1.4.diff \
		&& sudo make clean install

default: sync_sh
