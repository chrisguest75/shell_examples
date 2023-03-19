default:
  @just -f docker.justfile --list

list-images:
  docker images

build:
  @echo 'Build container'
  docker buildx build --progress=plain -f Dockerfile.processor -t processor .

run:
  @echo 'Run container'
  docker run --rm -it processor
