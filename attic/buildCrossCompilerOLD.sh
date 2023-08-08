#!/bin/sh

#if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-6)" = "cygwin" ]; then

#"${myBuildHome}"/myBuilds/wine.myBuild extract 2>&1 | tee logs/wine.extract.log
#"${myBuildHome}"/myBuilds/wine.myBuild build 2>&1 | tee logs/wine.build.log
#"${myBuildHome}"/myBuilds/wine.myBuild install 2>&1 | tee logs/wine.install.log

#fi


#"${myBuildHome}"/myBuilds/newlib.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/newlib.myBuild build 2>&1 | tee "${myBuildHome}"/logs/glibc.build.log
#"${myBuildHome}"/myBuilds/newlib.myBuild install 2>&1 | tee "${myBuildHome}"/logs/glibc.install.log

##export TARGET="i686-w32-newlib"

#FOR gcc when building for linux target
#"${myBuildHome}"/myBuilds/glibc.myBuild extract 2>&1 | tee logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/glibc.myBuild build 2>&1 | tee logs/glibc.build.log
#"${myBuildHome}"/myBuilds/glibc.myBuild install 2>&1 | tee logs/glibc.install.log

#OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
#if [ "$BITS" = 32 ]; then
#export LD_LIBRARY_PATH="${SYSROOT}/usr/lib:/usr/local/lib/${TARGET}:/lib${TARGET}:/usr/lib/${TARGET}:/usr/local/lib/lib32:/lib32:/usr/lib32:/usr/local/lib:/lib:/usr/lib:/usr/${TARGET}/lib32:/usr/${TARGET}/lib"
#else
#export LD_LIBRARY_PATH="${SYSROOT}/usr/lib:/usr/local/lib/${TARGET}:/lib${TARGET}:/usr/lib/${TARGET}:/usr/local/lib/lib64:/lib64:/usr/lib64:/usr/local/lib:/lib:/usr/lib:/usr/${TARGET}/lib64:/usr/${TARGET}/lib"
#fi

#OLD_LDFLAGS="$LDFLAGS"
#OLD_CPATH="$CPATH"
export WINECFLAGS="-D USE_WS_PREFIX -I${SYSROOT}/usr/include/wine/windows"
#export LDFLAGS="-L${SYSROOT}/usr/lib"
#export LIBS="-lwine"
#export CPATH="$CPATH:${SYSROOT}/usr/include/wine/windows"

OLD_PATH="$PATH"
#if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-6)" = "cygwin" ]; then
cd "${myBuildHome}/windows/winecompat"

#we set our PATH to find winegcc
export PATH="$PATH:$SYSROOT/usr/bin"
winebuild --implib -o libwinecompat.a -E libwinecompat.spec

cp -a libwinecompat.a "${SYSROOT}/usr/lib"




export PATH="$OLD_PATH"
#fi
#we build binutils
#FOR gcc
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/binutils.extract.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild build 2>&1 | tee "${myBuildHome}"/logs/binutils.build.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install 2>&1 | tee "${myBuildHome}"/logs/binutils.install.log

##OLD_LD="$LD"
##OLD_AR="$AR"
##OLD_RANLIB="$RANLIB"
zz
##export AS="${TARGET}-as"
##export LD="${TARGET}-ld"
##export AR="${TARGET}-ar"
##export RANLIB="${TARGET}-ranlib"

##if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then

##"${myBuildHome}"/myBuilds/mingw32.myBuild extract headers 2>&1 | tee "${myBuildHome}"/logs/mingw32.extract.log
##"${myBuildHome}"/myBuilds/mingw32.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/mingw32.build.log
##"${myBuildHome}"/myBuilds/mingw32.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/mingw32.install.log

##OLDER_CFLAGS="${CFLAGS}"
##export CFLAGS="${CFLAGS} -I${SYSROOT}/mingw/include"

##"${myBuildHome}"/myBuilds/mingw64.myBuild extract library 2>&1 | tee "${myBuildHome}"/logs/mingw64.extract.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild build library 2>&1 | tee "${myBuildHome}"/logs/mingw64.build.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild install library 2>&1 | tee "${myBuildHome}"/logs/mingw64.install.log

##OLDER_CFLAGS="${CFLAGS}"

##fi

##we set our PATH to find binutils executables
export PATH="$PATH:$SYSROOT/usr/bin"

"${myBuildHome}"/myBuilds/mingw64.myBuild extract headers 2>&1 | tee logs/mingw64.extract.log
"${myBuildHome}"/myBuilds/mingw64.myBuild build headers 2>&1 | tee logs/mingw64.build.log
"${myBuildHome}"/myBuilds/mingw64.myBuild install headers 2>&1 | tee logs/mingw64.install.log

#export CPATH="$CPATH:${SYSROOT}/mingw/include"
#"${myBuildHome}"/myBuilds/mingw64.myBuild extract library 2>&1 | tee logs/mingw64.extract.log
#"${myBuildHome}"/myBuilds/mingw64.myBuild build library 2>&1 | tee logs/mingw64.build.log
#"${myBuildHome}"/myBuilds/mingw64.myBuild install library 2>&1 | tee logs/mingw64.install.log


#if [ "$TARGET" != "$HOST" ]; then

	#we build initial compiler, used for bootstrapping, this is needed when cross-compiling only, the if statement ensures this
	#FOR linux
	#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild extract first 2>&1 | tee "${myBuildHome}"/logs/gcc.extract-first.log
	#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild build first 2>&1 | tee "${myBuildHome}"/logs/gcc.build-first.log
	#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild install first 2>&1 | tee "${myBuildHome}"/logs/gcc.install-first.log
#fi

#"${myBuildHome}"/myBuilds/cygwin-newlib.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/cygwin-newlib.myBuild build 2>&1 | tee "${myBuildHome}"/logs/glibc.build.log
#"${myBuildHome}"/myBuilds/cygwin-newlib.myBuild install 2>&1 | tee "${myBuildHome}"/logs/glibc.install.log

#OLD_LD="$LD"
#OLD_AR="$AR"
#OLD_RANLIB="$RANLIB"
#OLD_AS="$AS"

#export LD="${TARGET}-ld"
#export AR="${TARGET}-ar"
#export AS="${TARGET}-as"
#export RANLIB="${TARGET}-ranlib"

export PATH="$SYSROOT/usr/bin:$OLD_PATH"

#"${myBuildHome}"/myBuilds/musl.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/musl.extract.log
#"${myBuildHome}"/myBuilds/musl.myBuild build 2>&1 | tee "${myBuildHome}"/logs/musl.build.log
#"${myBuildHome}"/myBuilds/musl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/musl.install.log

##if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw64" ]; then

##"${myBuildHome}"/myBuilds/mingw64.myBuild extract headers 2>&1 | tee "${myBuildHome}"/logs/mingw64.extract.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/mingw64.build.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/mingw64.install.log

##OLDER_CFLAGS="${CFLAGS}"
##export CFLAGS="${CFLAGS} -I${SYSROOT}/mingw/include"

##"${myBuildHome}"/myBuilds/mingw64.myBuild extract library 2>&1 | tee "${myBuildHome}"/logs/mingw64.extract.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild build library 2>&1 | tee "${myBuildHome}"/logs/mingw64.build.log
##"${myBuildHome}"/myBuilds/mingw64.myBuild install library 2>&1 | tee "${myBuildHome}"/logs/mingw64.install.log

##OLDER_CFLAGS="${CFLAGS}"

##fi

#we then build libc libraries

#FOR gcc when building for windows target
#"${myBuildHome}"/myBuilds/musl.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/musl.extract.log
#"${myBuildHome}"/myBuilds/musl.myBuild build 2>&1 | tee "${myBuildHome}"/logs/musl.build.log
#"${myBuildHome}"/myBuilds/musl.myBuild install 2>&1 | tee "${myBuildHome}"/logs/musl.install.log

##FOR gcc when building for linux target
#"${myBuildHome}"/myBuilds/glibc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/glibc.myBuild build 2>&1 | tee "${myBuildHome}"/logs/glibc.build.log
#"${myBuildHome}"/myBuilds/glibc.myBuild install 2>&1 | tee "${myBuildHome}"/logs/glibc.install.log

##FOR gcc when building for linux target
#"${myBuildHome}"/myBuilds/newlib.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc.extract.log
#"${myBuildHome}"/myBuilds/newlib.myBuild build 2>&1 | tee "${myBuildHome}"/logs/glibc.build.log
#"${myBuildHome}"/myBuilds/newlib.myBuild install 2>&1 | tee "${myBuildHome}"/logs/glibc.install.log

#we run ldconfig because we have installed a new library to the SYSROOT
/sbin/ldconfig -v -r "${SYSROOT}"

export PATH="$OLD_PATH:$SYSROOT/usr/bin"

#export CPATH="${SYSROOT}/usr/include:${SYSROOT}/usr/${TARGET}/include:${SYSROOT}/usr/lib/gcc/${TARGET}/8/include:${SYSROOT}/usr/lib/gcc/${TARGET}/8/include-fixed:${SYSROOT}/usr/include/wine/wine/windows/"
#OLD_LIBRARY_PATH=$LIBRARY_PATH
#OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
#if [ "$BITS" = 32 ]; then
#export LIBRARY_PATH="${SYSROOT}/usr/local/lib/${TARGET}:${SYSROOT}/lib${TARGET}:${SYSROOT}/usr/lib/${TARGET}:${SYSROOT}/usr/local/lib/lib32:${SYSROOT}/lib32:${SYSROOT}/usr/lib32:${SYSROOT}/usr/local/lib:${SYSROOT}/lib:${SYSROOT}/usr/lib:${SYSROOT}/usr/${TARGET}/lib32:${SYSROOT}/usr/${TARGET}/lib"
#export LD_LIBRARY_PATH=$LIBRARY_PATH
#else
#export LIBRARY_PATH="${SYSROOT}/usr/local/lib/${TARGET}:${SYSROOT}/lib${TARGET}:${SYSROOT}/usr/lib/${TARGET}:${SYSROOT}/usr/local/lib/lib64:${SYSROOT}/lib64:${SYSROOT}/usr/lib64:${SYSROOT}/usr/local/lib:${SYSROOT}/lib:${SYSROOT}/usr/lib:${SYSROOT}/usr/${TARGET}/lib64:${SYSROOT}/usr/${TARGET}/lib"
#export LD_LIBRARY_PATH=$LIBRARY_PATH
#fi

#then we build the proper cross compiler
#FOR linux
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild extract second 2>&1 | tee "${myBuildHome}"/logs/gcc-second.extract.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild build second 2>&1 | tee "${myBuildHome}"/logs/gcc-second.build.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild install second 2>&1 | tee "${myBuildHome}"/logs/gcc-second.install.log

export PATH="$OLD_PATH"
export LIBRARY_PATH="$OLD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$OLD_LD_LIBRARY_PATH"
export LD="$OLD_LD"
export AR="$OLD_AR"
export RANLIB="$OLD_RANLIB"
