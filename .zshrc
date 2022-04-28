[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export CLICOLOR=1
export LSCOLORS=gxfxFxdxbxDxDxBxBxExEx

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"


# ALIASES
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

