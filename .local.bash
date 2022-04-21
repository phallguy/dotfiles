export BASH_SILENCE_DEPRECATION_WARNING=1

unset RUBY_HEAP_MIN_SLOTS
unset RAILS_ENV
unset CC
unset VERSION
# export RUBYOPT="-W0"

# Make sure brew executables are in path
export PATH="/usr/local/sbin:~/Library/Python/3.7/bin:$PATH"

export CLICOLOR=1
export LSCOLORS=gxfxFxdxbxDxDxBxBxExEx

# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

eval "$(gh completion -s bash)"

export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.minikube-completion ] && source ~/.minikube-completion

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

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
    echo "\e[38;5;1m ▪︎ "
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo "\e[38;5;2m   "
  elif [[ ! $git_status =~ "working directory clean" ]]; then
    echo "\e[38;5;3m ⦿ "
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo "\e[38;5;3m ● "
  fi
}

function my_git_ps1 {
  __git_ps1 "  $( git_status_indicator )%s "
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

  # Base16 Colors
  WORKING_DIR='\[\e[0;48;5;18;38;5;15m\]  $( "current_dirname" )\[\e[38;5;16m\]$( current_basename )  '
  GIT='\[\e[0;48;5;0;38;5;8m\]$( my_git_ps1 )'
  CURRENT_TIME='\[\e[0;48;5;10;38;5;18m\] \@ '
  PROMPT='\[\e[0;1;36m\]\$ \[\e[0m\]'

  # "Natural" Colors
  # WORKING_DIR='\[\e[0;48;5;18;38;5;15m\]  $( "current_dirname" )\[\e[1;35;16m\]$( current_basename )  '
  # GIT='\[\e[0m\]$( my_git_ps1 )'

  if [ "$LAST_EXIT" == "0" ]; then
    EXECUTION_RESULT='\[\e[48;5;14m\] ${timer_show}s '
  else
    EXECUTION_RESULT='\[\e[48;5;1;38;5;21m\] ${timer_show}s '
    if [ "$LAST_EXIT" != "1" ]; then
      EXECUTION_RESULT="${EXECUTION_RESULT}\[\e[48;5;16;38;5;18m\] $LAST_EXIT "
      tput bel
    fi
  fi

  PS1="\r\n\n${CURRENT_TIME}${EXECUTION_RESULT}${WORKING_DIR}${GIT}${PROJECT_PS1}\[\e[0m\]\r\n\n${PROMPT}"
}
export PROMPT_COMMAND="my_prompt; timer_stop"
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
alias ll='ls -lFh'
alias la='ls -A'
alias be='bundle exec'
alias d='docker'
alias dcl='docker-compose -f docker-compose.yml.local'
alias vi='nvim'
alias k='kubectl'
alias t='terraform'
alias light_theme='base16_mexico-light'
# alias dark_theme='base16_material-darker'
alias dark_theme='base16_material-palenight'
# alias dark_theme='base16_woodland'
alias matrix_theme='base16_greenscreen'
alias admin_theme='base16_heetch'
alias psql='pgcli'
alias v='vagrant'
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

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
export NO_TIMEOUT=1
export LESS=FRX
# Don't list every path/var change on every prompt
# export DIRENV_LOG_FORMAT=

eval "$(direnv hook bash)"

# Make sure its last so that we don't get a PATH warning all the time
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(rbenv init -)"

dark_theme

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/palexander/google-cloud-sdk/path.bash.inc' ]; then . '/Users/palexander/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/palexander/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/palexander/google-cloud-sdk/completion.bash.inc'; fi

source /Users/palexander/.config/broot/launcher/bash/br
