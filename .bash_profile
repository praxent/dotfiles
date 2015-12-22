#!/bin/bash
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

alias ll='/bin/ls -lAFh'

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias fuckit='sudo halt'

##
# Shell colors
##
BLACK="\[\e[0;30m\]"  BOLD_BLACK="\[\e[1;30m\]"  UNDER_BLACK="\[\e[4;30m\]"
RED="\[\e[0;31m\]"    BOLD_RED="\[\e[1;31m\]"    UNDER_RED="\[\e[4;31m\]"
GREEN="\[\e[0;32m\]"  BOLD_GREEN="\[\e[1;32m\]"  UNDER_GREEN="\[\e[4;32m\]"
YELLOW="\[\e[0;33m\]" BOLD_YELLOW="\[\e[1;33m\]" UNDER_YELLOW="\[\e[4;33m\]"
BLUE="\[\e[0;34m\]"   BOLD_BLUE="\[\e[1;34m\]"   UNDER_BLUE="\[\e[4;34m\]"
PURPLE="\[\e[0;35m\]" BOLD_PURPLE="\[\e[1;35m\]" UNDER_PURPLE="\[\e[4;35m\]"
CYAN="\[\e[0;36m\]"   BOLD_CYAN="\[\e[1;36m\]"   UNDER_CYAN="\[\e[4;36m\]"
WHITE="\[\e[0;37m\]"  BOLD_WHITE="\[\e[1;37m\]"  UNDER_WHITE="\[\e[4;37m\]"
NO_COLOR="\[\e[0m\]"

function git_status {
  status="$(git status 2> /dev/null | cat)"

  pattern="Changes"
  [[ "$status" =~ "$pattern" ]] && echo "!"

  pattern="untracked files"
  [[ "$status" =~ "$pattern" ]] && echo "*"
}

export PS1="${PURPLE}\h${WHITE}[${YELLOW}\w${WHITE}]\$(__git_ps1 '${WHITE}[${GREEN}%s${RED}'\$(git_status)'${WHITE}]')${WHITE}${NO_COLOR}"
export PS2=" > "
export PS4=" + "

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export GREP_OPTIONS='--color=auto'

function jscat {
  tail -n$2 $1 | while read a; do echo $a | python -mjson.tool; done;
}

# completion scripts
if [ -f /usr/local/Cellar/bash-completion/1.3/etc/bash_completion ]; then
  . /usr/local/Cellar/bash-completion/1.3/etc/bash_completion
fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

##
# For chruby
##
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  chruby 2.1.2
fi

if [ -f /usr/local/share/chruby/auto.sh ]; then
 source /usr/local/share/chruby/auto.sh
fi

export PYTHONUNBUFFERED=1
export NODE_PATH="'$(npm root -g)'"

# Add GHC 7.10.1 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.1.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

export ANSIBLE_HOSTS='/etc/ansible_hosts'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/Cellar/php56/5.6.9/bin:$PATH