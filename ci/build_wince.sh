#!/bin/sh
mkdir /var/lib/apt/lists/partial
apt-get update
apt-get install ssh git


mkdir wince && cd wince
cmake ../ -DCMAKE_TOOLCHAIN_FILE=Toolchain/arm-mingw32ce.cmake -DXSLTS=windows -DCACHE_SIZE=10485760 -Dsvg2png_scaling:STRING=16,32 -Dsvg2png_scaling_nav:STRING=32 -Dsvg2png_scaling_flag=16 -DSAMPLE_MAP=y 
make

mkdir output
cp navit/navit.exe output/
cp navit/navit.xml output/
cp -r locale/ output/
cp -r navit/icons/ output
mkdir output/maps
cp navit/maps/*.bin output/maps
cp navit/maps/*.xml output/maps

cd ..
bash ./navit/script/cabify.sh wince/output/navit.cab wince/
