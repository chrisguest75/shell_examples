set dotenv-load := true

# default lists actions
default:
  @just -f example.justfile --list

# echo with default parameters 
echo param1="defaultvalue1" param2="defaultvalue2":
  echo "This echoes $0, {{ param1 }}, {{ param2 }}"

# this is a comment
silentecho:
  @echo 'Silent echoes'

# show dotenv-load
echovars:
  @echo "EXAMPLE_VAR1=${EXAMPLE_VAR1}"
  @echo "EXAMPLE_VAR2=${EXAMPLE_VAR2}"

