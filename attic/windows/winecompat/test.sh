#!/bin/sh
sudo mv /usr/i686-w64-mingw32/lib/libmsvcrt.a /usr/i686-w64-mingw32/lib/libmsvcrt.a.old
LD_LIBRARY_PATH="$PWD/../../crosscompiler/usr/lib/wine/fakedlls"
i686-w64-mingw32-gcc -nostdlib test.c -L${PWD}/../../crosscompiler/usr/lib/wine/fakedlls -lmsvcrt -L. -lwinecompat
sudo mv /usr/i686-w64-mingw32/lib/libmsvcrt.a.old /usr/i686-w64-mingw32/lib/libmsvcrt.a