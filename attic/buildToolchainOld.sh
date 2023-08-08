#!/bin/sh

#if [ "$(hostname)" = "debian" ]; then
##hack for debian, to find asm/errno.h https://gcc.gnu.org/bugzilla/show_bug.cgi?id=48879
#hack for debian, to find stddef.h
#export C_INCLUDE_PATH="/usr/lib/gcc/i686-linux-gnu/8/include/stddef.h"
#export CPLUS_INCLUDE_PATH="/usr/lib/gcc/i686-linux-gnu/8/include/stddef.h"
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/gcc/i686-linux-gnu/8/x32/"
#fi

#myBuild options

#environment variables
export myBuildHome="$1"
export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest3"

mkdir "$myBuildSourceDest"
mkdir "$myBuildExtractDest"
mkdir "${myBuildHome}/logs"

export J="-j12"

#this would be for binutils search paths, but i am playing my luck to see if i can go without it
#ld --verbose | grep SEARCH_DIR | tr -s ' ;' \\012
export BITS='32'

#architecture='x86' #the architecture of the target (used for building a kernel)
#export architecture

export TARGET="i686-linux-gnu" #the toolchain we're creating
export ARCH='x86' #the architecture of the toolchain we're compiling from
export BUILD="i686-linux-gnu" #the toolchain we're compiling from, can be found by reading the "Target: *" field from "gcc -v", or "gcc -v 2>&1 | grep Target: | sed 's/.*: //" for systems with grep and sed

export SYSROOT="${myBuildHome}/installDir3" #the root dir

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
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild get 2>&1 | tee logs/linux-deblob.get.log
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

####THE FOLLOWING IS REQUIRED FOR WINE BUILDS { #####
####THE FOLLOWING IS REQUIRED FOR GRAPHICAL DISPLAY { #####

#build flex (probably for wine)

#for xorg-server
#"${myBuildHome}"/myBuilds/pixman.myBuild get 2>&1 | tee logs/pixman.get.log
#"${myBuildHome}"/myBuilds/pixman.myBuild extract 2>&1 | tee logs/pixman.extract.log
#"${myBuildHome}"/myBuilds/pixman.myBuild build 2>&1 | tee logs/pixman.build.log
#"${myBuildHome}"/myBuilds/pixman.myBuild install 2>&1 | tee logs/pixman.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xkbfile.myBuild get 2>&1 | tee logs/xkbfile.get.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild extract 2>&1 | tee logs/xkbfile.extract.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild build 2>&1 | tee logs/xkbfile.build.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild install 2>&1 | tee logs/xkbfile.install.log

#for xfont
#"${myBuildHome}"/myBuilds/freetype.myBuild get 2>&1 | tee logs/freetype.get.log
#"${myBuildHome}"/myBuilds/freetype.myBuild extract 2>&1 | tee logs/freetype.extract.log
#"${myBuildHome}"/myBuilds/freetype.myBuild build 2>&1 | tee logs/freetype.build.log
#"${myBuildHome}"/myBuilds/freetype.myBuild install 2>&1 | tee logs/freetype.install.log

#for xfont
#"${myBuildHome}"/myBuilds/fontenc.myBuild get 2>&1 | tee logs/fontenc.get.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild extract 2>&1 | tee logs/fontenc.extract.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild build 2>&1 | tee logs/fontenc.build.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild install 2>&1 | tee logs/fontenc.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xfont.myBuild get 2>&1 | tee logs/xfont.get.log
#"${myBuildHome}"/myBuilds/xfont.myBuild extract 2>&1 | tee logs/xfont.extract.log
#"${myBuildHome}"/myBuilds/xfont.myBuild build 2>&1 | tee logs/xfont.build.log
#"${myBuildHome}"/myBuilds/xfont.myBuild install 2>&1 | tee logs/xfont.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/pkg-config.myBuild get 2>&1 | tee logs/pkg-config.get.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild extract 2>&1 | tee logs/pkg-config.extract.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild build 2>&1 | tee logs/pkg-config.build.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild install 2>&1 | tee logs/pkg-config.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/pciaccess.myBuild get 2>&1 | tee logs/pciaccess.get.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild extract 2>&1 | tee logs/pciaccess.extract.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild build 2>&1 | tee logs/pciaccess.build.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild install 2>&1 | tee logs/pciaccess.install.log

#for libepoxy
#"${myBuildHome}"/myBuilds/util-macros.myBuild get 2>&1 | tee logs/util-macros.get.log
#"${myBuildHome}"/myBuilds/util-macros.myBuild extract 2>&1 | tee logs/util-macros.extract.log
#"${myBuildHome}"/myBuilds/util-macros.myBuild build 2>&1 | tee logs/util-macros.build.log
#"${myBuildHome}"/myBuilds/util-macros.myBuild install 2>&1 | tee logs/util-macros.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libepoxy.myBuild get 2>&1 | tee logs/libepoxy.get.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild extract 2>&1 | tee logs/libepoxy.extract.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild build 2>&1 | tee logs/libepoxy.build.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild install 2>&1 | tee logs/libepoxy.install.log

#for xrandr
#"${myBuildHome}"/myBuilds/xrender.myBuild get 2>&1 | tee logs/xrender.get.log
#"${myBuildHome}"/myBuilds/xrender.myBuild extract 2>&1 | tee logs/xrender.extract.log
#"${myBuildHome}"/myBuilds/xrender.myBuild build 2>&1 | tee logs/xrender.build.log
#"${myBuildHome}"/myBuilds/xrender.myBuild install 2>&1 | tee logs/xrender.install.log

#for mesa
#"${myBuildHome}"/myBuilds/xrandr.myBuild get 2>&1 | tee logs/xrandr.get.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild extract 2>&1 | tee logs/xrandr.extract.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild build 2>&1 | tee logs/xrandr.build.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild install 2>&1 | tee logs/xrandr.install.log

#for mesa
#"${myBuildHome}"/myBuilds/libdrm.myBuild get 2>&1 | tee logs/libdrm.get.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild extract 2>&1 | tee logs/libdrm.extract.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild build 2>&1 | tee logs/libdrm.build.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild install 2>&1 | tee logs/libdrm.install.log

#for xorg-server, because egl is required for building xorg
#"${myBuildHome}"/myBuilds/mesa.myBuild get 2>&1 | tee logs/mesa.get.log
#"${myBuildHome}"/myBuilds/mesa.myBuild extract 2>&1 | tee logs/mesa.extract.log
#"${myBuildHome}"/myBuilds/mesa.myBuild build 2>&1 | tee logs/mesa.build.log
#"${myBuildHome}"/myBuilds/mesa.myBuild install 2>&1 | tee logs/mesa.install.log

#for wine, at the moment X.org is preferred. https://bugs.winehq.org/show_bug.cgi?id=42284
#"${myBuildHome}"/myBuilds/xorg-server.myBuild get 2>&1 | tee logs/xorg-server.get.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild extract 2>&1 | tee logs/xorg-server.extract.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild build 2>&1 | tee logs/xorg-server.build.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild install 2>&1 | tee logs/xorg-server.install.log

#### } THE PREVIOUS WAS REQUIRED FOR GRAPHICAL DISPLAY #####

#build wine
#"${myBuildHome}"/myBuilds/wine.myBuild get 2>&1 | tee logs/wine.get.log
#"${myBuildHome}"/myBuilds/wine.myBuild extract 2>&1 | tee logs/wine.extract.log
#"${myBuildHome}"/myBuilds/wine.myBuild build 2>&1 | tee logs/wine.build.log
#"${myBuildHome}"/myBuilds/wine.myBuild install 2>&1 | tee logs/wine.install.log

#### } THE PREVIOUS WAS REQUIRED FOR WINDOWS BUILDS #####

export TARGET="i686-pc-gnu" #the toolchain we're creating

#we build binutils
#FOR gcc
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild get 2>&1 | tee logs/binutils.get.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild extract 2>&1 | tee logs/binutils.extract.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild build 2>&1 | tee logs/binutils.build.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install 2>&1 | tee logs/binutils.install.log

##we build libc headers
##GCC when building for windows target
##"${myBuildHome}"/myBuilds/mingw64.myBuild get headers 2>&1 | tee logs/mingw64.get.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild extract headers 2>&1 | tee logs/mingw64.extract.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild build headers 2>&1 | tee logs/mingw64.build.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild install headers 2>&1 | tee logs/mingw64.install.log

##we set our PATH to find binutils executables
OLD_PATH="$PATH"
export PATH="$PATH:$SYSROOT/usr/bin"

if [ "$(hostname)" = "debian" ]; then
	#for debian, because can't find stddef.h
	OLD_CPATH="$CPATH"
	export CPATH="/usr/${BUILD}/include:/usr/lib/gcc/${BUILD}/8/include:/usr/lib/gcc/${BUILD}/8/include-fixed:/usr/include/wine/wine/windows/"
	#for debian, because /lib/ld.so doesn't exist
	if ! [ -f "/lib/ld.so" ]; then
		sudo ln -s /lib/ld-linux.so.2 /lib/ld.so
	fi
##:${SYSROOT}/mingw/include
fi

##OLD_CC="$CC"
##export CC="/usr/bin/i686-linux-gnu-gcc-7"
##OLD_CXX="$CXX"
##export CXX="/usr/bin/i686-linux-gnu-g++-7"


###we set this to find libc libraries

#we build initial compiler, used for bootstrapping
#FOR linux
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild get first 2>&1 | tee logs/gcc.get.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild extract first 2>&1 | tee logs/gcc.extract.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild build first 2>&1 | tee logs/gcc.build.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild install first 2>&1 | tee logs/gcc.install.log

OLD_LD="$LD"
OLD_AR="$AR"
OLD_RANLIB="$RANLIB"

export LD="${TARGET}-ld"
export AR="${TARGET}-ar"
export RANLIB="${TARGET}-ranlib"

##export CC="$OLD_CC"
##export CXX="$OLD_CXX"

##maybe need to put this back in if musl fails.
##if [ "$(hostname)" = "debian" ]; then
##	#for debian because can't find stddef.h
##	export CPATH="$OLD_CPATH"
##fi

export PATH="$SYSROOT/usr/bin:$OLD_PATH"

export LIBRARY_PATH=""

#we then build libc libraries

#FOR gcc when building for windows target
#"${myBuildHome}"/myBuilds/musl.myBuild get 2>&1 | tee logs/musl.get.log
#"${myBuildHome}"/myBuilds/musl.myBuild extract 2>&1 | tee logs/musl.extract.log
#"${myBuildHome}"/myBuilds/musl.myBuild build 2>&1 | tee logs/musl.build.log
#"${myBuildHome}"/myBuilds/musl.myBuild install 2>&1 | tee logs/musl.install.log

##FOR gcc when building for linux target
##"${myBuildHome}"/myBuilds/glibc.myBuild get 2>&1 | tee logs/glibc.get.log
##"${myBuildHome}"/myBuilds/glibc.myBuild extract 2>&1 | tee logs/glibc.extract.log
##"${myBuildHome}"/myBuilds/glibc.myBuild build 2>&1 | tee logs/glibc.build.log
##"${myBuildHome}"/myBuilds/glibc.myBuild install 2>&1 | tee logs/glibc.install.log

##"${myBuildHome}"/myBuilds/mingw64.myBuild build libraries 2>&1 | tee logs/mingw64.build.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild install libraries 2>&1 | tee logs/mingw64.install.log

export PATH="$OLD_PATH:$SYSROOT/usr/bin"

##OLD_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
##export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$SYSROOT/lib/"

#then we build the proper cross compiler
#FOR linux
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild extract second 2>&1 | tee logs/gcc.extract.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild build second 2>&1 | tee logs/gcc.build.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild install second 2>&1 | tee logs/gcc.install.log



#DELETE THE FOLLOWING BLOCK (JUST A TEST TO SEE IF LINUX COMPILES WITH THE W32 TOOLCHAIN.)
##"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild get #2>&1 | tee logs/linux-deblob.get.log
##"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild extract 2>&1 | tee logs/linux-deblob.extract.log
##"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild build 2>&1 | tee logs/linux-deblob.build.log
##"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild install 2>&1 | tee logs/linux-deblob.install.log





export PATH="$OLD_PATH"
export LD_LIBRARY_PATH="$OLD_LD_LIBRARY_PATH"
export LD="$OLD_LD"
export AR="$OLD_AR"
export RANLIB="$OLD_RANLIB"

##probably needed IF NOT using busybox (untested)
##"${myBuildHome}"/myBuilds/coreutils.myBuild get #2>&1 | tee logs/coreutils.get.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild extract #2>&1 | tee logs/coreutils.extract.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild build #2>&1 | tee logs/coreutils.build.log
##"${myBuildHome}"/myBuilds/coreutils.myBuild install #2>&1 | tee logs/coreutils.install.log

###backup was here, though didn't include binutils

#FOR linux
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild get 2>&1 | tee logs/busybox.get.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild extract 2>&1 | tee logs/busybox.extract.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild build 2>&1 | tee logs/busybox.build.log
#"${myBuildHome}"/myBuilds/busybox/busybox.myBuild install 2>&1 | tee logs/busybox.install.log

##we should now have a working compiler, libc and kernel

#FOR make, due to make throwing error "undefined reference to `__alloca'" when compiling glibc
#note, is also used to build software from [source] .ac files, which relevant to much of the software for myBuilds (inc. make)
#"${myBuildHome}"/myBuilds/autoconf.myBuild get 2>&1 | tee logs/autoconf.get.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild extract 2>&1 | tee logs/autoconf.extract.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild build 2>&1 | tee logs/autoconf.build.log
#"${myBuildHome}"/myBuilds/autoconf.myBuild install 2>&1 | tee logs/autoconf.install.log

export TARGET="i686-linux-gnu"

#FOR automake
#"${myBuildHome}"/myBuilds/perl.myBuild get 2>&1 | tee logs/perl.get.log
#"${myBuildHome}"/myBuilds/perl.myBuild extract 2>&1 | tee logs/perl.extract.log
#"${myBuildHome}"/myBuilds/perl.myBuild build 2>&1 | tee logs/perl.build.log
#"${myBuildHome}"/myBuilds/perl.myBuild install 2>&1 | tee logs/perl.install.log

export TARGET="i686-pc-gnu" #the toolchain we're creating

#FOR make
#"${myBuildHome}"/myBuilds/automake.myBuild get 2>&1 | tee logs/automake.get.log
#"${myBuildHome}"/myBuilds/automake.myBuild extract 2>&1 | tee logs/automake.extract.log
#"${myBuildHome}"/myBuilds/automake.myBuild build 2>&1 | tee logs/automake.build.log
#"${myBuildHome}"/myBuilds/automake.myBuild install 2>&1 | tee logs/automake.install.log

##NOT needed, but for possibly (and optionally) building glib
##"${myBuildHome}"/myBuilds/libffi.myBuild get #2>&1 | tee logs/libffi.get.log
##"${myBuildHome}"/myBuilds/libffi.myBuild extract #2>&1 | tee logs/libffi.extract.log
##"${myBuildHome}"/myBuilds/libffi.myBuild build #2>&1 | tee logs/libffi.build.log
##"${myBuildHome}"/myBuilds/libffi.myBuild install #2>&1 | tee logs/libffi.install.log

#FOR make whilst using autoreconf (note: also for building glib)
#"${myBuildHome}"/myBuilds/gettext.myBuild get 2>&1 | tee logs/gettext.get.log
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

#FOR linux
#"${myBuildHome}"/myBuilds/make/make.myBuild get 2>&1 | tee logs/make.get.log
#"${myBuildHome}"/myBuilds/make/make.myBuild extract 2>&1 | tee logs/make.extract.log
#"${myBuildHome}"/myBuilds/make/make.myBuild build 2>&1 | tee logs/make.build.log
#"${myBuildHome}"/myBuilds/make/make.myBuild install 2>&1 | tee logs/make.install.log

export AR="${TARGET}-ar"
export PATH="$OLD_PATH:$SYSROOT/usr/bin"

#FOR elfutils
#"${myBuildHome}"/myBuilds/zlib.myBuild get 2>&1 | tee logs/zlib.get.log
#"${myBuildHome}"/myBuilds/zlib.myBuild extract 2>&1 | tee logs/zlib.extract.log
#"${myBuildHome}"/myBuilds/zlib.myBuild build 2>&1 | tee logs/zlib.build.log
#"${myBuildHome}"/myBuilds/zlib.myBuild install 2>&1 | tee logs/zlib.install.log

export AR="${OLD_AR}"
export PATH="$OLD_PATH"

##this library doesn't work for compiling linux when i tested, because gelf.h was installed in /usr/include/libelf/ rather than just /usr/include but I may be wrong.
##"${myBuildHome}"/myBuilds/libelf.myBuild get #2>&1 | tee logs/libelf.get.log
##"${myBuildHome}"/myBuilds/libelf.myBuild extract #2>&1 | tee logs/libelf.extract.log
##"${myBuildHome}"/myBuilds/libelf.myBuild build #2>&1 | tee logs/libelf.build.log
##"${myBuildHome}"/myBuilds/libelf.myBuild install #2>&1 | tee logs/libelf.install.log

#FOR bc 
#"${myBuildHome}"/myBuilds/elfutils.myBuild get 2>&1 | tee logs/elfutils.get.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild extract 2>&1 | tee logs/elfutils.extract.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild build 2>&1 | tee logs/elfutils.build.log
#"${myBuildHome}"/myBuilds/elfutils.myBuild install 2>&1 | tee logs/elfutils.install.log

##FOR bc
#"${myBuildHome}"/myBuilds/texinfo.myBuild get 2>&1 | tee logs/texinfo.get.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild extract 2>&1 | tee logs/texinfo.extract.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild build 2>&1 | tee logs/texinfo.build.log
#"${myBuildHome}"/myBuilds/texinfo.myBuild install 2>&1 | tee logs/texinfo.install.log

#export CFLAGS="--sysroot=${SYSROOT}"

##FOR linux
#"${myBuildHome}"/myBuilds/bc.myBuild get 2>&1 | tee logs/bc.get.log
#"${myBuildHome}"/myBuilds/bc.myBuild extract 2>&1 | tee logs/bc.extract.log
#"${myBuildHome}"/myBuilds/bc.myBuild build 2>&1 | tee logs/bc.build.log
#"${myBuildHome}"/myBuilds/bc.myBuild install 2>&1 | tee logs/bc.install.log

export TARGET="i686-linux-gnu"

##FOR linux
#"${myBuildHome}"/myBuilds/openssl.myBuild get 2>&1 | tee logs/openssl.get.log
#"${myBuildHome}"/myBuilds/openssl.myBuild extract 2>&1 | tee logs/openssl.extract.log
#"${myBuildHome}"/myBuilds/openssl.myBuild build 2>&1 | tee logs/openssl.build.log
#"${myBuildHome}"/myBuilds/openssl.myBuild install 2>&1 | tee logs/openssl.install.log

export TARGET="i686-pc-gnu" #the toolchain we're creating

##FOR linux, we use this because busybox does not provide a "-b" option for the "depmod" command
#"${myBuildHome}"/myBuilds/kmod.myBuild get 2>&1 | tee logs/kmod.get.log
#"${myBuildHome}"/myBuilds/kmod.myBuild extract 2>&1 | tee logs/kmod.extract.log
#"${myBuildHome}"/myBuilds/kmod.myBuild build 2>&1 | tee logs/kmod.build.log
#"${myBuildHome}"/myBuilds/kmod.myBuild install 2>&1 | tee logs/kmod.install.log

##FOR gcc
#"${myBuildHome}"/myBuilds/gawk.myBuild get 2>&1 | tee logs/gawk.get.log
#"${myBuildHome}"/myBuilds/gawk.myBuild extract 2>&1 | tee logs/gawk.extract.log
#"${myBuildHome}"/myBuilds/gawk.myBuild build 2>&1 | tee logs/gawk.build.log
#"${myBuildHome}"/myBuilds/gawk.myBuild install 2>&1 | tee logs/gawk.install.log

##FOR gcc, also for wine
#"${myBuildHome}"/myBuilds/bison.myBuild get 2>&1 | tee logs/bison.get.log
#"${myBuildHome}"/myBuilds/bison.myBuild extract 2>&1 | tee logs/bison.extract.log
#"${myBuildHome}"/myBuilds/bison.myBuild build 2>&1 | tee logs/bison.build.log
#"${myBuildHome}"/myBuilds/bison.myBuild install 2>&1 | tee logs/bison.install.log

export TARGET="i686-linux-gnu"

##NOT needed
##"${myBuildHome}"/myBuilds/gnulib/gnulib.myBuild get #2>&1 | tee logs/gnulib.get.log
##"${myBuildHome}"/myBuilds/gnulib/gnulib.myBuild extract 2>&1 | tee logs/gnulib.extract.log
##"${myBuildHome}"/myBuilds/gnulib/gnulib.myBuild build 2>&1 | tee logs/gnulib.build.log
##"${myBuildHome}"/myBuilds/gnulib/gnulib.myBuild install 2>&1 | tee logs/gnulib.install.log

##FOR gcc
#"${myBuildHome}"/myBuilds/m4/m4.myBuild get 2>&1 | tee logs/m4.get.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild extract 2>&1 | tee logs/m4.extract.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild build 2>&1 | tee logs/m4.build.log
#"${myBuildHome}"/myBuilds/m4/m4.myBuild install 2>&1 | tee logs/m4.install.log

export TARGET="i686-pc-gnu" #the toolchain we're creating

###	copy sources to build directory in /root/myBuildBootstrap	###
"${myBuildHome}"/myBuilds/copyMyBuild.myBuild install #2>&1 | tee logs/copyMyBuild.install.log

###	finally run ldconfig last so that the libraries get linked correctly	###
/sbin/ldconfig -v -r "${SYSROOT}"

#~/playGeorge.sh


