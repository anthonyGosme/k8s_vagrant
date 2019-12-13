#!/bin/bash -x
#https://linuxhint.com/debian_10_package_cache_server_apt_cacher_ng/
sudo su
swapoff -a
echo -e "\n\n \e[95m==== install apt-cacher  ====\n\n\e[m"
apt-get update 

apt install -y apt-cacher-ng
echo "PassThroughPattern: .*">> /etc/apt-cacher-ng/acng.conf
sleep 1
echo 'Acquire::http::Proxy "http://192.168.56.10:3142";' > /etc/apt/apt.conf.d/02proxy
systemctl restart apt-cacher-ng
systemctl status apt-cacher-ng
echo -e "\n\n \e[95m==== browser : http://192.168.56.10:3142/acng-report.html \n chached repo list /etc/apt-cacher-ng/backends_debian  ====\n\n\e[m"
