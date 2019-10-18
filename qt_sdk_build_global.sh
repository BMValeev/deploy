#!/bin/bash
git clone -b rocko  https://github.com/openembedded/openembedded-core.git
cd openembedded-core
export HOMEFOLDER=$(pwd)
git clone -b rocko https://github.com/meta-qt5/meta-qt5.git
git clone -b rocko https://github.com/SolidRun/meta-solidrun-arm-imx6.git
git clone -b rocko https://github.com/Freescale/meta-freescale.git
git clone -b rocko https://github.com/openembedded/meta-openembedded.git
git clone -b 1.36 https://github.com/openembedded/bitbake.git
git clone -b rocko https://github.com/schnitzeltony/meta-qt5-extra.git
git clone -b rocko git://git.yoctoproject.org/meta-security
cd meta-qt5
git checkout fe6dbe144acbcbcbe37f5e9a07a08e414dbce036
cd ..
cd meta-freescale
git checkout affb4b17d3d97ae45bdc4887268ba1d88fccd876
cd ..
cd meta-openembedded
git checkout dacfa2b1920e285531bec55cd2f08743390aaf57
cd ..
cd bitbake
git checkout d0fb46eead1f23356d8c3bd53a85047521ef29a7
cd ..
cd meta-solidrun-arm-imx6
git checkout d567d75be8984bd868df9af6108f12fecb049c2d
cd ..
cd meta-qt5-extra
git checkout 79e26686520f2ce5f743975e90116b263a33697f
cd ..
#patch meta-solidrun-arm-imx6/dynamic-layers/qt5-layer/recipes-qt/qt5/qtbase_%.bbappend 0001.patch
source oe-init-build-env
cd 
cat <<EOM >${HOMEFOLDER}/build/conf/bblayers.conf
LCONF_VERSION = "7"
BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
	${HOMEFOLDER}/meta \ 
	${HOMEFOLDER}/meta-freescale \
	${HOMEFOLDER}/meta-solidrun-arm-imx6 \
	${HOMEFOLDER}/meta-qt5 \
	${HOMEFOLDER}/meta-openembedded/meta-filesystems/ \
	${HOMEFOLDER}/meta-openembedded/meta-oe/ \
	${HOMEFOLDER}/meta-openembedded/meta-perl/ \
	${HOMEFOLDER}/meta-openembedded/meta-python/ \
	${HOMEFOLDER}/meta-openembedded/meta-networking/ \
	${HOMEFOLDER}/meta-openembedded/meta-multimedia/ \
	${HOMEFOLDER}/meta-security/ \
	${HOMEFOLDER}/meta-qt5-extra \
  "
EOM

cat <<EOM >${HOMEFOLDER}/build/conf/local.conf

BB_DISKMON_DIRS ??= "\
    STOPTASKS,${TMPDIR},1G,100K \
    STOPTASKS,${DL_DIR},1G,100K \
    STOPTASKS,${SSTATE_DIR},1G,100K \
    STOPTASKS,/tmp,100M,100K \
    ABORT,${TMPDIR},100M,1K \
    ABORT,${DL_DIR},100M,1K \
    ABORT,${SSTATE_DIR},100M,1K \
    ABORT,/tmp,10M,1K"


CONF_VERSION = "1"
PARALLEL_MAKE ?= "-j 4"
BB_NUMBER_THREADS ?= "8"
MACHINE ??= "solidrun-imx6"
EXTRA_IMAGE_FEATURES = "debug-tweaks tools-debug dev-pkgs"
PACKAGECONFIG_append_pn-qtbase = " accessibility"
PACKAGECONFIG_append_pn-qtquickcontrols = " accessibility"
IMAGE_INSTALL += "gdbserver"
IMAGE_FEATURES += "ssh-server-openssh"
#INHERIT += "rm_work"
ACCEPT_FSL_EULA = "1"
LICENSE_FLAGS_WHITELIST = "commercial"
PACKAGE_CLASSES = "package_deb "
SSTATE_MIRRORS = ""
INCOMPATIBLE_LICENSE = ""
SDKMACHINE = "x86_64"
LINGUAS_INSTALL = ""
CVS_PROXY_HOST = ""
CVS_PROXY_PORT = ""
DISTRO_FEATURES_remove += "x11 directfb"
DISTRO_FEATURES_append += "wayland opengl libwayland-egl"

EOM


