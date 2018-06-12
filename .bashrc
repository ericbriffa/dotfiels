function prompt_gen {
  local exit_status="$?"

  local INVERT="\[$(tput rev)\]"
  local CYAN="\[$(tput setaf 6)\]"
  local RED="\[$(tput setaf 1)\]"
  local GREEN="\[$(tput setaf 2)\]"
  local YELLOW="\[$(tput setaf 3)\]"
  local RESET="\[$(tput sgr0)\]"

  [ $exit_status -ne 0 ] && last_return="$INVERT$RED $exit_status $RESET "

  git rev-parse --is-inside-work-tree &>/dev/null && local br="$(git symbolic-ref --short -q HEAD) "
  [ $br ] && [ $(git status --porcelain | wc -l) -ne "0" ] && local BRCOLOUR="$YELLOW"

  echo "\n\A $CYAN\u@\h:$GREEN\w$RESET\n$last_return$BRCOLOUR$br$RESET\$ "
}

PROMPT_COMMAND='PS1=$(prompt_gen)'

# History
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

export CLICOLOR=1
if ls --help 2>&1 | grep -q -- --color; then
  alias ls='ls --color=auto -Flah'; else  # GNU ls
  alias ls='ls -Flah'; fi  # BSD ls

# Load external .alias file
[ -f $HOME/.alias ] && source $HOME/.alias

alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias fgrep='grep --color=auto'

alias gl='git log --oneline --decorate --all --color'