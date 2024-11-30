# DIFFOSCOPE

In-depth comparison of files, archives, and directories.

TODO:

* Use for other filetypes; tar, png, etc

## Simple

Simple file compare.  

```sh
diffoscope ./docker/Dockerfile.cleaned ./docker/Dockerfile.unclean
```

## DiffOCI

```sh
just build

just dive cleaned
just dive unclean

just details cleaned
just details unclean

just diffoci

# output markdown report
just diffoscope
```

## Resources

* In-depth comparison of files, archives, and directories. [here](https://diffoscope.org/)
* diffoscope will try to get to the bottom of what makes files or directories different. [here](https://salsa.debian.org/reproducible-builds/diffoscope)
* Reproducible builds are a set of software development practices that create an independently-verifiable path from source to binary code. [here](https://reproducible-builds.org/)
