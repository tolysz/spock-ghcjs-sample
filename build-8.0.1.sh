#!/bin/bash

shopt -s expand_aliases

export OLDPATH=$PATH

alias stack8js='stack --stack-yaml stack80-frontend.yaml'
alias stack8='stack --stack-yaml stack80.yaml'

stack8 setup
stack8 install alex happy hscolour
PATH=`stack8 path --bin-path 2>/dev/null`:$OLDPATH

echo SETUP
stack8js setup

stack8js build
stack8 build

mkdir -p static

# copy something somwhere
cp `stack8js path --local-install-root`/bin/project-frontend-exe.jsexe/* static

cp `stack8 path --local-install-root`/bin/project-backend-exe .
echo ./project-backend-exe

PATH=$OLDPATH
