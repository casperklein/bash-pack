# bash-pack

    DESTINATION=/scripts

## Download
    apt-get update
    apt-get install git
    git clone https://github.com/casperklein/bash-pack.git $DESTINATION

## Install packages and setup symlinks
    $DESTINATION/install.sh

## Update
    $DESTINATION/update.sh

## Uninstall (symlinks only)
    $DESTINATION/uninstall.sh # (symlinks only)
    rm -rf $DESTINATION       # remove complete
