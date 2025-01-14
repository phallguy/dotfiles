
# Download Znap, if it's not there yet.
[[ -r ~/dotfiles/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/dotfiles/znap
source ~/dotfiles/znap/znap.zsh  # Start Znap

# Use arm or x86 version of brew depending on architecture
if [[ $(uname -p) == 'arm' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

export DIRENV_LOG_FORMAT=$'\E[30mdirenv: %s\E[0m'
znap eval direnv "direnv hook zsh"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

znap install zsh-users/zsh-completions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source wintermi/zsh-mise

autoload edit-command-line
zle -N edit-command-line

zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
zstyle ':autocomplete:*' min-input 3
zstyle ':autocomplete:*' delay 0.5  # seconds (float)

bindkey "^y" autosuggest-accept
bindkey "^ " autosuggest-accept
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^v" edit-command-line

export CLICOLOR=1
export GPG_TTY=$TTY
export BAT_THEME="Monokai Extended Origin"

znap eval batpipe "batpipe"

alias cat="$(which bat)"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

if command -v zoxide &> /dev/null; then
  znap eval zoxide "zoxide init zsh"
else
  echo "zoxide not installed"
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
export EZA_COLORS="reset"
eza_params=('--group-directories-first')
alias ls='eza $eza_params'
alias ll='eza $eza_params --long --no-permissions --no-user'
alias d='docker'
alias dcl='docker-compose -f docker-compose.yml.local'
alias k='kubectl'
alias vi='nvim'
alias t='terraform'
alias v='vagrant'
alias x86='arch -arch x86_64 /bin/zsh --login'
alias cd='z'
alias g='git'
alias lg='lazygit'
alias man='batman'
alias sb='cd ~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault; vi .'
alias y='yazi'
alias zel='zellij'

function kan() {
  cd ~/dotfiles;
  sudo kanata -n
}

function _begin_osc {
  printf "\033]"
}

function _end_osc {
  printf "\007"
}

function resetTerminalBackground() {
  _begin_osc
  printf "104;"
  _end_osc
}

function setTerminalBackground() {
  color=${1:-#31002D}
  _begin_osc
  printf "11;${color}"
  _end_osc
}
trap resetTerminalBackground EXIT

function tailf() {
  tail -F $@ | bat -pp -l log
}


if [[ $(uname -p) != 'arm' ]]; then
  setTerminalBackground "#000064"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
export PATH=$PATH:/Users/paulalexander/.spicetify

# function current_dir() {
#     local current_dir=$PWD
#     if [[ $current_dir == $HOME ]]; then
#         current_dir="~"
#     else
#         current_dir=${current_dir##*/}
#     fi
#
#     echo $current_dir
# }
#
# function change_tab_title() {
#     local title=$1
#     command nohup zellij action rename-tab $title >/dev/null 2>&1
# }
#
# function set_tab_to_working_dir() {
#     local result=$?
#     local title=$(current_dir)
#     # uncomment the following to show the exit code after a failed command
#     # if [[ $result -gt 0 ]]; then
#     #     title="$title[$result]" 
#     # fi
#
#     change_tab_title $title
# }
#
# function set_tab_to_command_line() {
#     local cmdline=$1
#     change_tab_title $cmdline
# }
#
# if [[ -n $ZELLIJ ]]; then
#     add-zsh-hook precmd set_tab_to_working_dir
#     add-zsh-hook preexec set_tab_to_command_line
# fi

ZELLIJ_AUTO_EXIT=true

fpath=(
  ~/dotfiles/zellij/completion,
  "${fpath[@]}"
)

# znap eval navi "navi widget zsh"
znap eval mise "~/.local/bin/mise activate zsh"
znap eval atuin "atuin init zsh --disable-up-arrow"
znap eval starship "starship init zsh"

function zn () {
  if [ ! $# -eq 0 ]; then
    z "$*"
  fi
  
  local layout="dev"
  if [ -f ./.zellij-layout ]; then
    layout =  $(cat .zellij-layout)
  fi

  local session=$(basename $(pwd))
  local active=$(zellij list-sessions --short 2> /dev/null)

  if (($active[(Ie)$session])); then
    zellij attach $session
  else
    zellij -n $layout -s $session
  fi
}

function za () { zellij attach "$*"; }
function zl () { zellij ls;}
function zw () { zellij -l welcome;}
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function zri () { zellij run --name "$*" --in-place -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}
function zei () { zellij edit --in-place "$*";}
function zpipe () { 
  if [ -z "$1" ]; then
    zellij pipe;
  else 
    zellij pipe -p $1;
  fi
}
