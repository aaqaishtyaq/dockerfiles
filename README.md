# Dockerfiles

Various dockerfiles I use.

## How To

### Build the image locally

```console
./scripts/build.rb -i <IMAGE_NAME> -t <TAG> --push
```

Flags:

* `-i || --image`  `che-ubuntu`   Set the image name
* `-t || --tag`    `1.0.0`        Set the image tag. Default is `latest`
* `-p || --push`   `true/false`   Push the image to GH Container Registry. Default is `false`

### Build the image using github action

```console
./scripts/release <IMAGE_NAME>
```
