export BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

NPM_GLOBAL='/opt/twitter_mde/package/nodejs/b7c2b80f58d1d2481dbda9cc3fd274ae5505edfa9b53d88533f4a757fa03272f/bin'
export PATH="$HOME/.yarn/bin:$NPM_GLOBAL:$PATH"

unset GIT_PS1_SHOWDIRTYSTATE

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
  __git_ps1 "  $( git_status_indicator )%s "
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

function my_prompt {
  LAST_EXIT=$?

  WORKING_DIR='\[\e[0;48;5;18;38;5;15m\]  $( "current_dirname" )\[\e[38;5;16m\]$( current_basename )  '
  GIT='\[\e[0;48;5;0;38;5;8m\]$( my_git_ps1 )'
  CURRENT_TIME='\[\e[0;48;5;10;38;5;18m\] \@ '
  PROMPT='\[\e[0;1;36m\]\$ \[\e[0m\]'

  if [ "$LAST_EXIT" == "0" ]; then
    EXECUTION_RESULT='\[\e[48;5;14m\] ${timer_show}s '
  else
    EXECUTION_RESULT='\[\e[48;5;1;38;5;21m\] ${timer_show}s '
    if [ "$LAST_EXIT" != "1" ]; then
      EXECUTION_RESULT="${EXECUTION_RESULT}\[\e[48;5;16;38;5;18m\] $LAST_EXIT "
      tput bel
    fi
  fi

  PS1="\r\n\n${CURRENT_TIME}${EXECUTION_RESULT}${WORKING_DIR}${GIT}${PROJECT_PS1}\r\n\n${PROMPT}"
}
export PROMPT_COMMAND="my_prompt; timer_stop"

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
alias srails='spring rails'
alias srake='spring rake'
alias spec='spring rspec'
alias d='docker'
alias dc='docker-compose'
alias v='vagrant'
alias vi='nvim'
alias nv='cd ~/workspace/niche/niche_web; vi'
alias nd='cd ~/workspace/niche/niche_web'
alias lv='cd ~/workspace/phallguy/lactastic; vi'
alias ld='cd ~/workspace/phallguy/lactastic;'
alias light='base16_mexico-light'
alias dark='base16_oceanicnext'
alias matrix='base16_greenscreen'

export GPG_TTY=$(tty)

export EDITOR="nvim"
export BUNDLER_EDITOR="nvim"
export NO_TIMEOUT=1

export RUBY_GC_HEAP_INIT_SLOTS=500000
unset RUBY_HEAP_MIN_SLOTS
unset RAILS_ENV
unset CC
unset VERSION

source /opt/twitter/opt/autoenv/activate.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


