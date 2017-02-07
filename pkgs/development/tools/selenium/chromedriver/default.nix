{ stdenv, fetchurl, cairo, fontconfig, freetype, gdk_pixbuf, glib
, glibc, gtk2, libX11, makeWrapper, nspr, nss, pango, unzip, gconf
, libXi, libXrender, libXext
, chromium
, libredirect
}:

# note: there is a i686 version available as well
assert stdenv.system == "x86_64-linux";

stdenv.mkDerivation rec {
  product = "chromedriver_linux64";
  version = "2.27";
  name = "${product}-${version}";

  src = fetchurl {
    url = "http://chromedriver.storage.googleapis.com/${version}/${product}.zip";
    sha256 = "0dxi1sbd2l4s3i1624ibl61mnfsy50ildan3jwk85jlx9lpl124w";
  };

  buildInputs = [ unzip makeWrapper ];

  unpackPhase = "unzip $src";

  # postPatch = ''
  #   sed -i "s,/opt/google/chrome,${chromium}/bin," chromedriver/chrome/chrome_finder.cc
  # '';

  installPhase = ''
    mkdir -p $out/bin
    mv chromedriver $out/bin
    patchelf --set-interpreter ${glibc.out}/lib/ld-linux-x86-64.so.2 $out/bin/chromedriver
    wrapProgram "$out/bin/chromedriver" \
      --prefix LD_LIBRARY_PATH : "${stdenv.lib.makeLibraryPath [ stdenv.cc.cc.lib cairo fontconfig freetype gdk_pixbuf glib gtk2 libX11 nspr nss pango libXrender gconf libXext libXi ]}:\$LD_LIBRARY_PATH"
      --set LD_PRELOAD "${libredirect}/lib/libredirect.so" \
      --set NIX_REDIRECTS "/opt/google/chrome=${chromium}/bin"
  '';

  meta = with stdenv.lib; {
    homepage = http://code.google.com/p/chromedriver/;
    description = "A WebDriver server for running Selenium tests on Chrome";
    license = licenses.bsd3;
    maintainers = [ maintainers.goibhniu ];
    platforms = platforms.linux;
  };
}
