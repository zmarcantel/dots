#!/usr/bin/env bash

is_linux() {
    if [ "$(uname)" = "Linux" ]; then
        return 1
    else
        return 0
    fi
}

is_mac() {
    if [ "$(uname)" = "Darwin" ]; then
        return 1
    else
        return 0
    fi
}

is_ubuntu() {
    if ! is_linux; then
        return 0
    fi

    return $(lsb_release -a | grep "Ubuntu")
}
