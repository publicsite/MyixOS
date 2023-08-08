#!/bin/sh

#export LD_LIBRARY_PATH="/usr/lib/i386-linux-gnu/wine:/usr/lib/i386-linux-gnu/wine/fakedlls"

#export LD_LIBRARY_PATH="/usr/i686-w64-mingw32/lib"

export PATH="${PWD}/crosscompiler/usr/bin:$PATH"

#./crosscompiler/usr/bin/i686-pc-mingw32-gcc -nostdlib helloworld.c -L/usr/lib/i386-linux-gnu/wine/fakedlls -lmsvcrt
#./crosscompiler/usr/bin/i686-pc-mingw32-gcc
#i686-w64-mingw32-gcc -nostdlib -lgcc helloworld.c -L/usr/i686-w64-mingw32/lib -lmsvcrt


#./crosscompiler/usr/bin/i686-w32-mingw32-gcc -nodefaultlibs helloworld.c -lmingwthrd -lmingw32 -lmingwex -lmoldname -lmsvcrt -ladvapi32 -lshell32 -luser32 -lkernel32 -lgcc


#THIS COMMAND IS KNOWN TO COMPILE OK WHEN USING A CHICKEN EGG MINGW:
#i686-w64-mingw32-gcc -nodefaultlibs helloworld.c -lmingwthrd -lmingw32 -lmingwex -lmoldname -lmsvcrt -ladvapi32 -lshell32 -luser32 -lkernel32 -lgcc

#THIS COMMAND IS ALSO KNOWN TO COMPILE OK WHEN USING A CHICKEN EGG MINGW:
#i686-w64-mingw32-gcc -nodefaultlibs helloworld.c -lmingw32 -lmingwex -lmsvcrt -lkernel32 -lgcc

i686-w64-mingw32-gcc -nodefaultlibs -nostdinc -I${PWD}/crosscompiler/usr/i686-w32-mingw32/include helloworld.c -lc

#test1
#i686-w32-mingw -nodefaultlibs -nostdinc helloworld.c -I/usr/include/wine/wine/windows -L/usr/lib/i386-linux-gnu/wine/fakedlls -ladvapi32 -lshell32 -luser32 -lkernel32

#test2
#i686-pc-cygwin-gcc -nodefaultlibs helloworld.c -L/usr/lib/i386-linux-gnu/wine/fakedlls -lmsvcrt -lkernel32 -lgcc
#i686-pc-cygwin-gcc -nodefaultlibs -nostdinc helloworld.c -I${PWD}/crosscompiler/usr/i686-pc-cygwin/include -L/usr/lib/i386-linux-gnu/wine/fakedlls -L${PWD}/crosscompiler/usr/i686-pc-cygwin/lib -I${PWD}/crosscompiler/usr/lib/gcc/i686-pc-cygwin/8.2.0/include -L${PWD}/crosscompiler/usr/lib/gcc/i686-pc-cygwin/8.2.0 -lc -ladvapi32 -lshell32 -luser32 -lkernel32 -lgcc