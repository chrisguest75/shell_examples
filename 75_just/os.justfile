set dotenv-load := true

# default lists actions
default:
  @just -f {{ source_file() }} --list

#test:
#  echo "You're calling default commnd"

[linux]
test:
  echo "You're calling Linux commnd"

[macos]
test:
  echo "You're calling MacOS commnd"
