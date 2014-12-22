#!/bin/bash

set -e

./configure --prefix=$PREFIX \
    --with-shared --with-normal --without-debug --without-ada \
    --without-manpages --with-termlib=tinfo --enable-widec \
    --disable-overwrite

make
make install
