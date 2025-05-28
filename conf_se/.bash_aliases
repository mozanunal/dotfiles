export EDITOR=nvim
export MANPAGER="nvim +Man!"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000000
HISTFILESIZE=10000000

if [ -d "$HOME/go/bin" ]; then
	PATH="$HOME/go/bin:$PATH"
fi

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
	PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# --- aliases
alias la='ls -la'
alias ll='ls -ll'
alias bat='bat --theme=base16 --style=numbers --color=always --line-range :500'
alias v='source .venv/bin/activate'
alias vp='source playground/.envrc'
alias e='source .venv/bin/activate; && $EDITOR .'
alias n='cd ~/.password-store && $EDITOR .'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias lg='lazygit'
alias moz_sync="cd ~/dotfiles/ && git pull && make"
alias lvim='NVIM_APPNAME="lvim" nvim'
# --- functions
FD_OPTS="--follow --hidden -E .git -E node_modules -E .venv -E .cache"
FZF_CMD="fzf --reverse"

moz_fzef() {
  fd -t f -d 7 $FD_OPTS | $FZF_CMD | xargs -r $EDITOR
}

moz_fzed() {
  cd $(fd -t d -d 5 $FD_OPTS | $FZF_CMD )
  source .venv/bin/activate 2>/dev/null || true
  $EDITOR .
}
# -- readline functions
__moz_fzcd() {
  READLINE_LINE="cd $(fd -t d -d 5 $FD_OPTS | $FZF_CMD)"
  READLINE_POINT=${#READLINE_LINE}
}

__moz_fzh() {
  READLINE_LINE=$(cat ~/.bash_history | sort | uniq | $FZF_CMD)
  READLINE_POINT=${#READLINE_LINE}
}

# Ctrl+t cd to directory
bind -x '"\C-t":__moz_fzcd'
# Ctrl+r history search
bind -x '"\C-r":__moz_fzh'
# Alt+d edit directory
bind -x '"\ed":moz_fzed'
# Alt+e edit file
bind -x '"\ee":moz_fzef'

moz_fd_large_files() {
	du -h -x -s -- * | sort -r -h | head -20
}

moz_update() {
	sudo apt -q update
	sudo apt -q -y upgrade
	sudo apt -q -y autoclean
	sudo apt -q -y autoremove
}

