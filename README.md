# bash-pack

## Install git

    apt-get update
    apt-get install git

## Clone repository

    DESTINATION=~/bash-pack
    git clone --depth 1 https://github.com/casperklein/bash-pack.git "$DESTINATION"

## Install packages and setup symlinks

    "$DESTINATION"/install.sh

## Update

    "$DESTINATION"/update.sh

## Repair

    "$DESTINATION"/repair.sh [--hard]

## Uninstall

    "$DESTINATION"/uninstall.sh # (symlinks only)
    rm -rf "$DESTINATION"       # remove complete
