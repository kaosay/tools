rm -f /etc/apt/sources.list.d/nvidia-container-toolkit.list
rm -f /etc/apt/sources.list.d/graphics-drivers-ubuntu-ppa-jammy.list

add-apt-repository --yes ppa:graphics-drivers/ppa
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | sudo apt-key add -
cp files/nvidia-container-toolkit.list /etc/apt/sources.list.d/nvidia-container-toolkit.list

sed -i 's#ppa.launchpadcontent.net#launchpad.proxy.ustclug.org#g' /etc/apt/sources.list.d/graphics-drivers-ubuntu-ppa-jammy.list
cp files/libnvidia-container.gpg /etc/apt/trusted.gpg.d/

apt-get update
apt install -y nvidia-driver-560=560.35.05-0ubuntu1 nvidia-container-toolkit-base  nvidia-container-toolkit nvidia-modprobe=560.35.05-0ubuntu1 nvidia-settings=560.35.05-0ubuntu1 

nvidia-smi -pm 1
nvidia-ctk runtime configure --runtime=docker
systemctl daemon-reload
systemctl restart docker

rmmod nvidia_modeset 
rmmod nvidia_uvm         
rmmod nvidia          
nvidia-smi    
