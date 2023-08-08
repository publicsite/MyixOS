#!/bin/sh

checkResultPrebuilt(){
#this function checks if the folder exists given the user input as argument 1

	if [ "$(find . -maxdepth 1 -type d -name "arch*" | cut -c 8- | while read line; do if [ "$1" = "$line" ]; then printf "yes\n"; fi; done)" = "yes" ]; then
		return 0
	else
		return 101
	fi
}

if [ "$2" = "buildCross" ]; then
	if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
	else
		export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${OLD_PATH}"
	fi
fi

cd "${myBuildHome}"

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 2 | cut -c 1-5)" = "linux" ]; then

	if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then

		cd "${myBuildHome}/headers-prebuilt/include"

		while true; do
			printf "\n\n==TYPE THE ARCHITECTURE==\n\n"

			find . -maxdepth 1 -type d -name "arch*" | cut -c 8-

			printf "generic\n"

			read theArch

			checkResultPrebuilt "$theArch"

			if [ "$?" = "0" ]; then
				break
			fi
		done

		find . -maxdepth 1 -type d | while read line; do

			if [ "$line" != "." ]; then
				if [ "$(printf "%s" "$line" | cut -c 1-7)" = "./arch-" ]; then
					if [ "$(printf "%s" "$line" | cut -c 8-)" = "$theArch" ]; then
						cp -a "${line}/"* "${SYSROOT}${PREFIX}/${TARGET}/include"
					fi
				else
					cp -a "$line" "${SYSROOT}${PREFIX}/${TARGET}/include"
				fi
			fi
		done

		cd "${myBuildHome}"
	else

		#we want the linux headers for the host if we are building a cross compiler
		if [ "$2" = "buildCross" ]; then
			export TARGET="${HOST}"
		fi

		#install linux headers for HOST
		"${myBuildHome}"/myBuilds/linux/linux.myBuild extract headers 2>&1 | tee "${myBuildHome}"/logs/linux."$2".extract.log

		if [ "$2" = "buildCross" ]; then
printf \
"\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n \
NOTE: It is important to type the BUILD architecture for the kernel here !!!\n \
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"
		else
printf \
"\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n \
NOTE: It is important to type the TARGET architecture for the kernel here !!!\n \
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"
		fi


		"${myBuildHome}"/myBuilds/linux/linux.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/linux.headers."$2".build.log
		"${myBuildHome}"/myBuilds/linux/linux.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/linux.headers."$2".install.log

		#because it's cross, we set target back to OLD_HOST
		if [ "$2" = "buildCross" ]; then
			export TARGET="${OLD_HOST}"
		#else
		#	"${myBuildHome}"/myBuilds/linux/linux.myBuild package headers 2>&1 | tee "${myBuildHome}"/logs/linux.headers."$2".package.log
		fi
	fi
fi


#build binutils
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild extract "$2" 2>&1 | tee "${myBuildHome}"/logs/binutils."${TARGET}"."$2".extract.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild build "$2" 2>&1 | tee "${myBuildHome}"/logs/binutils."${TARGET}"."$2".build.log
"${myBuildHome}"/myBuilds/binutils/binutils.myBuild install "$2" 2>&1 | tee "${myBuildHome}"/logs/binutils."${TARGET}"."$2".install.log

#if [ "$2" != "buildCross" ]; then
#"${myBuildHome}"/myBuilds/binutils/binutils.myBuild package "$2" 2>&1 | tee "${myBuildHome}"/logs/binutils."${TARGET}"."$2".package.log
#fi

#install the libc headers

if [ "$2" != "buildCross" ] && [ "${with_selinux}" = "true" ]; then

	#we build selinux, needed for GUI
	"${myBuildHome}/buildSELinux.sh" "$PWD" 2>&1


	if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		#build glibc with selinux
		"${myBuildHome}"/myBuilds/glibc/glibc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".extract.log

		"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".build.log
		"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".install.log

		"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build library 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".library."$2".build.log
		"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install library 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".library."$2".install.log
		#"${myBuildHome}"/myBuilds/glibc/glibc.myBuild package library 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".library."$2".package.log
	fi
fi

if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild extract headers 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".extract.log
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build headers 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".build.log
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install headers 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#if [ "$2" != "buildCross" ]; then
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package headers 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#fi
elif [ "$2" = "buildCross" ]; then
	old_with_selinux="${with_selinux}"
	export with_selinux="false"

	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".extract.log

	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".build.log
	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".headers."$2".install.log

	export with_selinux="${old_with_selinux}"

fi

if [ "$2" = "buildCross" ]; then
	#we build initial compiler, used for bootstrapping
	#FOR linux
	"${myBuildHome}"/myBuilds/gcc/gcc.myBuild extract first "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-first."${TARGET}"."$2".extract.log
	"${myBuildHome}"/myBuilds/gcc/gcc.myBuild build first "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-first."${TARGET}"."$2".build.log
	"${myBuildHome}"/myBuilds/gcc/gcc.myBuild install first "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-first."${TARGET}"."$2".install.log

	if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then

		#remove old configuration for HOST
		if [ -f "${myBuildExtractDest}/linux/theArch.config" ]; then
			rm "${myBuildExtractDest}/linux/theArch.config"
		fi
		if [ -f "${myBuildExtractDest}/linux/thedefconfig.config" ]; then
			rm "${myBuildExtractDest}/linux/thedefconfig.config"
		fi

		if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
			"${myBuildHome}"/myBuilds/linux/linux.myBuild extract headers 2>&1 | tee "${myBuildHome}"/logs/linux.kernel.build.log
		fi

printf \
"\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n \
NOTE: It is important to type the name of TARGET for the kernel here !!!\n \
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"


		#install linux headers for TARGET
		"${myBuildHome}"/myBuilds/linux/linux.myBuild build headers 2>&1 | tee "${myBuildHome}"/logs/linux.headers."$2".build.log
		"${myBuildHome}"/myBuilds/linux/linux.myBuild install headers 2>&1 | tee "${myBuildHome}"/logs/linux.headers."$2".install.log

	fi

		#we set this for building libc.
		if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
			export PATH="${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin:${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin"
		else
			export PATH="${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${OLD_PATH}"
		fi
fi

#if building for the mingw target, we build the runtime and libraries, otherwise we build glibc
if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" = "mingw32" ]; then
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild extract runtime 2>&1 | tee logs/mingw64."${TARGET}".runtime."$2".extract.log
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build runtime 2>&1 | tee logs/mingw64."${TARGET}".runtime."$2".build.log
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install runtime 2>&1 | tee logs/mingw64."${TARGET}".runtime."$2".install.log
	#if [ "$2" != "buildCross" ]; then
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package runtime 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#fi

	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build libraries 2>&1 | tee logs/mingw64."${TARGET}".libraries."$2".build.log
	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install libraries 2>&1 | tee logs/mingw64."${TARGET}".libraries."$2".install.log
	#if [ "$2" != "buildCross" ]; then
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package libraries 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#fi

	##build 32 bit mingw library for multilib support
	#if [ "$TARGET32" != "$TARGET" ]; then
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild extract headers m32 2>&1 | tee logs/mingw64."${TARGET32}".headers."$2".extract.log
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build headers m32 2>&1 | tee logs/mingw64."${TARGET32}".headers."$2".build.log
	#		"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install headers m32 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#	if [ "$2" != "buildCross" ]; then
	#		"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package headers m32 2>&1 | tee logs/mingw64."${TARGET}".headers."$2".install.log
	#	fi

	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild extract runtime m32 2>&1 | tee logs/mingw64."${TARGET32}".runtime."$2".extract.log
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build runtime m32 2>&1 | tee logs/mingw64."${TARGET32}".runtime."$2".build.log
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install runtime m32 2>&1 | tee logs/mingw64."${TARGET32}".runtime."$2".install.log
	#	if [ "$2" != "buildCross" ]; then
	#		"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package runtime m32 2>&1 | tee logs/mingw64."${TARGET32}".headers."$2".install.log
	#	fi

	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild build libraries m32 2>&1 | tee logs/mingw64."${TARGET32}".libraries."$2".build.log
	#	"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild install libraries m32 2>&1 | tee logs/mingw64."${TARGET32}".libraries."$2".install.log
	#	if [ "$2" != "buildCross" ]; then
	#		"${myBuildHome}"/myBuilds/mingw64/mingw64.myBuild package libraries m32 2>&1 | tee logs/mingw64."${TARGET32}".headers."$2".install.log
	#	fi
	#fi

elif [ "$2" = "buildCross" ] || [ "${with_selinux}" != "true" ]; then
	#we build glibc without selinux first

	old_with_selinux="${with_selinux}"
	export with_selinux="false"

	#FOR gcc when building for linux target #we need two c libraries, one for the HOST and one for the TARGET
	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build library 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".library."$2".build.log
	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install library 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET}".library."$2".install.log

	##build 32 bit glibc library for multilib support
	#if [ "$TARGET32" != "$TARGET" ]; then
	
	#	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET32}".headers."$2".extract.log

	#	#FOR gcc when building for linux target #we need two c libraries, one for the HOST and one for the TARGET
	#	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build headers m32 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET32}".headers."$2".build.log
	#	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install headers m32 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET32}".headers."$2".install.log

	#	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild build library m32 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET32}".library."$2".build.log
	#	"${myBuildHome}"/myBuilds/glibc/glibc.myBuild install library m32 2>&1 | tee "${myBuildHome}"/logs/glibc."${TARGET32}".library."$2".install.log

	#fi

	export with_selinux="${old_with_selinux}"

fi

if [ "$2" = "buildCross" ]; then
	#we set this back for building the cross compiler final.
	if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
		export PATH="${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
	else
		export PATH="${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin"
	fi
fi

#then we build the proper cross compiler
#FOR linux
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild extract second "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-second."${TARGET}"."$2".extract.log
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild build second "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-second."${TARGET}"."$2".build.log
"${myBuildHome}"/myBuilds/gcc/gcc.myBuild install second "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-second."${TARGET}"."$2".install.log

#if [ "$2" != "buildCross" ]; then
#"${myBuildHome}"/myBuilds/gcc/gcc.myBuild package second "$2" 2>&1 | tee "${myBuildHome}"/logs/gcc-second."${TARGET}"."$2".package.log
#fi

#we set this for building tools for HOST
if [ "$(printf "%s\n" "${BUILD}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	export PATH="${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin:${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/bin:${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin:${TEMP_SYSROOT}/build_tools/bin:${TEMP_SYSROOT}/build_tools/usr/bin"
else
	export PATH="${TEMP_SYSROOT}${PREFIX}/${TARGET}/bin;${TEMP_SYSROOT}${PREFIX}/${TARGET}/usr/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/bin;${TEMP_SYSROOT}${PREFIX}/${HOST}/usr/bin;${TEMP_SYSROOT}/build_tools/bin;${TEMP_SYSROOT}/build_tools/usr/bin;${OLD_PATH}"
fi

#we build zlib for the target, this is required, on the host, for building a native elfutils and gcc for the target
if [ "$(printf "%s\n" "${TARGET}" | cut -d "-" -f 3 | cut -c 1-7)" != "mingw32" ]; then
	#FOR elfutils
	"${myBuildHome}"/myBuilds/zlib/zlib.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/zlib-"${TARGET}"."$2".extract.log
	"${myBuildHome}"/myBuilds/zlib/zlib.myBuild build 2>&1 | tee "${myBuildHome}"/logs/zlib-"${TARGET}"."$2".build.log
	if [ "$2" = "buildCross" ]; then
		"${myBuildHome}"/myBuilds/zlib/zlib.myBuild install 2>&1 | tee "${myBuildHome}"/logs/zlib-"${TARGET}"."$2".install.log
	else
		export SYSROOT="${OLD_SYSROOT}"
		"${myBuildHome}"/myBuilds/zlib/zlib.myBuild install 2>&1 | tee "${myBuildHome}"/logs/zlib-"${TARGET}"."$2".install.log
		#"${myBuildHome}"/myBuilds/zlib/zlib.myBuild package 2>&1 | tee "${myBuildHome}"/logs/zlib-"${TARGET}"."$2".package.log
		export SYSROOT="${TEMP_SYSROOT}"
	fi
else
	#FOR elfutils
	"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".extract.log
	"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild build 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".build.log
	"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".install.log
	if [ "$2" = "buildCross" ]; then
		"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".install.log
	else
		export SYSROOT="${OLD_SYSROOT}"
		"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild install 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".install.log
		#"${myBuildHome}"/myBuilds/zlib-w32/zlib-w32.myBuild package 2>&1 | tee "${myBuildHome}"/logs/zlib-w32-"${TARGET}"."$2".package.log
		export SYSROOT="${TEMP_SYSROOT}"
	fi
fi