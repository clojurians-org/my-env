{ stdenv, dpkg, fetchurl, buildFHSUserEnv, qt5
}:

let 
  easyConnectFiles = stdenv.mkDerivation {
    name = "easyConnectFiles" ;
    src = fetchurl {
      url = http://download.sangfor.com.cn/download/product/sslvpn/pkg/linux_01/EasyConnect_x64.deb ;
      sha256 = "46f3fb2da61404e5f028fb6bc4eb12737a5dd75e1cef8cc3b6d502aa40a5bf4b" ;
    } ;

    unpackCmd = "dpkg -x $src ." ;
    sourceRoot = "." ;

    nativeBuildInputs = [ qt5.wrapQtAppsHook dpkg ] ;

    installPhase = ''
      mkdir $out
      cp -r * $out/
      chmod +x $out/usr/share/sangfor/EasyConnect/EasyConnect
    '' ;
  } ;
in
  buildFHSUserEnv {
    name = "easy-connect" ;

    targetPkgs = pkgs: [
      easyConnectFiles
      
      pkgs.fontconfig
      pkgs.atk
      pkgs.glib
      pkgs.gtk2
      pkgs.pango
      pkgs.gdk_pixbuf

      pkgs.cairo
      pkgs.freetype
      pkgs.dbus
      pkgs.dbus-glib
      
      pkgs.xorg.libX11
      pkgs.xorg.libxcb
      pkgs.xorg.libXi
      pkgs.xorg.libXcursor

      pkgs.xorg.libXdamage
      pkgs.xorg.libXrandr
      pkgs.xorg.libXcomposite
      pkgs.xorg.libXext
      pkgs.xorg.libXfixes
      pkgs.xorg.libXrender
      pkgs.xorg.libXtst
      
      pkgs.nss
      pkgs.nspr
      pkgs.alsaLib
      pkgs.cups
      pkgs.expat
    ] ;

    runScript = ''${easyConnectFiles}/usr/share/sangfor/EasyConnect/EasyConnect '' ;
  }

