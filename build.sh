#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

USERID=$(id -u)
GROUPID=$(id -g)
[ "$USERID" -eq "0" ] && USERID=1000
[ "$GROUPID" -eq "0" ] && GROUPID=1000

IMGNAME=p4edge-apu-$(date +'%Y-%m-%d')-$(git rev-parse --short HEAD).iso

[ "${CI:-false}" = "true" ] && echo ::set-output name=imgname::${IMGNAME}

docker build --build-arg UID=${USERID} --build-arg GID=${GROUPID} --tag=p4edge-apu .
docker run --name p4edge-apu-builder -v $(pwd)/profiles:/home/builder/build_image/profiles:ro p4edge-apu
mkdir -p ./dist
docker cp p4edge-apu-builder:/home/builder/build_image/images/debian-11-amd64-CD-1.iso ./dist/${IMGNAME}
docker rm -v p4edge-apu-builder
