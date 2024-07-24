# Use arm or x86 version of brew depending on architecture
if [[ $(uname -p) == 'arm' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

export DIRENV_LOG_FORMAT=$'\E[30mdirenv: %s\E[0m'
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  mise
  zsh-autocomplete
  zsh-autosuggestions
  zsh-syntax-highlighting
)

autoload edit-command-line
zle -N edit-command-line

zstyle ':omz:*' aliases no
zstyle ':completion:*:*' matcher-list 'm:{[:lower:]-}={[:upper:]_}' '+r:|[.]=**'
zstyle ':autocomplete:*' min-input 3
zstyle ':autocomplete:*' delay 0.5  # seconds (float)

source $ZSH/oh-my-zsh.sh

bindkey "^y" autosuggest-accept
bindkey "^ " autosuggest-accept
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^v" edit-command-line

export CLICOLOR=1
export GPG_TTY=$TTY
export BAT_THEME="Monokai Extended Origin"

eval "$(batpipe)"

# if command -v wezterm &> /dev/null; then
#   eval "$(wezterm shell-completion --shell zsh)"
# fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
else
  echo "zoxide not installed"
fi

if command -v fzy &> /dev/null; then
else
  echo "fzy not installed"
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
alias ob='cd ~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault; vi .'

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

eval "$(atuin init zsh)"
eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
