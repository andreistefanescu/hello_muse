.PHONY: all

all: sha512.bc

%.bc : %.c
	clang-12 -g -c -emit-llvm $< -o $@

