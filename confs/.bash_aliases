
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

# --- functions
function fd_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}

# --- exports

# Let there be color in grep!
export GREP_OPTIONS=' — color=auto'
# Set Vim as my default editor
export EDITOR=vim