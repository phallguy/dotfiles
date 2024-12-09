export BASH_SILENCE_DEPRECATION_WARNING=1

unset RUBY_HEAP_MIN_SLOTS
unset RAILS_ENV
unset CC
unset VERSION
export RUBYOPT="-W0"
export RIPGREP_CONFIG_PATH="/Users/paulalexander/.ripgreprc"
export BAT_THEME="base16-256"
LESSOPEN="|/opt/homebrew/Cellar/bat-extras/2022.07.27/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;

# The following will enable colors when using batpipe with less:
LESS="$LESS -FRX";
BATPIPE="color";
export LESS;
export BATPIPE;

export CPU_ARCH=$(uname -a)

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make sure brew executables are in path
export PATH="/usr/local/sbin:~/Library/Python/3.7/bin:$PATH:~/.local/bin"

export CLICOLOR=1
#export LSCOLORS=gxfxFxdxbxDxDxBxBxExEx

# # Base16 Shell
# export BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         source "$BASE16_SHELL/profile_helper.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

[ -f "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ] && \
  . $(brew --prefix)/etc/bash_completion.d/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=
export GIT_PS1_SHOWUNTRACKEDFILES=

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

function git_status_indicator {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "not staged for commit" ]]; then
    echo "\e[31;2m ▪︎ "
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo "\e[1;30m "
  elif [[ ! $git_status =~ "working directory clean" ]]; then
    echo "\e[33;2m ⦿ "
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo "\e[33;2m ● "
  fi
}

function my_git_ps1 {
  __git_ps1 "$( git_status_indicator )%s"
}

function current_dirname {
  DIRNAME=$( dirname "$( pwd )" )
  [[ "$DIRNAME" =~ ^"$HOME" ]] && DIRNAME="~${DIRNAME#$HOME}"

  if ! [[ "$DIRNAME" =~ ^/$ ]]; then
    echo $DIRNAME
  fi
}

function current_basename {
  BASENAME=$( basename "$( pwd )" )

  if ! [[ "$BASENAME" =~ ^/$ ]]; then
    echo /$BASENAME
  else
    echo /
  fi
}

function my_prompt {
  LAST_EXIT=$?

  WORKING_DIR='\[\e[0;1;30m\]$( "current_dirname" )\[\e[0;32m\]$( current_basename )  '
  GIT='\[\e[0m\]$( my_git_ps1 )'
  CURRENT_TIME='\[\e[0;30m\] \@ '
  PROMPT='\[\e[0;1;32m\]\$ \[\e[0;37m\]'

  if [ "$LAST_EXIT" == "0" ]; then
    EXECUTION_RESULT='\[\e[0;30m\] ${timer_show}s '
  else
    EXECUTION_RESULT='\[\e[0;41;1;m\] ${timer_show}s '
    if [ "$LAST_EXIT" != "1" ]; then
      EXECUTION_RESULT="${EXECUTION_RESULT}\[\e[1;33m\] $LAST_EXIT "
      tput bel
    fi
  fi

  if [[ $CPU_ARCH =~ x86_64 ]]; then
    CURRENT_ARCH="\[\e[0;1;31m\] x86_64 "
  else
    CURRENT_ARCH=""
  fi

  PS1="\r\n\n$(title $(current_basename))${WORKING_DIR}${GIT}${PROJECT_PS1}${CURRENT_ARCH}${CURRENT_TIME}${EXECUTION_RESULT}\[\e[0m\]\r\n\n${PROMPT}"
}
export PROMPT_COMMAND="my_prompt; history -a; timer_stop"
shopt -s histappend
export HISTCONTROL=ignoreboth:erasedups

# function for setting terminal titles in OSX
function title {
  printf "\033]0;%s\007" "$1"
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
# alias ll='ls -lFh'
alias ll='exa -l --icons --git'
alias la='ls -A'
alias be='bundle exec'
alias d='docker'
alias dcl='docker-compose -f docker-compose.yml.local'
alias vi='nvim'
alias k='kubectl'
alias t='terraform'
alias psql='pgcli'
alias v='vagrant'

bd() {
  cd ~/workspace/bark

  if [[ ! -z "$1" ]]; then
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

export GPG_TTY=$(tty)

export EDITOR="nvim"
export VISUAL="nvim"
export BUNDLER_EDITOR="nvim"
# Don't list every path/var change on every prompt
# export DIRENV_LOG_FORMAT=

eval "$(direnv hook bash)"

eval "$(rbenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/paulalexander/google-cloud-sdk/path.bash.inc' ]; then . '/Users/paulalexander/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/paulalexander/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/paulalexander/google-cloud-sdk/completion.bash.inc'; fi

. "$HOME/.cargo/env"

if command -v wezterm &> /dev/null; then
  eval "$(wezterm shell-completion --shell bash)"
fi
