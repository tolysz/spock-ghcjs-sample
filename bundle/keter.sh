#!/bin/bash

OLD=$PWD

rm -rf static
cd ..

rm static/*

./build-lts.sh
upx-ucl project-backend-exe

cp project-backend-exe $OLD
cp -r static $OLD 
cd $OLD

cd static
ccjs all.js --compilation_level=ADVANCED_OPTIMIZATIONS --language_in=ECMASCRIPT5 > all.adv.min.js
zopfli all.adv.min.js 
cp ../index2.html .
cd ..

tar -zcvpf spock.keter config/keter.yaml project-backend-exe static
scp spock.keter spock8.kio.sx:keter
