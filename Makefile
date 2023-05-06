
PWD="$(shell pwd)"
SEP="\e[1;32m-------------------------------------------\e[0m"

sync_sh: install_apt copy

sync_dev: sync_sh install_neovim install_helix

sync_wsl: sync_dev install_font install_kitty

sync_i3: sync_wsl install_i3

###### Generic ########
copy:   
	@echo $(SEP) copy
	ln -s -f $(PWD)/confs/.gitconfig ~/.gitconfig
	ln -s -f $(PWD)/confs/.inputrc ~/.inputrc
	ln -s -f $(PWD)/confs/.tmux.conf ~/.tmux.conf
	ln -s -f $(PWD)/confs/.bash_aliases ~/.bash_aliases
	ln -s -f $(PWD)/confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

install_apt:
	@echo $(SEP) install_apt
	sudo apt install -qq -y \
		htop git vim tmux fzf ripgrep bat \
		dict calc aspell fd-find unzip


###### Optional ########
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

install_neovim:
	@echo $(SEP) install_neovim
	wget -q https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
	sudo dpkg -i nvim-linux64.deb
	rm nvim-linux64.deb
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim/
	ln -s -f $(PWD)/confs/nvim/init.lua ~/.config/nvim/init.lua

install_kitty:
	@echo $(SEP) install_kitty
	sudo apt install -qq -y kitty
	mkdir -p ~/.config/kitty/
	ln -s -f $(PWD)/confs/kitty.conf ~/.config/kitty/kitty.conf

install_i3:
	@echo $(SEP) install_i3
	sudo apt install -qq -y i3 i3blocks i3lock-fancy xss-lock volumeicon-alsa rofi arandr xclip maim light
	mkdir -p ~/.config/i3/
	mkdir -p ~/.config/i3blocks/
	ln -s -f $(PWD)/confs/i3/config ~/.config/i3/config
	ln -s -f $(PWD)/confs/i3blocks/config ~/.config/i3blocks/config

install_helix:
	@echo $(SEP) install_helix
	wget -q https://github.com/helix-editor/helix/releases/download/22.12/helix-22.12-x86_64.AppImage -O hx
	chmod +x hx
	sudo mv hx /usr/local/bin/hx
	mkdir -p ~/.config/helix/
	ln -s -f $(PWD)/confs/helix/config.toml ~/.config/helix/config.toml

install_font:
	@echo $(SEP) install_font
	wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Cousine.zip
	mkdir -p ~/.local/share/fonts/CousineNerdFont
	unzip -o Cousine.zip -d ~/.local/share/fonts/CousineNerdFont 
	rm Cousine.zip

default: sync_sh
