#!/bin/bash

set -e

function build() {
    IMAGE=$1

    VERSION=`docker run --rm --entrypoint='' nginx:$IMAGE nginx -v 2>&1 | awk -F / '{print $2}'`

    echo "Building $VERSION"

    TAGS=""

    TAGS="$TAGS -t brianlmoon/nginx:"`echo $VERSION | awk -F . {'print $1"."$2"."$3'}`
    TAGS="$TAGS -t brianlmoon/nginx:"`echo $VERSION | awk -F . {'print $1"."$2'}`

    if [ "$2" == "latest" ]
    then
        TAGS="$TAGS -t brianlmoon/nginx:latest"
    fi

    CMD="docker buildx build \
        --platform linux/arm64,linux/amd64 \
        -t brianlmoon/nginx:$IMAGE \
        $TAGS \
        --build-arg BASEIMAGE=$IMAGE \
        --push \
        ."

    $CMD
}

build 1.26-alpine
build 1.27-alpine
build 1.28-alpine
build 1.29-alpine latest
