# README

Demonstrate how to detect the OS type in script to change parameters to commands.  

## Example

```sh
# use decision logic based on OS version
./detect-os.sh  
```

## Docker

```sh
docker buildx build --progress=plain -f Dockerfile.os -t detect-os .
docker run --rm detect-os
```

## Resources

