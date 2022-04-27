set -euo pipefail
IFS=$'\n\t'

docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --tag=p4edge-apu .
docker run --name p4edge-apu-builder -v $(pwd)/profiles:/home/builder/build_image/profiles:ro p4edge-apu
mkdir -p ./dist
docker cp p4edge-apu-builder:/home/builder/build_image/images/debian-11-amd64-CD-1.iso ./dist/p4edge-apu-0.1.0.iso
docker rm -v p4edge-apu-builder
