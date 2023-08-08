#!/bin/sh

if ! [ -d "/overlay/tmpfs" ]; then
mkdir -p /overlay/tmpfs
fi

if ! [ -d "/overlay/mountpoint" ]; then
mkdir -p /overlay/mountpoint
fi

mount -t tmpfs tmpfs /overlay/tmpfs

if ! [ -d "/overlay/tmpfs/upperdir" ]; then
mkdir /overlay/tmpfs/upperdir
fi

if ! [ -d "/overlay/tmpfs/workdir" ]; then
mkdir /overlay/tmpfs/workdir
fi

mount -t overlay overlay -o lowerdir=/,upperdir=/overlay/tmpfs/upperdir,workdir=/overlay/tmpfs/workdir /overlay/mountpoint

mount --bind dev /overlay/mountpoint/dev
mount --bind proc /overlay/mountpoint/proc
mount --bind sys /overlay/mountpoint/sys

#pivot_root /overlay/mountpoint /
#exec chroot /overlay/mountpoint /sbin/init

exec chroot /overlay/mountpoint /sbin/init </dev/console >dev/console 2>&1