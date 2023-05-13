# LINKS

Demonstrate symbolic and hard links.  

TODO:

* Is a link hard or symlinks?
* Permissions on links.

## Notes

* Hard links point to an `inode`.  
* All normal files are hard links.  
* Symbolic links point to another file.  

## Create environments

```sh
# build
docker build --progress=plain -f Dockerfile -t links .

# run (pops straight into a shell)
docker run --rm -it links
```

## Tests

Work through a few links examples.  

### Symbolic Links

```sh
ln -s /bin/bash ./my-bash
ln -s /bin ./my-bins

# list inodes
ls -ila
./my-bash -c "echo 'hello'"
ls ./my-bins
```

### Hard Links

```sh
ln /bin/bash ./my-hard-bash
# NOTE: links to directories should not be allowed
ln /bin ./my-hard-bins

# list inodes
ls -ila
./my-hard-bash -c "echo 'hello'"
ls ./my-hard-bins
cd ./my-hard-bins
```

## Finding links

```sh
# find links
find . -type l -ls

# list all links
find / -type l 
```

## Cleanup

```sh
rm ./my-bash
rm ./my-bins

unlink ./my-hard-bash
unlink ./my-hard-bins
```

## Resources

