#!/bin/sh
#myBuild options

#environment variables
export myBuildHome="$1"
export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest"

mkdir "$myBuildSourceDest"
mkdir "$myBuildExtractDest"

export J="-j12"

#this would be for binutils search paths, but i am playing my luck to see if i can go without it
#ld --verbose | grep SEARCH_DIR | tr -s ' ;' \\012
export BITS='32'

#architecture='x86' #the architecture of the target (used for building a kernel)
#export architecture

export TARGET="i686-linux-gnu" #the toolchain we're creating
export ARCH='x86' #the architecture of the toolchain we're compiling from
export BUILD="i686-linux-gnu" #the toolchain we're compiling from, can be found by reading the "Target: *" field from "gcc -v", or "gcc -v 2>&1 | grep Target: | sed 's/.*: //" for systems with grep and sed

export SYSROOT="${myBuildHome}/installDir" #the root dir

mkdir "$SYSROOT"

export PREFIX='/usr' #the location to install to


#cd "${myBuildExtractDest}/linux-debian/${filename}/arch"

#while true; do
#	printf "\n\n==TYPE YOUR ARCHITECTURE==\n\n"
#	ls -d */ | cut -f1 -d'/'
#	read architecture
#	test=$(checkForDirectoryResult $architecture)

#	if [ "$test" = "yes" ]; then
#		break
#	fi
#done




###	get, extract, build and install the programs	###

#FOR glibc
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild get #2>&1 | tee logs/linux-deblob.get.log
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild extract 2>&1 | tee logs/linux-deblob.extract.log
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild build 2>&1 | tee logs/linux-deblob.build.log
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild install 2>&1 | tee logs/linux-deblob.install.log

#NOT needed
#"${myBuildHome}"/myBuilds/ncurses.myBuild get #2>&1 | tee logs/ncurses.get.log
#"${myBuildHome}"/myBuilds/ncurses.myBuild extract #2>&1 | tee logs/ncurses.extract.log
#"${myBuildHome}"/myBuilds/ncurses.myBuild build #2>&1 | tee logs/ncurses.build.log
#"${myBuildHome}"/myBuilds/ncurses.myBuild install #2>&1 | tee logs/ncurses.install.log

##needed IF NOT using busybox (untested)
##"${myBuildHome}"/myBuilds/bash.myBuild get #2>&1 | tee logs/bash.get.log
##"${myBuildHome}"/myBuilds/bash.myBuild extract #2>&1 | tee logs/bash.extract.log
##"${myBuildHome}"/myBuilds/bash.myBuild build #2>&1 | tee logs/bash.build.log
##"${myBuildHome}"/myBuilds/bash.myBuild install #2>&1 | tee logs/bash.install.log

#FOR gcc
#"${myBuildHome}"/myBuilds/glibc.myBuild get #2>&1 | tee logs/glibc.get.log
#"${myBuildHome}"/myBuilds/glibc.myBuild extract 2>&1 | tee logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/glibc.myBuild build 2>&1 | tee logs/glibc.build.log
#"${myBuildHome}"/myBuilds/glibc.myBuild install 2>&1 | tee logs/glibc.install.log

#FOR gcc
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild get #2>&1 | tee logs/binutils.get.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild extract 2>&1 | tee logs/binutils.extract.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild build 2>&1 | tee logs/binutils.build.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install 2>&1 | tee logs/binutils.install.log

#FOR linux
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild get #2>&1 | tee logs/gcc.get.log
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild extract 2>&1 | tee logs/gcc.extract.log
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild build 2>&1 | tee logs/gcc.build.log
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild install 2>&1 | tee logs/gcc.install.log

##probably needed IF NOT using busybox (untested)
##"${myBuildHome}"/myBuilds/coreutils.myBuild get #2>&1 | tee logs/coreutils.get.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild extract #2>&1 | tee logs/coreutils.extract.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild build #2>&1 | tee logs/coreutils.build.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild install #2>&1 | tee logs/coreutils.install.log

###backup was here, though didn't include binutils

#FOR linux
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild get #2>&1 | tee logs/busybox.get.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild extract 2>&1 | tee logs/busybox.extract.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild build 2>&1 | tee logs/busybox.build.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild install 2>&1 | tee logs/busybox.install.log

##we should now have a working compiler, libc and kernel

#FOR make, due to make throwing error "undefined reference to `__alloca'" when compiling glibc
#note, is also used to build software from [source] .ac files, which relevant to much of the software for myBuilds (inc. make)
#"${myBuildHome}"/myBuilds/autoconf.myBuild get #2>&1 | tee logs/autoconf.get.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild extract 2>&1 | tee logs/autoconf.extract.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild build 2>&1 | tee logs/autoconf.build.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild install 2>&1 | tee logs/autoconf.install.log

#FOR automake
#"${myBuildHome}"/myBuilds/perl.myBuild get #2>&1 | tee logs/perl.get.log
#"${myBuildHome}"/myBuilds/perl.myBuild extract 2>&1 | tee logs/perl.extract.log
#"${myBuildHome}"/myBuilds/perl.myBuild build 2>&1 | tee logs/perl.build.log
#"${myBuildHome}"/myBuilds/perl.myBuild install 2>&1 | tee logs/perl.install.log

#FOR make
#"${myBuildHome}"/myBuilds/automake.myBuild get #2>&1 | tee logs/automake.get.log
#"${myBuildHome}"/myBuilds/automake.myBuild extract 2>&1 | tee logs/automake.extract.log
#"${myBuildHome}"/myBuilds/automake.myBuild build 2>&1 | tee logs/automake.build.log
#"${myBuildHome}"/myBuilds/automake.myBuild install 2>&1 | tee logs/automake.install.log

##NOT needed, but for possibly (and optionally) building glib
##"${myBuildHome}"/myBuilds/libffi.myBuild get #2>&1 | tee logs/libffi.get.log
##"${myBuildHome}"/myBuilds/libffi.myBuild extract #2>&1 | tee logs/libffi.extract.log
##"${myBuildHome}"/myBuilds/libffi.myBuild build #2>&1 | tee logs/libffi.build.log
##"${myBuildHome}"/myBuilds/libffi.myBuild install #2>&1 | tee logs/libffi.install.log

#FOR make whilst using autoreconf (note: also for building glib)
#"${myBuildHome}"/myBuilds/gettext.myBuild get #2>&1 | tee logs/gettext.get.log
#"${myBuildHome}"/myBuilds/gettext.myBuild extract 2>&1 | tee logs/gettext.extract.log
#"${myBuildHome}"/myBuilds/gettext.myBuild build 2>&1 | tee logs/gettext.build.log
#"${myBuildHome}"/myBuilds/gettext.myBuild install 2>&1 | tee logs/gettext.install.log

##NOT needed, but possibly can be used to build glib instead of glib's internal pcre
##"${myBuildHome}"/myBuilds/pcre.myBuild get #2>&1 | tee logs/pcre.get.log
##"${myBuildHome}"/myBuilds/pcre.myBuild extract #2>&1 | tee logs/pcre.extract.log
##"${myBuildHome}"/myBuilds/pcre.myBuild build #2>&1 | tee logs/pcre.build.log
##"${myBuildHome}"/myBuilds/pcre.myBuild install #2>&1 | tee logs/pcre.install.log

##NOT needed, but possibly can be used for building pkgconfig
##"${myBuildHome}"/myBuilds/glib.myBuild get #2>&1 | tee logs/glib.get.log
##"${myBuildHome}"/myBuilds/glib.myBuild extract #2>&1 | tee logs/glib.extract.log
##"${myBuildHome}"/myBuilds/glib.myBuild build #2>&1 | tee logs/glib.build.log
##"${myBuildHome}"/myBuilds/glib.myBuild install #2>&1 | tee logs/glib.install.log

##NOT needed
##"${myBuildHome}"/myBuilds/pkg-config.myBuild get #2>&1 | tee logs/pkg-config.get.log
##"${myBuildHome}"/myBuilds/pkg-config.myBuild extract #2>&1 | tee logs/pkg-config.extract.log
##"${myBuildHome}"/myBuilds/pkg-config.myBuild build #2>&1 | tee logs/pkg-config.build.log
##"${myBuildHome}"/myBuilds/pkg-config.myBuild install #2>&1 | tee logs/pkg-config.install.log

#FOR linux
#"${myBuildHome}"/myBuilds/make/make.myBuild get #2>&1 | tee logs/make.get.log
#"${myBuildHome}"/myBuilds/make/make.myBuild extract 2>&1 | tee logs/make.extract.log
#"${myBuildHome}"/myBuilds/make/make.myBuild build 2>&1 | tee logs/make.build.log
#"${myBuildHome}"/myBuilds/make/make.myBuild install 2>&1 | tee logs/make.install.log

#FOR elfutils
#"${myBuildHome}"/myBuilds/zlib.myBuild get #2>&1 | tee logs/zlib.get.log
#"${myBuildHome}"/myBuilds/zlib.myBuild extract 2>&1 | tee logs/zlib.extract.log
#"${myBuildHome}"/myBuilds/zlib.myBuild build 2>&1 | tee logs/zlib.build.log
#"${myBuildHome}"/myBuilds/zlib.myBuild install 2>&1 | tee logs/zlib.install.log

##this library doesn't work for compiling linux when i tested, because gelf.h was installed in /usr/include/libelf/ rather than just /usr/include but I may be wrong.
##"${myBuildHome}"/myBuilds/libelf.myBuild get #2>&1 | tee logs/libelf.get.log
##"${myBuildHome}"/myBuilds/libelf.myBuild extract #2>&1 | tee logs/libelf.extract.log
##"${myBuildHome}"/myBuilds/libelf.myBuild build #2>&1 | tee logs/libelf.build.log
##"${myBuildHome}"/myBuilds/libelf.myBuild install #2>&1 | tee logs/libelf.install.log

#FOR bc 
#"${myBuildHome}"/myBuilds/elfutils.myBuild get #2>&1 | tee logs/elfutils.get.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild extract 2>&1 | tee logs/elfutils.extract.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild build 2>&1 | tee logs/elfutils.build.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild install 2>&1 | tee logs/elfutils.install.log

##FOR bc
#"${myBuildHome}"/myBuilds/texinfo.myBuild get #2>&1 | tee logs/texinfo.get.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild extract 2>&1 | tee logs/texinfo.extract.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild build 2>&1 | tee logs/texinfo.build.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild install 2>&1 | tee logs/texinfo.install.log

##FOR linux
#"${myBuildHome}"/myBuilds/bc.myBuild get #2>&1 | tee logs/bc.get.log
#"${myBuildHome}"/myBuilds/bc.myBuild extract 2>&1 | tee logs/bc.extract.log
#"${myBuildHome}"/myBuilds/bc.myBuild build 2>&1 | tee logs/bc.build.log
#"${myBuildHome}"/myBuilds/bc.myBuild install 2>&1 | tee logs/bc.install.log

##FOR linux
#"${myBuildHome}"/myBuilds/openssl.myBuild get #2>&1 | tee logs/openssl.get.log
#"${myBuildHome}"/myBuilds/openssl.myBuild extract 2>&1 | tee logs/openssl.extract.log
#"${myBuildHome}"/myBuilds/openssl.myBuild build 2>&1 | tee logs/openssl.build.log
#"${myBuildHome}"/myBuilds/openssl.myBuild install 2>&1 | tee logs/openssl.install.log

##FOR linux, we use this because busybox does not provide a "-b" option for the "depmod" command
#"${myBuildHome}"/myBuilds/kmod.myBuild get #2>&1 | tee logs/kmod.get.log
#"${myBuildHome}"/myBuilds/kmod.myBuild extract 2>&1 | tee logs/kmod.extract.log
#"${myBuildHome}"/myBuilds/kmod.myBuild build 2>&1 | tee logs/kmod.build.log
#"${myBuildHome}"/myBuilds/kmod.myBuild install 2>&1 | tee logs/kmod.install.log

##FOR gcc
#"${myBuildHome}"/myBuilds/gawk.myBuild get #2>&1 | tee logs/gawk.get.log
#"${myBuildHome}"/myBuilds/gawk.myBuild extract 2>&1 | tee logs/gawk.extract.log
#"${myBuildHome}"/myBuilds/gawk.myBuild build 2>&1 | tee logs/gawk.build.log
#"${myBuildHome}"/myBuilds/gawk.myBuild install 2>&1 | tee logs/gawk.install.log

##FOR gcc
#"${myBuildHome}"/myBuilds/bison.myBuild get #2>&1 | tee logs/bison.get.log
#"${myBuildHome}"/myBuilds/bison.myBuild extract 2>&1 | tee logs/bison.extract.log
#"${myBuildHome}"/myBuilds/bison.myBuild build 2>&1 | tee logs/bison.build.log
#"${myBuildHome}"/myBuilds/bison.myBuild install 2>&1 | tee logs/bison.install.log

##FOR gcc
#"${myBuildHome}"/myBuilds/m4/m4.myBuild get #2>&1 | tee logs/m4.get.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild extract 2>&1 | tee logs/m4.extract.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild build 2>&1 | tee logs/m4.build.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild install 2>&1 | tee logs/m4.install.log

###	copy sources to build directory in /root/myBuildBootstrap	###
#"${myBuildHome}"/myBuilds/copyMyBuild.myBuild install #2>&1 | tee logs/copyMyBuild.install.log

###	finally run ldconfig last so that the libraries get linked correctly	###
#/sbin/ldconfig -v -r "${SYSROOT}"

#~/playGeorge.sh
















#--	any extras not included go after this	###

##gnu gzip is required for gnu tar

#"${myBuildHome}"/myBuilds/gzip.myBuild get #2>&1 | tee logs/gzip.get.log
#"${myBuildHome}"/myBuilds/gzip.myBuild extract #2>&1 | tee logs/gzip.extract.log
#"${myBuildHome}"/myBuilds/gzip.myBuild build #2>&1 | tee logs/gzip.build.log
#"${myBuildHome}"/myBuilds/gzip.myBuild install #2>&1 | tee logs/gzip.install.log

#"${myBuildHome}"/myBuilds/tar.myBuild get #2>&1 | tee logs/tar.get.log
#"${myBuildHome}"/myBuilds/tar.myBuild extract #2>&1 | tee logs/tar.extract.log
#"${myBuildHome}"/myBuilds/tar.myBuild build #2>&1 | tee logs/tar.build.log
#"${myBuildHome}"/myBuilds/tar.myBuild install #2>&1 | tee logs/tar.install.log

#"${myBuildHome}"/myBuilds/sed.myBuild get #2>&1 | tee logs/sed.get.log
#"${myBuildHome}"/myBuilds/sed.myBuild extract #2>&1 | tee logs/sed.extract.log
#"${myBuildHome}"/myBuilds/sed.myBuild build #2>&1 | tee logs/sed.build.log
#"${myBuildHome}"/myBuilds/sed.myBuild install #2>&1 | tee logs/sed.install.log

#"${myBuildHome}"/myBuilds/grep.myBuild get #2>&1 | tee logs/grep.get.log
#"${myBuildHome}"/myBuilds/grep.myBuild extract #2>&1 | tee logs/grep.extract.log
#"${myBuildHome}"/myBuilds/grep.myBuild build #2>&1 | tee logs/grep.build.log
#"${myBuildHome}"/myBuilds/grep.myBuild install #2>&1 | tee logs/grep.install.log

#"${myBuildHome}"/myBuilds/findutils.myBuild get #2>&1 | tee logs/findutils.get.log
#"${myBuildHome}"/myBuilds/findutils.myBuild extract #2>&1 | tee logs/findutils.extract.log
#"${myBuildHome}"/myBuilds/findutils.myBuild build #2>&1 | tee logs/findutils.build.log
#"${myBuildHome}"/myBuilds/findutils.myBuild install #2>&1 | tee logs/findutils.install.log

##we should now be able to chroot to the sysroot and build programs in a primative manner

#"${myBuildHome}"/myBuilds/text-template-perl.myBuild get #2>&1 | tee logs/text-template-perl.get.log
#"${myBuildHome}"/myBuilds/text-template-perl.myBuild extract #2>&1 | tee logs/text-template-perl.extract.log
#"${myBuildHome}"/myBuilds/text-template-perl.myBuild build #2>&1 | tee logs/text-template-perl.build.log
#"${myBuildHome}"/myBuilds/text-template-perl.myBuild install #2>&1 | tee logs/text-template-perl.install.log

#"${myBuildHome}"/myBuilds/openssl.myBuild get #2>&1 | tee logs/openssl.get.log
#"${myBuildHome}"/myBuilds/openssl.myBuild extract #2>&1 | tee logs/openssl.extract.log
#"${myBuildHome}"/myBuilds/openssl.myBuild build #2>&1 | tee logs/openssl.build.log
#"${myBuildHome}"/myBuilds/openssl.myBuild install #2>&1 | tee logs/openssl.install.log

#"${myBuildHome}"/myBuilds/wget.myBuild get #2>&1 | tee logs/wget.get.log
#"${myBuildHome}"/myBuilds/wget.myBuild extract #2>&1 | tee logs/wget.extract.log
#"${myBuildHome}"/myBuilds/wget.myBuild build #2>&1 | tee logs/wget.build.log
#"${myBuildHome}"/myBuilds/wget.myBuild install #2>&1 | tee logs/wget.install.log



#elfutils requires zlib



#"${myBuildHome}"/myBuilds/binutils.myBuild extract 2>&1 | tee logs/binutils.extract.log
#"${myBuildHome}"/myBuilds/binutils.myBuild build 2>&1 | tee logs/binutils.build.log


#"${myBuildHome}"/myBuilds/linux-debian.myBuild build 2>&1 | tee logs/linux-debian.log

