set dotenv-load := true

# default lists actions
default:
  @just -f {{ source_file() }} --list

counter:
  #!/usr/bin/env bash
  # globbing is +f
  set -euo pipefail
  counter=1
  for file in *; do
    echo "$file -> ${counter}"
    counter=$((counter + 1))  
  done

directory-listing:
  #!/usr/bin/env bash
  mkdir -p ./out || true
  set -euo pipefail
  for file in ./*; do
    echo "file '${file}'"
  done > ./out/out.txt