#!/bin/bash

apt-get update
apt-get install aptitude boxes bsdmainutils ccze checkinstall colordiff colormake curl dcfldd lynx most openssl procps pv tcpflow vim

cd /scripts &&
	wget https://raw.githubusercontent.com/casperklein/croncal/master/croncal.pl
