# bash-pack

## Download
    git clone https://github.com/casperklein/bash-pack.git /scripts

## Install packages
    /scripts/install.sh

## Symlink .bashrc
    echo return > ~/.bashrc.local
    cat ~/.bashrc >> ~/.bashrc.local
    mv -i ~/.bashrc ~/.bashrc.original
    ln -s /scripts/bashrc ~/.bashrc
