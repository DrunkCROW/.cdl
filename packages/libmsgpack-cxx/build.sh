TERMUX_PKG_HOMEPAGE=https://msgpack.org/
TERMUX_PKG_DESCRIPTION="msgpack for C++"
TERMUX_PKG_LICENSE="BSL-1.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=4.0.3
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/msgpack/msgpack-c/releases/download/cpp-${TERMUX_PKG_VERSION}/msgpack-cxx-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=9b3c1803b9855b7b023d7f181f66ebb0d6941275ba41d692037e0aa27736443f
TERMUX_PKG_DEPENDS="boost"
TERMUX_PKG_BUILD_DEPENDS="boost-headers"
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

termux_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(termux_github_api_get_tag "${TERMUX_PKG_SRCURL}")"
	# check if this is not a c release:
	if grep -qP "^cpp-${TERMUX_PKG_UPDATE_VERSION_REGEXP}$" <<<"$tag"; then
		termux_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update of ${TERMUX_PKG_NAME}: Not a cpp release($tag)"
	fi
}
