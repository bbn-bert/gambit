#!/bin/bash

## THESE NEED TO BE RUN MANUALLY
# echo "Setting up..."
# sudo apt install automake libtool
# pip3 install Cython

# git clone https://github.com/bbn-bert/gambit.git
# cd gambit
# git checkout -t python3

echo "Configuring gambit..."
mkdir m4
aclocal
libtoolize
automake --add-missing
autoconf
./configure --prefix="/usr/" --disable-gui "CFLAGS=-m64" "CXXFLAGS=-m64" "LDFLAGS=-m64"

echo "Building gambit binaries..."
# first make always fails from a possibly broken configuration,
# second make will work for some reason
make -j 8 2>/dev/null
make -j 8

echo "Installing gambit binaries..."
make install

echo "Building python extensions..."
cd src/python
python3 ./setup.py build

echo "Installing python extensions..."
python3 ./setup.py install
