# --- aliases
alias dict='dict -d wn'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias fzv='nvim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'

export EDITOR=nvim
