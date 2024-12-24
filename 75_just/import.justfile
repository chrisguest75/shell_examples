set allow-duplicate-recipes

set dotenv-load := true

import 'docker.justfile'
import 'functions.justfile'
import? 'doesnotexist.justfile'

# default lists actions
default:
  @just -f {{ source_file() }} --list


