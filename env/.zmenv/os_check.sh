#!/usr/bin/env bash

is_linux() {
    if [ "$(uname)" = "Linux" ]; then
        return 0
    else
        return 1
    fi
}

is_mac() {
    if [ "$(uname)" = "Darwin" ]; then
        return 0
    else
        return 1
    fi
}

is_ubuntu() {
    if ! is_linux; then
        return 1
    fi

    return $(lsb_release -a | grep "Ubuntu")
}
