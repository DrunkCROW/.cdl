TERMUX_PKG_HOMEPAGE=https://github.com/KhronosGroup/OpenCL-CLHPP
TERMUX_PKG_DESCRIPTION="Khronos OpenCL C++ Headers"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2023.02.06
TERMUX_PKG_SRCURL=https://github.com/KhronosGroup/OpenCL-CLHPP/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=2726106df611fb5cb65503a52df27988d80c0b8844c8f0901c6092ab43701e8c
TERMUX_PKG_BUILD_DEPENDS="opencl-headers"
TERMUX_PKG_PLATFORM_INDEPENDENT=true
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_EXAMPLES=OFF
-DBUILD_TESTS=OFF
"
