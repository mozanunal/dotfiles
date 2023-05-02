sync_sh: install_apt copy

sync_dev: sync_sh install_neovim install_helix

sync_wsl: sync_dev install_font install_kitty

sync_i3: sync_wsl install_i3

###### Generic ########
copy:
	cp confs/.gitconfig ~/.gitconfig
	cp confs/.tmux.conf ~/.tmux.conf
	cp confs/.bash_aliases ~/.bash_aliases
	cp confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

install_apt:
	sudo apt install -y \
		htop git vim tmux fzf ripgrep bat \
		dict calc aspell fd-find unzip


###### Optional ########
install_vim_lite:
	sudo apt install -y vim
	cp confs/.vimrc ~/.vimrc

install_vim_full:
	sudo apt install -y vim
	cp confs/.vimrc.full ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install_neovim:
	wget -q https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
	sudo dpkg -i nvim-linux64.deb
	rm nvim-linux64.deb
	rm -rf ~/.config/nvim
	mkdir -p ~/.config/nvim/
	cp confs/nvim/init.lua ~/.config/nvim/init.lua

install_kitty:
	sudo apt install -y kitty
	mkdir -p ~/.config/kitty/
	cp confs/kitty.conf ~/.config/kitty/kitty.conf

install_i3:
	sudo apt install -y i3 volumeicon-alsa rofi arandr xclip maim
	mkdir -p ~/.config/i3/
	mkdir -p ~/.config/i3status/
	cp confs/i3/config ~/.config/i3/config
	cp confs/i3status/config ~/.config/i3status/config

install_helix:
	wget https://github.com/helix-editor/helix/releases/download/22.12/helix-22.12-x86_64.AppImage -O hx
	chmod +x hx
	sudo mv hx /usr/local/bin/hx
	mkdir -p ~/.config/helix/
	cp confs/helix/config.toml ~/.config/helix/config.toml

install_font:
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Cousine.zip
	mkdir -p ~/.local/share/fonts/CousineNerdFont
	unzip -o Cousine.zip -d ~/.local/share/fonts/CousineNerdFont 
	rm Cousine.zip

default: sync
