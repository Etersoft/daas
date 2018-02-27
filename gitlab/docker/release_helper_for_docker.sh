#!/bin/sh

# config

export TMPDIR=$HOME/tmp
export TMP=${TMPDIR}
mkdir -p $TMPDIR

git config --global user.email "docker@builder-p8"
git config --global user.name "docker builder"

# get source
# mkdir -p $HOME/build && tar xvf $HOME/src/src.tar -C $HOME/build/

# build
cd $HOME/build 
rpmgp -i
rpmlog -q -r -l
rpmbb
