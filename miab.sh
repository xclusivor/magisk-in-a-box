#!/usr/bin/env bash

# Magisk in a Box
# Dockerized Magisk that let's you easily root boot images without the need for an Android device or emulator.
#
# Usage: ./miab.sh <32/64> <boot.img/AP...tar.md5>
#

if [ ! -d "host/" ]
then 
    mkdir host
fi

# Copy Magisk image tool
cp Magisk/native/out/x86_64/magiskboot .

if [ $1 == "32" ]
then 
    cp Magisk/native/out/armeabi-v7a/magiskinit .
    cp Magisk/native/out/armeabi-v7a/magisk magisk32
fi

if [ $1 == "64" ]
then
    cp Magisk/native/out/arm64-v8a/magiskinit .
    cp Magisk/native/out/arm64-v8a/magisk magisk64
fi

# Samsung support
is_samsung=false
if [[ $2 == *.tar.md5 ]]
then 
    echo "Extracting AP..."
    mkdir extracted
    7z e $2 -oextracted/

    lz4 -d extracted/boot.img.lz4
    cp extracted/boot.img .

    is_samsung=true
fi

sh boot_patch.sh boot.img

if [ "$is_samsung" = true ]
then 
    tar -H ustar -c boot.img > boot.tar
    (cat boot.tar; md5sum -t boot.tar ) > boot.tar.md5

    cp boot.tar.md5 host/
else
    cp boot.img host/
fi
