#!/bin/sh
dbus-uuidgen > /etc/machine-id
echo root:x:0:0:root:/root:/bin/sh > /etc/passwd
echo "root:x:0:" > /etc/group
chmod 755 /etc/group
chmod 755 /etc/passwd
mkdir -p /tmp/.X11-unix
mkdir -p /tmp/wayland
mkdir /sys
export XDG_RUNTIME_DIR=/tmp/wayland
mount -t sysfs sysfs /sys
mkdir -p /dev/pts
mount -t devpts devpts /dev/pts

##start of script to add udev keyboard and mouse###
for i in `ls -1 /dev/input/event*`
do
        udevadm test --action=add "$(udevadm info -q path $i)"
done

mkdir -p /root/.config

rm /root/.config/weston.ini
printf '[core]\n' >> /root/.config/weston.ini
printf 'xwayland=true\n\n' >> /root/.config/weston.ini
printf '[keyboard]\n' >> /root/.config/weston.ini
printf 'keymap_layout=gb\n\n' >> /root/.config/weston.ini
printf '[output]\n' >> /root/.config/weston.ini
printf 'name=LVDS1\n' >> /root/.config/weston.ini
printf 'mode=640x480\n' >> /root/.config/weston.ini
printf 'transform=90\n\n' >> /root/.config/weston.ini
printf '[launcher]\n' >> /root/.config/weston.ini
printf 'path=/usr/bin/weston-terminal --shell=/bin/sh\n' >> /root/.config/weston.ini
