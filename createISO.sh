#!/bin/sh
#stage4.sh :- start of bootable cd code

PREFIX="/usr"
TARGET="${1}"

##we mount the stuff for apt
#mount none -t proc /proc
#mount none -t sysfs /sys
#mkdir -p /dev/pts
#mount none -t devpts /dev/pts

THELABEL="MYIXOS"

#make an initramfs (start)

if [ ! -d rootfs/proc ]; then
	mkdir rootfs/proc
fi
if [ ! -d rootfs/sys ]; then
	mkdir rootfs/sys
fi
if [ ! -d rootfs/dev ]; then
	mkdir rootfs/dev
fi

mkdir initramfs
mkdir initramfs/bin
mkdir initramfs/sbin
mkdir initramfs/etc
touch initramfs/etc/passwd
touch initramfs/etc/group
cp -a rootfs/etc/mdev.conf initramfs/etc
mkdir initramfs/proc
mkdir initramfs/run
mkdir initramfs/sys
mkdir initramfs/usr
mkdir initramfs/usr/bin
mkdir initramfs/usr/sbin
mkdir -p initramfs/home/root
mkdir -p initramfs/usr/${TARGET}/lib
cp -a rootfs/lib/modules initramfs/usr/${TARGET}/lib
cp -a rootfs/usr/${TARGET}/lib/libm-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libm\.* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libresolv-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libresolv\.* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libselinux\.* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libc-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libc\.* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/ld-linux-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libpcre* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libpthread-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libpthread\.* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/ld-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libdl-* initramfs/usr/${TARGET}/lib/
cp -a rootfs/usr/${TARGET}/lib/libdl\.* initramfs/usr/${TARGET}/lib/

echo '#!/bin/busybox sh' > initramfs/sbin/init
echo '' >> initramfs/sbin/init
echo '/bin/busybox mount -n -t proc proc /proc' >> initramfs/sbin/init
echo '/bin/busybox mount -n -t sysfs sysfs /sys' >> initramfs/sbin/init
echo '/bin/busybox mount -n -t devtmpfs devtmpfs /dev' >> initramfs/sbin/init
echo '/bin/busybox mount -n -t tmpfs tmpfs /run' >> initramfs/sbin/init
echo '/bin/busybox mkdir mountpoint' >> initramfs/sbin/init
echo '/bin/busybox adduser root' >> initramfs/sbin/init
echo '/bin/busybox addgroup root' >> initramfs/sbin/init
echo '/bin/busybox addgroup root root' >> initramfs/sbin/init
echo '/bin/busybox addgroup tty' >> initramfs/sbin/init
echo '/bin/busybox addgroup root tty' >> initramfs/sbin/init
echo '/bin/busybox addgroup uucp' >> initramfs/sbin/init
echo '/bin/busybox addgroup root uucp' >> initramfs/sbin/init
echo '/bin/busybox addgroup disk' >> initramfs/sbin/init
echo '/bin/busybox addgroup root disk' >> initramfs/sbin/init
echo '/bin/busybox addgroup floppy' >> initramfs/sbin/init
echo '/bin/busybox addgroup root floppy' >> initramfs/sbin/init
echo '/bin/busybox addgroup audio' >> initramfs/sbin/init
echo '/bin/busybox addgroup root audio' >> initramfs/sbin/init
echo '/bin/busybox addgroup dialout' >> initramfs/sbin/init
echo '/bin/busybox addgroup root dialout' >> initramfs/sbin/init
echo '/bin/busybox addgroup video' >> initramfs/sbin/init
echo '/bin/busybox addgroup root video' >> initramfs/sbin/init
echo '/bin/busybox addgroup cdrom' >> initramfs/sbin/init
echo '/bin/busybox addgroup root cdrom' >> initramfs/sbin/init

##modules
#echo '/bin/busybox modprobe loop' >> initramfs/sbin/init
#echo '/bin/busybox modprobe fuse' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ctr' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ccm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rfcomm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe cmac' >> initramfs/sbin/init
#echo '/bin/busybox modprobe algif_hash' >> initramfs/sbin/init
#echo '/bin/busybox modprobe algif_skcipher' >> initramfs/sbin/init
#echo '/bin/busybox modprobe af_alg' >> initramfs/sbin/init
#echo '/bin/busybox modprobe bnep' >> initramfs/sbin/init
#echo '/bin/busybox modprobe uinput' >> initramfs/sbin/init
#echo '/bin/busybox modprobe nls_ascii' >> initramfs/sbin/init
#echo '/bin/busybox modprobe nls_cp437' >> initramfs/sbin/init
#echo '/bin/busybox modprobe vfat' >> initramfs/sbin/init
#echo '/bin/busybox modprobe fat' >> initramfs/sbin/init
#echo '/bin/busybox modprobe parport_pc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ppdev' >> initramfs/sbin/init
#echo '/bin/busybox modprobe lp' >> initramfs/sbin/init
#echo '/bin/busybox modprobe parport' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dm_crypt' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dm_mod' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_rapl' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_codec_hdmi' >> initramfs/sbin/init
#echo '/bin/busybox modprobe x86_pkg_temp_thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_powerclamp' >> initramfs/sbin/init
#echo '/bin/busybox modprobe coretemp' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_skl' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_skl_ipc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe kvm_intel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_sst_ipc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_sst_dsp' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_ext_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_acpi_intel_match' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_acpi' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_codec_realtek' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_soc_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_codec_generic' >> initramfs/sbin/init
#echo '/bin/busybox modprobe amdkfd' >> initramfs/sbin/init
#echo '/bin/busybox modprobe arc4' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_laptop' >> initramfs/sbin/init
#echo '/bin/busybox modprobe kvm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe irqbypass' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_compress' >> initramfs/sbin/init
#echo '/bin/busybox modprobe joydev' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_cstate' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_smm_hwmon' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_intel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_uncore' >> initramfs/sbin/init
#echo '/bin/busybox modprobe amdgpu' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_codec' >> initramfs/sbin/init
#echo '/bin/busybox modprobe efi_pstore' >> initramfs/sbin/init
#echo '/bin/busybox modprobe iwlmvm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hda_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_rapl_perf' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_wmi' >> initramfs/sbin/init
#echo '/bin/busybox modprobe btusb' >> initramfs/sbin/init
#echo '/bin/busybox modprobe pcspkr' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_hwdep' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_smbios' >> initramfs/sbin/init
#echo '/bin/busybox modprobe btrtl' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dcdbas' >> initramfs/sbin/init
#echo '/bin/busybox modprobe serio_raw' >> initramfs/sbin/init
#echo '/bin/busybox modprobe btbcm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe btintel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe efivars' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_pcm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe sparse_keymap' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mac80211' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_wmi_descriptor' >> initramfs/sbin/init
#echo '/bin/busybox modprobe wmi_bmof' >> initramfs/sbin/init
#echo '/bin/busybox modprobe bluetooth' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd_timer' >> initramfs/sbin/init
#echo '/bin/busybox modprobe iTCO_wdt' >> initramfs/sbin/init
#echo '/bin/busybox modprobe snd' >> initramfs/sbin/init
#echo '/bin/busybox modprobe iwlwifi' >> initramfs/sbin/init
#echo '/bin/busybox modprobe soundcore' >> initramfs/sbin/init
#echo '/bin/busybox modprobe iTCO_vendor_support' >> initramfs/sbin/init
#echo '/bin/busybox modprobe chash' >> initramfs/sbin/init
#echo '/bin/busybox modprobe gpu_sched' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ttm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe cfg80211' >> initramfs/sbin/init
#echo '/bin/busybox modprobe uvcvideo' >> initramfs/sbin/init
#echo '/bin/busybox modprobe videobuf2_vmalloc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe videobuf2_memops' >> initramfs/sbin/init
#echo '/bin/busybox modprobe videobuf2_v4l2' >> initramfs/sbin/init
#echo '/bin/busybox modprobe drbg' >> initramfs/sbin/init
#echo '/bin/busybox modprobe videobuf2_common' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ansi_cprng' >> initramfs/sbin/init
#echo '/bin/busybox modprobe videodev' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rtsx_usb_ms' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mei_me' >> initramfs/sbin/init
#echo '/bin/busybox modprobe media' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mei' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ecdh_generic' >> initramfs/sbin/init
#echo '/bin/busybox modprobe memstick' >> initramfs/sbin/init
#echo '/bin/busybox modprobe hid_multitouch' >> initramfs/sbin/init
#echo '/bin/busybox modprobe idma64' >> initramfs/sbin/init
#echo '/bin/busybox modprobe processor_thermal_device' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_soc_dts_iosf' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_pch_thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe pcc_cpufreq' >> initramfs/sbin/init
#echo '/bin/busybox modprobe tpm_crb' >> initramfs/sbin/init
#echo '/bin/busybox modprobe int3403_thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe tpm_tis' >> initramfs/sbin/init
#echo '/bin/busybox modprobe tpm_tis_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe int3400_thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe tpm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe dell_rbtn' >> initramfs/sbin/init
#echo '/bin/busybox modprobe evdev' >> initramfs/sbin/init
#echo '/bin/busybox modprobe acpi_thermal_rel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rfkill' >> initramfs/sbin/init
#echo '/bin/busybox modprobe int3402_thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe int340x_thermal_zone' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rng_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe battery' >> initramfs/sbin/init
#echo '/bin/busybox modprobe acpi_pad' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ac' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ext4' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crc16' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mbcache' >> initramfs/sbin/init
#echo '/bin/busybox modprobe jbd2' >> initramfs/sbin/init
#echo '/bin/busybox modprobe fscrypto' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ecb' >> initramfs/sbin/init
#echo '/bin/busybox modprobe btrfs' >> initramfs/sbin/init
#echo '/bin/busybox modprobe zstd_compress' >> initramfs/sbin/init
#echo '/bin/busybox modprobe zstd_decompress' >> initramfs/sbin/init
#echo '/bin/busybox modprobe xxhash' >> initramfs/sbin/init
#echo '/bin/busybox modprobe efivarfs' >> initramfs/sbin/init
#echo '/bin/busybox modprobe raid10' >> initramfs/sbin/init
#echo '/bin/busybox modprobe raid456' >> initramfs/sbin/init
#echo '/bin/busybox modprobe async_raid6_recov' >> initramfs/sbin/init
#echo '/bin/busybox modprobe async_memcpy' >> initramfs/sbin/init
#echo '/bin/busybox modprobe async_pq' >> initramfs/sbin/init
#echo '/bin/busybox modprobe async_xor' >> initramfs/sbin/init
#echo '/bin/busybox modprobe async_tx' >> initramfs/sbin/init
#echo '/bin/busybox modprobe xor' >> initramfs/sbin/init
#echo '/bin/busybox modprobe raid6_pq' >> initramfs/sbin/init
#echo '/bin/busybox modprobe libcrc32c' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crc32c_generic' >> initramfs/sbin/init
#echo '/bin/busybox modprobe raid1' >> initramfs/sbin/init
#echo '/bin/busybox modprobe raid0' >> initramfs/sbin/init
#echo '/bin/busybox modprobe multipath' >> initramfs/sbin/init
#echo '/bin/busybox modprobe linear' >> initramfs/sbin/init
#echo '/bin/busybox modprobe md_mod' >> initramfs/sbin/init
#echo '/bin/busybox modprobe sg' >> initramfs/sbin/init
#echo '/bin/busybox modprobe sr_mod' >> initramfs/sbin/init
#echo '/bin/busybox modprobe cdrom' >> initramfs/sbin/init
#echo '/bin/busybox modprobe sd_mod' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rtsx_usb_sdmmc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mmc_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe rtsx_usb' >> initramfs/sbin/init
#echo '/bin/busybox modprobe hid_generic' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i2c_designware_platform' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i2c_designware_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crct10dif_pclmul' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crc32_pclmul' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crc32c_intel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i915' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ghash_clmulni_intel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe pcbc' >> initramfs/sbin/init
#echo '/bin/busybox modprobe ahci' >> initramfs/sbin/init
#echo '/bin/busybox modprobe libahci' >> initramfs/sbin/init
#echo '/bin/busybox modprobe aesni_intel' >> initramfs/sbin/init
#echo '/bin/busybox modprobe aes_x86_64' >> initramfs/sbin/init
#echo '/bin/busybox modprobe crypto_simd' >> initramfs/sbin/init
#echo '/bin/busybox modprobe psmouse' >> initramfs/sbin/init
#echo '/bin/busybox modprobe cryptd' >> initramfs/sbin/init
#echo '/bin/busybox modprobe glue_helper' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i2c_algo_bit' >> initramfs/sbin/init
#echo '/bin/busybox modprobe libata' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i2c_i801' >> initramfs/sbin/init
#echo '/bin/busybox modprobe drm_kms_helper' >> initramfs/sbin/init
#echo '/bin/busybox modprobe r8169' >> initramfs/sbin/init
#echo '/bin/busybox modprobe xhci_pci' >> initramfs/sbin/init
#echo '/bin/busybox modprobe realtek' >> initramfs/sbin/init
#echo '/bin/busybox modprobe xhci_hcd' >> initramfs/sbin/init
#echo '/bin/busybox modprobe scsi_mod' >> initramfs/sbin/init
#echo '/bin/busybox modprobe libphy' >> initramfs/sbin/init
#echo '/bin/busybox modprobe drm' >> initramfs/sbin/init
#echo '/bin/busybox modprobe usbcore' >> initramfs/sbin/init
#echo '/bin/busybox modprobe thermal' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_lpss_pci' >> initramfs/sbin/init
#echo '/bin/busybox modprobe intel_lpss' >> initramfs/sbin/init
#echo '/bin/busybox modprobe i2c_hid' >> initramfs/sbin/init
#echo '/bin/busybox modprobe mfd_core' >> initramfs/sbin/init
#echo '/bin/busybox modprobe hid' >> initramfs/sbin/init
#echo '/bin/busybox modprobe wmi' >> initramfs/sbin/init
#echo '/bin/busybox modprobe usb_common' >> initramfs/sbin/init
#echo '/bin/busybox modprobe video' >> initramfs/sbin/init
#echo '/bin/busybox modprobe button' >> initramfs/sbin/init
##end modules

echo '/bin/busybox mdev -s' >> initramfs/sbin/init

echo 'init=/sbin/init' >> initramfs/sbin/init
echo 'root=' >> initramfs/sbin/init
echo 'rootdelay=' >> initramfs/sbin/init
echo 'rootfstype=auto' >> initramfs/sbin/init
echo 'ro="ro"' >> initramfs/sbin/init
echo 'rootflags=' >> initramfs/sbin/init
echo 'thedevice=' >> initramfs/sbin/init
#echo "" >> initramfs/sbin/init
echo 'resume=' >> initramfs/sbin/init
echo 'noresume=false' >> initramfs/sbin/init

echo 'read -r cmdline < /proc/cmdline' >> initramfs/sbin/init

echo 'for param in $cmdline ; do' >> initramfs/sbin/init
echo '  case $param in' >> initramfs/sbin/init
echo '    init=*      ) init=${param#init=}             ;;' >> initramfs/sbin/init
echo '    root=*      ) root=${param#root=}             ;;' >> initramfs/sbin/init
echo '    rootdelay=* ) rootdelay=${param#rootdelay=}   ;;' >> initramfs/sbin/init
echo '    rootfstype=*) rootfstype=${param#rootfstype=} ;;' >> initramfs/sbin/init
echo '    rootflags=* ) rootflags=${param#rootflags=}   ;;' >> initramfs/sbin/init
echo '    resume=*    ) resume=${param#resume=}         ;;' >> initramfs/sbin/init
echo '    noresume    ) noresume=true                   ;;' >> initramfs/sbin/init
echo '    ro          ) ro="ro"                         ;;' >> initramfs/sbin/init
echo '    rw          ) ro="rw"                         ;;' >> initramfs/sbin/init
echo '  esac' >> initramfs/sbin/init
echo 'done' >> initramfs/sbin/init

echo 'case "$root" in' >> initramfs/sbin/init
echo '    /dev/*    ) thedevice=$root ;;' >> initramfs/sbin/init
echo '    UUID=*    ) eval $root; thedevice="$(/bin/busybox blkid | /bin/busybox grep "UUID=\"${UUID}\"" | /bin/busybox cut -d ':' -f 1)" ;;' >> initramfs/sbin/init
echo '    PARTUUID=*) eval $root; thedevice="$(/bin/busybox blkid | /bin/busybox grep "PARTUUID=\"${PARTUUID}\"" | /bin/busybox cut -d ':' -f 1)" ;;' >> initramfs/sbin/init
echo '    LABEL=*   ) eval $root; thedevice="$(/bin/busybox blkid | /bin/busybox grep "LABEL=\"${LABEL}\"" | /bin/busybox cut -d ':' -f 1)" ;;' >> initramfs/sbin/init
echo 'esac' >> initramfs/sbin/init

#HERE {
echo '/bin/busybox mount ${thedevice} mountpoint' >> initramfs/sbin/init

echo '/bin/busybox mount --bind dev mountpoint/dev' >> initramfs/sbin/init
echo '/bin/busybox mount --bind proc mountpoint/proc' >> initramfs/sbin/init
echo '/bin/busybox mount --bind sys mountpoint/sys' >> initramfs/sbin/init
echo 'exec /bin/busybox chroot mountpoint ${init}' >> initramfs/sbin/init

#}HERE

#echo "exec /bin/busybox sh" >> initramfs/sbin/init

#echo '/bin/busybox sh' >> initramfs/sbin/init

#echo '/bin/busybox ln -sf /dev/null /dev/tty2' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty3' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty4' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty5' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty6' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty7' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty8' >> initramfs/sbin/init
#echo '/bin/busybox ln -sf /dev/null /dev/tty9' >> initramfs/sbin/init




#echo '/bin/busybox mount /dev/disk/by-label/${THELABEL} mountpoint' >> initramfs/sbin/init
#echo 'exec /bin/busybox chroot mountpoint ${PREFIX}/${TARGET}/sbin/init-overlay.sh' >> initramfs/sbin/init

chmod +x initramfs/sbin/init

cp -a extractdest/busybox-*/busybox initramfs/bin/

cd initramfs

ln -s ./usr/${TARGET}/lib lib
ln -s ./usr/${TARGET}/lib lib64
ln -s ./sbin/init init

cd bin

ln -s busybox passwd

cd ..

find . -print0 | cpio --null -ov --format=newc \
  | gzip -9 > ../initramfs.cpio.gz

cd ..

#make an initramfs (end)

#enter directory containing this script
cd $(dirname $(realpath $0))

#copy the installer
cp installToHDD.sh rootfs${PREFIX}/${TARGET}/sbin/
chmod +x rootfs${PREFIX}/${TARGET}/sbin/installToHDD.sh

cp init-overlay.sh rootfs${PREFIX}/${TARGET}/sbin/
chmod +x rootfs${PREFIX}/${TARGET}/sbin/init-overlay.sh

#these dirs are required for init-overlay.sh script
mkdir rootfs/overlay
mkdir rootfs/overlay/tmpfs
mkdir rootfs/overlay/mountpoint

mkdir tempmount

#EFI

rm efiboot-new.img
mknod /dev/loop0 b 7 0
dd if=/dev/zero bs=1MB count=512 of=efiboot-new.img

/sbin/mkfs.vfat -n "BOOT_EFI" efiboot-new.img
mount -t vfat -o loop efiboot-new.img tempmount

cp initramfs.cpio.gz tempmount/initrd.img
cp initramfs.cpio.gz rootfs/boot/initrd.img-myixos
cd rootfs
ln -s boot/initrd.img-myixos initrd.img
cd ..
cp "$(find rootfs/boot/vmlinuz-*)" tempmount/

mkdir -p tempmount/EFI/BOOT/

cp extractdest/efilinux-*/efilinux.efi tempmount/EFI/BOOT/BOOTIA32.EFI
cp extractdest/efilinux-*/efilinux.efi tempmount/EFI/BOOT/BOOTX64.EFI

#
printf "%s 0:%s%s initrd=0:%sinitrd.img root=LABEL=%s console=tty0 init=%s/%s/sbin/init-overlay.sh\n" "-f" "\\" "$(basename rootfs/boot/vmlinuz-*)" "\\" "${THELABEL}" "${PREFIX}" "${TARGET}" > tempmount/EFI/BOOT/efilinux.cfg

umount tempmount

#MBR

mkdir -p rootfs/isolinux
cp -a extractdest/syslinux-*/bios/core/isolinux.bin rootfs/isolinux/
cp -a extractdest/syslinux-*/bios/com32/elflink/ldlinux/ldlinux.c32 rootfs/isolinux/
cp -a efiboot-new.img rootfs/isolinux/efiboot.img
mkdir rootfs/kernel
cp -a extractdest/syslinux-*/bios/memdisk/memdisk rootfs/kernel #copy bios/memdisk/memdisk

#although u-boot doesn't work for the cdrom, we use it in the installer
cp -a extractdest/u-boot-*/u-boot-payload.efi rootfs/isolinux/

#this config is for ISOLINUX
echo "MENU TITLE Boot Menu" > rootfs/isolinux/syslinux.cfg
echo "PROMPT 1" >> rootfs/isolinux/syslinux.cfg
echo "DEFAULT 1" >> rootfs/isolinux/syslinux.cfg
echo "" >> rootfs/isolinux/syslinux.cfg
echo "label 1" >> rootfs/isolinux/syslinux.cfg
echo "    MENU LABEL MyixOS" >> rootfs/isolinux/syslinux.cfg
#setting the path to the symlink /vmlinux doesn't work
echo "    KERNEL /boot/$(basename "$(find rootfs/boot/vmlinuz-*)")" >> rootfs/isolinux/syslinux.cfg
echo "    APPEND initrd=/boot/$(basename "$(find rootfs/boot/initrd.img*)") root=LABEL=${THELABEL} console=tty0 init=${PREFIX}/${TARGET}/sbin/init-overlay.sh" >> rootfs/isolinux/syslinux.cfg
echo "    TIMEOUT 1" >> rootfs/isolinux/syslinux.cfg

#create the root user
echo "root:x:0:0:root:/root:/bin/sh" > rootfs/etc/passwd
echo "root:x:0:" > rootfs/etc/group
chmod 644 rootfs/etc/passwd
chmod 644 rootfs/etc/group
chown root:root rootfs/etc/passwd
chown root:root rootfs/etc/group

#WRITE ISO

extractdest/xorriso-*/xorriso/xorriso -as mkisofs \
  -o myixos-$(echo "${1}" | cut -d '-' -f 1).iso \
  -V "${THELABEL}" \
  -isohybrid-mbr extractdest/syslinux-*/bios/mbr/isohdpfx.bin \
  -c isolinux/boot.cat \
  -b isolinux/isolinux.bin \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -eltorito-alt-boot \
  -no-emul-boot \
  -isohybrid-gpt-basdat \
  --xattr \
  -e isolinux/efiboot.img rootfs

##unmount stuff
#umount /proc
#umount /sys
#umount /dev/pts
