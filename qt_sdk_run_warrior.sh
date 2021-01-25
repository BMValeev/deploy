#!/bin/bash
cd ~/openembedded-core/
cd meta-eleps/structure
cp -rf . ../..
cd ../..
export HOMEFOLDER=$(pwd)
source oe-init-build-env
cd .
cat <<EOM >${HOMEFOLDER}/build/conf/bblayers.conf
LCONF_VERSION = "7"
BBPATH = "\${TOPDIR}"
BBFILES ?= ""
BBLAYERS ?= " \
	${HOMEFOLDER}/meta \  
	${HOMEFOLDER}/meta-freescale \ 
	${HOMEFOLDER}/meta-solidrun-arm-imx6 \ 
	${HOMEFOLDER}/meta-qt5 \ 
  ${HOMEFOLDER}/meta-eleps \ 
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
    STOPTASKS,\${TMPDIR},1G,100K \ 
    STOPTASKS,\${DL_DIR},1G,100K \ 
    STOPTASKS,\${SSTATE_DIR},1G,100K \ 
    STOPTASKS,/tmp,100M,100K \ 
    ABORT,\${TMPDIR},100M,1K \ 
    ABORT,\${DL_DIR},100M,1K \ 
    ABORT,\${SSTATE_DIR},100M,1K \ 
    ABORT,/tmp,10M,1K"
CONF_VERSION = "1"
PARALLEL_MAKE ?= "-j 1"
BB_NUMBER_THREADS ?= "8"
MACHINE ??= "solidrun-imx6"
EXTRA_IMAGE_FEATURES = "debug-tweaks tools-debug dev-pkgs"
IMAGE_INSTALL += "gdbserver"
IMAGE_FEATURES += "ssh-server-openssh"
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
PACKAGECONFIG_append_pn-qtbase = " accessibility"
PACKAGECONFIG_append_pn-qtquickcontrols = " accessibility"
CORE_IMAGE_EXTRA_INSTALL += "firmware-imx-vpu-imx6d firmware-imx-vpu-imx6q" 
INHERIT += "buildhistory"
BUILDHISTORY_COMMIT = "1"
PACKAGECONFIG_append_pn-qtbase =" widgets"
PACKAGECONFIG_append_pn-qtbase =" icu"
DISTRO_FEATURES_append = " pam "
EOM
