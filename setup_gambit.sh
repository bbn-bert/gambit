#!/bin/bash

## THESE NEED TO BE RUN MANUALLY
# echo "Setting up..."
# sudo apt install automake libtool
# pip3 install Cython

# git clone https://github.com/bbn-bert/gambit.git
# cd gambit
# git checkout -t python3

echo "Configuring gambit..."
mkdir m4 >> config.log
aclocal >> config.log
libtoolize >> config.log
automake --add-missing >> config.log
autoconf >> config.log
./configure --prefix="$(pwd)" --disable-gui >> config.log

echo "Building gambit binaries..."
# first make always fails from a possibly broken configuration,
# second make will work for some reason
make 2>/dev/null 1>build.log
make > build.log

echo "Installing gambit binaries..."
sudo make install > install.log

echo "Building python extensions..."
cd src/python
python3 ./setup.py build > build.log

echo "Installing python extensions..."
sudo python3 ./setup.py install > install.log
