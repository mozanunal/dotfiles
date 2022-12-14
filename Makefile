

sync: apt_install vim_install neovim_install copy

copy:
	cp confs/.vimrc ~/.vimrc
	#mkdir -p ~/.config/nvim
	#cp confs/.vimrc ~/.config/nvim/init.vim
	cp confs/.gitconfig ~/.gitconfig
	cp confs/.tmux.conf ~/.tmux.conf
	cp confs/.bash_aliases ~/.bash_aliases
	cp confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

apt_install:
	sudo apt install -y \
		htop git vim neovim \
		tmux fzf ripgrep bat \
		dict calc aspell micro

micro_install:
	micro -plugin install fzf
	micro -plugin install comment
	micro -plugin install detectindent

vim_install:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

neovim_install:
	wget -q https://github.com/neovim/neovim/releases/download/v0.8.1/nvim-linux64.deb
	sudo dpkg -i nvim-linux64.deb
	rm nvim-linux64.deb


default: sync
