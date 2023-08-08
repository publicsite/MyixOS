#!/bin/sh
#argv1	the file to extract
#argv2	the destination to extract to
thecwd="$PWD"
if [ ! -d "$2" ]; then
	printf "Error: The output directory to extract the sources into (%s) does not exist!\n" "$2"
	exit 1
fi

cd "$2"

if type "tar" > /dev/null; then
	if [ "$(printf "%s" "$1" | grep ".tar.bz2$")" != "" ]; then
		bzip2 -dkc "$1" | tar -xvf -
		exit 0
	fi
	tar -xvf "$1" #was xzvf for tar.gz before tar.xz
	if [ "$?" = "0" ]; then
		#check for success, and if successful, exit with success
		cd "${thecwd}"
		exit 0
	else
		unzip "$1"
		if [ "$?" = "0" ]; then
			#check for success, and if successful, exit with success
			cd "${thecwd}"
			exit 0
		else
			gzip -d "$1"
			if [ "$?" = "0" ]; then
				#check for success, and if successful, exit with success
				cd "${thecwd}"
				exit 0
			fi
		fi
	fi
fi

cd "${thecwd}"
exit 1