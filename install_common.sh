#!/usr/bin/env bash

set -e
set -x

source $(dirname "$0")/env/.zmenv/os_check.sh

PKGS="ack stow \
      git cmake python2.7 \
      vim zsh"

get_pkg_man() {
    if is_apt_based; then
        echo "apt-get"
        return 0
    elif is_yum_based; then
        echo "yum"
        return 0
    elif is_mac; then
        echo "brew"
        return 0
    fi

    return 1
}

get_pkg_install() {
    if [ "$#" -ne 1 ]; then
    >&2 echo "expected a package manager name to be passed in"
        return 1
    fi

    PKGMGR=$1
    if [ "$?" -ne 0 ]; then
        return $?
    fi

    case "$PKGMGR" in
        apt-get|yum|brew)
        echo "$PKGMGR install -y"
        return 0
        ;;
    esac

    >&2 echo "could not find package manager for distro"
    return 1
}

get_pkg_names() {
    local result=""
    for pkg in "$@"; do
        case $pkg in
            ack)
            if [ "$PKGMGR" = "apt" ]; then
                result+=" ack-grep"
            else
                result+=" $pkg"
            fi
        ;;
        *)
        result+=" $pkg"
        ;;
        esac
    done
    echo "$result"
}

PKGMGR=$(get_pkg_man)
INSTALL_CMD=$(get_pkg_install $PKGMGR)
if [ $? -ne 0 ]; then
    exit 1
fi

sudo $INSTALL_CMD $(get_pkg_names $PKGS)
