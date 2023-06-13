
source ~/.fzf_keybindings.bash

# --- aliases
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'
alias dict='dict -d wn'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias fzv='nvim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'

export EDITOR=nvim
