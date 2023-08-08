#!/bin/busybox sh

mkdir mountpoint
mount -L ${THELABEL} mountpoint
chroot mountpoint