# CLEANUP

`.terraform` and `node_modules` folders.

## Find

Find folders and remove them.

```sh
FOLDER_NAME=".terraform"
FOLDER_NAME="node_modules"

find ./ -iname "${FOLDER_NAME}" -type d -exec echo {} \;

# show size first
find ./ -iname "${FOLDER_NAME}" | xargs gdu -sh
```

## Remove

Remove folders that use a huge amount of space for providers.

```sh
find ./ -iname "${FOLDER_NAME}" -type d -exec rm -r {} \;
```

## Resources
