#!/usr/bin/env bash

set -ex

BUILDDIR=/tmp/i3lock-color
GITSRC=https://github.com/PandorasFox/i3lock-color

# install deps
sudo apt install -y libev-dev \
    libxcb-composite0 libxcb-composite0-dev libxcb-xinerama0 libxcb-randr0 \
    libxcb-randr0-dev libxcb-xrm-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxcb-image0-dev \
    libxcb-util-dev \
    libxkbcommon-x11-dev \
    libjpeg-turbo8-dev \
    libpam0g-dev \
    libcairo2-dev

# clone repo
ls $BUILDDIR 2>/dev/null || git clone $GITSRC $BUILDDIR
cd $BUILDDIR

# build
autoreconf -i
./configure
make

# install
sudo cp $BUILDDIR/x86_64-pc-linux-gnu/i3lock /usr/local/bin/i3lock
