export EDITOR=nvim
export MANPAGER="nvim +Man!"

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
HISTSIZE=1000000
HISTFILESIZE=10000000

# Append to the history file, don't overwrite it
shopt -s histappend
# Enable ** for recursive globbing
shopt -s globstar
# Automatically cd into typed directory names
shopt -s autocd
# Correct minor spelling errors in cd
shopt -s cdspell
# Keep window size updated after command execution
shopt -s checkwinsize
# Save multi-line commands as one history entry
shopt -s cmdhist
# Enable extended globbing (very powerful!)
shopt -s extglob
# Cause globs that match nothing to fail instead of expanding to a literal string
shopt -s failglob

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

# --- Aliases
alias la='ls -la'
alias ll='ls -ll'
# Conditionally create alias if command exists
if command -v bat &> /dev/null; then
  alias bat='bat --theme=base16 --style=numbers --color=always --line-range :500'
fi
alias v='source .venv/bin/activate'
alias vp='source playground/.envrc'
alias e='source .venv/bin/activate; $EDITOR .'
alias n='cd ~/.password-store && $EDITOR .'
alias tm='tmux a || tmux'
alias zm='zellij a || zellij'
alias lg='lazygit'
alias lvim='NVIM_APPNAME="lvim" nvim'

# --- Functions
FD_OPTS="--follow --hidden -E .git -E node_modules -E .venv -E .cache"
FZF_CMD="fzf --reverse"

# Find and edit a file
moz_fzef() {
  local file
  file=$(fd -t f -d 7 $FD_OPTS | $FZF_CMD)
  [ -n "$file" ] && $EDITOR "$file"
}

# Find a directory, cd into it, and edit
moz_fzed() {
  local dir
  dir=$(fd -t d -d 5 $FD_OPTS | $FZF_CMD)
  if [ -n "$dir" ]; then
    cd "$dir"
    # Attempt to activate virtualenv, silencing errors
    source .venv/bin/activate 2>/dev/null || true
    $EDITOR .
  fi
}

moz_fd_large_files() {
  # List top 20 largest files/dirs in current directory
	du -h -x -s -- * | sort -r -h | head -20
}

moz_update() {
	sudo apt -q update && sudo apt -q upgrade
	# Separate potentially interactive part
	read -p "Run autoremove and autoclean? (y/N) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		sudo apt -q -y autoremove
		sudo apt -q -y autoclean
	fi
}


# -- Readline Functions and Bindings
__moz_fzcd() {
  local dir
  dir=$(fd -t d -d 5 $FD_OPTS | $FZF_CMD)
  if [ -n "$dir" ]; then
    READLINE_LINE="cd \"$dir\""
    READLINE_POINT=${#READLINE_LINE}
  fi
}

__moz_fzh() {
  # awk '!x[$0]++' is a fast way to get unique lines while preserving order
  READLINE_LINE=$(tac ~/.bash_history | awk '!x[$0]++' | $FZF_CMD)
  READLINE_POINT=${#READLINE_LINE}
}

# Ctrl+t cd to directory
bind -x '"\C-t":__moz_fzcd'
# Ctrl+r history search (custom)
bind -x '"\C-r":__moz_fzh'
# Alt+d edit directory
bind -x '"\ed":moz_fzed'
# Alt+e edit file
bind -x '"\ee":moz_fzef'


