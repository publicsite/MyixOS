#!/bin/sh

export PATH="${OLD_PATH}"
#add symlink to python3 for selinux
cd "${TEMP_SYSROOT}/build_tools/bin"
for tolink in wc flex aclocal-1.16 automake-1.16 aclocal-1.15 automake-1.15 aclocal-1.14 \
automake-1.14 makeinfo bc sha1sum seq join autom4te xsubpp autoreconf pod2html makeinfo \
ls awk echo od dd id ; do
#ls awk echo od and dd are for busybox-w32
#id is for tar
	#make symlink
	if [ "$(which "$tolink")" != "" ] && [ "$(which "$tolink")" != "$tolink" ]; then
		if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			ln -s "$(which "$tolink")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "$tolink")" "${tolink}"
		fi
	elif [ "$(which "${tolink}.exe")" != "" ] && [ "$(which "${tolink}.exe")" != "${tolink}.exe" ]; then
		if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			ln -s "$(which "${tolink}.exe")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "${tolink}.exe")" "${tolink}"
		fi
	fi
done

cd "${myBuildHome}"

if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}/build_tools/usr/bin"
else
	export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${OLD_PATH}"
fi

if [ "${with_selinux}" != "true" ]; then
	#python is needed for building glibc (regardless of selinux)
	#"${myBuildHome}"/myBuilds/python/python.myBuild get 2>&1 | tee "${myBuildHome}"/logs/python.get.log
	"${myBuildHome}"/myBuilds/python/python.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/python.extract.log
	"${myBuildHome}"/myBuilds/python/python.myBuild build 2>&1 | tee "${myBuildHome}"/logs/python.build.log
	"${myBuildHome}"/myBuilds/python/python.myBuild install 2>&1 | tee "${myBuildHome}"/logs/python.install.log
	#"${myBuildHome}"/myBuilds/python/python.myBuild package 2>&1 | tee "${myBuildHome}"/logs/python.package.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
	#"${myBuildHome}"/myBuilds/gnulib-w32/gnulib-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gnulib-w32.get.log
	"${myBuildHome}"/myBuilds/gnulib-w32/gnulib-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gnulib-w32.extract.log
	"${myBuildHome}"/myBuilds/gnulib-w32/gnulib-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gnulib-w32.build.log
	"${myBuildHome}"/myBuilds/gnulib-w32/gnulib-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gnulib-w32.install.log
	#"${myBuildHome}"/myBuilds/gnulib-w32/gnulib-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/gnulib-w32.package.log
fi

if [ "${with_selinux}" != "true" ]; then
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
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR glibc
	if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
		"${myBuildHome}"/myBuilds/linux/linux.myBuild extract kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.build.log
	fi

	"${myBuildHome}"/myBuilds/linux/linux.myBuild build kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.build.log
	"${myBuildHome}"/myBuilds/linux/linux.myBuild install kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.install.log
	#"${myBuildHome}"/myBuilds/linux/linux.myBuild package kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.package.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR linux
	#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild get 2>&1 | tee "${myBuildHome}"/logs/busybox.get.log
	"${myBuildHome}"/myBuilds/busybox/busybox.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/busybox.extract.log
	"${myBuildHome}"/myBuilds/busybox/busybox.myBuild build 2>&1 | tee "${myBuildHome}"/logs/busybox.build.log
	"${myBuildHome}"/myBuilds/busybox/busybox.myBuild install 2>&1 | tee "${myBuildHome}"/logs/busybox.install.log
	#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild package 2>&1 | tee "${myBuildHome}"/logs/busybox.package.log

	#we use sysvinit for init script support
	#"${myBuildHome}"/myBuilds/sysvinit/sysvinit.myBuild get 2>&1 | tee "${myBuildHome}"/logs/sysvinit.get.log
	"${myBuildHome}"/myBuilds/sysvinit/sysvinit.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/sysvinit.extract.log
	"${myBuildHome}"/myBuilds/sysvinit/sysvinit.myBuild build 2>&1 | tee "${myBuildHome}"/logs/sysvinit.build.log
	"${myBuildHome}"/myBuilds/sysvinit/sysvinit.myBuild install 2>&1 | tee "${myBuildHome}"/logs/sysvinit.install.log
	#"${myBuildHome}"/myBuilds/sysvinit/sysvinit.myBuild package 2>&1 | tee "${myBuildHome}"/logs/sysvinit.package.log
else
	#FOR linux
	#"${myBuildHome}"/myBuilds/busybox-w32/busybox-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/busybox-w32.get.log
	"${myBuildHome}"/myBuilds/busybox-w32/busybox-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/busybox-w32.extract.log
	"${myBuildHome}"/myBuilds/busybox-w32/busybox-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/busybox-w32.build.log
	"${myBuildHome}"/myBuilds/busybox-w32/busybox-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/busybox-w32.install.log
	#"${myBuildHome}"/myBuilds/busybox-w32/busybox-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/busybox-w32.install.log

	#needed because busybox-w32's tar isn't error free
	#"${myBuildHome}"/myBuilds/libarchive-w32/libarchive-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libarchive-w32.get.log
	"${myBuildHome}"/myBuilds/libarchive-w32/libarchive-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libarchive-w32.extract.log
	"${myBuildHome}"/myBuilds/libarchive-w32/libarchive-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libarchive-w32.build.log
	"${myBuildHome}"/myBuilds/libarchive-w32/libarchive-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libarchive-w32.install.log
	#"${myBuildHome}"/myBuilds/libarchive-w32/libarchive-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libarchive-w32.package.log
fi

#we should now have a working chroot

	#FOR make, due to make throwing error "undefined reference to `__alloca'" when compiling glibc
	#note, is also used to build software from [source] .ac files, which relevant to much of the software for myBuilds (inc. make)
	#"${myBuildHome}"/myBuilds/autoconf/autoconf.myBuild get 2>&1 | tee "${myBuildHome}"/logs/autoconf.get.log
	"${myBuildHome}"/myBuilds/autoconf/autoconf.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/autoconf.extract.log
	"${myBuildHome}"/myBuilds/autoconf/autoconf.myBuild build 2>&1 | tee "${myBuildHome}"/logs/autoconf.build.log
	"${myBuildHome}"/myBuilds/autoconf/autoconf.myBuild install 2>&1 | tee "${myBuildHome}"/logs/autoconf.install.log
	#"${myBuildHome}"/myBuilds/autoconf/autoconf.myBuild package 2>&1 | tee "${myBuildHome}"/logs/autoconf.package.log

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR automake
	#"${myBuildHome}"/myBuilds/perl/perl.myBuild get 2>&1 | tee "${myBuildHome}"/logs/perl.get.log
	"${myBuildHome}"/myBuilds/perl/perl.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/perl.extract.log
	"${myBuildHome}"/myBuilds/perl/perl.myBuild build 2>&1 | tee "${myBuildHome}"/logs/perl.build.log
	"${myBuildHome}"/myBuilds/perl/perl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/perl.install.log
	#"${myBuildHome}"/myBuilds/perl/perl.myBuild package 2>&1 | tee "${myBuildHome}"/logs/perl.package.log
#else
fi

	#FOR make
	#"${myBuildHome}"/myBuilds/automake/automake.myBuild get 2>&1 | tee "${myBuildHome}"/logs/automake.get.log
	"${myBuildHome}"/myBuilds/automake/automake.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/automake.extract.log
	"${myBuildHome}"/myBuilds/automake/automake.myBuild build 2>&1 | tee "${myBuildHome}"/logs/automake.build.log
	"${myBuildHome}"/myBuilds/automake/automake.myBuild install 2>&1 | tee "${myBuildHome}"/logs/automake.install.log
	#"${myBuildHome}"/myBuilds/automake/automake.myBuild package 2>&1 | tee "${myBuildHome}"/logs/automake.package.log

	#FOR linux
	#"${myBuildHome}"/myBuilds/make/make.myBuild get 2>&1 | tee "${myBuildHome}"/logs/make.get.log
	"${myBuildHome}"/myBuilds/make/make.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/make.extract.log
	"${myBuildHome}"/myBuilds/make/make.myBuild build 2>&1 | tee "${myBuildHome}"/logs/make.build.log
	"${myBuildHome}"/myBuilds/make/make.myBuild install 2>&1 | tee "${myBuildHome}"/logs/make.install.log
	#"${myBuildHome}"/myBuilds/make/make.myBuild package 2>&1 | tee "${myBuildHome}"/logs/make.package.log

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR make whilst using autoreconf (note: also for building glib)
	#"${myBuildHome}"/myBuilds/gettext/gettext.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gettext.get.log
	"${myBuildHome}"/myBuilds/gettext/gettext.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gettext.extract.log
	"${myBuildHome}"/myBuilds/gettext/gettext.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gettext.build.log
	"${myBuildHome}"/myBuilds/gettext/gettext.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gettext.install.log
	#"${myBuildHome}"/myBuilds/gettext/gettext.myBuild package 2>&1 | tee "${myBuildHome}"/logs/gettext.package.log
else
	#iconv is required for gettext win32
	#"${myBuildHome}"/myBuilds/libiconv/libiconv.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libiconv.get.log
	"${myBuildHome}"/myBuilds/libiconv/libiconv.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libiconv.extract.log
	"${myBuildHome}"/myBuilds/libiconv/libiconv.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libiconv.build.log
	"${myBuildHome}"/myBuilds/libiconv/libiconv.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libiconv.install.log
	#"${myBuildHome}"/myBuilds/libiconv/libiconv.myBuild package 2>&1 | tee "${myBuildHome}"/logs/libiconv.package.log

	#FOR make whilst using autoreconf (note: also for building glib)
	#"${myBuildHome}"/myBuilds/gettext-w32/gettext-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gettext-w32.get.log
	"${myBuildHome}"/myBuilds/gettext-w32/gettext-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gettext-w32.extract.log
	"${myBuildHome}"/myBuilds/gettext-w32/gettext-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gettext-w32.build.log
	"${myBuildHome}"/myBuilds/gettext-w32/gettext-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gettext-w32.install.log
	#"${myBuildHome}"/myBuilds/gettext-w32/gettext-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/gettext-w32.install.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR bc 
	#"${myBuildHome}"/myBuilds/elfutils/elfutils.myBuild get 2>&1 | tee "${myBuildHome}"/logs/elfutils.get.log
	"${myBuildHome}"/myBuilds/elfutils/elfutils.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/elfutils.extract.log
	"${myBuildHome}"/myBuilds/elfutils/elfutils.myBuild build 2>&1 | tee "${myBuildHome}"/logs/elfutils.build.log
	"${myBuildHome}"/myBuilds/elfutils/elfutils.myBuild install 2>&1 | tee "${myBuildHome}"/logs/elfutils.install.log
	#"${myBuildHome}"/myBuilds/elfutils/elfutils.myBuild package 2>&1 | tee "${myBuildHome}"/logs/elfutils.package.log
#note bc should come with busybox-w32 for the mingw platform
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#elfutils-w32 lacks libargparse or argparse in the C library
	##FOR bc
	#"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild get 2>&1 | tee "${myBuildHome}"/logs/texinfo.get.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/texinfo.extract.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild build 2>&1 | tee "${myBuildHome}"/logs/texinfo.build.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild install 2>&1 | tee "${myBuildHome}"/logs/texinfo.install.log
	#"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild package 2>&1 | tee "${myBuildHome}"/logs/texinfo.package.log
else

	#"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild get 2>&1 | tee "${myBuildHome}"/logs/ncurses.get.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/ncurses.extract.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild build 2>&1 | tee "${myBuildHome}"/logs/ncurses.build.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild install 2>&1 | tee "${myBuildHome}"/logs/ncurses.install.log
	#"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild package 2>&1 | tee "${myBuildHome}"/logs/ncurses.package.log

	#elfutils-w32 lacks libargparse or argparse in the C library
	##FOR bc
	#"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild get 2>&1 | tee "${myBuildHome}"/logs/texinfo.get.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/texinfo.extract.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild build 2>&1 | tee "${myBuildHome}"/logs/texinfo.build.log
	"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild install 2>&1 | tee "${myBuildHome}"/logs/texinfo.install.log
	#"${myBuildHome}"/myBuilds/texinfo/texinfo.myBuild package 2>&1 | tee "${myBuildHome}"/logs/texinfo.package.log
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##FOR linux
	#"${myBuildHome}"/myBuilds/bc/bc.myBuild get 2>&1 | tee "${myBuildHome}"/logs/bc.get.log
	"${myBuildHome}"/myBuilds/bc/bc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/bc.extract.log
	"${myBuildHome}"/myBuilds/bc/bc.myBuild build 2>&1 | tee "${myBuildHome}"/logs/bc.build.log
	"${myBuildHome}"/myBuilds/bc/bc.myBuild install 2>&1 | tee "${myBuildHome}"/logs/bc.install.log
	#"${myBuildHome}"/myBuilds/bc/bc.myBuild package 2>&1 | tee "${myBuildHome}"/logs/bc.package.log
else
	#"${myBuildHome}"/myBuilds/bc-w32/bc-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/bc-w32.get.log
	"${myBuildHome}"/myBuilds/bc-w32/bc-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/bc-w32.extract.log
	"${myBuildHome}"/myBuilds/bc-w32/bc-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/bc-w32.build.log
	"${myBuildHome}"/myBuilds/bc-w32/bc-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/bc-w32.install.log
	#"${myBuildHome}"/myBuilds/bc-w32/bc-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/bc-w32.install.log
fi

if [ "${with_selinux}" != "true" ]; then
	if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		##FOR linux
		#"${myBuildHome}"/myBuilds/openssl/openssl.myBuild get 2>&1 | tee "${myBuildHome}"/logs/openssl.get.log
		"${myBuildHome}"/myBuilds/openssl/openssl.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/openssl.extract.log
		"${myBuildHome}"/myBuilds/openssl/openssl.myBuild build 2>&1 | tee "${myBuildHome}"/logs/openssl.build.log
		"${myBuildHome}"/myBuilds/openssl/openssl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
		#"${myBuildHome}"/myBuilds/openssl/openssl.myBuild package 2>&1 | tee "${myBuildHome}"/logs/openssl.package.log
	else
		#"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/openssl.get.log
		"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/openssl.extract.log
		"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/openssl.build.log
		"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
		#"${myBuildHome}"/myBuilds/openssl-w32/openssl-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/openssl.install.log
	fi
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##FOR linux, we use this because busybox does not provide a "-b" option for the "depmod" command
	#"${myBuildHome}"/myBuilds/kmod/kmod.myBuild get 2>&1 | tee "${myBuildHome}"/logs/kmod.get.log
	"${myBuildHome}"/myBuilds/kmod/kmod.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/kmod.extract.log
	"${myBuildHome}"/myBuilds/kmod/kmod.myBuild build 2>&1 | tee "${myBuildHome}"/logs/kmod.build.log
	"${myBuildHome}"/myBuilds/kmod/kmod.myBuild install 2>&1 | tee "${myBuildHome}"/logs/kmod.install.log
	#"${myBuildHome}"/myBuilds/kmod/kmod.myBuild package 2>&1 | tee "${myBuildHome}"/logs/kmod.package.log

	#we don't have a replacement for mingw for this yet...
	#unless the -b option works for depmod in busybox-w32
	#which is doesn't
	#kmod requires fnmatch.h header, which is not present in gnulib or mingw64
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##FOR gcc
	#"${myBuildHome}"/myBuilds/gawk/gawk.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gawk.get.log
	"${myBuildHome}"/myBuilds/gawk/gawk.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gawk.extract.log
	"${myBuildHome}"/myBuilds/gawk/gawk.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gawk.build.log
	"${myBuildHome}"/myBuilds/gawk/gawk.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gawk.install.log
	#"${myBuildHome}"/myBuilds/gawk/gawk.myBuild package 2>&1 | tee "${myBuildHome}"/logs/gawk.package.log

	#we don't have a replacement for GNU AWK, hopefully the busybox version works, but I doubt it tbh
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##FOR gcc, also for wine
	#"${myBuildHome}"/myBuilds/bison/bison.myBuild get 2>&1 | tee "${myBuildHome}"/logs/bison.get.log
	"${myBuildHome}"/myBuilds/bison/bison.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/bison.extract.log
	"${myBuildHome}"/myBuilds/bison/bison.myBuild build 2>&1 | tee "${myBuildHome}"/logs/bison.build.log
	"${myBuildHome}"/myBuilds/bison/bison.myBuild install 2>&1 | tee "${myBuildHome}"/logs/bison.install.log
	#"${myBuildHome}"/myBuilds/bison/bison.myBuild package 2>&1 | tee "${myBuildHome}"/logs/bison.package.log

	#for console-setup
	#"${myBuildHome}"/myBuilds/kbd/kbd.myBuild get 2>&1 | tee "${myBuildHome}"/logs/kbd.get.log
	"${myBuildHome}"/myBuilds/kbd/kbd.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/kbd.build.log
	"${myBuildHome}"/myBuilds/kbd/kbd.myBuild build 2>&1 | tee "${myBuildHome}"/logs/kbd.build.log
	"${myBuildHome}"/myBuilds/kbd/kbd.myBuild install 2>&1 | tee "${myBuildHome}"/logs/kbd.install.log

	#"${myBuildHome}"/myBuilds/console-setup/console-setup.myBuild get 2>&1 | tee "${myBuildHome}"/logs/console-setup.get.log
	"${myBuildHome}"/myBuilds/console-setup/console-setup.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/console-setup.build.log
	"${myBuildHome}"/myBuilds/console-setup/console-setup.myBuild build 2>&1 | tee "${myBuildHome}"/logs/console-setup.build.log
	"${myBuildHome}"/myBuilds/console-setup/console-setup.myBuild install 2>&1 | tee "${myBuildHome}"/logs/console-setup.install.log

else
	##FOR gcc, also for wine
	#"${myBuildHome}"/myBuilds/bison-w32/bison-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/bison-w32.get.log
	"${myBuildHome}"/myBuilds/bison-w32/bison-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/bison-w32.extract.log
	"${myBuildHome}"/myBuilds/bison-w32/bison-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/bison-w32.build.log
	"${myBuildHome}"/myBuilds/bison-w32/bison-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/bison-w32.install.log
	#"${myBuildHome}"/myBuilds/bison-w32/bison-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/bison-w32.install.log
fi

	##FOR gcc
	#"${myBuildHome}"/myBuilds/m4/m4.myBuild get 2>&1 | tee "${myBuildHome}"/logs/m4.get.log
	"${myBuildHome}"/myBuilds/m4/m4.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/m4.extract.log
	"${myBuildHome}"/myBuilds/m4/m4.myBuild build 2>&1 | tee "${myBuildHome}"/logs/m4.build.log
	"${myBuildHome}"/myBuilds/m4/m4.myBuild install 2>&1 | tee "${myBuildHome}"/logs/m4.install.log
	#"${myBuildHome}"/myBuilds/m4/m4.myBuild package 2>&1 | tee "${myBuildHome}"/logs/m4.package.log

	##FOR linux
	#"${myBuildHome}"/myBuilds/rsync/rsync.myBuild get 2>&1 | tee "${myBuildHome}"/logs/rsync.get.log
	"${myBuildHome}"/myBuilds/rsync/rsync.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/rsync.extract.log
	"${myBuildHome}"/myBuilds/rsync/rsync.myBuild build 2>&1 | tee "${myBuildHome}"/logs/rsync.build.log
	"${myBuildHome}"/myBuilds/rsync/rsync.myBuild install 2>&1 | tee "${myBuildHome}"/logs/rsync.install.log
	#"${myBuildHome}"/myBuilds/rsync/rsync.myBuild package 2>&1 | tee "${myBuildHome}"/logs/rsync.package.log
