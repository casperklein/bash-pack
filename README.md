# bash-pack

    DESTINATION=~/bash-pack

## Download
    apt-get update
    apt-get install git
    git clone https://github.com/casperklein/bash-pack.git $DESTINATION

## Install packages and setup symlinks
    $DESTINATION/install.sh

## Update
    $DESTINATION/update.sh

## Uninstall
    $DESTINATION/uninstall.sh # (symlinks only)
    rm -rf $DESTINATION       # remove complete

## Install tmux
    cd $DESTINATION/tmux/
    make install

## Copy tmux configuration to /etc/tmux.conf
    cd $DESTINATION/tmux/
    make copy-conf
