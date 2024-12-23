set dotenv-load := true

# default lists actions
default:
  @just -f {{ source_file() }} --list

_start_task name="":
  echo "Start {{ name}}"

_end_task name="":
  echo "End {{ name }}"

mytask: (_start_task 'mytask') && (_end_task 'mytask')
  #!/usr/bin/env bash
  set -eufo pipefail
  just --version
  sleep 5
