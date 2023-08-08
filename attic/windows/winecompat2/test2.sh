#!/bin/sh
#sudo mv /usr/i686-w64-mingw32/lib/libmsvcrt.a /usr/i686-w64-mingw32/lib/libmsvcrt.a.old
#LD_LIBRARY_PATH="$PWD/../../crosscompiler/usr/lib/wine/fakedlls:$PWD/../../crosscompiler/usr/lib"
#PATH="$PWD/../../crosscompiler/usr/bin"
#winebuild --def -E libwinecompat.spec -o libwinecompat.def

#winegcc -shared -o libwinecompat.dll -L$PWD/../../extractdest3/wine-4.3/dlls -lmsvcrt

LD_LIBRARY_PATH="/usr/lib/i386-linux-gnu/wine"

gcc test.c -L/usr/lib/i386-linux-gnu/wine -lwine

#winegcc -shared -o libwinecompat.dll -D__WINESRC__ -I$PWD/../../extractdest3/wine-4.3/include $PWD/../../extractdest3/wine-4.3/dlls/msvcrt/exit.o $PWD/../../extractdest3/wine-4.3/dlls/msvcrt/file.o -ladvapi32
#winegcc -shared -o libwinecompat.dll -I$PWD/../../extractdest3/wine-4.3/include $PWD/../../extractdest3/wine-4.3/dlls/msvcrt/exit.o $PWD/../../extractdest3/wine-4.3/dlls/msvcrt/file.o $PWD/../../extractdest3/wine-4.3/dlls/advapi32/libadvapi32.def $PWD/../../extractdest3/wine-4.3/dlls/user32/libuser32.def \
#  $PWD/../../extractdest3/wine-4.3/dlls/kernel32/libkernel32.def $PWD/../../extractdest3/wine-4.3/dlls/ntdll/libntdll.def \
#  $PWD/../../extractdest3/wine-4.3/dlls/winecrt0/libwinecrt0.a $PWD/../../extractdest3/wine-4.3/libs/port/libwine_port.a $PWD/../../extractdest3/wine-4.3/tools/winebuild/winebuild \
#  $PWD/../../extractdest3/wine-4.3/tools/winegcc/winegcc

#i686-w64-mingw32-gcc -nostdlib test.c -L${PWD}/../../crosscompiler/usr/lib/wine/fakedlls -lmsvcrt -L. -lwinecompat
#sudo mv /usr/i686-w64-mingw32/lib/libmsvcrt.a.old /usr/i686-w64-mingw32/lib/libmsvcrt.a