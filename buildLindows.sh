#!/bin/sh

#build wine
#"${myBuildHome}"/myBuilds/wine.myBuild get 2>&1 | tee "${myBuildHome}"/logs/wine.get.log
#"${myBuildHome}"/myBuilds/wine.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/wine.extract.log
#"${myBuildHome}"/myBuilds/wine.myBuild build 2>&1 | tee "${myBuildHome}"/logs/wine.build.log
#"${myBuildHome}"/myBuilds/wine.myBuild install 2>&1 | tee "${myBuildHome}"/logs/wine.install.log

export TARGET=$OLD_TARGET

#build our [canadian] Lindows toochain
#. "$1/buildToolchain.sh" "$PWD" 2>&1

export TARGET="i686-w64-mingw32"

#build our [canadian] Lindows toochain
. "$1/buildToolchain.sh" "$PWD" 2>&1