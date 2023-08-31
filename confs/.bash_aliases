export EDITOR=nvim


# --- aliases
alias dict='dict -d wn'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias fzv='nvim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias mpy='source ~/dotfiles/dev/.venv/bin/activate'
alias mpyi='source ~/dotfiles/dev/.venv/bin/activate;ipython -i ~/dotfiles/dev/start.py'

# --- functions
moz_conf ()
{
   fdfind . ~/dotfiles/ -t f --hidden -E .git | fzf | xargs nvim
}

moz_fd_large_files ()
{
    du -h -x -s -- * | sort -r -h | head -20;
}

moz_smoke_test ()
{
smoke_tests="Normalx
\033[1mBold\033[22m
\033[3mItalic\033[23m
\033[3;1mBold Italic\033[0m
\033[4mUnderline\033[24m
== === !== >= <= =>
契          勒 鈴 \n"
printf "%b" "${smoke_tests}"
}

moz_update ()
{
    sudo apt -q update
    sudo apt -q -y upgrade
    sudo apt -q -y autoclean
    sudo apt -q -y autoremove
}




