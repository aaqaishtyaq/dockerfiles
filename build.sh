#!/bin/bash
set -e
set -o pipefail
cd "${0%/*}"

ORGANISATION=ghcr.io
USER=aaqaishtyaq
REPO="${ORGANISATION}/${USER}"

build_and_push() {
    base=$1
    suite=$2
    build_dir=$3
    image="${REPO}/${base}:${suite}"

    echo "Building $image for context ${build_dir}"
    docker build --rm --force-rm -t \
        "${image}" "${build_dir}" || \
        return 1

}

main() {
    dir=$1
    image=${dir%Dockerfile}
    base=${image%%\/*}
    build_dir=$(dirname "${f}")
    suite=${build_dir##*\/}

    if [[ -z "$suite" ]] || [[ "$suite" == "$base" ]]; then
		suite=latest
	fi

    build_and_push "${base}" "${suite}" "${build_dir}"
    echo
    echo
}
