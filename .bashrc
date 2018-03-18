function prompt_gen {
  local exit_status="$?"

  local INVERT=$(tput rev)
  local CYAN=$(tput setaf 6)
  local RED=$(tput setaf 1)
  local GREEN=$(tput setaf 2)
  local RESET=$(tput sgr0)

  [ $exit_status -ne 0 ] && last_return="$RED[$exit_status] "

  git rev-parse --is-inside-work-tree >/dev/null 2>&1 && local br="$(git symbolic-ref --short -q HEAD) "
  [ $br ] && [ $(git status --porcelain | wc -l) -ne "0" ] && local GITCOLOUR="$(tput setaf 3)"

  echo "\n$INVERT \A $CYAN \u@\h:$RESET$GREEN\w$RESET\n$GITCOLOUR$br$RESET$last_return$RESET\$ "
}

PROMPT_COMMAND='PS1=$(prompt_gen)'