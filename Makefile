

sync:
	cp confs/.vimrc ~/.vimrc
	cp confs/.gitconfig ~/.gitconfig
	cp confs/.tmux.conf ~/.tmux.conf
	cp confs/.bash_aliases ~/.bash_aliases
	cp confs/fzf/keybindings.bash ~/.fzf_keybindings.bash
	. ~/.bashrc

install:
	sudo apt install \
		htop git vim neovim \
		tmux fzf ripgrep bat \
		ncal dict calc aspell 

vim_install:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


default: sync