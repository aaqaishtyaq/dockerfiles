#! /bin/bash
set -e
cd "${0%/*}"

IMAGE=$1
DIR=$(echo "$IMAGE" | sed "s/-/\//g")

if [ -z "$IMAGE" ]; then
		echo -e "\n\033[41mUSAGE: $0 {IMAGE}\033[0m\n"
    exit 1
fi

if [ -z $(find "../${DIR}" -type f -name Dockerfile) ]; then
  echo -e "\n\033[41mINVALID IMAGE: $IMAGE\033[0m\n"
  exit 1
fi

echo -e "\033[33m\nInitiating release for $IMAGE:\033[0m\n"

HASH=$(git rev-parse --short HEAD)
TAG=release#$HASH-$IMAGE
git tag -a $TAG -m "Release for $IMAGE"
git push origin $TAG

echo -e "\n\033[32mReleased $IMAGE successfully with Tag: $TAG\033[0m\n\n"
