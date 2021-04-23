#!/bin/bash -e

dir=$(pwd)/void-packages

if [ ! -d $dir ] ; then
  git clone --depth 1 git://github.com/void-linux/void-packages.git $dir
else
  cd $dir
  git pull
fi
