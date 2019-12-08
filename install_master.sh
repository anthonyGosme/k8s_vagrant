#!/bin/bash -x
sudo su

echo -e "\n\n \e[95m==== set the master cluster IP  ====\n\n\e[m"
swapoff -a
cat /etc/hosts
echo "localhost 192.168.56.2" >> /etc/hosts

echo -e "\n\n \e[95m==== installation tools  ====\n\n\e[m"
apt-get update && apt-get install -y --fix-missing nmap apt-transport-https  ca-certificates curl gnupg-agent software-properties-common gnupg2 nmap 

echo -e "\n\n \e[95m==== install docker  ====\n\n\e[m"
curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add -
add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
cat /etc/apt/sources.list.d/kubernetes.list

echo -e "\n\n \e[95m==== install  kube ====\n\n\e[m"
apt-get update && apt-get install -y  kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
kubeadm config images pull

echo -e "\n\n \e[95m==== start the services   ====\n\n\e[m"
systemctl daemon-reload
systemctl enable docker
systemctl enable kubelet.service
systemctl status docker.service --no-pager
systemctl status kubelet.service --no-pager

echo -e "\n\n \e[95m==== kubeadm init  ====\n\n\e[m"
kubeadm init --pod-network-cidr=192.168.56.0/16 --apiserver-advertise-address=192.168.56.2

echo -e "\n\n \e[95m==== set k8s conf ====\n\n\e[m"
mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl get pods --all-namespaces

echo -e "\n\n \e[95m==== create K8s network ====\n\n\e[m"
kubectl apply -f https://docs.projectcalico.org/master/manifests/calico.yaml
kubectl get pods -A

echo -e "\n\n \e[95m==== DNS fix ====\n\n\e[m"
cp /etc/resolv.conf /etc/resolv.conf.save
rm -f /etc/resolv.conf
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved.service

echo -e "\n\n \e[95m==== grant ssh to root (workaround) ====\n\n\e[m"
echo 'root:rootp' | chpasswd
cp /etc/ssh/sshd_config  /etc/ssh/sshd_config.old
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config 
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 
systemctl restart sshd
systemctl status sshd

echo -e "\n\n \e[95m==== create admin for dashboard ====\n\n\e[m"
cat << 'EOF' > admin.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system 
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF
kubectl apply -f admin.yaml  

echo -e "\n\n \e[95m==== create proxy ====\n\n\e[m"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta6/aio/deploy/recommended.yaml
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')

echo "\e[95mget token and goto http://127.0.0.1:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/. \e[m"
kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='.*'
