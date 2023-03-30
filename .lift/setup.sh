#!/bin/sh
set -ex

SAW_URL='https://saw-builds.s3.us-west-2.amazonaws.com/saw-0.9.0.99-2023-03-03-Linux-x86_64.tar.gz'
Z3_URL='https://github.com/Z3Prover/z3/releases/download/z3-4.8.8/z3-4.8.8-x64-ubuntu-16.04.zip'
YICES_URL='https://yices.csl.sri.com/releases/2.6.2/yices-2.6.2-x86_64-pc-linux-gnu-static-gmp.tar.gz'

sudo apt-get update && sudo apt-get install -y clang-12 llvm-12

SCRIPT_DIR=$(dirname -- "$0")
BIN=/usr/local/bin
DEPS=$SCRIPT_DIR/deps

mkdir -p $BIN $DEPS

# fetch saw
rm -rf $DEPS/saw
mkdir -p $DEPS/saw
curl --location $SAW_URL --output $DEPS/saw.tar.gz
tar xfz $DEPS/saw.tar.gz --directory $DEPS/saw
sudo cp $DEPS/saw/*/bin/saw $BIN
sudo cp $DEPS/saw/*/bin/cryptol $BIN

# fetch z3
if [ ! -f $BIN/z3 ]
then
    mkdir -p $DEPS/z3
    curl --location $Z3_URL --output $DEPS/z3.zip
    unzip $DEPS/z3.zip -d $DEPS/z3
    sudo cp $DEPS/z3/*/bin/z3 $BIN
fi

# fetch yices
if [ ! -f $BIN/yices ]
then
    mkdir -p $DEPS/yices
    curl --location $YICES_URL --output $DEPS/yices.tar.gz
    tar xfz $DEPS/yices.tar.gz --directory $DEPS/yices
    sudo cp $DEPS/yices/*/bin/yices $BIN
    sudo cp $DEPS/yices/*/bin/yices-smt2 $BIN
fi

saw --version

