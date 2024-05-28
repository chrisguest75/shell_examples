# APK

TODO:

- Create packages
- Host packages in a repository (s3)

## Build

Build and run the container

```sh
# Build 
docker build -t apkbuilder -f Dockerfile.build .

# run
docker run -it --entrypoint /bin/sh apkbuilder
```

## Resources

- Alpine linux create a apk-package [here](https://stackoverflow.com/questions/59684341/alpine-linux-create-a-apk-package)
- https://github.com/alpinelinux
- https://github.com/alpinelinux/apk-tools/blob/master/doc/apk.8.scd
- https://github.com/gr0und-s3ct0r/apkbuild
https://codeberg.org/chimo/apkbuilds
