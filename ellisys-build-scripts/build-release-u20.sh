#!/bin/bash
set -e

GID=$(id -g)
MSYS_NO_PATHCONV=1  docker run \
  --rm \
  -v "${PWD}/../:/libusb-src" \
  -w="/libusb-src" \
  libusb-wine-linux:0.9.0 \
  bash -c "\
	./autogen.sh;make clean;make -f Makefile.wine.linux \
	"

