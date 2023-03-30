#!/bin/sh
set -ex

sudo apt-get update && sudo apt-get install -y cmake clang-12 llvm-12
pip3 install wllvm

#cd ../SAW

sudo ./scripts/docker_install.sh
sudo ./scripts/install.sh

saw --version

