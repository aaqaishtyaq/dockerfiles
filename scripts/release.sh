#! /bin/bash

set -e
cd "${0%/*}"
. ./build.include

IMAGE=$1
DIR=$(echo "$IMAGE" | sed "s/-/\//g")

if [ -z "$IMAGE" ]; then
  error "USAGE: $0 {IMAGE}"
  exit 1
fi

if [ -z $(find "../dockerfiles/${DIR}" -type f -name Dockerfile) ]; then
  error "INVALID IMAGE: $IMAGE"
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  error "Ensure there are no changes on LOCAL to make a release. Aborting script."
  exit 1
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD)
REMOTE_HEAD=$(git rev-parse origin/$BRANCH)
LOCAL_HEAD=$(git rev-parse HEAD)

if [ "$REMOTE_HEAD" != "$LOCAL_HEAD" ]; then
  error "REMOTE and LOCAL need to be up-to-date to make a release. Aborting script."
  exit 1
fi

information "Initiating release for $IMAGE:"

HASH=$(git rev-parse --short HEAD)
TAG=release#$HASH-$IMAGE
git tag -a $TAG -m "Release for $IMAGE"
git push origin $TAG

success "Released $IMAGE successfully with Tag: $TAG"
