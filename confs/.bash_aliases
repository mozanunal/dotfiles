export EDITOR=nvim

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/home/linuxbrew/.linuxbrew/bin" ] ; then
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# --- aliases
alias dict='dict -d wn'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias fzv='nvim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias moz_py='source ~/dotfiles/dev/.venv/bin/activate'
alias moz_ipy='source ~/dotfiles/dev/.venv/bin/activate;ipython -i ~/dotfiles/dev/start.py'
alias moz_bpy='source ~/dotfiles/dev/.venv/bin/activate;bpython -p ~/dotfiles/dev/start.py'
alias moz_sql='litecli ~/dotfiles/dev/data/sq.sqlite'
alias moz_notes='cd ~/.password-store/notes/ && $EDITOR .'
alias moz_git_sync="git add . && git commit -m 'sync' && git push"

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




