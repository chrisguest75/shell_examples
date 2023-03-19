set dotenv-load := true

# default lists actions
default:
  @just -f example.justfile --list

# another comment
echo:
  echo 'This echoes'

# this is a comment
silentecho:
  @echo 'Silect echoes'

# show dotenv-load
echovars:
  @echo "EXAMPLE_VAR1=${EXAMPLE_VAR1}"
  @echo "EXAMPLE_VAR2=${EXAMPLE_VAR2}"

