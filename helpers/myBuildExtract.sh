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
	tar -xvf "$1" #was xzvf for tar.gz before tar.xz
	if [ "$?" = "0" ]; then
		#check for success, and if successful, exit with success
		cd "${thecwd}"
		exit 0
	fi
fi

cd "${thecwd}"
exit 1