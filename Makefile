
PWD="$(shell pwd)"
SEP="\e[1;32m-------------------------------------------\e[0m"

######## Tools #########
sync_sh_server: install_bash install_vim_lite
sync_sh_dev: sync_sh_server install_sh_bins install_neovim install_helix 
sync_term: sync_sh_dev install_font install_kitty install_zellij
sync_de_i3: sync_term install_gui_bins install_gui_tools install_i3
sync_de_dwm: sync_term install_gui_bins install_gui_tools install_sl_tools \
	install_dwm install_st install_dmenu install_slstatus

######## Dev Env ########
dev_all: dev_python dev_data dev_spark
dev_python: install_dev_python install_nodejs
dev_data: install_dev_data install_duckdb
dev_spark: install_dev_scala

###### Shells #########
install_bash:
	@echo $(SEP) install_bash
	sudo apt install -qq -y \
		htop git vim tmux fzf ripgrep bat \
		ncal dict calc aspell fd-find unzip
	ln -s -f $(PWD)/confs/.gitconfig ~/.gitconfig
	ln -s -f $(PWD)/confs/.inputrc ~/.inputrc
	ln -s -f $(PWD)/confs/.tmux.conf ~/.tmux.conf
	ln -s -f $(PWD)/confs/.bash_aliases ~/.bash_aliases
	ln -s -f $(PWD)/confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

install_sh_bins:
	@echo $(SEP) install_sh_bins
	ln -s -f $(PWD)/bin/sh/moz_conf ~/.local/bin/moz_conf
	ln -s -f $(PWD)/bin/sh/moz_fd_large_files ~/.local/bin/moz_fd_large_files
	ln -s -f $(PWD)/bin/sh/moz_smoke_test ~/.local/bin/moz_smoke_test
	ln -s -f $(PWD)/bin/sh/moz_update ~/.local/bin/moz_update

install_gui_bins:
	@echo $(SEP) install_gui_bins
	ln -s -f $(PWD)/bin/gui/moz_emoji ~/.local/bin/moz_emoji

###### Editors ########
install_vim_lite:
	@echo $(SEP) install_vim_lite
	sudo apt install -qq -y vim
	ln -s -f $(PWD)/confs/.vimrc ~/.vimrc

install_vim_full:
	@echo $(SEP) install_vim_full
	sudo apt install -qq -y vim
	ln -s -f $(PWD)/confs/.vimrc.full ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install_zellij:
	@echo $(SEP) install_zellij
	wget -q https://github.com/zellij-org/zellij/releases/download/v0.36.0/zellij-x86_64-unknown-linux-musl.tar.gz
	tar -xvf zellij*.tar.gz
	chmod +x zellij
	sudo mv zellij /usr/local/bin/zellij
	rm zellij*.tar.gz
	mkdir -p ~/.config/zellij
	ln -s -f $(PWD)/confs/zellij/config.kdl ~/.config/zellij/config.kdl

install_neovim:
	@echo $(SEP) install_neovim
	wget -q https://github.com/neovim/neovim/releases/download/v0.9.0/nvim.appimage
	chmod +x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim/
	ln -s -f $(PWD)/confs/nvim/init.lua ~/.config/nvim/init.lua

install_helix:
	@echo $(SEP) install_helix
	wget -q https://github.com/helix-editor/helix/releases/download/23.05/helix-23.05-x86_64.AppImage -O hx
	chmod +x hx
	sudo mv hx /usr/local/bin/hx
	mkdir -p ~/.config/helix/
	ln -s -f $(PWD)/confs/helix/config.toml ~/.config/helix/config.toml

###### Terminal ########
install_font:
	@echo $(SEP) install_font
	wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Cousine.zip
	mkdir -p ~/.local/share/fonts/CousineNerdFont
	unzip -o Cousine.zip -d ~/.local/share/fonts/CousineNerdFont
	rm Cousine.zip
	ln -s -f $(PWD)/confs/.icons ~/.icons

install_kitty:
	@echo $(SEP) install_kitty
	sudo apt install -qq -y kitty
	mkdir -p ~/.config/kitty/
	ln -s -f $(PWD)/confs/kitty.conf ~/.config/kitty/kitty.conf

install_wezterm:
	@echo $(SEP) install_wezterm
	ln -s -f $(PWD)/confs/wezterm.lua ~/.wezterm.lua

install_alacrity:
	@echo $(SEP) install_alacrity
	ln -s -f $(PWD)/confs/alacritty.yml ~/.alacritty.yml

###### Dev Environment #####
install_dev_python:
	@echo $(SEP) install_dev_python
	sudo apt install -y -qq python-is-python3 python3-pip ipython3

install_nodejs:
	@echo $(SEP) install_nodejs
	curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
	sudo apt-get install -y nodejs
	
install_dev_data:
	@echo $(SEP) install_dev_data
	sudo apt install -y -qq sqlite3
	
install_duckdb:
	@echo $(SEP) install_duckdb
	wget https://github.com/duckdb/duckdb/releases/download/v0.7.1/duckdb_cli-linux-amd64.zip
	unzip duckdb_cli-linux-amd64.zip
	rm duckdb_cli-linux-amd64.zip
	sudo mv duckdb /usr/local/bin

install_dev_scala:
	@echo $(SEP) install_dev_scala
	sudo apt install openjdk-8-jdk
	curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
	chmod +x cs
	./cs setup
	sudo mv ./cs /usr/local/bin

install_dev_spark:
	pip install pyspark



###### Window Manager and Gui #########
install_gui_tools:
	@echo $(SEP) install_gui_tools
	sudo apt install -qq -y volumeicon-alsa pavucontrol rofi \
				lxrandr lxappearance arandr \
				xclip maim light lm-sensors \
				mupdf
	sudo usermod -aG video moz

install_i3:
	@echo $(SEP) install_i3
	sudo apt install -qq -y i3 i3blocks i3lock-fancy xss-lock
	mkdir -p ~/.config/i3/
	mkdir -p ~/.config/i3blocks/
	ln -s -f $(PWD)/confs/i3/config ~/.config/i3/config
	ln -s -f $(PWD)/confs/i3blocks/config ~/.config/i3blocks/config

##### Suckless Tools #################
install_sl_tools:
	@echo $(SEP) install_sl_tools
	sudo apt install -qq -y git patch diffutils \
		libglib2.0-dev libimlib2-dev

install_dwm:
	sudo rm -r build/dwm | true
	mkdir -p build
	cd build && git clone -b 6.3 git://git.suckless.org/dwm
	cp sl/dwm/* build/dwm/
	cd build/dwm \
		&& patch -i dwm-winicon-6.3-v2.1.diff \
		&& patch -i dwm-focusmaster-return-20210804-138b405.diff\
		&& patch -i dwm-cool-autostart-6.2.diff \
		&& sudo make clean install
		#&& patch -i dwm-systray-6.4.diff \

install_st:
	sudo rm -r build/st | true
	mkdir -p build
	cd build && git clone -b 0.9 git://git.suckless.org/st
	cp sl/st/* build/st/
	cd build/st \
		&& patch -i st-font2-0.8.5.diff \
		&& sudo make clean install

install_dmenu:
	sudo rm -r build/dmenu | true
	mkdir -p build
	cd build && git clone -b 5.2 git://git.suckless.org/dmenu
	cp sl/dmenu/* build/dmenu/
	cd build/dmenu && sudo make clean install

install_slstatus:
	sudo rm -r build/slstatus | true
	mkdir -p build
	cd build && git clone -b master git://git.suckless.org/slstatus
	cp sl/slstatus/* build/slstatus/
	cd build/slstatus && sudo make clean install

default: sync_sh
