
function _begin_osc {
  printf "\e]"
}

function _end_osc {
  printf "\e\\"
}

function resetTerminalBackground() {
  _begin_osc
  printf "111"
  _end_osc
}

function setTerminalBackground() {
  # color=${1:-#31002D}
  _begin_osc
  printf "11;$*"
  _end_osc
}
trap resetTerminalBackground EXIT

_finish_prod() {
  resetTerminalBackground

  if [[ $ZELLIJ ]]; then
    zellij action toggle-fullscreen
    zellij action undo-rename-pane
    zellij action focus-next-pane
    zellij action close-pane
  fi
}

function prod() {
  if [[ $ZELLIJ ]]; then
    echo "In a Zellij session. Allow?"
    read REPLY\?"Really start? [y/N]"

    if [[ $REPLY =~ ^[Yy]$ ]]; then
      zellij action new-pane -d down -n prod -- echo "You're using PROD. BE CAREFUL!"
      zellij action focus-previous-pane
      zellij action toggle-fullscreen
      zellij action rename-pane "You're using PROD. BE CAREFUL!"
    else
      echo "Aborting"
      return 1
    fi
  fi

  setTerminalBackground "#4E001C"
  trap _finish_prod EXIT

  TERM=xterm "$@"
}
