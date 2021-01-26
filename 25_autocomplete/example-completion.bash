#!/bin/bash -x 
#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
autoload bashcompinit
bashcompinit

_test_script_completion()
{
  case ${COMP_CWORD} in
    1)
      COMPREPLY=($(compgen -W "$(./test_script.sh autocomplete all)"))
    ;;    
    2)
      COMPREPLY=($(compgen -W "$(./test_script.sh autocomplete directories)"))
    ;;  
    3)
      COMPREPLY=($(compgen -W "$(./test_script.sh autocomplete files})"))
    ;;         
    4)
      COMPREPLY=($(compgen -W "$(./test_script.sh autocomplete cd})"))
    ;;         
    *)
      COMPREPLY=()
    ;;
  esac
    
  ## Used for debugging.
  # COMPREPLY=()
  # echo ""
  # echo "COMP_WORDS : ${COMP_WORDS}"
  # echo "COMP_CWORD : ${COMP_CWORD}"
  # echo "COMP_WORDS[COMP_CWORD] : ${COMP_WORDS[COMP_CWORD]}"
  # echo "COMP_WORDS[COMP_CWORD-1] : ${COMP_WORDS[COMP_CWORD-1]}"
  # echo "COMP_LINE : ${COMP_LINE}"
  # echo "COMP_POINT : ${COMP_POINT}"
  # echo "COMP_KEY : ${COMP_KEY}"
  # echo "COMP_TYPE : ${COMP_TYPE}"
  # echo "args : $@"
  # echo "reply : ${COMPREPLY}"
}

complete -F _test_script_completion test_script.sh
