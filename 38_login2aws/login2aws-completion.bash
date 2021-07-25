#!/bin/bash -x 
#!/usr/bin/env bash 
#Use !/bin/bash -x  for debugging 
autoload bashcompinit
bashcompinit

_test_script_completion()
{
  if [[ -n $COMPLETION_DEBUG ]]; then
    # Used for debugging.
    COMPREPLY=()
    echo ""
    echo "$$1 : $1"
    echo "$$2 : $2"
    echo "$$3 : $3"
    echo "COMP_WORDS : ${COMP_WORDS}"
    echo "COMP_CWORD : ${COMP_CWORD}"
    echo "COMP_WORDS[COMP_CWORD] : ${COMP_WORDS[COMP_CWORD]}"
    echo "COMP_WORDS[COMP_CWORD-1] : ${COMP_WORDS[COMP_CWORD-1]}"
    echo "COMP_LINE : ${COMP_LINE}"
    echo "COMP_POINT : ${COMP_POINT}"
    echo "COMP_KEY : ${COMP_KEY}"
    echo "COMP_TYPE : ${COMP_TYPE}"
    echo "args : $@"
    echo "reply : ${COMPREPLY}"
  else
    # COMP_CWORD is the current work completion index
    case ${COMP_CWORD} in
      1)
        accounts=$(./login2aws --complete)
        if [[ $? -eq 0 ]]; then
          COMPREPLY=($(compgen -W "$accounts"))
          if [[ $? -ne 0 ]]; then
              exit 1
          fi
        else
            exit 1
        fi

        #COMPREPLY=($(compgen -W "$(./login2aws --complete)"))
      ;;    
      *)
        COMPREPLY=()
      ;;
    esac

  fi
}

complete -F _test_script_completion login2aws
