## About MyixOS

MyixOS is a self-hosted, source reproducable, GNU/Linux distribution; in the sense that when somebody says
"You can compile GNU/Linux completely from source",
we've actually gone and proven that fact;
not only have we produced an GNU/Linux operating system,
but we have produced and operating system capable of compiling itself.
You will see there is an Oroborous logo placed within the sources,
we use this as a kind of 'fun' proof mark:
If the operating system you currently use can compile MyixOS,
then you know you'd be safe if you liked computing and was stuck on a desert island;
for if you are able to compile MyixOS,
you have the capability to modify and repair the whole operating system.

The components of MyixOS were chosen carefully;
we tried to make a simple, yet functional operating system that supported as many architectures as possibile
and at the same time trying to keep the number of dependencies small.
The operating system was designed to follow upstream (too many modifications and a project becomes difficult to manage).

Amongst the things learnt during the writing of MyixOS was the fact that sometimes those documenting the third-party software weren't
100% accurate on the listing of the dependencies required to build their software.
Instead of following and installing the dependencies in the READMEs, we meticulously brute forced them ie. we started compilation
and installed the dependency only once a build failed.

One example of a misnomer is that GCC requires bash and coreutils.
In actual fact, gcc gets along quite nicely with just busybox (sh) and their minimal set of tools.
To answer the question of whether to compile GCC you will need a C++ compiler.
This much is true.

Which brings us to the next point.
The more dependencies developers add to the software listed in the buildToolchain and buildBase scripts,
the bigger the requirements for building GNU/Linux as a whole becomes.
A minimal operating system on a bad day can take that entire day to compile.
So let this be a warning to the GNU/Linux software ecosystem.
If people still want to be able to compile their own working operating system in say 30 years time,
they need to stop adding lots of new dependencies to said core packages.

Compiling GNU/Linux is supposed to be an easy task,
and that may be the case if you know where to look.
When I wrote MyixOS,
I didn't know where to look.
I saw lots of sources for packages on servers,
but rarely found the master build script(s) for the core set of packages,
by core, I mean an Oroborous-proof core.
It took me about half a year to get to a "working" chroot of the build scripts.
Maybe soon will be the day that when people say "You can compile GNU/Linux completely from source",
we will actually know (knowing being different from believing), for sure,
that it may now take less than a day to prove such a fact.

## Building the system

MyixOS only currently builds for 32 bit.

1) cd to the directory containing the scripts

cd myBuildBootstrap

2) run buildToolchain script to build the toolchain

\./buildToolchain.sh "$PWD" | tee 2>&1 temp.txt

## Testing the system

1) chroot into the system with

sudo chroot installDir /bin/sh

2) you can view the copied source in the chroot by visiting the following directory

cd /root/myBuildBootstrap

3) and if you wish, can follow the steps in "Building the system" to perform a repeat clean compilation within the chroot.

## Note

note, if a build fails and you wish to repeat for any reason, you can perform the following steps in order to clean both
the extract directory (where sources are extracted to and then built), and also the install directory (where the chroot is):

rm -rf extractdest
sudo rm -rf installDir



