#!/bin/bash

OLD=$PWD

rm -rf static
cd ..


./build-8.0.1.sh
upx-ucl project-backend-exe

cp project-backend-exe $OLD
cp -r static $OLD 
cd $OLD 

tar -zcvpf spock8.keter config/keter.yaml project-backend-exe static
scp spock.keter spock8.kio.sx:keter

