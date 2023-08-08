#!/bin/sh

###ENVIRONMENT VARIABLES/FUNCTIONS###

export TARGET="arm-linux-gnueabihf"
export myBuildHome="$1"
export myBuildExtractDest="${myBuildHome}/extractdest"
export SYSROOT="${myBuildHome}/installDir" #the root dir

findSPL(){
	find "${myBuildExtractDest}/u-boot-"*"/spl" -maxdepth 1 -name *-spl.bin | while read line; do
		lineLength="$(expr length "$line")"
		lineLength="$(expr $lineLength - 13)"
		if [ "$(printf "$line" | cut -c $lineLength- )" != "u-boot-spl.bin" ]; then
			echo "$line"
			break;
		fi
	done
}

printArchitecturesMkImage(){
	start="0"
	"${myBuildExtractDest}/u-boot-"*/tools/mkimage -A -h 2>&1 | sed 's#[[:blank:]]\+# #g' | while read line; do
		if [ "$(printf "%s\n" "$line" | grep "Invalid architecture")" != "" ]; then
			start="$(expr $start + 1)"
		else
			if [ "$start" = "1" ]; then
				toPrint="$(printf "%s\n" "$line" | cut -f 1 -d " ")"
				if [ "$toPrint" != "Unknown" ] && [ "$toPrint" != "" ]; then
					printf "$toPrint\n"
				fi
			fi
		fi
	done
}

checkResultArchitectures(){
#this function checks if the file exists given the user input as argument 1

	if [ "$(printArchitecturesMkImage | while read line; do if [ "$1" = "$line" ]; then printf "yes\n"; fi; done)" = "yes" ]; then
		return 0
	else
		return 101
	fi
}

###SCRIPT STARTS HERE###

while true; do
	printf "\n\n==TYPE THE ARCHITECTURE==\n\n"

	printArchitecturesMkImage

	read theArchMkImage

	checkResultArchitectures "$theArchMkImage"

	if [ "$?" = "0" ]; then
		break
	fi
done

#dd a blank image
dd if=/dev/zero of="${myBuildHome}/image.img" bs=1M count=4000

if [ "$theArchMkImage" = "x86" ]; then
(
printf "o\n" # Create a new empty DOS partition table
printf "n\n" # Add a new partition
printf "p\n" # Primary partition
printf "1\n" # Partition number
printf "2048\n" # First sector (Accept default)
printf "264148\n"  # Last sector (Accept default)
printf "n\n" # Add a new partition
printf "p\n" # Primary partition
printf "2\n" # Partition number
printf "\n" # First sector (Accept default)
printf "\n"  # Last sector (Accept default)
printf "w\n" # Write changes
) | fdisk "${myBuildHome}/image.img"

else
(
printf "o\n" # Create a new empty DOS partition table
printf "n\n" # Add a new partition
printf "p\n" # Primary partition
printf "1\n" # Partition number
printf "\n" # First sector (Accept default)
printf "\n"  # Last sector (Accept default)
printf "w\n" # Write changes
) | fdisk "${myBuildHome}/image.img"
fi

losetup -P /dev/loop321 "${myBuildHome}/image.img"

if [ "$theArchMkImage" != "x86" ]; then
#dd uboot spl
	ubootSPL="$(findSPL)"
	if [ -f "${ubootSPL}" ]; then
		dd if="${ubootSPL}" of=/dev/loop321 bs=1024 seek=8 conv=notrunc
	else
		ubootSPL="$(find "${myBuildExtractDest}/u-boot-"*/spl -maxdepth 1 -name u-boot-spl.bin)"
		if [ -f "${ubootSPL}" ]; then
			dd if="${ubootSPL}" of=/dev/loop321 bs=1024 seek=8
		fi
	fi

	ubootIMG="$(find "${myBuildExtractDest}/u-boot-"* -maxdepth 1 -name u-boot.img)"
	if [ -f "${ubootIMG}" ]; then
		dd if="${ubootIMG}" of=/dev/loop321 bs=1024 seek=40 conv=notrunc
	else
		ubootBIN="$(find "${myBuildExtractDest}/u-boot-"* -maxdepth 1 -name u-boot.bin)"
		if [ -f "${ubootIMG}" ]; then
			dd if="${ubootBIN}" of=/dev/loop321 seek=32 conv=notrunc
		fi
	fi

fi

if [ "$theArchMkImage" = "x86" ]; then
	mkfs.vfat -F 32 -s 1 /dev/loop321p1
	mkfs.ext2 -F /dev/loop321p2
	mkdir "${myBuildHome}/mount"

	#mount fat32 partition and copy u-boot efi payload, create script.bin, copy boot.cmd, then unmount
	mount -t vfat /dev/loop321p1 "${myBuildHome}/mount"
	mkdir -p "${myBuildHome}/mount/efi/boot"
	mkdir -p "${myBuildHome}/mount/boot"
	ubootEFI="$(find "${myBuildExtractDest}/u-boot-"* -maxdepth 1 -name u-boot-payload.efi)"
	cp -a "${ubootEFI}" "${myBuildHome}/mount/efi/boot/bootia32.efi"
	#create script.bin
	"${myBuildExtractDest}/u-boot-"*/tools/mkimage -A "$theArchMkImage" -O linux -T script -C none -n "U-Boot boot script" -d "${myBuildHome}"/myBuilds/uboot/boot.cmd.x86 "${myBuildHome}/mount/boot.scr"
	#copy boot.cmd 
	cp -a "${myBuildHome}"/myBuilds/uboot/boot.cmd.x86 "${myBuildHome}/mount/boot.cmd"
	umount "${myBuildHome}/mount"

	#mount ext2 partition
	mount -t ext2 /dev/loop321p2 "${myBuildHome}/mount"
else
	mkfs.ext2 -F /dev/loop321p1
	mkdir "${myBuildHome}/mount"
	mount -t ext2 /dev/loop321p1 "${myBuildHome}/mount"
fi

#create and copy our rootfs
cp -a "${SYSROOT}/"* "${myBuildHome}/mount/"

#create fstab
printf "#\n" >> deleteme.txt
printf "# /etc/fstab: static file system information\n" >> "${myBuildHome}/mount/etc/fstab"
printf "#\n" >> "${myBuildHome}/mount/etc/fstab"
printf "# <file system>\t<dir>\t<type>\t<options>\t<dump>\t<pass>\n" >> "${myBuildHome}/mount/etc/fstab"
printf "/dev/mmcblk0p1  /       ext2    defaults        0       0\n" >> "${myBuildHome}/mount/etc/fstab"


###add uboot device tree file
##if [ -f "${myBuildExtractDest}/u-boot-"*"/u-boot.dtb" ]; then
##	mkdir -p "${myBuildHome}/mount/boot/dtbs"
##	cp -a "${myBuildExtractDest}/u-boot-"*"/u-boot.dtb" "${myBuildHome}/mount/boot/dtbs/" 
##fi

#create u-boot boot.scr

if [ "$theArchMkImage" != "x86" ]; then

	#create script.bin
	"${myBuildExtractDest}/u-boot-"*/tools/mkimage -A "$theArchMkImage" -O linux -T script -C none -n "U-Boot boot script" -d "${myBuildHome}"/myBuilds/uboot/boot.cmd.arm "${myBuildHome}/mount/boot/boot.scr"

	#copy boot.cmd.arm 
	cp -a "${myBuildHome}"/myBuilds/uboot/boot.cmd.arm "${myBuildHome}/mount/boot/boot.cmd"

fi

umount "${myBuildHome}/mount/"

losetup -d /dev/loop321

chown ${2}:${2} "${myBuildHome}/image.img"

#qemu-system-x86_64 -kernel installDir/boot/vmlinuz-linux-deblob -m 256 -drive format=raw,file=image.img,media=disk -append 'root=/dev/sda rootfstype=ext2 rw rootwait' -vga cirrus
#xinit /etc/X11/xinit/site.xinitrc -- /usr/bin/X -br