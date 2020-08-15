#!/usr/bin/env bash

set -ex

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# TODO: add others/missed
#           - i3status-rs
sudo apt install -y \
    curl \
    i3 \
    feh compton dunst rofi

# install the lockscreen tools
# ~/dots/install_i3lock.sh
# BETTERLOCK=/usr/local/bin/betterlockscreen
# LOCKURL=https://raw.githubusercontent.com/pavanjadhaw/betterlockscreen/master/betterlockscreen
# if [[ -f "$BETTERLOCK" ]]; then
#     sudo rm $BETTERLOCK
# fi
# sudo curl -o $BETTERLOCK $LOCKURL
# sudo chmod +x $BETTERLOCK


# san francisco, fontawesome, and powerline fonts
SFFONT=/tmp/sanfran.zip
wget -O $SFFONT https://img2.allbestfonts.com/wp-content/uploads/2015/06/San-Francisco.zip
sudo unzip -u -d /usr/local/share/fonts $SFFONT
sudo apt install -y fonts-font-awesome fonts-powerline


# install rust... needed for i3status-rs because they don't release prebuilt binaries or packages
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH=$PATH:~/.cargo/bin
sudo apt install -y build-essential pkg-config libdbus-1-dev

# now install i3status-rs
I3STATUSVER=$(get_latest_release "greshake/i3status-rust")
I3STATUSTMP=/tmp/i3status
rm -rf $I3STATUSTMP
git clone https://github.com/greshake/i3status-rust $I3STATUSTMP
cd $I3STATUSTMP
git checkout $I3STATUSVER
cargo build --release
sudo mv target/release/i3status-rs /usr/local/bin/i3status-rs
