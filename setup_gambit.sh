#!/bin/bash

echo "Setting up..."
sudo apt install automake libtool
pip3 install Cython

git clone https://github.com/bbn-bert/gambit.git
cd gambit
git checkout -t python3

echo "Configuring gambit..." > config.log
mkdir m4
aclocal
libtoolize
automake --add-missing
autoconf
./configure --prefix="$(pwd)" --disable-gui

echo "Building gambit binaries..." > build.log
# first make always fails from a possibly broken configuration,
# second make will work for some reason
make 2>/dev/null
make

echo "Installing gambit binaries..." > install.log
sudo make install

echo "Building python extensions..."
cd src/python
python3 ./setup.py build > build.log

echo "Installing python extensions..."
sudo python3 ./setup.py install > install.log
