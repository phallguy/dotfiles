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
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autocomplete
  zsh-autosuggestions
  # zsh-syntax-highlighting
  # zsh-vim-mode
)

autoload edit-command-line
zle -N edit-command-line

zstyle ':omz:*' aliases no

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
exa_params=('--git' '--icons' '--classify' '--group-directories-first' '--color-scale')
alias ls='exa $exa_params'
alias ll='exa $exa_params --long'
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

eval "$(rbenv init - zsh)"
eval "$(atuin init zsh)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
