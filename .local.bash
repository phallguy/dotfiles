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

function my_git_ps1 {
  PWD=$( pwd )
  # if ! [[ $PWD =~ /source(/|$) ]]; then
    __git_ps1
  # fi
}

export PS1='\r\n${debian_chroot:+($debian_chroot)}\[\e[1;32m\]\u\[\e[1;30m\]@\h\[\e[0m\]: \[\e[0;36m\]\w \033[31m\]$("my_git_ps1")\[\033[00m\] \e[1;30m\]${timer_show}s\r\n\[\e[1;36m\]\$ \[\e[0;37m\]'

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
