eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim"
export VISUAL="nvim"
export BUNDLER_EDITOR="nvim"
export RIPGREP_CONFIG_PATH="/Users/paulalexander/.ripgreprc"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ll='exa -l --icons --git'
alias d='docker'
alias dcl='docker-compose -f docker-compose.yml.local'
alias k='kubectl'
alias vi='nvim'
alias t='terraform'
alias psql='pgcli'
alias v='vagrant'

bd() {
  cd ~/workspace/bark

  if [ -n "$1" ]; then
    TARGET_DIR=$1

    if ! [ -d "$TARGET_DIR" ]; then
      if [ -d "bark-$TARGET_DIR" ]; then
        TARGET_DIR=bark-$TARGET_DIR
      fi

      if [ -d "trl-$TARGET_DIR" ]; then
        TARGET_DIR=trl-$TARGET_DIR
      fi
    fi

    cd "$TARGET_DIR" || return
  fi
}
