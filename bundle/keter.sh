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

tar -zcvpf spock.keter config/keter.yaml project-backend-exe static
scp spock.keter spock8.kio.sx:keter
