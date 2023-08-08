#!/bin/sh
export XDG_RUNTIME_DIR=/tmp/wayland
mount -t sysfs sysfs /sys
mkdir -p /dev/pts
mount -t devpts devpts /dev/pts
weston --backend=fbdev-backend.so --tty=1 --device=/dev/fb0 --log=$HOME/weston-log.txt