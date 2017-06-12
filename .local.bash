# Add git branch support to shell
unset GIT_PS1_SHOWDIRTYSTATE
# unset GIT_PS1_SHOWUNTRACKEDFILES
# unset GIT_PS1_SHOWSTASHSTATE
# unset GIT_PS1_SHOWUPSTREAM

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

if ! [ "$(type -t __git_ps1)" = function ]; then
  function __git_ps1 {
    "SUBSHELL"
  }
fi

# function for setting terminal titles in OSX
function title {
  printf "\033]0;%s\007" "$1"
}

function git_status_indicator {
  local git_status="$(git status 2> /dev/null)"

    # echo "\e[38;5;2m⎇  "

  if [[ $git_status =~ "not staged for commit" ]]; then
    echo "\e[38;5;1m ▪︎ "
  elif [[ ! $git_status =~ "working directory clean" ]]; then
    echo "\e[38;5;3m ✚ "
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
    echo "\e[38;5;3m ● "
  elif [[ $git_status =~ "nothing to commit" ]]; then
    echo "\e[38;5;2m   "
  fi
}

function my_git_ps1 {
  # if ! [[ $PWD =~ /source(/|$) ]]; then
  __git_ps1 "  $( git_status_indicator )%s "
  # fi
}

function current_dirname {
  DIRNAME=$( dirname $( pwd ) )
  [[ "$DIRNAME" =~ ^"$HOME" ]] && DIRNAME="~${DIRNAME#$HOME}"

  if ! [[ "$DIRNAME" =~ ^/$ ]]; then
    echo $DIRNAME
  fi
}

function current_basename {
  BASENAME=$( basename $( pwd ) )

  if ! [[ "$BASENAME" =~ ^/$ ]]; then
    echo /$BASENAME
  else
    echo /
  fi
}

# export PS1='\r\n\[\e[1;32m\]\u\[\e[1;30m\]@\h\[\e[0m\]: \[\e[0;46m\]\[\e[97m\] \w \033[0;31m\]$("my_git_ps1")\[\033[00m\] \e[1;30m\]${timer_show}s\r\n\[\e[1;36m\]\$ \[\e[0;37m\]'
# export PS1='\r\n\e[0;48;5;12;38;5;0m \e[0;48;5;19;38;5;20m  \w  \033[0;48;5;18;38;5;8m$( "my_git_ps1" )\e[0;38;5;19m ${timer_show}s\r\n\n\e[0;1;36m\$ \e[0m'
# export PS1='\r\n\e[0;48;5;12;38;5;0m \e[0;48;5;19;38;5;20m  $( "current_dirname" )\e[38;5;16m$( current_basename )  \033[0;48;5;18;38;5;8m$( "my_git_ps1" )\e[0;38;5;19m ${timer_show}s\r\n\n\e[0;1;36m\$ \e[0m'
export PS1='\r\n\r\n\[\e[0;48;5;10;38;5;18m\] \T \[\e[48;5;14m\] ${timer_show}s \[\e[0;48;5;18;38;5;15m\]  $( "current_dirname" )\[\e[38;5;16m\]$( current_basename )  \[\e[0;48;5;0;38;5;8m\]$( "my_git_ps1" )\[\e[0;38;5;19m\]\r\n\n\[\e[0;1;36m\]\$ \[\e[0m\]'


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
alias l='ls -CF'
alias ps='ps u'
alias be='bundle exec'
alias s='spring'
alias srails='spring rails'
alias srake='spring rake'
alias spec='spring rspec'
alias g='git'
alias nbeg='NO_CI=1 beg'
alias beg='NO_TIMEOUT=1 be guard start -P rspec -c'
alias d='docker'
alias dc='docker-compose'
alias v='vagrant'
alias vi='nvim'
alias nv='cd ~/workspace/niche/niche_web; vi'
alias light='base16_mexico-light'
alias dark='base16_oceanicnext'
alias matrix='base16_greenscreen'

export GPG_TTY=$(tty)

export EDITOR="vi"
# export EDITOR="/usr/local/bin/subl -wn"

export BUNDLER_EDITOR="vi"
export RAILS_ERRORS=1
export NO_TIMEOUT=1
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
# Don't show 'Will run ... ' messages
export AUTOENV_QUIET=1

RUBY_GC_HEAP_INIT_SLOTS=500000
unset RUBY_HEAP_MIN_SLOTS
unset RAILS_ENV
unset CC
unset VERSION

export JAVA_LIBRARY_PATH=$JAVA_LIBRARY_PATH:/opt/twitter/lib
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(/opt/twitter/bin/jenv init -)"

source /opt/twitter/opt/autoenv/activate.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
