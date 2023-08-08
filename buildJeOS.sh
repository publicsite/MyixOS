#!/bin/sh

#myBuild options

###	environment variables	###
export J="-j4"

export myBuildHome="$1"
export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest"

mkdir "$myBuildSourceDest"
mkdir "$myBuildExtractDest"
mkdir "${myBuildHome}/logs"

export SYSROOT="${myBuildHome}/installDir" #the root dir
mkdir "$SYSROOT"

#this would be for binutils search paths, but i am playing my luck to see if i can go without it
#ld --verbose | grep SEARCH_DIR | tr -s ' ;' \\012

export BITS='32'
export ARCH='x86' #the architecture of the toolchain we're compiling from

export TARGET="i686-w64-mingw32" #the toolchain we're creating
export BUILD="i686-linux-gnu" #the system we're compiling from
export HOST="i686-linux-gnu" #the system that we will run the toolchain on

export PREFIX='/usr' #the location to install to

###THIS BLOCK CREATES SYMLINKS TO THE TARGET DIRECTORY {

mkdir -p "$SYSROOT${PREFIX}/${HOST}/lib"
mkdir -p "$SYSROOT${PREFIX}/${HOST}/bin"
mkdir -p "$SYSROOT${PREFIX}/${HOST}/sbin"

mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/include"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/lib"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/bin"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/share"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/sbin"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/local"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/etc"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/libexec"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/var"
mkdir -p "$SYSROOT${PREFIX}/${HOST}${PREFIX}/etc"

ln -s "$(printf "%s" "${PREFIX}" | cut -c 2-)/${HOST}/lib" "${SYSROOT}/"
ln -s "$(printf "%s" "${PREFIX}" | cut -c 2-)/${HOST}/bin" "${SYSROOT}/"
ln -s "$(printf "%s" "${PREFIX}" | cut -c 2-)/${HOST}/sbin" "${SYSROOT}/"


ln -s "${HOST}${PREFIX}/include" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/lib" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/bin" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/share" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/sbin" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/local" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/etc" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/libexec" "${SYSROOT}${PREFIX}/"
ln -s "${HOST}${PREFIX}/var" "${SYSROOT}${PREFIX}/"

ln -s "$(printf "%s" "${PREFIX}" | cut -c 2-)/${HOST}${PREFIX}/etc" "${SYSROOT}/"
ln -s "./$(printf "%s" "${PREFIX}" | cut -c 2-)/include" "${SYSROOT}${PREFIX}/${HOST}"
ln -s "./$(printf "%s" "${PREFIX}" | cut -c 2-)/etc" "${SYSROOT}${PREFIX}/${HOST}"

###}

#make /dev/zero and /dev/null on the host if it doesn't exist
if [ "$(ls -l /dev/null | cut -c 1-1)" != "c" ] || ! [ -f "/dev/null" ]; then
	mknod -m 666 /dev/null c 1 3
	mknod -m 666 /dev/zero c 1 5
	chown root:root /dev/null /dev/zero
fi

#export CC="${BUILD}-gcc"
#export AS="${BUILD}-as"
#export AR="${BUILD}-ar"
#export RANLIB="${BUILD}-ranlib"
#export LD="${BUILD}-ld"
#export NM="${BUILD}-nm"

#call the symlink dir NEW_PATH
export NEW_PATH="${myBuildHome}"/tempsysroot

#make the temp sysroot
mkdir "${NEW_PATH}"

#save our path variable
export OLD_PATH="$PATH"

#cd and make symlinks
cd "${NEW_PATH}"
ln -s "$(which which)"
ln -s "$(which tee)"
ln -s "$(which rm)"
ln -s "$(which mkdir)"
ln -s "$(which cut)"
ln -s "$(which expr)"
ln -s "$(which sed)"
ln -s "$(which make)"
ln -s "$(which ln)"
ln -s "$(which patch)"
ln -s "$(which tar)"
ln -s "$(which unzip)"
ln -s "$(which gzip)"
ln -s "$(which ls)"
ln -s "$(which cat)"
ln -s "$(which gawk)"
ln -s "$(which bison)"
ln -s "$(which grep)"
ln -s "$(which sort)"
ln -s "$(which chmod)"
ln -s "$(which awk)"
ln -s "$(which tr)"
ln -s "$(which mv)"
ln -s "$(which cp)"
ln -s "$(which rmdir)"
ln -s "$(which cmp)"
ln -s "$(which touch)"
ln -s "$(which dirname)"
ln -s "$(which fgrep)"
ln -s "$(which basename)"
ln -s "$(which bzip2)"
ln -s "$(which echo)"
ln -s "$(which arch)"
ln -s "$(which uname)"
ln -s "$(which test)"
ln -s "$(which head)"
ln -s "$(which printf)"
ln -s "$(which mktemp)"
ln -s "$(which sh)"
ln -s "$(which autoconf)"
ln -s "$(which autoheader)"
ln -s "$(which automake)"
ln -s "$(which aclocal)"
ln -s "$(which false)"
ln -s "$(which test)"
ln -s "$(which egrep)"
ln -s "$(which print)"
ln -s "$(which xset)"
ln -s "$(which pwd)"
ln -s "$(which hostname)"
ln -s "$(which sleep)"
ln -s "$(which uniq)"
ln -s "$(which diff)"
ln -s "$(which od)"
ln -s "$(which env)"
ln -s "$(which true)"
ln -s "$(which find)"
ln -s "$(which tail)"
ln -s "$(which date)"
ln -s "$(which flex)"
ln -s "$(which xargs)"
ln -s "$(which perl)"

#add the toolchain symlinks from the build system to the temp sysroot
ln -s "$(which ${BUILD}-gcc)"
ln -s "$(which ${BUILD}-g++)" #this is bad, but now a requirement unfortunately.
ln -s "$(which ${BUILD}-as)"
ln -s "$(which ${BUILD}-ar)"
ln -s "$(which ${BUILD}-ranlib)"
ln -s "$(which ${BUILD}-ld)"
ln -s "$(which ${BUILD}-nm)"

ln -s "$(which ${BUILD}-gcc)" gcc
ln -s "$(which ${BUILD}-g++)" g++ #this is bad, but now a requirement unfortunately.
ln -s "$(which ${BUILD}-as)" as
ln -s "$(which ${BUILD}-ar)" ar
ln -s "$(which ${BUILD}-ranlib)" ranlib
ln -s "$(which ${BUILD}-ld)" ld
ln -s "$(which ${BUILD}-nm)" nm
cd "${myBuildHome}"

###	hacks for debian	###
if [ -f "/etc/debian_version" ]; then
	#for debian, because can't find stddef.h
	OLD_CPATH="$CPATH"

	#This>>>export CPATH="/usr/include:/usr/${BUILD}/include:/usr/lib/gcc/${BUILD}/8/include:/usr/lib/gcc/${BUILD}/8/include-fixed:/usr/include/freetype2:/usr/include/freetype2/freetype"
	#export CPATH="/usr/include:/usr/${BUILD}/include:/usr/lib/gcc/${BUILD}/8/include:/usr/lib/gcc/${BUILD}/8/include-fixed:/usr/include/freetype2:/usr/include/freetype2/freetype:/usr/include/wine/wine/windows"

	#export CPATH="/usr/include:/usr/lib/gcc/${BUILD}/8/include:/usr/lib/gcc/${BUILD}/8/include-fixed:/usr/include/wine/wine/windows/"
	#export CPATH="/usr/include:/usr/${BUILD}/include:/usr/lib/gcc/${BUILD}/8/include:/usr/lib/gcc/${BUILD}/8/include-fixed:/usr/include/wine/windows/"
	#for debian, because /lib/ld.so doesn't exist
	if ! [ -f "/lib/ld.so" ]; then
		sudo ln -s /lib/ld-linux.so.2 /lib/ld.so
	fi

	#fix debian not finding libwine
	if ! [ -f "/usr/lib/libwine.so" ]; then
		export wineDir="$(printf "%s\n" "/usr/lib/"*"/wine/")"
		sudo ln "${wineDir}/libwine.so.1.0" /usr/lib/libwine.so
		#printf "$wineDir\n" | sudo tee /etc/ld.so.conf.d/libwine.conf
		#sudo ldconfig
	fi

	##make symlink so that gcc can find libstdc++
	##stdcpluspluspath="$(printf "%s\n" /usr/lib/*/libstdc++.so.6 | cut -d "/" -f1-4)"
	##cd "$(printf "%s\n" "$stdcpluspluspath" | cut -d "/" -f 1-3)"
	##sudo ln -s libstdc++.so.6 libstdc++.so
	##cd "${myBuildHome}"



	#sudo ln -s /libx32/libstdc++.so.6 /libx32/libstdc++.so
	#sudo ln -s /lib64/libstdc++.so.6 /lib64/libstdc++.so


	#cd /usr/lib
	#sudo ln -s ./i386-linux-gnu/crt*.o .

fi

#####################BUILD STARTS HERE#####################

###	get the packages required for building a toolchain	###
#"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild get headers 2>&1 | tee "${myBuildHome}"/logs/linux-deblob.get.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild get 2>&1 | tee "${myBuildHome}"/logs/binutils.get.log
#"${myBuildHome}"/myBuilds/mingw32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/mingw32.get.log
#"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild get first 2>&1 | tee "${myBuildHome}"/logs/gcc.get.log
#"${myBuildHome}"/myBuilds/glibc.myBuild get 2>&1 | tee "${myBuildHome}"/logs/glibc.get.log

##"${myBuildHome}"/myBuilds/musl.myBuild get 2>&1 | tee "${myBuildHome}"/logs/musl.get.log

#As we are building a cross sysroot first, we set target=host
#This is changed back again later when we build a candadian cross compiler.
export OLD_TARGET="$TARGET"
export TARGET="$HOST"



### JeOS toolchain starts here {

#use our symlink directory as path
export PATH="${NEW_PATH}"

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 2 | cut -c 1-5)" = "linux" ]; then
#the linux kernel headers are required for a linux toolchain
"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild extract headers 2>&1 | tee "${myBuildHome}"/logs/linux-deblob.extract.log
"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/linux-deblob.headers.build.log
"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/linux-deblob.headers.install.log
fi

"${myBuildHome}"/myBuilds/binutils/binutils.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/binutils.${TARGET}.extract.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild build 2>&1 | tee "${myBuildHome}"/logs/binutils.${TARGET}.build.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install 2>&1 | tee "${myBuildHome}"/logs/binutils.${TARGET}.install.log

#add the newly built binutils to path
export PATH="${NEW_PATH}:${SYSROOT}/usr/${TARGET}/bin:${SYSROOT}/mingw/${TARGET}/bin:${SYSROOT}/usr/bin"

#we build initial compiler, used for bootstrapping, this is needed when cross-compiling only, the if statement ensures this
#FOR linux
"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild extract first 2>&1 | tee "${myBuildHome}"/logs/gcc.${TARGET}.extract-first.log
"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild build first 2>&1 | tee "${myBuildHome}"/logs/gcc.${TARGET}.build-first.log
"${myBuildHome}"/myBuilds/gcc/gcccross.myBuild install first 2>&1 | tee "${myBuildHome}"/logs/gcc.${TARGET}.install-first.log

export PATH="${SYSROOT}/usr/${TARGET}/bin:${SYSROOT}/mingw/${TARGET}/bin:${SYSROOT}/usr/bin:${NEW_PATH}"

#as we have the initial cross compiler, and we are going to use it, we remove the symlinks used to build it
cd "${NEW_PATH}"
rm ./${BUILD}-gcc
rm ./${BUILD}-g++ #this is bad, but now a requirement unfortunately.
rm ./${BUILD}-as
rm ./${BUILD}-ar
rm ./${BUILD}-ranlib
rm ./${BUILD}-ld
rm ./${BUILD}-nm
rm ./gcc
rm ./g++ #this is bad, but now a requirement unfortunately.
rm ./as
rm ./ar
rm ./ranlib
rm ./ld
rm ./nm
cd "${myBuildHome}"

export PATH="${SYSROOT}${PREFIX}/${TARGET}/bin:${SYSROOT}/mingw/${TARGET}/bin:${NEW_PATH}"

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
#FOR gcc when building for linux target #we need two c libraries, one for the HOST and one for the TARGET
"${myBuildHome}"/myBuilds/glibc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc.${TARGET}.extract.log
"${myBuildHome}"/myBuilds/glibc.myBuild build 2>&1 | tee "${myBuildHome}"/logs/glibc.${TARGET}.build.log
fi

#remove the sysroot because it contains gcc
rm -rf "${SYSROOT}"

#reinstall linux kernel headers and binutils to the sysroot

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 2 | cut -c 1-5)" = "linux" ]; then
#the linux kernel headers are required for a linux toolchain
"${myBuildHome}"/myBuilds/linux-deblob/linux-deblob.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/linux-deblob.headers.install.log
fi

"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install 2>&1 | tee "${myBuildHome}"/logs/binutils.${TARGET}.install.log

#install glibc

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
"${myBuildHome}"/myBuilds/glibc.myBuild install 2>&1 | tee "${myBuildHome}"/logs/glibc.${TARGET}.install.log
fi

#get, extract, build and install busybox
"${myBuildHome}"/myBuilds/busybox/busybox.myBuild get 2>&1 | tee "${myBuildHome}"/logs/busybox.get.log
"${myBuildHome}"/myBuilds/busybox/busybox.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/busybox.extract.log
"${myBuildHome}"/myBuilds/busybox/busybox.myBuild build 2>&1 | tee "${myBuildHome}"/logs/busybox.build.log
"${myBuildHome}"/myBuilds/busybox/busybox.myBuild install 2>&1 | tee "${myBuildHome}"/logs/busybox.install.log

#we set this back to old path so we can add the following symlinks again
export PATH="${OLD_PATH}"


### } JeOS toolchain ends here

### Change this comment and put linux program myBuild (get,extract,build,install), [eg. clamav] between the curly braces here {

### } End of Change this comment and put linux program myBuild (get,extract,build,install), [eg. clamav] between the curly braces here

###	finally run ldconfig last so that the libraries get linked correctly	###
/sbin/ldconfig -v -r "${SYSROOT}"


