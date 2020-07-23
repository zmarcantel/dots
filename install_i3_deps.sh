#!/usr/bin/env bash

set -ex

# TODO: add others/missed
#           - i3status-rs
sudo apt install -y \
    feh compton \
    xautolock

# install the lockscreen tools
~/dots/install_i3lock.sh
BETTERLOCK=/usr/local/bin/betterlockscreen
LOCKURL=https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/betterlockscreen
if [[ -f "$BETTERLOCK" ]]; then
    sudo rm $BETTERLOCK
fi
sudo curl -o $BETTERLOCK $LOCKURL
sudo chmod +x $BETTERLOCK
