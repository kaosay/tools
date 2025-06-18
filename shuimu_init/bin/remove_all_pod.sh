apt-mark hold linux-image-generic linux-headers-generic

bash /usr/local/bin/k3s-killall.sh
bash /usr/local/bin/k3s-agent-uninstall.sh

docker ps -a |grep -v "CONTAINER ID" | awk '{print $1}' |xargs docker stop
docker ps -a |grep -v "CONTAINER ID" | awk '{print $1}' |xargs docker rm

df -m |grep kubelet |awk '{print $NF}' | xargs umount
df -m |grep docker |awk '{print $NF}' | xargs umount

iptables -t nat -F
iptables -t mangle -F
iptables -F
iptables-save

route -n |grep "10."|awk '{print $1}' > /tmp/podport.txt

while read myprot
do
  route del -net ${myprot}/24
done < /tmp/podport.txt
rm -f /tmp/podport.txt

service docker restart


nvidia-ctk runtime configure --runtime=docker
systemctl daemon-reload
service docker restart

