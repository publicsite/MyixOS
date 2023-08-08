## About MyixOS

MyixOS is a self-hosted, source reproducible GNU/Linux distribution in the sense that when somebody says
"You can compile GNU/Linux completely from source,
we've actually gone and proven that fact;
not only have we produced a GNU/Linux operating system,
but we have produced an operating system capable of compiling itself.
You will see there is an Ouroboros logo in the docs directory of the sources,
we use this as a kind of 'fun' proof mark:
If the operating system you use can compile MyixOS,
then you know you'd be safe if you liked computing and was stuck on a desert island;
for if you are able to compile MyixOS, you have the capability to modify and repair the whole operating system.

The components of MyixOS were chosen carefully;
we tried to make a simple, yet functional operating system that supported as many architectures as possible
and at the same time, trying to keep the number of dependencies small.
The operating system was designed to follow upstream (but too many modifications and a project becomes difficult to manage).

Amongst the things learnt during the writing of MyixOS was the fact that sometimes those documenting the third-party software weren't
100% accurate on the listing of the dependencies required to build their software.
Instead of installing the dependencies in the READMEs, we meticulously brute forced them
i.e. we started compilation and installed the dependency only once the build failed.

One example of a misnomer is that GCC requires bash and coreutils.
In actual fact, GCC gets along quite nicely with just busybox (sh) and their minimal set of tools.
To answer the question of whether you really need a C++ compiler to compile GCC nowadays.
This much is true.

Which brings us to the next point.
The more dependencies developers add to the software required to bootstrap a GNU/Linux system from source,
the bigger the requirements for building GNU/Linux as a whole becomes.
A minimal operating system on a bad day, can take an entire day to compile.
So let this be a warning to the GNU/Linux ecosystem.
If people still want to compile their own working operating system in say 30 years time,
they need to stop adding lots of new dependencies to said core packages.

Compiling GNU/Linux is supposed to be an easy task, and that may be the case if you know where to look.
When I wrote MyixOS I didn't know where to look.
I found lots of sources for packages on servers, but rarely found the master build script(s) for the core set of packages,
by core, I mean an Ouroboros-proof core.

It took me about half a year to get to a "working" chroot of the build scripts. It didn't take long before I added a kernel and bootloader.
I then added the installation script to produce the first ISO release for the x86_64-linux-gnu platform.
MyixOS - a software 'clean room': Other platforms aside for x86_64 may work too but are not well tested.

Now when people say "You can compile GNU/Linux completely from source!" ...

We actually KNOW (knowing being different from believing) ...

That it's actually TRUE!

## Using the ISO

Boot the ISO in qemu as cdrom, and use a virtual hard drive. The ISO should be able to boot from both EFI and Legacy Boot.

When the ISO is booted

## Install myixos to the hard drive

	`/sbin/installToHDD.sh /dev/sda`

And follow the installation instructions.

When you're done,

shutdown the system with:

	`shutdown -hn now`

## Loading Keyboard Config

Boot to qemu without cdrom and only hard drive.

You will notice myixos works from a hard disk too.

Run
	`setupcon`

to load your keyboard layout

## To build myixos from source

	`cd /root/myBuildBootstrap && ./buildAll "$PWD" 2>&1 | tee temp.txt`

You will need to answer some questions as myixos compiles itself. It will take a long time.

After myixos has compiled itself:

	`cp -a tmp/data rootfs && ./buildISO.sh "x86_64-linux-gnu"`

To create an iso

Note that the code in /root/myBuildBootstrap should also be portable to other distributions that are not myixos, so that myixos is capable of bootstrapping from
not just itself, but other distros. This has been tested on debian, for example.

## Getting files in and out of Qemu and Myixos

	`mkdir mountpoint`

mounting the qcow

	`sudo modprobe nbd max_part=8`
	`sudo qemu-nbd --connect /dev/nbd0 thehdd.qcow`
	`sudo mount /dev/nbd0p2 mountpoint`

for example, copy the newly generated iso to your home directory

	`cp -a mountpoint/root/myBuildBootstrap/myixos-x86_64.iso ~/`

cleaning up

	`sudo umount mountpoint`
	`sudo qemu-nbd --disconnect /dev/nbd0`
	`sudo rmmod nbd`

## Notes

The stuff in /root/myBuildBootstrap (except for mainly /root/myBuildBootstrap/sourcedest) is copyright J05HYYY where that copyright applies.
(If you are getting the source code directly without downloading an ISO, then it's all copyright J05HYYY where that copyright applies.)

The code given is under the GNU General Public Licence v3.

## Donate

https://www.paypal.com/donate/?hosted_button_id=SZABYRV48SAXW