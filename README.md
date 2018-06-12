dotfiles
========

This is my collection of dotfiles.

They can individually be installed using `stow` (instructions below).

Dot Packages
============

1. env
    * General enviroment: aliases, exports, variables, etc
2. i3
    * Config for the `i3` tiling window manager
3. vim
    * Configuration for the `vim` text editor
4. zsh
    * Configuration for the `zsh` shell


Base Packages
==============

First, run the `install_common.sh` script which installs a few base utilities:

```
$ ./install_common.sh
```

Primarily, it installs [GNU Stow](https://www.gnu.org/software/stow/) which is needed
to install packages in this repo. is a tool used to manage the dot files as individual packages.
It's handy for pretty much all config management.

Other basic packages include:

- vim (with cmake for YCM)
- git
- zsh



Installing Dot-File Packages
============================

See the above list of available dot-packages.

Once in the directory of this repository (after cloning):

````bash
stow {package}
````

This symlinks the files into their correct place. Any changes to the files will change the files in this repo.

When changes are made, simply commit the changes.



Vim
=======

`vim` requires extra configuration due to `YouCompleteMe`.

All plugins and `YCM` will be installed using the included script:

```
~/.vim_install.sh {optional YCM install.py args}
```

For an install that supports `clang`, `go`, and `rust`:

```
~/.vim_install.sh --clang-completer --go-completer --rust-completer
```
