#!/bin/sh
set -ex

sudo apt-get update && sudo apt-get install -y cmake clang-12 llvm-12
pip3 install wllvm

#cd ../SAW

sudo ./scripts/docker_install.sh
sudo ./scripts/install.sh

saw --version

#PATCH=$(realpath ./patch)
#
#apply_patch() {
#  PATCH_NAME=$1
#
#  (cd ../src; patch -p1 -r - --forward < "$PATCH"/"$PATCH_NAME".patch || true)
#}
#
## First, apply some patches (TODO: remove them)...
#
#apply_patch "rsa-encrypt"
#apply_patch "nomuxrsp"
#apply_patch "noinline-aes_gcm_from_cipher_ctx"
#apply_patch "noinline-bn_mod_add_words"
#apply_patch "noinline-bn_reduce_once_in_place"
#apply_patch "noinline-bn_sub_words"
#apply_patch "noinline-ec_scalar_is_zero"
#apply_patch "noinline-ec_point_mul_scalar"
#apply_patch "noinline-ec_point_mul_scalar_base"
#apply_patch "noinline-ec_get_x_coordinate_as_bytes"
#apply_patch "noinline-ec_get_x_coordinate_as_scalar"
#apply_patch "noinline-value_barrier_w"
#apply_patch "noinline-GetInPlaceMethods"
#apply_patch "noinline-HMAC_Update"
#apply_patch "noinline-HMAC_Final"
#apply_patch "noinline-HKDF_extract"
#apply_patch "noinline-HKDF_expand"
#
## ...next, check the proofs using CMake's Release settings...
#
#./scripts/build_x86.sh  "Release"
#./scripts/build_llvm.sh "Release"
#./scripts/post_build.sh

