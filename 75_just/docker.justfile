# lists recipes
default:
  @just -f {{ source_file() }} --list

# list docker images
list-images:
  docker images

# build dockerfile.processor
build imagename="processor":
  @echo 'Build container {{ imagename }}'
  docker buildx build --progress=plain -f Dockerfile.processor -t {{ imagename }} .

# run processor
run imagename="processor": (build imagename)
  @echo 'Run container'
  docker run --rm -it {{ imagename }}
