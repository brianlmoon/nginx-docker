#!/bin/bash

set -e

function build() {
    IMAGE=$1

    echo "Building $IMAGE"

    VERSION=`docker run --rm --entrypoint='' nginx:$IMAGE nginx -v 2>&1 | awk -F / '{print $2}'`

    TAGS=""

    TAGS="$TAGS -t brianlmoon/nginx:"`echo $VERSION | awk -F . {'print $1"."$2"."$3'}`
    TAGS="$TAGS -t brianlmoon/nginx:"`echo $VERSION | awk -F . {'print $1"."$2'}`
    TAGS="$TAGS -t brianlmoon/nginx:"`echo $VERSION | awk -F . {'print $1'}`

    if [ "$2" == "latest" ]
    then
        TAGS="$TAGS -t brianlmoon/nginx:latest"
    fi

    docker buildx build \
        --platform linux/arm/v6,linux/amd64 \
        -t brianlmoon/nginx:$IMAGE \
        $TAGS \
        --build-arg BASEIMAGE=$IMAGE \
        --push \
        .
}

build 1.27-alpine latest
