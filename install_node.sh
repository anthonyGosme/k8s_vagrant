#!/bin/bash -x
sudo su

echo -e "\n\n \e[95m==== swap off  ====\n\n\e[m"
swapoff -a

echo -e "\n\n \e[95m==== installation tools  ====\n\n\e[m"
apt-get update && apt-get install -y --fix-missing nmap apt-transport-https sshpass ca-certificates curl gnupg-agent software-properties-common gnupg2 nmap 

echo -e "\n\n \e[95m==== installation docker  ====\n\n\e[m"
curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add -
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
cat /etc/apt/sources.list.d/kubernetes.list

echo -e "\n\n \e[95m==== installation  kube ====\n\n\e[m"
apt-get update && apt-get install -y  kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
kubeadm config images pull

echo -e "\n\n \e[95m==== start the services   ====\n\n\e[m"
systemctl daemon-reload
systemctl enable docker
systemctl enable kubelet.service
systemctl status docker.service --no-pager
systemctl status kubelet.service --no-pager

echo -e "\n\n \e[95m==== get join token from master ====\n\n\e[m"
kubeadm reset -f
sshpass -p rootp ssh -o "StrictHostKeyChecking no" root@192.168.56.2 kubeadm token list  | tail  -n 1 |awk '{print $1}' > token
cat token
kubeadm join 192.168.56.2:6443 --token $(cat token) --discovery-token-unsafe-skip-ca-verification --v=5