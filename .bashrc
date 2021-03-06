function prompt_gen {
  local exit_status="$?"

  local INVERT="\[$(tput rev)\]"
  local CYAN="\[$(tput setaf 6)\]"
  local RED="\[$(tput setaf 1)\]"
  local GREEN="\[$(tput setaf 2)\]"
  local YELLOW="\[$(tput setaf 3)\]"
  local RESET="\[$(tput sgr0)\]"

  [ $exit_status -ne 0 ] && last_return="$INVERT$RED $exit_status $RESET " && local CLOCKCOLOUR="$INVERT$RED"

  git rev-parse --is-inside-work-tree &>/dev/null && local br="$(git symbolic-ref --short -q HEAD) "
  [ $br ] && [ $(git status --porcelain | wc -l) -ne "0" ] && local BRCOLOUR="$YELLOW"

  echo "\n$CLOCKCOLOUR\A$RESET $CYAN\u@\h:$RESET$GREEN\w$RESET\n$last_return$BRCOLOUR$br$RESET\$ "
}

PROMPT_COMMAND='PS1=$(prompt_gen)'

export CLICOLOR=1

alias grep='grep --color=auto'
alias ls='ls -Flah'
