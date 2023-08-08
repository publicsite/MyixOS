#!/bin/sh
temppath="${PATH}"
export PATH="${OLD_PATH}"
cd "${TEMP_SYSROOT}/build_tools/bin"
$MYIXOS_LINK "$(which flex)" #for libsepol
$MYIXOS_LINK "$(which pod2man)" #not required, but for openssl
cd "${myBuildHome}"
export PATH="${temppath}"

#for weston
#"${myBuildHome}"/myBuilds/libcap/libcap.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libcap.get.log
"${myBuildHome}"/myBuilds/libcap/libcap.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libcap.extract.log
"${myBuildHome}"/myBuilds/libcap/libcap.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libcap.build.log
"${myBuildHome}"/myBuilds/libcap/libcap.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libcap.install.log
export SYSROOT="${TEMP_SYSROOT}"
"${myBuildHome}"/myBuilds/libcap/libcap.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libcap.install.log
export SYSROOT="${OLD_SYSROOT}"
#"${myBuildHome}"/myBuilds/libcap/libcap.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libcap.package.log

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#for building libsepol and building linux kernel
	#"${myBuildHome}"/myBuilds/flex/flex.myBuild get 2>&1 | tee "${myBuildHome}"/logs/flex.get.log
	"${myBuildHome}"/myBuilds/flex/flex.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/flex.extract.log
	"${myBuildHome}"/myBuilds/flex/flex.myBuild build 2>&1 | tee "${myBuildHome}"/logs/flex.build.log
	"${myBuildHome}"/myBuilds/flex/flex.myBuild install 2>&1 | tee "${myBuildHome}"/logs/flex.install.log
	#"${myBuildHome}"/myBuilds/flex/flex.myBuild package 2>&1 | tee "${myBuildHome}"/logs/flex.package.log
else
	#"${myBuildHome}"/myBuilds/flex-w32/flex-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/flex-w32.get.log
	"${myBuildHome}"/myBuilds/flex-w32/flex-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/flex-w32.extract.log
	"${myBuildHome}"/myBuilds/flex-w32/flex-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/flex-w32.build.log
	"${myBuildHome}"/myBuilds/flex-w32/flex-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/flex-w32.install.log
	#"${myBuildHome}"/myBuilds/flex-w32/flex-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/flex-w32.package.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#for libselinux
	#"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libsepol.get.log
	"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libsepol.extract.log
	"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libsepol.build.log
	"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libsepol.install.log
	export SYSROOT="${TEMP_SYSROOT}"
	"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libsepol.install.log
	export SYSROOT="${OLD_SYSROOT}"
	#"${myBuildHome}"/myBuilds/libsepol/libsepol.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libsepol.package.log
fi

#for libselinux gudev and wacom
#"${myBuildHome}"/myBuilds/pcre2/pcre2.myBuild get 2>&1 | tee "${myBuildHome}"/logs/pcre2.get.log
"${myBuildHome}"/myBuilds/pcre2/pcre2.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/pcre2.extract.log
"${myBuildHome}"/myBuilds/pcre2/pcre2.myBuild build 2>&1 | tee "${myBuildHome}"/logs/pcre2.build.log
"${myBuildHome}"/myBuilds/pcre2/pcre2.myBuild install 2>&1 | tee "${myBuildHome}"/logs/pcre2.install.log
export SYSROOT="${TEMP_SYSROOT}"
"${myBuildHome}"/myBuilds/pcre2/pcre2.myBuild install 2>&1 | tee "${myBuildHome}"/logs/pcre2.install.log
export SYSROOT="${OLD_SYSROOT}"
#"${myBuildHome}"/myBuilds/pcre/pcre.myBuild package 2>&1 | tee "${myBuildHome}"/logs/pcre2.package.log

#openssl is required for python
if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##FOR linux
	#"${myBuildHome}"/myBuilds/openssl/openssl.myBuild get 2>&1 | tee "${myBuildHome}"/logs/openssl.get.log
	"${myBuildHome}"/myBuilds/openssl/openssl.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/openssl.extract.log
	"${myBuildHome}"/myBuilds/openssl/openssl.myBuild build 2>&1 | tee "${myBuildHome}"/logs/openssl.build.log
	"${myBuildHome}"/myBuilds/openssl/openssl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
	export SYSROOT="${TEMP_SYSROOT}"
	"${myBuildHome}"/myBuilds/openssl/openssl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
	export SYSROOT="${OLD_SYSROOT}"
	#"${myBuildHome}"/myBuilds/openssl/openssl.myBuild package 2>&1 | tee "${myBuildHome}"/logs/openssl.package.log
else
	#"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/openssl.get.log
	"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/openssl.extract.log
	"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/openssl.build.log
	"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
	export SYSROOT="${TEMP_SYSROOT}"
	"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.package.log
	export SYSROOT="${OLD_SYSROOT}"
	#"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/openssl.package.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then

	#libuuid is needed for python
	#"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild get libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.get.log
	"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild extract libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.extract.log
	"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild build libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.build.log
	"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild install libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.install.log
	export SYSROOT="${TEMP_SYSROOT}"
	"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild install libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.install.log
	export SYSROOT="${OLD_SYSROOT}"
	#"${myBuildHome}"/myBuilds/util-linux/util-linux.myBuild package libuuid 2>&1 | tee "${myBuildHome}"/logs/util-linux.package.log
fi

#for building wayland and python
#"${myBuildHome}"/myBuilds/libffi/libffi.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libffi.get.log
"${myBuildHome}"/myBuilds/libffi/libffi.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libffi.extract.log
"${myBuildHome}"/myBuilds/libffi/libffi.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libffi.build.log
"${myBuildHome}"/myBuilds/libffi/libffi.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libffi.install.log
export SYSROOT="${TEMP_SYSROOT}"
"${myBuildHome}"/myBuilds/libffi/libffi.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libffi.install.log
export SYSROOT="${OLD_SYSROOT}"
#"${myBuildHome}"/myBuilds/libffi/libffi.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libffi.package.log

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#python is needed for python-mako, meson, and to build libselinux
	#"${myBuildHome}"/myBuilds/python/python.myBuild get 2>&1 | tee "${myBuildHome}"/logs/python.get.log
	"${myBuildHome}"/myBuilds/python/python.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/python.extract.log
	"${myBuildHome}"/myBuilds/python/python.myBuild build 2>&1 | tee "${myBuildHome}"/logs/python.build.log
	"${myBuildHome}"/myBuilds/python/python.myBuild install 2>&1 | tee "${myBuildHome}"/logs/python.install.log
	#"${myBuildHome}"/myBuilds/python/python.myBuild package 2>&1 | tee "${myBuildHome}"/logs/python.package.log

	#for gudev
	#"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libselinux.get.log
	"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libselinux.extract.log
	"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libselinux.build.log
	"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libselinux.install.log
	export SYSROOT="${TEMP_SYSROOT}"
	"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libselinux.install.log
	export SYSROOT="${OLD_SYSROOT}"
	#"${myBuildHome}"/myBuilds/libselinux/libselinux.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libselinux.package.log
fi