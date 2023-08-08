#!/bin/sh

myBuildHome="$1"
SYSROOT="${PWD}/sysroot"
MYIXOS_LINK="ln -s"
PKGDIR="${myBuildHome}/packages"
TEMP_SYSROOT="${myBuildHome}"/tempsysroot
PREFIX='/usr'
HOST="i686-linux-gnu"

export LD_LIBRARY_PATH="$PWD/tempsysroot/build_tools/usr/lib:${LD_LIBRARY_PATH}"

mkdir -p "${SYSROOT}"
mkdir -p "$SYSROOT${PREFIX}/${HOST}/lib"
$MYIXOS_LINK "${HOST}/lib" "${SYSROOT}${PREFIX}/"
mkdir ${SYSROOT}${PREFIX}/${HOST}/lib/opkg

gdb ${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl # --conf "$PWD/opkg.conf" -o "${SYSROOT}" install gcc-6-base_*.deb