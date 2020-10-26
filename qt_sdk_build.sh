#!/bin/bash
git clone -b rocko  https://github.com/openembedded/openembedded-core.git
cd openembedded-core
git checkout 0d70ca998b3bdc18db6a5644f4ed8797fd0e7ddd
export HOMEFOLDER=$(pwd)
git clone -b rocko https://github.com/meta-qt5/meta-qt5.git
git clone -b rocko https://github.com/SolidRun/meta-solidrun-arm-imx6.git
git clone -b rocko https://github.com/Freescale/meta-freescale.git
git clone -b rocko https://github.com/openembedded/meta-openembedded.git
git clone -b 1.36 https://github.com/openembedded/bitbake.git
git clone -b rocko https://github.com/schnitzeltony/meta-qt5-extra.git
git clone -b rocko git://git.yoctoproject.org/meta-security
git clone -b rocko http://deploy:cjkvbh1234@192.168.0.12/SDK/meta-eleps.git
cd meta-qt5
git checkout fe6dbe144acbcbcbe37f5e9a07a08e414dbce036
cd ..
cd meta-eleps
git checkout b0ea942d54695d44ac104dbaa66abfcda05be27c
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
patch meta-solidrun-arm-imx6/dynamic-layers/qt5-layer/recipes-qt/qt5/qtbase_%.bbappend ~/deploy/0001.patch
