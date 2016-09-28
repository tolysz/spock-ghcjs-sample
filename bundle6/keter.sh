#!/bin/bash

OLD=$PWD

rm -rf static
cd ..

rm static/*

./build-lts6.sh
upx-ucl project-backend-exe

cp project-backend-exe $OLD
cp -r static $OLD 
cd $OLD

tar -zcvpf spock6.keter config/keter.yaml project-backend-exe static
scp spock6.keter spock8.kio.sx:keter
