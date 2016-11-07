#!/bin/bash

shopt -s expand_aliases

export OLDPATH=$PATH

alias stackjs='stack --stack-yaml stack-frontend.yaml'
alias stack7='stack --stack-yaml stack.yaml'

stack7 setup
stack7 install alex happy hscolour hsc2hs
PATH=`stack7 path --bin-path 2>/dev/null`:$OLDPATH

echo SETUP
stackjs setup

# ls `stackjs path --local-install-root`/bin/project-frontend-exe.jsexe

#stackjs clean
stackjs build
# copy something somwhere
stack7 build


mkdir -p static

cp `stackjs path --local-install-root`/bin/project-frontend-exe.jsexe/* static

cp `stack7 path --local-install-root`/bin/project-backend-exe .
echo ./project-backend-exe

PATH=$OLDPATH
