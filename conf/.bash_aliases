export EDITOR=nvim

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

fzf_cmd="fzf --reverse"
# --- aliases
alias la='ls -la'
alias ll='ls -ll'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
# alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias v='source .venv/bin/activate'
alias n='cd ~/.password-store && $EDITOR .'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias lg='lazygit'
alias moz_sync="cd ~/dotfiles/ && git pull && make"
alias moz_py='source ~/.moz_py/bin/activate'
alias moz_jpy="tmux new-session -d -s jupyter 'source ./.moz_py/bin/activate && jupyter-lab --ip 0.0.0.0 --no-browser --port 8000'"
alias moz_ipy='moz_py && ipython'
alias moz_bpy='moz_py && bpython'
alias moz_sql='moz_py && litecli ~/.moz_py/dev.sqlite'

# --- functions
moz_fzef() {
  fd -t f -d 7 --hidden -E .git| $fzf_cmd | xargs -r $EDITOR
}

moz_fzed() {
  cd $(fd -t d -d 5 | $fzf_cmd )
  source .venv/bin/activate 2>/dev/null || true
  $EDITOR .
}
# -- readline functions
__moz_fzcd() {
  READLINE_LINE="cd $(fd -t d -d 5 | $fzf_cmd)"
  READLINE_POINT=${#READLINE_LINE}
}

__moz_fzh() {
  READLINE_LINE=$(cat ~/.bash_history | sort | uniq | $fzf_cmd)
  READLINE_POINT=${#READLINE_LINE}
}

# Alt+c cd to directory
bind -x '"\ec":__moz_fzcd'
# Ctrl+r history search
bind -x '"\C-r":__moz_fzh'
# Alt+d edit directory
bind -x '"\ed":moz_fzed'
# Alt+e edit file
bind -x '"\ee":moz_fzef'

moz_fd_large_files() {
	du -h -x -s -- * | sort -r -h | head -20
}

moz_smoke_test() {
	smoke_tests="Normal
\033[1mBold\033[22m
\033[3mItalic\033[23m
\033[3;1mBold Italic\033[0m
\033[4mUnderline\033[24m
== === !== >= <= =>
契          勒 鈴 \n"
	printf "%b" "${smoke_tests}"
}

moz_update() {
	sudo apt -q update
	sudo apt -q -y upgrade
	sudo apt -q -y autoclean
	sudo apt -q -y autoremove
}

moz_update_check () {
  echo "moz_os checking for updates, please wait..."
  DIRECTORY="$HOME/dotfiles"

  # Check if it's a Git repository
  if ! git -C "$DIRECTORY" rev-parse --is-inside-work-tree &>/dev/null; then
      echo "Directory $DIRECTORY is not a Git repository."
      exit 1
  fi

  # Fetch latest changes from remote repository
  git -C "$DIRECTORY" fetch &>/dev/null

  # Check if there are changes to pull
  AHEAD=$(git -C "$DIRECTORY" rev-list --count HEAD..origin/master)

  if [ $AHEAD -gt 0 ]; then
      echo -e "\n[Dotfiles is $AHEAD versions behind the remote repository.]"
      echo -e "[You should run moz_sync to be up-to-date.]"
  else
      echo -e "\n[Dotfiles are up-to-date]"
  fi
}

moz_update_ts_check () {
  last_run_file="$HOME/.last_run_timestamp"
  if [ -f "$last_run_file" ]; then
      last_run_timestamp=$(cat "$last_run_file")
      time_since_last_run=$(( $(date +%s) - last_run_timestamp ))
      if [ $time_since_last_run -gt 86399 ]; then
          moz_update_check
          date +%s > "$last_run_file"
      fi
  else
      moz_update_check
      date +%s > "$last_run_file"
  fi
}

moz_update_ts_check


