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
alias v='source .venv/bin/activate'
alias e='source .venv/bin/activate; $EDITOR .'
alias p='cd ~/.password-store && $EDITOR .'
alias n='cd ~/.notes && $EDITOR .'
alias tm='tmux a || tmux'
alias zm='zellij a || zellij'
alias lg='lazygit'
alias lvim='NVIM_APPNAME="lvim" nvim'

eval "$(fzf --bash)"
