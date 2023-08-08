#!/bin/sh
if [ "$1" = "nocd" ]; then
qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -m 4G -enable-kvm -hda thehdd.qcow -boot d
else
qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -m 4G -enable-kvm -hda thehdd.qcow -cdrom myixos-*.iso -boot d
fi
