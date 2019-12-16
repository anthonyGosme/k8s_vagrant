
echo -e "\n\n \e[95m==== get join token from master ====\n\n\e[m"
kubeadm reset -f
sshpass -p rootp ssh -o "StrictHostKeyChecking no" root@192.168.56.2 kubeadm token list  | tail  -n 1 |awk '{print $1}' > token
cat token
echo $(cat token) >> /shared/url.html
kubeadm join 192.168.56.2:6443 --token $(cat token) --discovery-token-unsafe-skip-ca-verification --v=5