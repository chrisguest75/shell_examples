set dotenv-load := true

# default lists actions
default:
  @just -f {{ source_file() }} --list

paths filepath:
  #!/usr/bin/env bash
  set -eufo pipefail
  echo "filepath: {{ filepath }}"
  echo ""
  echo "absolute_path() : {{ absolute_path(filepath) }}"
  echo "canonicalize() : {{ canonicalize(filepath) }}"
  echo "extension() : {{ extension(filepath) }}"
  echo "file_name() : {{ file_name(filepath) }}"
  echo "file_stem() : {{ file_stem(filepath) }}"
  echo "parent_directory() : {{ parent_directory(filepath) }}"
  echo "without_extension() : {{ without_extension(filepath) }}"



