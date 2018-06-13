function prompt_gen {
  local EXIT_STATUS="$?"

  local INVERT="\[$(tput rev)\]"
  local CYAN="\[$(tput setaf 6)\]"
  local RED="\[$(tput setaf 1)\]"
  local GREEN="\[$(tput setaf 2)\]"
  local YELLOW="\[$(tput setaf 3)\]"
  local MAGENTA="\[$(tput setaf 5)\]"
  local RESET="\[$(tput sgr0)\]"

  [ $EXIT_STATUS -ne 0 ] && LAST_RETURN="$INVERT$RED $EXIT_STATUS $RESET "

  git rev-parse --is-inside-work-tree &>/dev/null && local br="$(git symbolic-ref --short -q HEAD) "
  [ $br ] && [ $(git status --porcelain | wc -l) -ne "0" ] && local BRCOLOUR="$YELLOW"
  
  local HOSTCOLOR=$CYAN  # Hostname is Cyan
  [ -n "$SSH_TTY" ] && HOSTCOLOR=$MAGENTA  # If logged in over SSH, Hostname is Magenta

  echo "\n\A $HOSTCOLOR\u@\h:$GREEN\w$RESET\n$LAST_RETURN$BRCOLOUR$br$RESET\$ "
}

PROMPT_COMMAND='PS1=$(prompt_gen)'

# History
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
shopt -s histappend

# Aliases
export CLICOLOR=1
if ls --help 2>&1 | grep -q -- --color; then
  alias ls='ls --color=auto -Flah'; else  # GNU ls
  alias ls='ls -Flah'; fi  # BSD ls

alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias fgrep='grep --color=auto'
[ -f $HOME/.alias ] && source $HOME/.alias  # External alias file if present

alias gl='git log --oneline --decorate --all --color'

# Paths
export PATH=$PATH:$HOME/bin