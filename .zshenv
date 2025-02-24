
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
    zellij action undo-rename-tab
    zellij action focus-next-pane
    zellij action close-pane
  fi
}

function prod() {
  if [[ $ZELLIJ ]]; then
    zellij action new-pane -d down -n prod -- echo "You're using PROD. BE CAREFUL!"
    zellij action rename-tab "PROD. BE CAREFUL!"
    zellij action rename-pane "PROD. BE CAREFUL!"
    zellij action focus-previous-pane

    repeat 50 { zellij action resize + down; }
  fi

  setTerminalBackground "#4E001C"
  trap _finish_prod EXIT

  TERM=xterm "$@"
}

function zn () {
  if [ ! $# -eq 0 ]; then
    z "$*"
  fi
  
  local layout="${LAYOUT:-dev}"
  if [ -f ./.zellij-layout ]; then
    layout=$(cat .zellij-layout)
  fi

  local session=$(basename $(pwd) | tail -n1)
  local active=$(zellij list-sessions --short 2> /dev/null)

  if (($active[(Ie)$session])); then
    zellij attach "$session"
  else
    zellij -n $layout -s "$session"
  fi
}

function zak() {
  local session=kan
  local active=$(zellij list-sessions --short 2> /dev/null)

  if (($active[(Ie)$session])); then
    # Already running
  else
    setopt local_options no_notify no_monitor
    zellij -n kan -s $session
  fi
}

function zakk() { zellij kill-session kan; }


function zk () { zellij kill-session "$*"; }
function zka () { zellij kill-all-sessions; }
function za () { zellij attach "$*"; }
function zl () { zellij ls;}
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function zri () { zellij run --name "$*" --in-place -- zsh -ic "$*";}
function zpipe () { 
  if [ -z "$1" ]; then
    zellij pipe;
  else 
    zellij pipe -p $1;
  fi
}
