#!/bin/sh

####THE FOLLOWING IS REQUIRED FOR GRAPHICAL DISPLAY { #####

#for xorg-server
#"${myBuildHome}"/myBuilds/pixman.myBuild get 2>&1 | tee "${myBuildHome}"/logs/pixman.get.log
#"${myBuildHome}"/myBuilds/pixman.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/pixman.extract.log
#"${myBuildHome}"/myBuilds/pixman.myBuild build 2>&1 | tee "${myBuildHome}"/logs/pixman.build.log
#"${myBuildHome}"/myBuilds/pixman.myBuild install 2>&1 | tee "${myBuildHome}"/logs/pixman.install.log

#for building xkbfile
#"${myBuildHome}"/myBuilds/xproto.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xproto.get.log
#"${myBuildHome}"/myBuilds/xproto.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xproto.extract.log
#"${myBuildHome}"/myBuilds/xproto.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xproto.build.log
#"${myBuildHome}"/myBuilds/xproto.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xproto.install.log

#for building xkbfile
#"${myBuildHome}"/myBuilds/kbproto.myBuild get 2>&1 | tee "${myBuildHome}"/logs/kbproto.get.log
#"${myBuildHome}"/myBuilds/kbproto.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/kbproto.extract.log
#"${myBuildHome}"/myBuilds/kbproto.myBuild build 2>&1 | tee "${myBuildHome}"/logs/kbproto.build.log
#"${myBuildHome}"/myBuilds/kbproto.myBuild install 2>&1 | tee "${myBuildHome}"/logs/kbproto.install.log

#for building xkbfile
#"${myBuildHome}"/myBuilds/libpthread-stubs.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libpthread-stubs.get.log
#"${myBuildHome}"/myBuilds/libpthread-stubs.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libpthread-stubs.extract.log
#"${myBuildHome}"/myBuilds/libpthread-stubs.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libpthread-stubs.build.log
#"${myBuildHome}"/myBuilds/libpthread-stubs.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libpthread-stubs.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xkbfile.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xkbfile.get.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xkbfile.extract.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xkbfile.build.log
#"${myBuildHome}"/myBuilds/xkbfile.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xkbfile.install.log

#for xfont
#"${myBuildHome}"/myBuilds/freetype.myBuild get 2>&1 | tee "${myBuildHome}"/logs/freetype.get.log
#"${myBuildHome}"/myBuilds/freetype.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/freetype.extract.log
#"${myBuildHome}"/myBuilds/freetype.myBuild build 2>&1 | tee "${myBuildHome}"/logs/freetype.build.log
#"${myBuildHome}"/myBuilds/freetype.myBuild install 2>&1 | tee "${myBuildHome}"/logs/freetype.install.log

#for xfont
#"${myBuildHome}"/myBuilds/fontenc.myBuild get 2>&1 | tee "${myBuildHome}"/logs/fontenc.get.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/fontenc.extract.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild build 2>&1 | tee "${myBuildHome}"/logs/fontenc.build.log
#"${myBuildHome}"/myBuilds/fontenc.myBuild install 2>&1 | tee "${myBuildHome}"/logs/fontenc.install.log

#for building xfont
#"${myBuildHome}"/myBuilds/xorgproto.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xorgproto.get.log
#"${myBuildHome}"/myBuilds/xorgproto.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xorgproto.extract.log
#"${myBuildHome}"/myBuilds/xorgproto.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xorgproto.build.log
#"${myBuildHome}"/myBuilds/xorgproto.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xorgproto.install.log

#for building xfont
#"${myBuildHome}"/myBuilds/xtrans.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xtrans.get.log
#"${myBuildHome}"/myBuilds/xtrans.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xtrans.extract.log
#"${myBuildHome}"/myBuilds/xtrans.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xtrans.build.log
#"${myBuildHome}"/myBuilds/xtrans.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xtrans.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xfont.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xfont.get.log
#"${myBuildHome}"/myBuilds/xfont.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xfont.extract.log
#"${myBuildHome}"/myBuilds/xfont.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xfont.build.log
#"${myBuildHome}"/myBuilds/xfont.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xfont.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/pkg-config.myBuild get 2>&1 | tee "${myBuildHome}"/logs/pkg-config.get.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/pkg-config.extract.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild build 2>&1 | tee "${myBuildHome}"/logs/pkg-config.build.log
#"${myBuildHome}"/myBuilds/pkg-config.myBuild install 2>&1 | tee "${myBuildHome}"/logs/pkg-config.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/pciaccess.myBuild get 2>&1 | tee "${myBuildHome}"/logs/pciaccess.get.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/pciaccess.extract.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild build 2>&1 | tee "${myBuildHome}"/logs/pciaccess.build.log
#"${myBuildHome}"/myBuilds/pciaccess.myBuild install 2>&1 | tee "${myBuildHome}"/logs/pciaccess.install.log

#for libepoxy
"${myBuildHome}"/myBuilds/util-macros.myBuild get 2>&1 | tee "${myBuildHome}"/logs/util-macros.get.log
"${myBuildHome}"/myBuilds/util-macros.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/util-macros.extract.log
"${myBuildHome}"/myBuilds/util-macros.myBuild build 2>&1 | tee "${myBuildHome}"/logs/util-macros.build.log
"${myBuildHome}"/myBuilds/util-macros.myBuild install 2>&1 | tee "${myBuildHome}"/logs/util-macros.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/autogen.myBuild get 2>&1 | tee "${myBuildHome}"/logs/autogen.get.log
##"${myBuildHome}"/myBuilds/autogen.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/autogen.extract.log
##"${myBuildHome}"/myBuilds/autogen.myBuild build 2>&1 | tee "${myBuildHome}"/logs/autogen.build.log
##"${myBuildHome}"/myBuilds/autogen.myBuild install 2>&1 | tee "${myBuildHome}"/logs/autogen.install.log

#for libepoxy
#"${myBuildHome}"/myBuilds/libtool.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libtool.get.log
#"${myBuildHome}"/myBuilds/libtool.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libtool.extract.log
#"${myBuildHome}"/myBuilds/libtool.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libtool.build.log
#"${myBuildHome}"/myBuilds/libtool.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libtool.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libepoxy.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libepoxy.get.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libepoxy.extract.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libepoxy.build.log
#"${myBuildHome}"/myBuilds/libepoxy.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libepoxy.install.log

#for xrandr
#"${myBuildHome}"/myBuilds/xrender.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xrender.get.log
#"${myBuildHome}"/myBuilds/xrender.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xrender.extract.log
#"${myBuildHome}"/myBuilds/xrender.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xrender.build.log
#"${myBuildHome}"/myBuilds/xrender.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xrender.install.log

#for mesa
#"${myBuildHome}"/myBuilds/xrandr.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xrandr.get.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xrandr.extract.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xrandr.build.log
#"${myBuildHome}"/myBuilds/xrandr.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xrandr.install.log

#for mesa
#"${myBuildHome}"/myBuilds/libdrm.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libdrm.get.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libdrm.extract.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libdrm.build.log
#"${myBuildHome}"/myBuilds/libdrm.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libdrm.install.log

#for mesa
#"${myBuildHome}"/myBuilds/expat.myBuild get 2>&1 | tee "${myBuildHome}"/logs/expat.get.log
#"${myBuildHome}"/myBuilds/expat.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/expat.extract.log
#"${myBuildHome}"/myBuilds/expat.myBuild build 2>&1 | tee "${myBuildHome}"/logs/expat.build.log
#"${myBuildHome}"/myBuilds/expat.myBuild install 2>&1 | tee "${myBuildHome}"/logs/expat.install.log

#for xorg-server, because egl is required for building xorg
#"${myBuildHome}"/myBuilds/mesa.myBuild get 2>&1 | tee "${myBuildHome}"/logs/mesa.get.log
#"${myBuildHome}"/myBuilds/mesa.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/mesa.extract.log
#"${myBuildHome}"/myBuilds/mesa.myBuild build 2>&1 | tee "${myBuildHome}"/logs/mesa.build.log
#"${myBuildHome}"/myBuilds/mesa.myBuild install 2>&1 | tee "${myBuildHome}"/logs/mesa.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xinit.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xinit.get.log
#"${myBuildHome}"/myBuilds/xinit.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xinit.extract.log
#"${myBuildHome}"/myBuilds/xinit.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xinit.build.log
#"${myBuildHome}"/myBuilds/xinit.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xinit.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libX11/libx11.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libx11.get.log
#"${myBuildHome}"/myBuilds/libX11/libx11.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libx11.extract.log
#"${myBuildHome}"/myBuilds/libX11/libx11.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libx11.build.log
#"${myBuildHome}"/myBuilds/libX11/libx11.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libx11.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libxcb.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxcb.get.log
#"${myBuildHome}"/myBuilds/libxcb.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxcb.extract.log
#"${myBuildHome}"/myBuilds/libxcb.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxcb.build.log
#"${myBuildHome}"/myBuilds/libxcb.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxcb.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libxau.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxau.get.log
#"${myBuildHome}"/myBuilds/libxau.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxau.extract.log
#"${myBuildHome}"/myBuilds/libxau.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxau.build.log
#"${myBuildHome}"/myBuilds/libxau.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxau.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libxdmcp.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxdmcp.get.log
#"${myBuildHome}"/myBuilds/libxdmcp.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxdmcp.extract.log
#"${myBuildHome}"/myBuilds/libxdmcp.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxdmcp.build.log
#"${myBuildHome}"/myBuilds/libxdmcp.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxdmcp.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libxshmfence.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxshmfence.get.log
#"${myBuildHome}"/myBuilds/libxshmfence.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxshmfence.extract.log
#"${myBuildHome}"/myBuilds/libxshmfence.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxshmfence.build.log
#"${myBuildHome}"/myBuilds/libxshmfence.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxshmfence.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/libpng.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libpng.get.log
#"${myBuildHome}"/myBuilds/libpng.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libpng.extract.log
#"${myBuildHome}"/myBuilds/libpng.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libpng.build.log
#"${myBuildHome}"/myBuilds/libpng.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libpng.install.log

#for xorg-server (should double check if xkeyboardconfig error appears in x w/o this)
#"${myBuildHome}"/myBuilds/xkbcomp.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xkbcomp.get.log
#"${myBuildHome}"/myBuilds/xkbcomp.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xkbcomp.extract.log
#"${myBuildHome}"/myBuilds/xkbcomp.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xkbcomp.build.log
#"${myBuildHome}"/myBuilds/xkbcomp.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xkbcomp.install.log

#for xorg-server
#"${myBuildHome}"/myBuilds/xkeyboard-config.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xkeyboard-config.get.log
#"${myBuildHome}"/myBuilds/xkeyboard-config.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xkeyboard-config.extract.log
#"${myBuildHome}"/myBuilds/xkeyboard-config.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xkeyboard-config.build.log
#"${myBuildHome}"/myBuilds/xkeyboard-config.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xkeyboard-config.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/libxdamage.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxdamage.get.log
##"${myBuildHome}"/myBuilds/libxdamage.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxdamage.extract.log
##"${myBuildHome}"/myBuilds/libxdamage.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxdamage.build.log
##"${myBuildHome}"/myBuilds/libxdamage.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxdamage.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/libxfixes.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxfixes.get.log
##"${myBuildHome}"/myBuilds/libxfixes.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxfixes.extract.log
##"${myBuildHome}"/myBuilds/libxfixes.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxfixes.build.log
##"${myBuildHome}"/myBuilds/libxfixes.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxfixes.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/libxxf86vm.myBuild get 2>&1 | tee "${myBuildHome}"/logs/libxxf86vm.get.log
##"${myBuildHome}"/myBuilds/libxxf86vm.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/libxxf86vm.extract.log
##"${myBuildHome}"/myBuilds/libxxf86vm.myBuild build 2>&1 | tee "${myBuildHome}"/logs/libxxf86vm.build.log
##"${myBuildHome}"/myBuilds/libxxf86vm.myBuild install 2>&1 | tee "${myBuildHome}"/logs/libxxf86vm.install.log

####THE FOLLOWING ARE XORG DRIVERS { #####

#NOT NEEDED
##"${myBuildHome}"/myBuilds/xf86-video-fbdev.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xf86-video-fbdev.get.log
##"${myBuildHome}"/myBuilds/xf86-video-fbdev.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xf86-video-fbdev.extract.log
##"${myBuildHome}"/myBuilds/xf86-video-fbdev.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xf86-video-fbdev.build.log
##"${myBuildHome}"/myBuilds/xf86-video-fbdev.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xf86-video-fbdev.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/xf86-video-vesa.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xf86-video-vesa.get.log
##"${myBuildHome}"/myBuilds/xf86-video-vesa.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xf86-video-vesa.extract.log
##"${myBuildHome}"/myBuilds/xf86-video-vesa.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xf86-video-vesa.build.log
##"${myBuildHome}"/myBuilds/xf86-video-vesa.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xf86-video-vesa.install.log

#for xorg-server (keyboard input)
#"${myBuildHome}"/myBuilds/xf86-input-keyboard.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xf86-input-keyboard.get.log
#"${myBuildHome}"/myBuilds/xf86-input-keyboard.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xf86-input-keyboard.extract.log
#"${myBuildHome}"/myBuilds/xf86-input-keyboard.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xf86-input-keyboard.build.log
#"${myBuildHome}"/myBuilds/xf86-input-keyboard.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xf86-input-keyboard.install.log

#for xorg-server (mouse input)
#"${myBuildHome}"/myBuilds/xf86-input-mouse.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xf86-input-mouse.get.log
#"${myBuildHome}"/myBuilds/xf86-input-mouse.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xf86-input-mouse.extract.log
#"${myBuildHome}"/myBuilds/xf86-input-mouse.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xf86-input-mouse.build.log
#"${myBuildHome}"/myBuilds/xf86-input-mouse.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xf86-input-mouse.install.log

#NOT NEEDED
##"${myBuildHome}"/myBuilds/xf86-video-cirrus.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xf86-video-cirrus.get.log
##"${myBuildHome}"/myBuilds/xf86-video-cirrus.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xf86-video-cirrus.extract.log
##"${myBuildHome}"/myBuilds/xf86-video-cirrus.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xf86-video-cirrus.build.log
##"${myBuildHome}"/myBuilds/xf86-video-cirrus.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xf86-video-cirrus.install.log

#### } THE PREVIOUS WAS XORG DRIVERS #####

#for wine, at the moment X.org is preferred. https://bugs.winehq.org/show_bug.cgi?id=42284
#"${myBuildHome}"/myBuilds/xorg-server.myBuild get 2>&1 | tee "${myBuildHome}"/logs/xorg-server.get.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild extract 2>&1 | tee "${myBuildHome}"/logs/xorg-server.extract.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild build 2>&1 | tee "${myBuildHome}"/logs/xorg-server.build.log
#"${myBuildHome}"/myBuilds/xorg-server.myBuild install 2>&1 | tee "${myBuildHome}"/logs/xorg-server.install.log

#### } THE PREVIOUS WAS REQUIRED FOR GRAPHICAL DISPLAY #####