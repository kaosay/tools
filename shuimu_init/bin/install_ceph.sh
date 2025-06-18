apt-get install -y ceph-common
cp files/ceph.client.admin.keyring /etc/ceph/
cp files/ceph.conf /etc/ceph/

mkdir -p /data/images200
mkdir -p /data/comfy

mount -t ceph admin@859a126c-d7b1-11ef-ac5c-31e49aa95a79.public_image=/ /data/images200
mount -t ceph admin@859a126c-d7b1-11ef-ac5c-31e49aa95a79.public_data=/ /data/comfy
