
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
alias fzv='vim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias emj="cat ~/.icons | fzf | awk '{ print $1 }'"
alias fd='fdfind'
alias bat='batcat'
# --- functions
function fd_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}

function smoke_test() {
smoke_tests="Normal
\033[1mBold\033[22m
\033[3mItalic\033[23m
\033[3;1mBold Italic\033[0m
\033[4mUnderline\033[24m
== === !== >= <= =>
契          勒 鈴 \n"
printf "%b" "${smoke_tests}"
}

export EDITOR=nvim
