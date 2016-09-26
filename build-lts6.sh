#!/bin/bash

shopt -s expand_aliases

export OLDPATH=$PATH

alias stackjs='stack --stack-yaml stack6-frontend.yaml'
alias stack7='stack --stack-yaml stack6.yaml'

stack7 setup
stack7 install alex happy hscolour
PATH=`stack7 path --bin-path 2>/dev/null`:$OLDPATH

echo SETUP
stackjs setup

# ls `stackjs path --local-install-root`/bin/project-frontend-exe.jsexe

stackjs build
# copy something somwhere
stack7 build


mkdir -p static

cp `stackjs path --local-install-root`/bin/project-frontend-exe.jsexe/* static

cp `stack7 path --local-install-root`/bin/project-backend-exe .
echo ./project-backend-exe

PATH=$OLDPATH
