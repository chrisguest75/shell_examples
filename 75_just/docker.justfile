set dotenv-load := true

export DEFAULT_APPLICATION:="processor"

# lists recipes
default:
  @just -f {{ source_file() }} --list

# list docker images
docker-images:
  #!/usr/bin/env bash
  set -xeufo pipefail  
  docker images

# build docker image 
docker-build application="$DEFAULT_APPLICATION": 
  #!/usr/bin/env bash
  set -xeufo pipefail  
  docker buildx build --progress=plain -f Dockerfile.{{ application }} -t {{ application }}:latest .

# get shell in docker container
docker-shell application="$DEFAULT_APPLICATION": (docker-build application)
  #!/usr/bin/env bash
  set -xeufo pipefail  
  mkdir -p ./in || true
  mkdir -p ./out || true
  docker run -it -v $(pwd)/in:/in -v $(pwd)/out:/out --entrypoint bash {{ application }}_gui:latest

# run docker image
docker-run application="$DEFAULT_APPLICATION": (docker-build application)
  #!/usr/bin/env bash
  set -xeufo pipefail  
  docker run --rm -it {{ application }}:latest

