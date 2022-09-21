

install:
	sudo apt install \
		htop git vim neovim \
		tmux fzf ripgrep bat

vim_install:
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sync:
	cp confs/.vimrc ~/.vimrc
	cp confs/.tmux.conf ~/.tmux.conf