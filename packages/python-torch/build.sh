TERMUX_PKG_HOMEPAGE=https://pytorch.org/
TERMUX_PKG_DESCRIPTION="Tensors and Dynamic neural networks in Python"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.0.0
TERMUX_PKG_SRCURL=git+https://github.com/pytorch/pytorch
TERMUX_PKG_DEPENDS="python, python-numpy, libopenblas, libprotobuf, libzmq, ffmpeg, opencv"
TERMUX_PKG_HOSTBUILD=true
TERMUX_PKG_PYTHON_COMMON_DEPS="wheel, pyyaml, typing_extensions"
TERMUX_PKG_BUILD_IN_SRC=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DANDROID_NO_TERMUX=OFF
-DBUILD_CUSTOM_PROTOBUF=OFF
-DBUILD_PYTHON=ON
-DBUILD_TEST=OFF
-DCMAKE_CXX_STANDARD=14
-DCMAKE_BUILD_TYPE=Release
-DCMAKE_INSTALL_PREFIX=${TERMUX_PKG_SRCDIR}/torch
-DCMAKE_PREFIX_PATH=${TERMUX_PREFIX}/lib/python${TERMUX_PYTHON_VERSION}/site-packages
-DNUMPY_INCLUDE_DIR=${TERMUX_PREFIX}/lib/python${TERMUX_PYTHON_VERSION}/site-packages/numpy/core/include
-DOpenBLAS_INCLUDE_DIR=${TERMUX_PREFIX}/include/openblas
-DPYTHON_INCLUDE_DIR=${TERMUX_PREFIX}/include/python${TERMUX_PYTHON_VERSION}
-DPYTHON_LIBRARY=${TERMUX_PREFIX}/lib//libpython${TERMUX_PYTHON_VERSION}.so
-DNATIVE_BUILD_DIR=${TERMUX_PKG_HOSTBUILD_DIR}
-DTORCH_BUILD_VERSION=${TERMUX_PKG_VERSION}
-DUSE_NUMPY=ON
-DUSE_OPENCV=ON
-DUSE_FFMPEG=ON
-DUSE_ZMQ=ON
-DUSE_CUDA=OFF
-DUSE_FAKELOWP=OFF
-DUSE_FBGEMM=OFF
-DUSE_ITT=OFF
-DUSE_MAGMA=OFF
-DUSE_METAL=OFF
-DUSE_NCCL=OFF
-DUSE_NNPACK=OFF
-DCXX_AVX512_FOUND=OFF
-DCXX_AVX2_FOUND=OFF
"

TERMUX_PKG_RM_AFTER_INSTALL="lib/pkgconfig/sleef.pc"

termux_step_host_build() {
	termux_setup_cmake
	cmake "$TERMUX_PKG_SRCDIR/third_party/sleef"
	make -j "$TERMUX_MAKE_PROCESSES" mkrename mkrename_gnuabi mkmasked_gnuabi mkalias mkdisp
}

termux_step_pre_configure() {
	find "$TERMUX_PKG_SRCDIR" -name CMakeLists.txt -o -name '*.cmake' | \
		xargs -n 1 sed -i \
		-e 's/\([^A-Za-z0-9_]ANDROID\)\([^A-Za-z0-9_]\)/\1_NO_TERMUX\2/g' \
		-e 's/\([^A-Za-z0-9_]ANDROID\)$/\1_NO_TERMUX/g'

	termux_setup_protobuf

	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+="
	-DPYTHON_EXECUTABLE=$(command -v python3)
	-DPROTOBUF_PROTOC_EXECUTABLE=$(command -v protoc)
	-DCAFFE2_CUSTOM_PROTOC_EXECUTABLE=$(command -v protoc)
	"
}

termux_step_make_install() {
	pip -v install --prefix $TERMUX_PREFIX "$TERMUX_PKG_SRCDIR"
	ln -s ${TERMUX_PREFIX}/lib/python3.10/site-packages/torch/lib/*.so ${TERMUX_PREFIX}/lib
}

termux_step_create_debscripts() {
	echo "#!$TERMUX_PREFIX/bin/sh" > postinst
	echo "pip3 install typing_extensions" >> postinst
}
