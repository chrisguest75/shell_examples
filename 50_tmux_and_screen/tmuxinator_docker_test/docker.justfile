# lists recipes
default:
  @just -f docker.justfile --list

# list docker images
list-images:
  docker images

# build dockerfile.processor
build:
  @echo 'Build container'
  docker buildx build --progress=plain -f Dockerfile.processor -t processor .

# run processor
run:
  @echo 'Run container'
  docker run --rm -it processor

# logs
logs:
  @echo 'Container logs'
  lnav docker://detect-os


