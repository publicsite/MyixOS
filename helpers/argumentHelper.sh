#!/bin/sh
#set this variable to 1, so that the main function in the myBuild is not run twice
myBuildDoNotCallMainFunction="1"
#then source the myBuild functions
if [ -f "$2" ]; then
. "$2"
fi

case "$1" in
	"get")
		#get the file
		if type "do_get" > /dev/null; then
			do_get "$@"
			if [ "$?" = "0" ]; then
				exit 0
			else
				printf "Error: There was an error getting the file.\n"
				exit 1
			fi
		else
			printf "Error: This operation is not supported by the myBuild.\n"
			exit 1
		fi
	;;
	"extract")
		#extract the file
		if type "do_extract" > /dev/null; then
			do_extract "$@"
			if [ "$?" = 0 ]; then
				exit 0
			else
				printf "Error: There was an error extracting the file.\n"
				exit 1
			fi
		else
			printf "Error: This operation is not supported by the myBuild.\n"
			exit 1
		fi
	;;
	"build")
		if type "do_build" > /dev/null; then
			do_build "$@"
			if [ "$?" = 0 ]; then
				exit 0
			else
				printf "Error: There was an error building.\n"
				exit 1
			fi
		else
			printf "Error: This operation is not supported by the myBuild.\n"
			exit 1
		fi
	;;
	"install")
		if type "do_install" > /dev/null; then
			do_install "$@"
			if [ "$?" = 0 ]; then
				exit 0
			else
				printf "Error: There was an installing.\n"
				exit 1
			fi
		else
			printf "Error: This operation is not supported by the myBuild.\n"
			exit 1
		fi
	;;
	"package")
		if type "do_package" > /dev/null; then
			do_package "$@"
			if [ "$?" = 0 ]; then
				exit 0
			else
				printf "Error: There was an packaging.\n"
				exit 1
			fi
		else
			printf "Error: This operation is not supported by the myBuild.\n"
			exit 1
		fi
	;;
	"all")
		if type "do_get" > /dev/null; then
			do_get "$@"
			if [ "$?" != 0 ]; then
				printf "Error: There was an error getting the file, cannot continue.\n"
				exit 1
			fi
		fi
		if type "do_extract" > /dev/null; then
			do_extract "$@"
			if [ "$?" != 0 ]; then
				printf "Error: There was an error extracting the file, cannot continue.\n"
				exit 1
			fi
		fi
		if type "do_build" > /dev/null; then
			do_build "$@"
			if [ "$?" != 0 ]; then
				printf "Error: There was an error building, cannot continue.\n"
				exit 1
			fi
		fi
		if type "do_install" > /dev/null; then
			do_install "$@"
			if [ "$?" != 0 ]; then
				printf "Error: There was an error installing, cannot continue.\n"
				exit 1
			fi
		fi
		if type "do_package" > /dev/null; then
			do_package "$@"
			if [ "$?" != 0 ]; then
				printf "Error: There was an error packaging.\n"
				exit 1
			fi
			exit 0
		fi
	;;
	*)
		printf "Unknown command\n"
		exit 1
	;;
esac