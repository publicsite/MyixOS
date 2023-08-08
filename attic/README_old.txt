_____About_____

This is a GNU/Linux environment that can compile itself.

Cross compilation, and running on bare metal/emulators, is only partially tested,
but chroot at minimum, for the same architecture should work.

_____Building the system___________

1) cd to the directory containing the scripts

cd myBuildBootstrap

2) run buildToolchain script to build the toolchain

./buildAll.sh "$PWD" | tee 2>&1 temp.txt

#3) run the following command to link the libraries (this has to be run outside of the binutils script for some reason)
#
#/sbin/ldconfig -r installDir
#
_____Testing the system____________

1) chroot into the system with

sudo chroot installDir /bin/sh

2) you can view the copied source in the chroot by visiting the following directory

cd /root/myBuildBootstrap

3) and if you wish, can follow the steps in "Building the system" to perform a repeat clean compilation within the chroot.
_____________________________________________________________________________________________

note, if a build fails and you wish to repeat for any reason, you can perform the following steps in order to clean both
the extract directory (where sources are extracted to and then built), and also the install directory (where the chroot is):

rm -rf extractdest
sudo rm -rf installDir



