#!/bin/bash

apt-mark hold linux-image-generic linux-headers-generic
timedatectl set-timezone Asia/Shanghai

myip=`ip addr show | grep 'inet ' | grep '172.16.20' | awk '{print $2}' | cut -d/ -f1 | sed 's/\./-/g'`
hostnamectl set-hostname ${myip}

lvextend -L +780G /dev/mapper/ubuntu--vg-ubuntu--lv /dev/sda3 
resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
pvcreate /dev/nvme0n1
vgcreate vg00 /dev/nvme0n1
lvcreate -L +7150G -n lv00 vg00
mkfs.ext4 /dev/vg00/lv00 
mkdir -p /data
echo "/dev/vg00/lv00 /data/ ext4 defaults,noatime 0 0" >> /etc/fstab
mount -a

mkdir -p /data
mkdir -p /data/containerd
mkdir -p /data/kubelet
mkdir -p /data/rancher
mkdir -p /data/docker

ln -s /data/containerd /var/lib/containerd
ln -s /data/kubelet /var/lib/kubelet
ln -s /data/rancher /var/lib/rancher
ln -s /data/docker /var/lib/docker

echo "ubuntu:Mudata#1028" | chpasswd

sed -i '\|192-168-0-229|d' /root/.ssh/authorized_keys
cat files/root_id_rsa.pub >> /root/.ssh/authorized_keys

sed -i '\|192-168-0-229|d' /home/ubuntu/.ssh/authorized_keys
cat files/ubuntu_id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys

cp files/limits.conf /etc/security/
cp files/sudoers /etc/

cp files/99-disable-network-config.cfg /etc/cloud/cloud.cfg.d/
echo "set paste" >> /etc/vim/vimrc


mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp files/sources.list /etc/apt/

sleep 10s
apt-get update

apt-mark hold intel-microcode
sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{ucodehints} = 0;/\$nrconf{ucodehints} = 0;/g" /etc/needrestart/needrestart.conf
sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'l';/g" /etc/needrestart/needrestart.conf

sleep 10s
apt-get update
sleep 10s
apt-get update

apt-get install -y chrony net-tools nfs-common
rm -f /etc/chrony/chrony.conf
cp files/chrony.conf /etc/chrony/
systemctl restart chrony.service
systemctl enable chrony.service

mkdir -p /data/comfy
mkdir -p /data/images200

bash bin/install_docker.sh
bash bin/install_nvidia.sh
bash bin/load_images.sh
bash bin/install_ceph.sh 
bash bin/install_k3s_sg_agent.sh
