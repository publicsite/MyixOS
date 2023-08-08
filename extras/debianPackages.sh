#!/bin/sh
###written for buster###
#for building wine
sudo apt-get install flex xserver-xorg-dev libfreetype6 libfreetype6-dev

#for CLI
sudo apt-get install build-essential autoconf texinfo gcc-multilib linux-libc-dev libc6-dev-i386-cross libssl-dev libssl1.1 gawk bison bc flex

#for XORG
#sudo apt-get install python-xcbgen xcb-proto pkg-config libpixman-1-0 libpixman-1-dev libfreetype6 libfreetype6-dev libfontenc1 libfontenc-dev libxkbfile1 libxkbfile-dev libxfont2 libxfont-dev libpciaccess0 libpciaccess-dev xutils-dev libxrender1 libxrender-dev libxrandr-dev libdrm-dev libegl-mesa-dev libgbm1 libgbm-dev libepoxy0 libepoxy-dev libtool libegl1-mesa-dev libexpat1 libexpat1-dev libgl1-mesa-dev
#sudo apt-get install python-xcbgen xcb-proto pkg-config libpixman-1-0 libpixman-1-dev libfreetype6 libfreetype6-dev libfontenc1 libfontenc-dev libxkbfile1 libxkbfile-dev libxfont2 libxfont-dev libpciaccess0 libpciaccess-dev xutils-dev libxrender1 libxrender-dev libxrandr-dev libdrm-dev libegl-mesa-dev libgbm1 libgbm-dev libepoxy0 pkgconfig libepoxy-dev libtool libegl1-mesa-dev libexpat1 libexpat1-dev libgl1-mesa-dev

#for wayland
sudo apt-get install libffi6 libffi-dev libxml2 libxml2-dev

sudo ln /usr/bin/autoconf /usr/bin/autoconf-1.15
sudo ln /usr/bin/aclocal /usr/bin/aclocal-1.15
sudo ln /usr/bin/automake /usr/bin/automake-1.15
