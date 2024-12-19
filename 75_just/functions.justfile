set dotenv-load := true

# default lists actions
default:
  @just -f example.justfile --list

functions:
  #!/usr/bin/env bash
  set -eufo pipefail
  echo "os_family(): {{ os_family() }}"
  echo "arch(): {{ arch() }}"
  echo "num_cpus(): {{ num_cpus() }}"
  echo "os(): {{ os() }}"
  echo "home_directory(): {{ home_directory() }}"
  echo "invocation_directory(): {{ invocation_directory() }}"
  echo ""
  echo "source_file(): {{ source_file() }}"
  echo "source_directory(): {{ source_directory() }}"
  echo "just_executable(): {{ just_executable() }}"
  cat /etc/os-release


