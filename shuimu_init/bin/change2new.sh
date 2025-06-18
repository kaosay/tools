#!/bin/bash

cp files/rc.local /etc/
chmod 755 /etc/rc.local

bash bin/remove_all_pod.sh
umount /data/comfy
umount /data/images200
ln -s /data/kubelet /var/lib/kubelet
bash bin/load_images.sh
bash bin/install_ceph.sh
