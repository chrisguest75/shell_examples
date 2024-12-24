set dotenv-load := true

# default lists actions
default:
  @just -f {{ source_file() }} --list

export FOO := '''
a complicated string with
some dis\tur\bi\ng escape sequences
and "quotes" of 'different' kinds
'''

multiline1: 
  #!/usr/bin/env bash
  set -eufo pipefail
  just --version
  printf %s "$FOO"

multiline2:
  #!/usr/bin/env bash
  set -eufo pipefail
  echo '{{ \
  "This interpolation " + \
    "has a lot of text." \
  }}'
  echo 'back to recipe body'
