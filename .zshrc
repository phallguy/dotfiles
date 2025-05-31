
# Download Znap, if it's not there yet.
[[ -r ~/dotfiles/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/dotfiles/znap
source ~/dotfiles/znap/znap.zsh  # Start Znap
zstyle ':znap:*' repos-dir ~/dotfiles/znap-plugins

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

znap source zsh-users/zsh-completions
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
# znap source wintermi/zsh-mise

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

# znap eval batpipe "batpipe"

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
alias sb='cd ~/paul.xheo@gmail.com - Google Drive/My Drive/Obsidian Vault; zn'
alias y='yazi'
alias zel='zellij'
alias upgrade='brew upgrade tree-sitter luajit neovim aerospace zellij starship --greedy-latest --no-quarantine --fetch-HEAD; spicetify update'

function kan() {
  cd ~/dotfiles;
  sudo kanata -n
}

function tailf() {
  tail -F $@ | bat -pp -l log
}

if [[ $(uname -p) != 'arm' ]]; then
  setTerminalBackground "#000064"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
export PATH=$PATH:/Users/paulalexander/.spicetify

fpath=(
  ~/dotfiles/zellij/completion,
  "${fpath[@]}"
)

znap eval mise "/opt/homebrew/bin/mise activate zsh"
znap eval atuin "atuin init zsh --disable-up-arrow"
znap eval starship "starship init zsh"


