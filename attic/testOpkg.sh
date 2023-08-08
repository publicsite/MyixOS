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

${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"myixos-rootfs-skel*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"linux-headers*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"binutils*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"glibc*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"gcc*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"zlib*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"libcap*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"flex*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"libsepol*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"pcre*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"openssl*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"util-linux*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"libffi*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"python*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"libselinux*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"linux-image*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"busybox*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"autoconf*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"perl*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"automake*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"gettext*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"make*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"elfutils*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"texinfo*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"bc*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"kmod*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"gawk*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"bison*.ipk
${TEMP_SYSROOT}${PREFIX}/${HOST}/bin/opkg-cl --conf "$PWD/opkg.conf" -o "${SYSROOT}" install "${PKGDIR}/"m4*.ipk