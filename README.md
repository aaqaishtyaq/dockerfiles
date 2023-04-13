# Dockerfiles

Various Dockerfiles I use.

## How To

### Dependency

- [aaqaishtyaq/rouster](https://github.com/aaqaishtyaq/rouster)
- [docker buildx](https://docs.docker.com/build/install-buildx/)

### Build the image locally

```bash
GO111MODULE=on go install github.com/aaqaishtyaq/rouster@latest

IMAGE_NAME="base-debian"
IMAGE_TAG="latest"

rouster buildx -i ${IMAGE_NAME} -t ${IMAGE_TAG} dockerfiles

# build and push
rouster buildx -p -i ${IMAGE_NAME} -t ${IMAGE_TAG} dockerfiles
```

### Build the image using the Github action

```console
./scripts/release <IMAGE_NAME>
```

### In this repo

* [base-alpine](./dockerfiles/base/alpine/)
* [base-debian](./dockerfiles/base/debian/)
* [base-nixos](./dockerfiles/base/nixos/)
* [base-ubuntu](./dockerfiles/base/ubuntu/)
* [cgit](./dockerfiles/cgit/)
* [gitserver](./dockerfiles/gitserver)
* [shellcheck](./dockerfiles/shellcheck)
* [tailscale](./dockerfiles/tailscale)
* [workspace](./dockerfiles/workspace)
