#!/bin/sh
winpwd="$(printf "%s" "$PWD" | sed "s#/#\\\#g")"
export PATH="${winpwd}\usr\i686-w64-mingw32\bin;${winpwd}\usr\i686-w64-mingw32\lib;${winpwd}\usr\i686-w64-mingw32\usr\bin;${winpwd}\usr\i686-w64-mingw32\usr\lib;$PATH"
sh