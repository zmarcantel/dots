#!/usr/bin/env bash

set -e

is_mac() {
    if [ "$(uname)" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

is_linux() {
    if [ "$(uname)" = "Linux" ]; then
        return 0
    else
        return 1
    fi
}

check_redhat_release() {
    if ! is_linux; then
        return 1
    fi

    if [ "$#" -ne 1 ]; then
        return 1
    fi

    if [ -e /etc/redhat-release ]; then
        return $(cat /etc/redhat-release | grep "$1" > /dev/null 2>&1)
    fi

    return 1
}

check_lsb_release() {
    if ! is_linux; then
        return 1
    fi

    if [ "$#" -ne 1 ]; then
        return 1
    fi

    if which lsb_release > /dev/null 2>&1; then
    	return $(lsb_release -a | grep "$1" > /dev/null 2>&1)
    fi

    return 1
}


is_ubuntu() {
    return $(check_lsb_release Ubuntu)
}

is_debian() {
    return $(check_lsb_release Debian)
}

is_fedora() {
    return $(check_redhat_release Fedora)
}
is_rhel() {
    return $(check_redhat_release RHEL)
}
is_centos() {
    return $(check_redhat_release CentOS)
}

has_yum() {
    return $(which yum > /dev/null 2>&1)
}
is_yum_based() {
    $(is_fedora || is_rhel || is_centos)
    local is_rh=$?
    return $is_rh && has_yum
}

has_apt() {
    return $(which apt > /dev/null 2>&1)
}
has_apt_get() {
    return $(which apt-get > /dev/null 2>&1)
}
is_apt_based() {
    $(is_ubuntu || is_debian)
    local is_deb=$?
    $(has_apt || has_apt_get)
    local is_apt=$?
    return $is_deb && $is_apt
}
