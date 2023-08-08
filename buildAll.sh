#!/bin/sh

export J="-j1"

#set to false if you are not using wayland, or don't want selinux or a GUI
export with_selinux="true"

export BITS='64'
export ARCH='x86' #the architecture of the toolchain we're compiling from

export BUILD="x86_64-linux-gnu" #the system we're compiling from
export HOST="x86_64-linux-gnu" #the system that we will run the toolchain on
#export HOST="arm-linux-gnueabihf" #the system that we will run the toolchain on
export TARGET="x86_64-linux-gnu" #the toolchain we're creating
#export TARGET="arm-linux-gnueabihf" #the toolchain we're creating
#export TARGET="i686-w64-mingw32" #the toolchain we're creating
export TARGET32="i686-linux-gnu"

if [ "$TARGET32" = "" ]; then
	export TARGET32="$TARGET"
fi

export PREFIX='/usr' #the location to install to

if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ] || \
[ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ] ; then
	export MYIXOS_LINK="ln"
else
	export MYIXOS_LINK="ln -s"
fi

export myBuildHome="$1"

export myBuildHelpersDir="${myBuildHome}/helpers"
export myBuildSourceDest="${myBuildHome}/sourcedest"
export myBuildExtractDest="${myBuildHome}/extractdest"

mkdir "$myBuildSourceDest"
mkdir "$myBuildExtractDest"
mkdir "${myBuildHome}/logs"

export PKGDIR="${myBuildHome}/packages"
mkdir -p "${PKGDIR}"

export BUILDDIR="${myBuildHome}/tmp"
export CONTDIR="${BUILDDIR}/control" #the root dir
mkdir -p "${CONTDIR}"

#Create a tempsysroot dir
export TEMP_SYSROOT="${myBuildHome}"/tempsysroot
export SYSROOT="${TEMP_SYSROOT}"
#Create the cross rootfs
"${myBuildHome}"/myBuilds/myixos-rootfs-skel/myixos-rootfs-skel.myBuild build 2>&1 | tee "${myBuildHome}"/logs/myixos-rootfs-skel.native.build.log

#Then set sysroot as the target rootfs
export SYSROOT="${BUILDDIR}/data" #the root dir
mkdir -p "${SYSROOT}"

#this would be for binutils search paths, but i am playing my luck to see if i can go without it
#ld --verbose | grep SEARCH_DIR | tr -s ' ;' \\012

if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
	if [ "$(printf "%s\n" "$myBuildHome" | grep " ")" != "" ]; then
		printf "You must build using a directory without spaces!\n"
		exit 1
	fi
	if [ "$(printf "%s\n" "$myBuildHome" | cut -c 1-2)" != "C:" ] && [ "$(printf "%s\n" "$myBuildHome" | cut -c 1-2)" != "Z:" ]; then
		printf "You must build from the C: drive in Windoze or Z: drive in Wine/Linux!\n"
		exit 1
	fi
	myBuildHome="$(printf "%s\n" "$myBuildHome" | cut -c 3-)"
fi

if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#make /dev/zero and /dev/null on the host if it doesn't exist
	if [ "$(ls -l /dev/null | cut -c 1-1)" != "c" ]; then
			mknod -m 666 /dev/null c 1 3
			mknod -m 666 /dev/zero c 1 5
			chown root:root /dev/null /dev/zero
	fi
fi

export OLD_PATH="$PATH"

###THIS BLOCK CREATES SYMLINKS FOR TEMP_SYSROOT {

#if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
#	mkdir -p "${TEMP_SYSROOT}/mingw/${TARGET}"
#	#$MYIXOS_LINK "../mingw/${TARGET}" "${TEMP_SYSROOT}/usr"
#fi

cd ${myBuildHome}

#if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
#	$MYIXOS_LINK "../lib" "${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/"
#	$MYIXOS_LINK "../etc" "${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/"
#	$MYIXOS_LINK "../sbin" "${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/"
#	$MYIXOS_LINK "../include" "${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/"
#fi

###}

#WE ADD MORE SYMLINKS TO THE BUILD'S TOOLS IN TEMP_SYSROOT
mkdir -p "${TEMP_SYSROOT}/build_tools/bin"
cd "${TEMP_SYSROOT}/build_tools/bin"

for tolink in chown gunzip readlink less which tee rm mkdir cut expr sed make ln patch tar unzip gzip ls cat gawk bison \
grep sort chmod awk tr mv cp rmdir cmp touch dirname fgrep basename bzip2 echo arch uname \
test head printf mktemp sh autoconf autoheader automake aclocal false egrep print xset \
pwd hostname sleep uniq diff od env true find tail date flex xargs xz wget sha512sum \
msgfmt install expand pod2man pod2text pod2html whoami makeinfo m4 locale comm wc bc autopoint perl autoreconf rsync; do
#comm wc and bc are for uboot
#autopoint is for gnulib
#rsync is for installing linux headers
	#make symlink
	if [ "$(which "$tolink")" != "" ] && [ "$(which "$tolink")" != "$tolink" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			ln -s "$(which "$tolink")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "$tolink")" "${tolink}"
		fi
	elif [ "$(which "${tolink}.exe")" != "" ] && [ "$(which "${tolink}.exe")" != "${tolink}.exe" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			ln -s "$(which "${tolink}.exe")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "${tolink}.exe")" "${tolink}"
		fi
	fi

done


if ! [ -d "/usr/bin" ]; then
	mkdir -p "/usr/bin"
fi

cd /usr/bin

for tolink in makeinfo m4 perl; do
	if ! [ -f "/usr/bin/${tolink}" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then

			ln -s "$(which "$tolink")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "$tolink")" "${tolink}"
		fi
	elif ! [ -f "/usr/bin/${tolink}.exe" ] && ! [ -f "/usr/bin/${tolink}" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			ln -s "$(which "${tolink}.exe")" "${tolink}"
		else
			$MYIXOS_LINK "$(which "${tolink}.exe")" "${tolink}"
		fi
	fi
done

#set environment variables that some programs need to build
#these programs have to reside in said places unfortunately, because they are copied into runtime paths
export MAKEINFO="$(which makeinfo)"
export M4="$(which m4)"
export PERL="$(which perl)"
export SHELL="${TEMP_SYSROOT}/build_tools/bin/sh"
export CONFIG_SHELL="${TEMP_SYSROOT}/build_tools/bin/sh"
export SED="${TEMP_SYSROOT}/build_tools/bin/sed"
export GREP="${TEMP_SYSROOT}/build_tools/bin/grep"

#export CC="${HOST}-gcc"
#export AR="${HOST}-ar"
#export AS="${HOST}-as"
#export LD="${HOST}-ld"
#export RANLIB="${HOST}-ranlib"
#export OBJCOPY="${HOST}-objcopy"
#export OBJDUMP="${HOST}-objdump"
#export READELF="${HOST}-readelf"
#export STRIP="${HOST}-strip"
#export NM="${HOST}-nm"
##export CPP="$(which cpp)"

cd "${TEMP_SYSROOT}/build_tools/bin"

#add symlink to python3 for glibc
if [ "$(which python3)" != "" ] && [ "$(which python3)" != "python3" ]; then
	if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		$MYIXOS_LINK "$(which python3)"
	else
		$MYIXOS_LINK "$(which python3)"
	fi
elif [ "$(which python3.exe)" != "" ] && [ "$(which python3.exe)" != "python3.exe" ]; then
	if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		$MYIXOS_LINK "$(which python3.exe)"
	else
		$MYIXOS_LINK "$(which python3.exe)"
	fi
fi

##if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
##	if [ "$(which sh.exe)" != "" ] && [ "$(which sh.exe)" != "$tolink" ]; then
##		$MYIXOS_LINK "$(which sh.exe)"
##	fi
##fi

cd "${myBuildHome}"

###	hacks for debian	###
if [ -f "/etc/debian_version" ]; then
	printf "You are using Debian, we may need your password to make some symlinks ...\n"

	if ! [ -f "/lib/ld.so" ]; then
		sudo $MYIXOS_LINK /lib/ld-linux.so.2 /lib/ld.so
	fi

	#fix debian not finding libwine
	if ! [ -f "/usr/lib/libwine.so" ]; then
		export wineDir="$(printf "%s\n" "/usr/lib/"*"/wine/")"
		sudo ln "${wineDir}/libwine.so.1.0" /usr/lib/libwine.so
		#printf "$wineDir\n" | sudo tee /etc/ld.so.conf.d/libwine.conf
		#sudo ldconfig
	fi

	if ! [ -e "/usr/${BUILD}/usr/lib" ]; then
		sudo mkdir /usr/${BUILD}/usr
		sudo $MYIXOS_LINK /usr/${BUILD}/lib /usr/${BUILD}/usr/lib
	fi

	printf "Thanks, no more password needed.\n"
fi

#####################BUILD STARTS HERE#####################

###	get the packages required for building a toolchain	###
#"${myBuildHome}"/myBuilds/linux/linux.myBuild get headers 2>&1 | tee "${myBuildHome}"/logs/linux.get.log
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild get 2>&1 | tee "${myBuildHome}"/logs/binutils.get.log
#"${myBuildHome}"/myBuilds/mingw32/mingw32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/mingw32.get.log
#"${myBuildHome}"/myBuilds/gcc/gcc.myBuild get first 2>&1 | tee "${myBuildHome}"/logs/gcc.get.log
#"${myBuildHome}"/myBuilds/glibc/glibc.myBuild get 2>&1 | tee "${myBuildHome}"/logs/glibc.get.log
#"${myBuildHome}"/myBuilds/zlib/zlib.myBuild get 2>&1 | tee "${myBuildHome}"/logs/zlib.get.log

##"${myBuildHome}"/myBuilds/musl/musl.myBuild get 2>&1 | tee "${myBuildHome}"/logs/musl.get.log

#and we set SYSROOT AS TEMP_SYSROOT TO BUILD THE FIRST TOOLCHAIN
export OLD_SYSROOT="${SYSROOT}"
export SYSROOT="${TEMP_SYSROOT}"

if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then

	#add symlinks in tempsysroot, linking to HOST toolchain
	cd "${TEMP_SYSROOT}/build_tools/bin"
	ln -s "$(which ${BUILD}-gcc)" gcc
	ln -s "$(which ${BUILD}-gcc)" cc
	ln -s "$(which ${BUILD}-g++)" g++ #this is bad, but now a requirement unfortunately.
	ln -s "$(which ${BUILD}-as)" as
	ln -s "$(which ${BUILD}-ar)" ar
	ln -s "$(which ${BUILD}-ranlib)" ranlib
	ln -s "$(which ${BUILD}-ld)" ld
	ln -s "$(which ${BUILD}-nm)" nm
	ln -s "$(which ${BUILD}-windres)" windres
	ln -s "$(which ${BUILD}-ld.bfd)" ld.bfd
	ln -s "$(which ${BUILD}-objcopy)" objcopy
	ln -s "$(which ${BUILD}-objdump)" objdump
	ln -s "$(which ${BUILD}-readelf)" readelf
	ln -s "$(which ${BUILD}-strip)" strip

	#add symlinks in tempsysroot, linking to HOST toolchain

	mkdir -p "${TEMP_SYSROOT}/build_tools/usr/bin"
	cd "${TEMP_SYSROOT}/build_tools/usr/bin"
	ln -s "$(which ${BUILD}-gcc)"
	ln -s "$(which ${BUILD}-g++)" #this is bad, but now a requirement unfortunately.
	ln -s "$(which ${BUILD}-as)"
	ln -s "$(which ${BUILD}-ar)"
	ln -s "$(which ${BUILD}-ranlib)"
	ln -s "$(which ${BUILD}-ld)"
	ln -s "$(which ${BUILD}-nm)"
	ln -s "$(which ${BUILD}-windres)"
	ln -s "$(which ${BUILD}-ld.bfd)"
	ln -s "$(which ${BUILD}-objcopy)"
	ln -s "$(which ${BUILD}-objdump)"
	ln -s "$(which ${BUILD}-readelf)"
	ln -s "$(which ${BUILD}-strip)"

	if [ "$(which ${BUILD}-cpp)" = "" ]; then
		$MYIXOS_LINK "$(which cpp)" "${BUILD}-cpp"
	else
		$MYIXOS_LINK "$(which ${BUILD}-cpp)"
	fi

else
	cd "${TEMP_SYSROOT}/build_tools/bin"

	$MYIXOS_LINK "$(which ${BUILD}-gcc)" gcc
	$MYIXOS_LINK "$(which ${BUILD}-gcc)" cc
	$MYIXOS_LINK "$(which ${BUILD}-g++)" g++ #this is bad, but now a requirement unfortunately.
	$MYIXOS_LINK "$(which ${BUILD}-as)" as
	$MYIXOS_LINK "$(which ${BUILD}-ar)" ar
	$MYIXOS_LINK "$(which ${BUILD}-ranlib)" ranlib
	$MYIXOS_LINK "$(which ${BUILD}-ld)" ld
	$MYIXOS_LINK "$(which ${BUILD}-nm)" nm
	$MYIXOS_LINK "$(which ${BUILD}-windres)" windres
	$MYIXOS_LINK "$(which ${BUILD}-ld.bfd)" ld.bfd
	$MYIXOS_LINK "$(which ${BUILD}-objcopy)" objcopy
	$MYIXOS_LINK "$(which ${BUILD}-objdump)" objdump
	$MYIXOS_LINK "$(which ${BUILD}-readelf)" readelf
	$MYIXOS_LINK "$(which ${BUILD}-strip)" strip

	mkdir -p "${TEMP_SYSROOT}/build_tools/usr/bin"
	cd "${TEMP_SYSROOT}/build_tools/usr/bin"
	$MYIXOS_LINK "$(which ${BUILD}-gcc)"
	$MYIXOS_LINK "$(which ${BUILD}-g++)" #this is bad, but now a requirement unfortunately.
	$MYIXOS_LINK "$(which ${BUILD}-as)"
	$MYIXOS_LINK "$(which ${BUILD}-ar)"
	$MYIXOS_LINK "$(which ${BUILD}-ranlib)"
	$MYIXOS_LINK "$(which ${BUILD}-ld)"
	$MYIXOS_LINK "$(which ${BUILD}-nm)"
	$MYIXOS_LINK "$(which ${BUILD}-windres)"
	$MYIXOS_LINK "$(which ${BUILD}-ld.bfd)"
	$MYIXOS_LINK "$(which ${BUILD}-objcopy)"
	$MYIXOS_LINK "$(which ${BUILD}-objdump)"
	$MYIXOS_LINK "$(which ${BUILD}-readelf)"
	$MYIXOS_LINK "$(which ${BUILD}-strip)"

	if [ "$(which ${BUILD}-cpp)" = "" ]; then
		$MYIXOS_LINK "$(which cpp)" "${BUILD}-cpp"
	else
		$MYIXOS_LINK "$(which ${BUILD}-cpp)"
	fi
fi

cd "${myBuildHome}"

export OLD_HOST="$HOST"
export HOST="$BUILD"
export OLD_TARGET="$TARGET"
export TARGET="$BUILD"

#export CC="${HOST}-gcc"
#export AR="${HOST}-ar"
#export AS="${HOST}-as"
#export LD="${HOST}-ld"
#export RANLIB="${HOST}-ranlib"
#export OBJCOPY="${HOST}-objcopy"
#export OBJDUMP="${HOST}-objdump"
#export READELF="${HOST}-readelf"
#export STRIP="${HOST}-strip"
#export NM="${HOST}-nm"

##if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
##	printf "!#bin/sh\nrealpath \$@ | cut -c 3-\n" > "${TEMP_SYSROOT}/build_tools/bin/fakepath"
##	chmod +x "${TEMP_SYSROOT}/build_tools/bin/fakepath"
##	printf "!#bin/sh\npwd \$@ | cut -c 3-\n" > "${TEMP_SYSROOT}/build_tools/bin/fakepwd"
##	chmod +x "${TEMP_SYSROOT}/build_tools/bin/fakepwd"
##fi

if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
	##export PATH="$(echo "C:${TEMP_SYSROOT}/build_tools/bin/;C:${TEMP_SYSROOT}/build_tools/usr/bin;C:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;C:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;C:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;C:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}" | sed "s#/#\\\#g" )"

	export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"

	if ! [ -f "/usr/bin/perl" ]; then
		#"${myBuildHome}"/myBuilds/perl-w32/perl-w32.myBuild get 2>&1 | tee "${myBuildHome}"/logs/perl-w32.get.log
		"${myBuildHome}"/myBuilds/perl-w32/perl-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/perl-w32.extract.log
		"${myBuildHome}"/myBuilds/perl-w32/perl-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/perl-w32.build.log
		"${myBuildHome}"/myBuilds/perl-w32/perl-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/perl-w32.install.log
	fi

	cd /usr/bin

	if [ "$(which perl)" != "" ] && [ "$(which perl)" != "perl" ]; then
		$MYIXOS_LINK "$(which perl)" "perl"
	elif [ "$(which perl.exe)" != "" ] && [ "$(which perl.exe)" != "perl.exe" ]; then
		$MYIXOS_LINK "$(which make.exe)" "gmake.exe"
	fi

	texinfoLibA="$(realpath "$(dirname "$(which i686-w64-mingw32-gcc)")/../lib/texinfo")"
	texinfoLibB="$(realpath "$(dirname "$(which i686-w64-mingw32-gcc)")/../share/texinfo")"
	texinfoLibC="$(realpath "$(dirname "$(which i686-w64-mingw32-gcc)")/../share/texinfo/lib/Text-Unidecode/lib")"
	texinfoLibD="$(realpath "$(dirname "$(which i686-w64-mingw32-gcc)")/../share/texinfo/lib/Unicode-EastAsianWidth/lib")"
	texinfoLibE="$(realpath "$(dirname "$(which i686-w64-mingw32-gcc)")/../share/texinfo/lib/libintl-perl/lib")"
	export PERLLIB="$(printf "%s;%s;%s;%s;%s" "${texinfoLibA}" "${texinfoLibB}" "${texinfoLibC}" "${texinfoLibD}" "${texinfoLibE}" | sed "s#/#\\\#g")"
	cd "${myBuildHome}"

	export PATH="$OLD_PATH"
fi


if [ "$(printf "%s" "${OLD_TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then

	#create headers-prebuilt, because windoze has problems compiling the linux headers
	if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
	else
		export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
	fi

	mkdir -p "${OLD_SYSROOT}/root/myBuildBootstrap/headers-prebuilt"
	export SYSROOT="${OLD_SYSROOT}/root/myBuildBootstrap/headers-prebuilt"
	"${myBuildHome}"/myBuilds/linux/linux.myBuild extract headers_all 2>&1 | tee "${myBuildHome}"/logs/linux.extract.log
	"${myBuildHome}"/myBuilds/linux/linux.myBuild build headers_all 2>&1 | tee "${myBuildHome}"/logs/linux.headers.build.log
	"${myBuildHome}"/myBuilds/linux/linux.myBuild install headers_all 2>&1 | tee "${myBuildHome}"/logs/linux.headers.install.log
	export SYSROOT="${TEMP_SYSROOT}"

	export PATH="$OLD_PATH"

	#build join command if we don't have it
	if [ "$(which join)" = "" ]; then

		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
		else
			export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
		fi

		if [ "$(which join)" = "" ]; then
			${BUILD}-gcc "${myBuildHome}"/myBuilds/join/join.c -o ${TEMP_SYSROOT}/build_tools/bin/join
		fi
		export PATH="$OLD_PATH"
	else
		cd "${TEMP_SYSROOT}/build_tools/bin"
		ln -s "$(which join)"
		cd "${myBuildHome}"
	fi

	#build gperf command if we don't have it
	if [ "$(which gperf)" = "" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
		else
			export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
		fi
		if [ "$(which gperf)" = "" ]; then
			#"${myBuildHome}"/myBuilds/gperf/gperf.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gperf.get.log
			"${myBuildHome}"/myBuilds/gperf/gperf.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gperf.extract.log
			"${myBuildHome}"/myBuilds/gperf/gperf.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gperf.build.log
			"${myBuildHome}"/myBuilds/gperf/gperf.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gperf.install.log
		fi
		export PATH="$OLD_PATH"
	else
		cd "${TEMP_SYSROOT}/build_tools/bin"
		ln -s "$(which gperf)"
		cd "${myBuildHome}"
	fi

	if [ "$(which libtoolize)" = "" ]; then
		if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
		else
			export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
		fi
		if [ "$(which libtoolize)" = "" ]; then
			#"${myBuildHome}"/myBuilds/libtool/libtool.myBuild get datadirsysroot 2>&1 | tee "${myBuildHome}"/logs/libtool.get.log
			"${myBuildHome}"/myBuilds/libtool/libtool.myBuild extract datadirsysroot 2>&1 | tee "${myBuildHome}"/logs/libtool.extract.log
			"${myBuildHome}"/myBuilds/libtool/libtool.myBuild build datadirsysroot 2>&1 | tee "${myBuildHome}"/logs/libtool.build.log
			"${myBuildHome}"/myBuilds/libtool/libtool.myBuild install datadirsysroot 2>&1 | tee "${myBuildHome}"/logs/libtool.install.log
		fi
		export PATH="$OLD_PATH"
	else
		cd "${TEMP_SYSROOT}/build_tools/bin"
		ln -s "$(which libtoolize)"
		cd "${myBuildHome}"
	fi

	if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
	else
		export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
	fi
	#build a native version of ncurses (for building texinfo) and wine (for building perl and python)
	#"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild get 2>&1 | tee "${myBuildHome}"/logs/ncurses.${TARGET}.get.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/ncurses.${TARGET}.extract.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild build 2>&1 | tee "${myBuildHome}"/logs/ncurses.${TARGET}.build.log
	"${myBuildHome}"/myBuilds/ncurses/ncurses.myBuild install 2>&1 | tee "${myBuildHome}"/logs/ncurses.${TARGET}.install.log
	
##	#"${myBuildHome}"/myBuilds/wine/wine.myBuild get without-x 2>&1 | tee "${myBuildHome}"/logs/wine.get.log
##	"${myBuildHome}"/myBuilds/wine/wine.myBuild extract without-x 2>&1 | tee "${myBuildHome}"/logs/wine.extract.log
##	"${myBuildHome}"/myBuilds/wine/wine.myBuild build without-x 2>&1 | tee "${myBuildHome}"/logs/wine.build.log
##	"${myBuildHome}"/myBuilds/wine/wine.myBuild install without-x 2>&1 | tee "${myBuildHome}"/logs/wine.install.log

fi

#compile libubox for opkg

#create headers-prebuilt, because windoze has problems compiling the linux headers
if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
else
	export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
fi

##"${myBuildHome}"/myBuilds/libubox/libubox.myBuild get forbuild 2>&1 | tee "${myBuildHome}"/logs/libubox.extract.log
##"${myBuildHome}"/myBuilds/libubox/libubox.myBuild extract forbuild 2>&1 | tee "${myBuildHome}"/logs/libubox.extract.log
##"${myBuildHome}"/myBuilds/libubox/libubox.myBuild build forbuild 2>&1 | tee "${myBuildHome}"/logs/libubox.build.log
##"${myBuildHome}"/myBuilds/libubox/libubox.myBuild install forbuild 2>&1 | tee "${myBuildHome}"/logs/libubox.install.log

##"${myBuildHome}"/myBuilds/opkg/opkg.myBuild get 2>&1 | tee "${myBuildHome}"/logs/opkg.extract.log
##"${myBuildHome}"/myBuilds/opkg/opkg.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/opkg.extract.log
##"${myBuildHome}"/myBuilds/opkg/opkg.myBuild build 2>&1 | tee "${myBuildHome}"/logs/opkg.headers.build.log
##"${myBuildHome}"/myBuilds/opkg/opkg.myBuild install 2>&1 | tee "${myBuildHome}"/logs/opkg.headers.install.log

export PATH="$OLD_PATH"


export HOST="$OLD_HOST"
export TARGET="$OLD_TARGET"


export OLD_TARGET="${TARGET}"
export TARGET="${HOST}"
export OLD_HOST="${HOST}"
export HOST="${BUILD}"
OLD_TARGET32=$TARGET32

#export CC="${HOST}-gcc"
#export AR="${HOST}-ar"
#export AS="${HOST}-as"
#export LD="${HOST}-ld"
#export RANLIB="${HOST}-ranlib"
#export OBJCOPY="${HOST}-objcopy"
#export OBJDUMP="${HOST}-objdump"
#export READELF="${HOST}-readelf"
#export STRIP="${HOST}-strip"
#export NM="${HOST}-nm"

#here##	compile our cross toolchain for building	###
"${myBuildHome}/buildToolchain.sh" "$PWD" "buildCross" 2>&1

#build gnu-efi for efilinux (for our host)
#"${myBuildHome}"/myBuilds/gnu-efi/gnu-efi.myBuild get 2>&1 | tee "${myBuildHome}"/logs/gnu-efi.get.log
"${myBuildHome}"/myBuilds/gnu-efi/gnu-efi.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/gnu-efi.extract.log
"${myBuildHome}"/myBuilds/gnu-efi/gnu-efi.myBuild build 2>&1 | tee "${myBuildHome}"/logs/gnu-efi.build.log
"${myBuildHome}"/myBuilds/gnu-efi/gnu-efi.myBuild install 2>&1 | tee "${myBuildHome}"/logs/gnu-efi.install.log

if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "x86_64" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i386" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i486" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i586" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i686" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "amd64" ]; then
	#build nasm for syslinux
#	"${myBuildHome}"/myBuilds/nasm/nasm.myBuild get 2>&1 | tee "${myBuildHome}"/logs/nasm.get.log
	"${myBuildHome}"/myBuilds/nasm/nasm.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/nasm.extract.log
	"${myBuildHome}"/myBuilds/nasm/nasm.myBuild build 2>&1 | tee "${myBuildHome}"/logs/nasm.build.log
	"${myBuildHome}"/myBuilds/nasm/nasm.myBuild install 2>&1 | tee "${myBuildHome}"/logs/nasm.install.log
fi

if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "x86_64" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i386" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i486" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i586" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i686" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "amd64" ]; then
#	"${myBuildHome}"/myBuilds/xorriso/xorriso.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xorriso.get.log
	"${myBuildHome}"/myBuilds/xorriso/xorriso.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xorriso.extract.log
	"${myBuildHome}"/myBuilds/xorriso/xorriso.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xorriso.build.log
	"${myBuildHome}"/myBuilds/xorriso/xorriso.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xorriso.install.log
fi

export TARGET="${OLD_TARGET}"
export TARGET32="${OLD_TARGET32}"

#export CC="${HOST}-gcc"
#export AR="${HOST}-ar"
#export AS="${HOST}-as"
#export LD="${HOST}-ld"
#export RANLIB="${HOST}-ranlib"
#export OBJCOPY="${HOST}-objcopy"
#export OBJDUMP="${HOST}-objdump"
#export READELF="${HOST}-readelf"
#export STRIP="${HOST}-strip"
#export NM="${HOST}-nm"

export SYSROOT="${OLD_SYSROOT}"
if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}/build_tools/usr/bin"
else
	export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${OLD_PATH}"
fi

##export CPP="${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin/${TARGET}-cpp"

##	build the skel rootfs			###
"${myBuildHome}"/myBuilds/myixos-rootfs-skel/myixos-rootfs-skel.myBuild build 2>&1 | tee "${myBuildHome}"/logs/myixos-rootfs-skel.native.build.log

###	cross compile our native toolchain	###
"${myBuildHome}/buildToolchain.sh" "$PWD" "buildNative" 2>&1

###	build base packages	###
"${myBuildHome}/buildBase.sh" "$PWD" 2>&1

#"${myBuildHome}"/myBuilds/linux/linux.myBuild get kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.get.log
"${myBuildHome}"/myBuilds/linux/linux.myBuild extract kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.build.log
"${myBuildHome}"/myBuilds/linux/linux.myBuild build kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.build.log
"${myBuildHome}"/myBuilds/linux/linux.myBuild install kernel 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.install.log

#build efi-linux for our bootloader
#"${myBuildHome}"/myBuilds/efilinux/efilinux.myBuild get 2>&1 | tee "${myBuildHome}"/logs/efilinux.get.log
"${myBuildHome}"/myBuilds/efilinux/efilinux.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/efilinux.extract.log
"${myBuildHome}"/myBuilds/efilinux/efilinux.myBuild build 2>&1 | tee "${myBuildHome}"/logs/efilinux.build.log

if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "x86_64" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i386" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i486" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i586" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "i686" ] || [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 1)" = "amd64" ]; then
	#build syslinux
	#"${myBuildHome}"/myBuilds/syslinux/syslinux.myBuild get 2>&1 | tee "${myBuildHome}"/logs/syslinux.get.log
	"${myBuildHome}"/myBuilds/syslinux/syslinux.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/syslinux.extract.log
	"${myBuildHome}"/myBuilds/syslinux/syslinux.myBuild build 2>&1 | tee "${myBuildHome}"/logs/syslinux.build.log
	"${myBuildHome}"/myBuilds/syslinux/syslinux.myBuild install 2>&1 | tee "${myBuildHome}"/logs/syslinux.install.log
fi

#"${myBuildHome}"/myBuilds/tzdata/tzdata.myBuild get 2>&1 | tee "${myBuildHome}"/logs/tzdata.get.log
"${myBuildHome}"/myBuilds/tzdata/tzdata.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/tzdata.extract.log
"${myBuildHome}"/myBuilds/tzdata/tzdata.myBuild build 2>&1 | tee "${myBuildHome}"/logs/tzdata.build.log
"${myBuildHome}"/myBuilds/tzdata/tzdata.myBuild install 2>&1 | tee "${myBuildHome}"/logs/tzdata.build.log





export HOST="x86_64-w64-mingw32" #the system that we will run the toolchain on
export TARGET="x86_64-w64-mingw32" #the toolchain we're creating
export TARGET32="i686-w64-mingw32"

#native mingw toolchain
#"${myBuildHome}/buildToolchain.sh" "$PWD" "buildNative" 2>&1

###	build mingw base packages	###
#"${myBuildHome}/buildBase.sh" "$PWD" 2>&1

export HOST="${OLD_HOST}"
export TARGET="${OLD_TARGET}"
export TARGET32="${OLD_TARGET32}"



if [ "$(printf "%s" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin:${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin"
else
	export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/bin;${TEMP_SYSROOT}${PREFIX}/${BUILD}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${OLD_PATH}"
fi

if [ "$(printf "%s" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	##"${myBuildHome}"/myBuilds/myixos-rootfs-skel/myixos-rootfs-skel.myBuild build 2>&1 | tee "${myBuildHome}"/logs/uboot.build.log
	##"${myBuildHome}"/myBuilds/myixos-rootfs-skel/myixos-rootfs-skel.myBuild package 2>&1 | tee "${myBuildHome}"/logs/uboot.package.log

	###	build bootloader	###
	"${myBuildHome}"/myBuilds/u-boot/u-boot.myBuild get 2>&1 | tee "${myBuildHome}"/logs/uboot.get.log
	"${myBuildHome}"/myBuilds/u-boot/u-boot.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/uboot.extract.log
	"${myBuildHome}"/myBuilds/u-boot/u-boot.myBuild build 2>&1 | tee "${myBuildHome}"/logs/uboot.build.log
	"${myBuildHome}"/myBuilds/u-boot/u-boot.myBuild install 2>&1 | tee "${myBuildHome}"/logs/uboot.install.log
fi

##	copy sources to build directory in /root/myBuildBootstrap	###
"${myBuildHome}"/myBuilds/copymybuild/copymybuild.myBuild install 2>&1 | tee "${myBuildHome}"/logs/copyMyBuild.install.log









### build wayland - selinux is required for this (gudev is required) ###
#"${myBuildHome}/buildWayland.sh" "$PWD" 2>&1




###	build xorg	###
#"${myBuildHome}/buildXOrg.sh" "$PWD" 2>&1

###	build lindows	###
#"${myBuildHome}/buildLindows.sh" "$PWD" 2>&1

##this is a test block to see if the compiler produces windows executables, you can delete upon success
##cd "$myBuildHome"
##${TARGET}-gcc helloworld.c -o wibble



###	finally run ldconfig last so that the libraries get linked correctly	###
#/sbin/ldconfig -v -r "${SYSROOT}"

#~/playGeorge.sh


