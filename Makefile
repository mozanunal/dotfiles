

sync: apt_install copy

sh_sync: sync neovim_install kitty_install helix_install font_install

i3_sync: sh_sync i3_install

###### Generic ########
copy:
	cp confs/.gitconfig ~/.gitconfig
	cp confs/.tmux.conf ~/.tmux.conf
	cp confs/.bash_aliases ~/.bash_aliases
	cp confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

apt_install:
	sudo apt install -y \
		htop git vim tmux fzf ripgrep bat \
		dict calc aspell fd-find unzip


###### Optional ########
vim_lite_install:
	sudo apt install -y vim
	cp confs/.vimrc ~/.vimrc

vim_full_install:
	sudo apt install -y vim
	cp confs/.vimrc.full ~/.vimrc
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

neovim_install:
	wget -q https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb
	sudo dpkg -i nvim-linux64.deb
	rm nvim-linux64.deb
	rm -rf ~/.config/nvim
	git clone git@github.com:mozanunal/kickstart.nvim.git ~/.config/nvim

kitty_install:
	sudo apt install -y kitty
	mkdir -p ~/.config/kitty/
	cp confs/kitty.conf ~/.config/kitty/kitty.conf

i3_install:
	sudo apt install -y i3 volumeicon-alsa rofi arandr
	cp confs/i3/config ~/.config/i3/config
	cp confs/i3status/config ~/.config/i3status/config

helix_install:
	wget https://github.com/helix-editor/helix/releases/download/22.12/helix-22.12-x86_64.AppImage -O hx
	chmod +x hx
	sudo mv hx /usr/local/bin/hx
	mkdir -p ~/.config/helix/
	cp confs/helix/config.toml ~/.config/helix/config.toml

font_install:
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.0/Cousine.zip
	mkdir -p ~/.local/share/fonts/CousineNerdFont
	unzip -o Cousine.zip -d ~/.local/share/fonts/CousineNerdFont 
	rm Cousine.zip

default: sync
