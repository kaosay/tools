#!/bin/bash

SCRIPTDIR=`dirname $0`
bash ${SCRIPTDIR}/load_images.sh

myip=`ip addr show | grep 'inet ' | grep '172.16.21' | awk '{print $2}' | cut -d/ -f1`

curl -sfL https://rancher-mirror.rancher.cn/k3s/k3s-install.sh | \
  INSTALL_K3S_MIRROR=cn \
  K3S_URL=https://172.16.21.1:6443 \
  K3S_TOKEN=12345 \
  sh -s - \
  --docker \
  --node-name=${myip} \
  --node-ip=${myip} 
