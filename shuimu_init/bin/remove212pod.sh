service k3s-agent stop
bash /usr/local/bin/k3s-killall.sh
bash /usr/local/bin/k3s-agent-uninstall.sh

docker ps -a |grep -v "CONTAINER ID" | awk '{print $1}' |xargs docker stop
docker ps -a |grep -v "CONTAINER ID" | awk '{print $1}' |xargs docker rm
iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables-save

service docker stop

rm -rf /data/containerd
rm -rf /data/kubelet
rm -rf /data/rancher
rm -rf /data/docker
rm -rf /var/lib/containerd
rm -rf /var/lib/kubelet
rm -rf /var/lib/rancher
rm -rf /var/lib/docker

mkdir -p /data
mkdir -p /data/containerd
mkdir -p /data/kubelet
mkdir -p /data/rancher
mkdir -p /data/docker

ln -s /data/containerd /var/lib/containerd
ln -s /data/kubelet /var/lib/kubelet
ln -s /data/rancher /var/lib/rancher
ln -s /data/docker /var/lib/docker

