#!/bin/sh

thefdisk="/sbin/fdisk"
thechroot="/usr/sbin/chroot"
themkfsext4="/sbin/mkfs.ext4"
themkfsfat="/sbin/mkfs.fat"

mkdir /tmp/installToHDD
cd /tmp/installToHDD
thepwd="${PWD}"

THELABEL="$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')"

echo "The label will be ${THELABEL}."

THEPARTITION=""
PARTITIONNUMBER=""

if [ "$1" = "" ]; then
echo "Arg1 device to install onto eg. /dev/sdb"
exit
fi

#SECTION: TIMEZONE ...

printRegions(){
	find "/usr/share/zoneinfo" -maxdepth 1 -mindepth 1 -type d | while read line; do
		line="$(basename "$line")"
		if [ "${line}" != "posix" ] && [ "${line}" != "right" ]; then
			echo "${line}"
		fi
	done
}

check_for_region(){
		printRegions | while read line; do
			if [ "$1" = "${line}" ]; then
				echo "found"
				break
			fi
		done
}


printZones(){
	find "/usr/share/zoneinfo/${1}" -maxdepth 1 -mindepth 1 -type f | while read line; do
		line="$(basename "$line")"
		if [ "${line}" != "posix" ] && [ "${line}" != "right" ]; then
			echo "${line}"
		fi
	done
}

check_for_zone(){
		printZones "${2}" | while read line; do
			if [ "$1" = "${line}" ]; then
				echo "found"
				break
			fi
		done
}
set_timezone(){
while true; do
		echo "Type \"L\" to see regions. Or type a region or, otherwise type \"C\" for cancel.\n"
		read option12
	if [ "${option12}" = "L" ] || [ "${option12}" = "l" ]; then
		printRegions "${1}" | less
	elif [ "${option12}" = "C" ] || [ "${option12}" = "c" ]; then
		echo ""
		echo "***Not setting timezone.***"
		echo ""
		break
	else
		if [ "$(check_for_region "${option12}")" = "found" ]; then
				while true; do
				echo "Type \"L\" to see zones. Or type a zone or, otherwise type \"C\" for cancel.\n"
					read option13
					if [ "${option13}" = "L" ] || [ "${option13}" = "l" ]; then
						printZones "${option12}" | less
					elif [ "${option13}" = "C" ] || [ "${option13}" = "c" ]; then
						echo ""
						echo "***Not setting timezone.***"
						echo ""
						break
					else
						if [ "$(check_for_zone "${option13}" "${option12}")" = "found" ]; then
							echo "Setting timezone to ${option12}/${option13} ..."
							ln -sf "/usr/share/zoneinfo/${option12}/${option13}" "${1}/etc/localtime"
							break
						fi
					fi
				done
			break
		fi
	fi
done
}

#SECTION: LOCALE ...

printListOfLocales(){
	off="true"
	OLD_IFS="$IFS"
	IFS='\n'
	cat "${1}/etc/locale.gen" | while read line; do
		if [ "$line" = "" ]; then
			off="false"
		else
			if [ "$off" = "false" ]; then
				echo "${line}" | cut -d " " -f 2
			fi
		fi

	done
	IFS="$OLD_IFS"
}

check_for_locale(){
		printListOfLocales "$1" | while read line; do
			if [ "$2" = "${line}" ]; then
				echo "found"
				break
			fi
		done
}

set_locale(){
while true; do
		echo "Type \"L\" to see locales. Or type a locale or, otherwise type \"C\" for cancel.\n"
		read option7
	if [ "${option7}" = "L" ] || [ "${option7}" = "l" ]; then
		printListOfLocales "${1}" | less
	elif [ "${option7}" = "C" ] || [ "${option7}" = "c" ]; then
		echo ""
		echo "***Not setting locale.***"
		echo ""
		break
	else
		if [ "$(check_for_locale "${1}" ${option7})" = "found" ]; then
			sed -i "s/^# ${option7} /${option7} /g" "${1}/etc/locale.gen"
			${thechroot} "${1}" /usr/sbin/locale-gen
			${thechroot} "${1}" /usr/sbin/update-locale LANG="${option7}"
			break
		fi
	fi
done
}

#SECTION: KEYBOARD LAYOUT
printListOfKeymaps(){
	off="true"
	OLD_IFS="$IFS"
	IFS='\n'
	cat "${1}/usr/share/X11/xkb/rules/base.lst" | while read line; do
		if [ "$line" = "$2" ]; then
			off="false"
		else
			if [ "$off" = "false" ]; then
				if [ "$line" = "" ]; then
					break
				else
					if [ "$3" = "" ]; then
						printf ""
						echo "${line}"
					else
						thelinecut="$(echo "${line}" | sed "s/  /\t/g" | sed "s/\t /\t/g" | tr -s "\t")"
						if [ "$(echo "$thelinecut" | cut -f 3- | grep "^${3}\:.*")" != "" ]; then
							echo "${line}"
						fi
					fi
				fi
			fi
		fi

	done
	IFS="$OLD_IFS"
}

check_for_layout(){
		OLD_IFS="$IFS"
		IFS='\n'
		printListOfKeymaps "$1" "$3" | sed "s/  /\t/g" | sed "s/\t /\t/g" | tr -s "\t" | while read line; do
			if [ "$2" = "$(echo ${line} | cut -f 2)" ]; then
				echo "found"
				break
			fi
		done
		IFS="$OLD_IFS"
}

choose_layout(){
while true; do
		printf "*** Type \"L\" to see keyboard layouts. ***\n"
		printf "*** Type a layout code to set a layout, ***\n"
		printf "*** Or otherwise type \"C\" to not bother setting a layout. ***\n"
		read option8
	if [ "${option8}" = "L" ] || [ "${option8}" = "l" ]; then
		printf "*** (Press q to exit list) ***\n%s" "$(printListOfKeymaps "${1}" "! layout")" | less
	elif [ "${option8}" = "C" ] || [ "${option8}" = "c" ]; then
		echo ""
		printf "***Not setting keyboard layout.***"
		echo ""
		break
	else
		if [ "$(check_for_layout "${1}" "${option8}" "! layout")" = "found" ]; then
			printf "Setting layout to %s.\n\n" "${option8}"
			sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'${option8}'\"/g' "${1}/etc/default/keyboard"
			while true; do
					printf "*** Please wait while I print your variants for %s ***\n" "${option8}"
					printf "*** Then, type a variant code ***\n"
					printf "*** Or otherwise type \"C\" to not bother setting a keyboard variant ***\n"
					printListOfKeymaps "${1}" "! variant" "${option8}"
					read option9
				if [ "${option9}" = "C" ] || [ "${option9}" = "c" ]; then
					echo ""
					printf "***Not setting keyboard variant.***"
					echo ""
					break
				elif [ "$(check_for_layout "${1}" "${option9}" "! variant")" = "found" ]; then
					printf "Setting variant to %s.\n\n" "${option9}"
					sed -i 's/XKBVARIANT=\"\w*"/XKBVARIANT=\"'${option9}'\"/g' "${1}/etc/default/keyboard"
					break
				fi
			done
			break
		fi
	fi
done
}

#SECTION: OTHER

install_syslinux(){
while true; do
		echo "Would you like to install syslinux to the MBR [Y/N]?"
		read option4
	if [ "${option4}" = "Y" ] || [ "${option4}" = "y" ]; then
		echo ""
		echo "***Writing syslinux.***"
		echo ""
		dd bs=440 count=1 conv=notrunc if=/usr/lib/syslinux/mbr/mbr.bin of=${1}
		echo ""
		break
	elif [ "${option4}" = "N" ] || [ "${option4}" = "n" ]; then
		echo ""
		echo "***syslinux NOT written.***"
		echo ""
		break
	fi
done
}

efi_partition(){
	if [ "$(${thefdisk} -l | grep "${1}1")" != "" ]; then
		echo "Please delete partition 1 first"
	else

		while true; do
			echo "Would you like to create an EFI boot partition [Y/N]?"
			read option10
			if [ "${option10}" = "Y" ] || [ "${option10}" = "y" ]; then
				echo ""
				echo "***Creating EFI boot partition.***"
				echo ""
				printf "n\np\n1\n\n+256M\nt\nef\nw" | ${thefdisk} ${1}
				${themkfsfat} -F 32 ${1}1
				mkdir -p /tmp/installToHDD/efi
				mount ${1}1 /tmp/installToHDD/efi
				mkdir -p /tmp/installToHDD/efi/EFI/BOOT

				cp -a /isolinux/u-boot-payload.efi /tmp/installToHDD/efi/EFI/BOOT/BOOTX64.EFI
				cp -a /isolinux/u-boot-payload.efi /tmp/installToHDD/efi/EFI/BOOT/BOOTIA32.EFI

				#cp -a /usr/lib/SYSLINUX.EFI/efi64/syslinux.efi /tmp/installToHDD/efi/EFI/BOOT/BOOTX64.EFI
				#cp -a /usr/lib/SYSLINUX.EFI/efi32/syslinux.efi /tmp/installToHDD/efi/EFI/BOOT/BOOTIA32.EFI
				#cp -a /usr/lib/syslinux/modules/efi64/ldlinux.e64 /tmp/installToHDD/efi/EFI/BOOT/
				#cp -a /usr/lib/syslinux/modules/efi32/ldlinux.e32 /tmp/installToHDD/efi/EFI/BOOT/

				#cp "$(find rootfs/boot/vmlinuz-*)" /tmp/installToHDD/
				#cp "$(find rootfs/boot/initrd.img*)" /tmp/installToHDD/

				#echo "MENU TITLE Boot Menu" > /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "PROMPT 1" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "DEFAULT 1" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "label 1" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "    MENU LABEL Devuan testing" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "    KERNEL /vmlinuz" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "    APPEND initrd=/initrd.img root=LABEL=${THELABEL} init=/sbin/init" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg
				#echo "    TIMEOUT 1" >> /tmp/installToHDD/efi/EFI/BOOT/syslinux.cfg

				#efibootmgr -c -d ${1} -p 1 -l \\EFI\\BOOT\\syslinux.efi -L"SYSLINUX"

				umount /tmp/installToHDD/efi

				echo ""
				break
			elif [ "${option10}" = "N" ] || [ "${option10}" = "n" ]; then
				echo ""
				echo "***EFI partition NOT created.***"
				echo ""
				break
			fi
		done
	fi
}

are_you_sure(){
while true; do
		if [ "$3" = "deletepartition" ]; then
			echo "Are you sure you would like to delete ${1}${2} [Y/N]?"
		elif [ "$3" = "createfilesystem" ]; then
			echo "Are you sure you would like to create a filesystem on ${1}${2} [Y/N]?"
		fi
		read option3
	if [ "${option3}" = "Y" ] || [ "${option3}" = "y" ]; then
		if [ "$3" = "deletepartition" ]; then
(
echo d # Delete a partition
echo ${2} #Partition number
echo w #Write
) | ${thefdisk} ${1}

			echo ""
			echo "***Partition ${1}${2} deleted.***"
			echo ""
			break
		elif [ "$3" = "createfilesystem" ]; then
			PARTITIONNUMBER="${2}"
			THEPARTITION="${1}${PARTITIONNUMBER}"
			"${themkfsext4}" "${THEPARTITION}" -L "${THELABEL}"
			echo ""
			echo "***Filesystem on ${THEPARTITION} created.***"
			echo ""
			break
		fi
	elif [ "${option3}" = "N" ] || [ "${option3}" = "n" ]; then
		echo ""
		echo "***Partition NOT deleted.***"
		echo ""
		break
	fi
done
}

delete_partition (){
while true; do
		${thefdisk} -l "$1"
		echo ""
		echo "Enter partition number to delete or enter C for cancel."
		read option2
	if [ "${option2}" = "C" ] || [ "${option2}" = "c" ]; then
		break;
	else
		if [ -b "${1}${option2}" ]; then
			are_you_sure "$1" "${option2}" deletepartition
			break
		fi
	fi
done
}

create_filesystem (){
while true; do
		${thefdisk} -l "$1"
		echo ""
		echo "Enter partition number to create filesystem on, or enter D for done."
		read option2
	if [ "${option2}" = "D" ] || [ "${option2}" = "d" ]; then
		break;
	else
		if [ -b "${1}${option2}" ]; then
			are_you_sure "$1" "${option2}" createfilesystem
			break
		fi
	fi
done
}

create_partition (){
echo ""
echo "*** Remember to use \"w\" for write and/or \"q\" for quit! ***"
echo ""
(printf "n\n" ; cat) | ${thefdisk} ${1}
}

while true; do
${thefdisk} -l "$1"
echo ""
echo "Would you like to:"
echo "1) Delete a partition"
echo "2) Create an EFI partition"
echo "3) Next"
read option11
	if [ "${option11}" = 1 ]; then
		delete_partition "$1"
	elif [ "${option11}" = 2 ]; then
		efi_partition "$1"
	elif [ "${option11}" = 3 ]; then
		break
	fi
done

while true; do
${thefdisk} -l "$1"
echo ""
echo "Would you like to:"
echo "1) Delete a partition"
echo "2) Create a partition"
echo "3) Next"
read option
	if [ "${option}" = 1 ]; then
		delete_partition "$1"
	elif [ "${option}" = 2 ]; then
		create_partition "$1"
	elif [ "${option}" = 3 ]; then
		create_filesystem "$1"
		break
	fi
done

install_syslinux "${1}"

if [ "$THEPARTITION" = "" ]; then
	while true; do
		echo "Enter the partition"
		read THEPARTITION
			if [ -b "${THEPARTITION}" ]; then
				break
			fi
	done
fi

mkdir tempmount

mount "$THEPARTITION" tempmount

echo "*** Copying the files ***"

#copy the files
dest="${thepwd}/tempmount"
cd /
find . -maxdepth 1 -mindepth 1 -type d | cut -c 2- | while read line; do mkdir -p ${dest}${line}; chmod --reference=.${line} ${dest}${line}; chown --reference=.${line} ${dest}${line}; done
find . -maxdepth 1 -mindepth 1 -type b,c,l,p,f | cut -c 2- | grep -v "^/swapfile\|^/.cache\|^/overlay" | while read line; do cp -a .${line} ${dest}${line}; done
find . -maxdepth 2 -mindepth 2 | cut -c 2- | grep -v "^/isolinux/*\|^/swapfile\|^/overlay/*\|^/dev/*\|^/proc/*\|^/sys/*\|^/tmp/*\|^/run/*\|^/mnt/*\|^/media/*\|^/lost+found" | while read line; do cp -a .${line} ${dest}${line}; done
cd "${thepwd}"

#FOR EFI
mkdir -p tempmount/boot/extlinux
echo "MENU TITLE Boot Menu" > tempmount/boot/extlinux/extlinux.conf
echo "PROMPT 1" >> tempmount/boot/extlinux/extlinux.conf
echo "DEFAULT 1" >> tempmount/boot/extlinux/extlinux.conf
echo "" >> tempmount/boot/extlinux/extlinux.conf
echo "label 1" >> tempmount/boot/extlinux/extlinux.conf
echo "    MENU LABEL Devuan testing" >> tempmount/boot/extlinux/extlinux.conf
echo "    KERNEL /vmlinuz" >> tempmount/boot/extlinux/extlinux.conf
echo "    APPEND initrd=/initrd.img root=LABEL=${THELABEL} init=/sbin/init" >> tempmount/boot/extlinux/extlinux.conf
echo "    TIMEOUT 1" >> tempmount/boot/extlinux/extlinux.conf

#FOR LEGACY BOOT
ln -s /boot/extlinux/extlinux.conf tempmount/boot/syslinux.cfg


##OLD BLOCK START
#mkdir -p tempmount/boot
##for MBR syslinux
#echo "MENU TITLE Boot Menu" > tempmount/boot/syslinux.cfg
#echo "PROMPT 1" >> tempmount/boot/syslinux.cfg
#echo "DEFAULT 1" >> tempmount/boot/syslinux.cfg
#echo "" >> tempmount/boot/syslinux.cfg
#echo "label 1" >> tempmount/boot/syslinux.cfg
#echo "    MENU LABEL Devuan testing" >> tempmount/boot/syslinux.cfg
#echo "    KERNEL /vmlinuz" >> tempmount/boot/syslinux.cfg
#echo "    APPEND initrd=/initrd.img root=LABEL=${THELABEL} init=/sbin/init" >> tempmount/boot/syslinux.cfg
#echo "    TIMEOUT 1" >> tempmount/boot/syslinux.cfg

##for EFI u-boot
#mkdir tempmount/extlinux
#echo "MENU TITLE Boot Menu" > tempmount/extlinux/extlinux.conf
#echo "PROMPT 1" >> tempmount/extlinux/extlinux.conf
#echo "DEFAULT 1" >> tempmount/extlinux/extlinux.conf
#echo "" >> tempmount/extlinux/extlinux.conf
#echo "label 1" >> tempmount/extlinux/extlinux.conf
#echo "    MENU LABEL Devuan testing" >> tempmount/extlinux/extlinux.conf
#echo "    KERNEL /vmlinuz" >> tempmount/extlinux/extlinux.conf
#echo "    APPEND initrd=/initrd.img root=LABEL=${THELABEL} init=/sbin/init" >> tempmount/extlinux/extlinux.conf
#echo "    TIMEOUT 1" >> tempmount/extlinux/extlinux.conf
##OLD BLOCK END

extlinux --install tempmount/boot

while true; do
printf "Type the alphanumeric hostname you wish to use for this machine and press return\n(\"-\" characters are also allowed).\n"
	read hostname
	#check if alphanumeric
	if [ "$(echo "$hostname" | sed "s#[A-Z]\|[a-z]\|[0-9]\|\-##g" )" = "" ]; then
		printf "%s\n" "$hostname" > "${dest}/etc/hostname"
		chmod 644 "${dest}/etc/hostname"
		chown root:root "${dest}/etc/hostname"

		printf "127.0.0.1\tlocalhost\n" > "${dest}/etc/hosts"
		printf "127.0.1.1\t%s\n" "$hostname" >> "${dest}/etc/hosts"
		printf "::1\t\tlocalhost ip6-localhost ip6-loopback\n" >> "${dest}/etc/hosts"
		printf "ff02::1\t\tip6-allnodes\n" >> "${dest}/etc/hosts"
		printf "ff02::2\t\tip6-allrouters\n" >> "${dest}/etc/hosts"
		chmod 644 "${dest}/etc/hosts"
		chown root:root "${dest}/etc/hosts"

		break
	fi
done

set_locale "${dest}"
set_timezone "${dest}"
choose_layout "${dest}"

howManyGLeft="$(df -h "$dest" | head -n 2 | tail -n 1 | tr -s " " | cut -d " " -f 4)"
if [ "$(printf "%s" "$howManyGLeft" | grep "G")" != "" ]; then
while true; do
		printf "Would you like to create a swap [Y/N]?"
		read option5
	if [ "${option5}" = "Y" ] || [ "${option5}" = "y" ]; then
		howManyGLeft="$(df -h "$dest" | head -n 2 | tail -n 1 | tr -s " " | cut -d " " -f 4)"
		printf "You have %s availiable for a swap.\n" "$howManyGLeft"
		printf "How big would you like your swap to be?\n"
			while true; do
				printf "... Type a number less than %s or type \"C\" to cancel\n" "$howManyGLeft"
				read option6
				#cope with the user typing a suffix of G
				if [ "$(printf "%s" "$howManyGLeft" | grep "G")" != "" ]; then
					option6="$(printf "%s" "$option6" | cut -d "G" -f1 )"
				fi
				if [ "${option6}" = "C" ] || [ "${option6}" = "c" ]; then
					break
				else
					justTheNumberLeft="$(printf "%s" "$howManyGLeft" | cut -d "G" -f 1)"
					if [ "$(printf "%s < %s\n" "${option6}" "${justTheNumberLeft}" | bc)" = 1 ]; then
						printf "OK, creating a swap of %sG.\n" ${option6}
						fallocate -l "${option6}G" ${dest}/swapfile
						chmod 600 "${dest}/swapfile"
						${thechroot} ${dest} /sbin/mkswap /swapfile
						#NOTE TO SELF: =========== make sure we check the fstab before completely over-writing it
						printf "/swapfile none swap sw 0 0\n" > "${dest}/etc/fstab"
						printf "The swap will be there at boot\n"
						break
					fi
				fi
			done
		break
	elif [ "${option5}" = "N" ] || [ "${option5}" = "n" ]; then
		printf "No swap created.\n"
		break
	fi
done
else
printf "You do not have enough space to create a swap, so not bothering to ask\n"
fi

umount tempmount

(
echo a # set partition boot flag
echo ${PARTITIONNUMBER} # set partition boot flag
echo w #Write
) | ${thefdisk} ${1}

cd

rm -rf /tmp/installToHDD