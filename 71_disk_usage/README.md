# DISK USAGE

Demonstrate some examples of calculating disk usage.

## gdu

Uses SSD parallel reads to rapidly summarise folder sizes.

```sh
nix-shell -p gdu --command zsh

gdu

# disk usage (depth 1)q
gdu -h -d1 ./
```

## Space

```sh
# find files or folders and show disk space used for them.
find /output -iname "share" -or -iname "include" | xargs du -sh

# summarise each folder (depth 1)
echo ../* | du -h -d1
```

## inodes

You can change the number of inodes when creating the filesystem.

```sh
df -i
```

## Resources

- Pretty fast disk usage analyzer written in Go. [here](https://github.com/dundee/gdu)
