#!/bin/bash

#git clone https://github.com/ptitSeb/gl4es.git
#cd gl4es

git checkout mirror

mkdir build-aarch64 && cd build-aarch64
CC=gcc-10 CXX=g++-10 cmake .. \
 -DNOX11=ON -DGLX_STUBS=ON -DEGL_WRAPPER=ON -DGBM=ON
make -j8
cd ..
mv lib gl4es.aarch64

mkdir build-armhf && cd build-armhf
PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig \
  CC=arm-linux-gnueabihf-gcc-10 CXX=arm-linux-gnueabihf-g++-10 cmake .. \
  -DNOX11=ON -DGLX_STUBS=ON -DEGL_WRAPPER=ON -DGBM=ON
make -j8
cd ..
mv lib gl4es.armhf

# gl4es shim
mkdir build-shim-aarch64 && cd build-shim-aarch64
CC=gcc-10 CXX=g++-10 cmake .. \
 -DCMAKE_BUILD_TYPE=Release -DNOX11=ON -DGLX_STUBS=ON \
 -DGBM=OFF -DNOEGL=ON
make -j8
cd ..
mv lib gl4es.shim.aarch64

mkdir build-shim-armhf && cd build-shim-armhf
PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig \
 CC=arm-linux-gnueabihf-gcc-10 CXX=arm-linux-gnueabihf-g++-10 cmake .. \
 -DCMAKE_BUILD_TYPE=Release -DNOX11=ON -DGLX_STUBS=ON \
 -DGBM=OFF -DNOEGL=ON
make -j8
cd ..
mv lib gl4es.shim.armhf

zip -r gl4es.zip ./gl4es.*aarch64 ./gl4es.*armhf
