#!/bin/bash -x
#https://linuxhint.com/debian_10_package_cache_server_apt_cacher_ng/
sudo su
swapoff -a
echo 'Acquire::http::Proxy "http://192.168.56.10:3142";' > /etc/apt/apt.conf.d/02proxy
apt-get install -y htop
