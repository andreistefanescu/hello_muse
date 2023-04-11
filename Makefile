.SUFFIXES: .c .bc
.PHONY: all

CLANG ?= clang 
C_FILES = $(shell find . -name '*.c')
BC_FILES = $(patsubst %.c, %.bc, $(C_FILES))

all: $(BC_FILES)

%.bc : %.c
	$(CLANG) -g -O0 -c -emit-llvm $< -o $@

