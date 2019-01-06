{ stdenv, fetchFromGitHub
, vala, cmake, ninja, wrapGAppsHook, pkgconfig, gettext
, gobject-introspection, gnome3, glib, gdk_pixbuf, gtk3, glib-networking
, xorg, libXdmcp, libxkbcommon
, libnotify, libsoup
, libgcrypt
, epoxy
, at-spi2-core
, sqlite
, dbus
, gpgme
, pcre
, qrencode
, icu
 }:

stdenv.mkDerivation rec {
  name = "dino-unstable-2018-11-29";

  src = fetchFromGitHub {
    owner = "dino";
    repo = "dino";
    rev = "cdd4c0b854fd4d27fa1d9bd941df03888301780a";
    sha256 = "067s0s3z7yv55nydlb8vz66zmrb7rsy95a8n3668a3r9p20mm3ya";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    vala
    cmake
    ninja
    pkgconfig
    wrapGAppsHook
  ];

  buildInputs = [
    qrencode
    gobject-introspection
    glib-networking
    glib
    gnome3.libgee
    gnome3.defaultIconTheme
    sqlite
    gdk_pixbuf
    gtk3
    libnotify
    gpgme
    libgcrypt
    libsoup
    pcre
    xorg.libxcb
    xorg.libpthreadstubs
    libXdmcp
    libxkbcommon
    epoxy
    at-spi2-core
    dbus
    gettext
    icu
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Modern Jabber/XMPP Client using GTK+/Vala";
    homepage = https://github.com/dino/dino;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.mic92 ];
  };
}
