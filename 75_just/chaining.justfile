set dotenv-load := true


# default lists actions
default:
  @just -f {{ source_file() }} --list

pre-start:
  @echo "**************************"
  @echo "Pre-start environment variables:"
  @echo "**************************"
  @echo "TEST1=${TEST1-}"
  @echo "TEST2=${TEST2-}"

post-start:
  @echo "**************************"
  @echo "Post-start environment variables:"
  @echo "**************************"
  @echo "TEST1=${TEST1-}"
  @echo "TEST2=${TEST2-}"

child-start:
  @echo "**************************"
  @echo "Child-start environment variables:"
  @echo "**************************"
  @echo "TEST1=${TEST1-}"
  @echo "TEST2=${TEST2-}"

# Environment variables do not get inherited when using pre and post hooks
start:  (pre-start) && (post-start)
  #!/usr/bin/env bash
  set -eufo pipefail

  export TEST1="test1"
  export TEST2="test2"

  # this will work
  just -f {{ source_file() }} child-start
