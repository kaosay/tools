#!/bin/bash

cp files/rc.local /etc/
chmod 755 /etc/rc.local

apt-mark hold linux-image-generic linux-headers-generic

/usr/local/bin/k3s-agent-uninstall.sh


if mount | grep "/data/comfy" > /dev/null; then
    umount /data/comfy
fi

if mount | grep "/data/images200" > /dev/null; then
    umount /data/images200
fi

if [ `df -m |grep kubelet|grep -v grep` ];then
    df -m |grep kubelet |awk '{print $NF}' | xargs umount
fi
if [ `df -m |grep docker|grep -v grep` ];then
    df -m |grep docker |awk '{print $NF}' | xargs umount
fi

apt-get update
bash bin/install_ceph.sh
