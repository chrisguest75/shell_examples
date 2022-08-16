  * Detecting dotsourcing.
        https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced
        ```sh
        (return 0 2>/dev/null) && SOURCED=1 || SOURCED=0
          if [[ $SOURCED == 1 ]]; then
            #echo "Script is being sourced"
            return 1
            #else
            #echo "Script is a subshell"
          fi
        ```
  * tricks and shortcuts [[ $_ != $0 ]] && echo "Script is being sourced" || echo "Script is a subshell"


https://stackoverflow.com/questions/2683279/how-to-detect-if-a-script-is-being-sourced