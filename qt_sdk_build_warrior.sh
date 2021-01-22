##!/bin/bash
HASH_CORE=0d70ca998b3bdc18db6a5644f4ed8797fd0e7ddd
HASH_QT5=9248dc741f4e051d8d8578b7e04681cbae182c69
HASH_SOLIDRUN=d567d75be8984bd868df9af6108f12fecb049c2d
HASH_FREESCALE=affb4b17d3d97ae45bdc4887268ba1d88fccd876
HASH_OPENEMBEDDED=dacfa2b1920e285531bec55cd2f08743390aaf57
HASH_QT5_EXTRA=79e26686520f2ce5f743975e90116b263a33697f
HASH_ELEPS=b0ea942d54695d44ac104dbaa66abfcda05be27c
git clone -b rocko https://github.com/openembedded/openembedded-core.git
cd openembedded-core && git checkout $HASH_CORE
git clone -b 1.36 https://github.com/openembedded/bitbake.git
git clone -b rocko git://git.yoctoproject.org/meta-security
git clone -b warrior https://github.com/meta-qt5/meta-qt5.git
git clone -b rocko https://github.com/SolidRun/meta-solidrun-arm-imx6.git
git clone -b rocko https://github.com/Freescale/meta-freescale.git
git clone -b rocko https://github.com/openembedded/meta-openembedded.git
git clone -b rocko https://github.com/schnitzeltony/meta-qt5-extra.git
git clone -b rocko http://deploy:cjkvbh1234@192.168.0.12/SDK/meta-eleps.git
cd bitbake && git checkout d0fb46eead1f23356d8c3bd53a85047521ef29a7 && cd ..
cd meta-qt5 && git checkout $HASH_QT5 && cd ..
cd meta-solidrun-arm-imx6 && git checkout $HASH_SOLIDRUN && cd ..
cd meta-freescale && git checkout $HASH_FREESCALE && cd ..
cd meta-openembedded && git checkout $HASH_OPENEMBEDDED && cd ..
cd meta-qt5-extra && git checkout $HASH_QT5_EXTRA && cd ..
cd meta-eleps && git checkout $HASH_ELEPS && cd ..



