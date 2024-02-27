export EDITOR=nvim

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
alias dict='dict -d wn'
alias fd='fdfind'
alias bat='batcat --theme=base16 --style=numbers --color=always --line-range :500'
alias fzf="fzf --preview 'batcat --theme=base16 --style=numbers --color=always --line-range :500 {}'"
alias fze='nvim $(fzf)'
alias tm='tmux a||tmux'
alias zm='zellij a||zellij'
alias lg='lazygit'
alias moz_py='source ~/dotfiles/dev/.venv/bin/activate'
alias moz_ipy='source ~/dotfiles/dev/.venv/bin/activate;ipython -i ~/dotfiles/dev/start.py'
alias moz_bpy='source ~/dotfiles/dev/.venv/bin/activate;bpython -p ~/dotfiles/dev/start.py'
alias moz_sql='litecli ~/dotfiles/dev/data/sq.sqlite'
alias moz_notes='cd ~/.password-store/ && $EDITOR .'
alias moz_git_sync="git add . && git commit -m 'sync' && git push"
alias moz_sync="cd ~/dotfiles/ && git pull && make sync_de"

# --- functions
moz_conf() {
	fdfind . ~/dotfiles/ -t f --hidden -E .git | fzf | xargs $EDITOR
}

moz_fd_large_files() {
	du -h -x -s -- * | sort -r -h | head -20
}

moz_smoke_test() {
	smoke_tests="Normalx
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

last_run_file="$HOME/.last_run_timestamp"
if [ -f "$last_run_file" ]; then
    last_run_timestamp=$(cat "$last_run_file")
    time_since_last_run=$(( $(date +%s) - last_run_timestamp ))
    if [ $time_since_last_run -gt 86399 ]; then
        moz_update_check &
        date +%s > "$last_run_file"
    fi
else
    moz_update_check &
    date +%s > "$last_run_file"
fi








