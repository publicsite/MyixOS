#!/bin/sh
#argv1	the remote url to get
#argv2	the local destination to save to
thecwd="$PWD"
if [ ! -d "$2" ]; then
	printf "Error: The output directory to download the sources into (%s) does not exist!\n" "$2"
	exit 1
fi

cd "$2"

if type "wget" > /dev/null; then
	wget "$1"
	#check for success, and if successful, exit with success
	if [ "$?" = "0" ]; then
		cd "${thecwd}"
		exit 0
	fi
fi

cd "${thecwd}"
exit 1