TERMUX_PKG_HOMEPAGE=https://docs.xfce.org/panel-plugins/xfce4-clipman-plugin/start
TERMUX_PKG_DESCRIPTION="Clipman is a clipboard manager for Xfce"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@termux"
_MAJOR_VERSION=1.6
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.3
TERMUX_PKG_SRCURL=https://archive.xfce.org/src/panel-plugins/xfce4-clipman-plugin/${_MAJOR_VERSION}/xfce4-clipman-plugin-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=e11c1f976217fc959cee98ecfb934058ae485cb363d2c25c7ddede44394c9a10
TERMUX_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libqrencode, libsm, libx11, libxfce4ui, libxfce4util, libxtst, pango, xfce4-panel, xfconf, zlib"
