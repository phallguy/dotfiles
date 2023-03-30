eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="vi"
export VISUAL="vi"
export BUNDLER_EDITOR="vi"
export RIPGREP_CONFIG_PATH="/Users/paulalexander/.ripgreprc"

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
