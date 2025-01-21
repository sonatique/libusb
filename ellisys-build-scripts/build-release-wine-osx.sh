#!/bin/bash
set -e
set -x

scriptdir="$(dirname "$0")"
scriptdir="$(realpath "$scriptdir")"
mountroot="$(realpath "$scriptdir/..")"

uid=$(id -u)
gid=$(id -g)

# Note: OSX-image password for user Ellisys is ellisys if needed for interactive usage
# Note: For going interactive with no modification saved: just add -it and remove -e "OSX_COMMANDS=..." from the docker run command line below
# Note: For modifying an image use: 
# docker run   --rm -it  -v /mnt/c/users/me/source/repos/libusb:/libusb-src   -e UID=$(id -u) -e GID=$(id -g)   --device /dev/kvm   -p 50922:10022   -v /tmp/.X11-unix:/tmp/.X11-unix   -e "DISPLAY=${DISPLAY:-:0.0}" \
# -e CPU='Haswell-noTSX'   -e CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on'   -e EXTRA="-virtfs local,path=/libusb-src,mount_tag=hostshare,security_model=passthrough,id=hostshare" \
# -v "/home/me/mac_hdd_ng.img:/image" containers.ellisys.com/tools/docker-osx:sonoma-naked-auto-v1

MSYS_NO_PATHCONV=1 docker run \
  --rm \
  -v $mountroot:/libusb-src \
  -e UID=$uid -e GID=$gid \
  --device /dev/kvm \
  -p 50922:10022 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e "DISPLAY=${DISPLAY:-:0.0}" \
  -e CPU='Haswell-noTSX' \
  -e CPUID_FLAGS='kvm=on,vendor=GenuineIntel,+invtsc,vmware-cpuid-freq=on' \
  -e EXTRA="-virtfs local,path=/libusb-src,mount_tag=hostshare,security_model=passthrough,id=hostshare" \
  -e USERNAME=ellisys -e PASSWORD=ellisys \
  -e "OSX_COMMANDS=/bin/zsh --login -c \"echo ellisys | sudo -S /opt/set-uid-gid.sh user $uid $gid;echo ellisys | sudo -S mount_9p hostshare;echo alpine | sudo -S -u user bash -c 'cd /Volumes/hostshare;make -f Makefile.wine.osx clean;rm config.h;./autogen.sh;make V=1 -f Makefile.wine.osx'\"" \
  containers.ellisys.com/tools/libusb-wine-osx:1.0.0
