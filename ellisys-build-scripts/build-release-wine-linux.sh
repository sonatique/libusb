#!/bin/bash
set -e

scriptdir="$(dirname "$0")"
scriptdir="$(realpath "$scriptdir")"
mountroot="$(realpath "$scriptdir/..")"

MSYS_NO_PATHCONV=1 docker run \
  --rm \
  -v $mountroot:/libusb-src \
  -w="/libusb-src" \
  -e UID=$(id -u) -e GID=$(id -g) \
  containers.ellisys.com/tools/libusb-wine-linux:1.0.0 \
  bash -c "\
	make clean -f Makefile.wine.linux;rm config.h;./autogen.sh;make -f Makefile.wine.linux\
	"