#!/bin/bash


file="/etc/default/grub"

# 使用 sed 命令修改文件中的特定行
sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash intel_iommu=on\"/" "$file"

# 更新 grub 配置
sudo update-grub


# 检查文件是否存在
if [ -f "/etc/modprobe.d/blacklist.conf" ]; then
    # 使用追加模式向文件末尾添加内容
    echo "blacklist nouveau" | sudo tee -a /etc/modprobe.d/blacklist.conf > /dev/null
    #echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/blacklist.conf > /dev/null
    echo "添加成功。"
else
    echo "文件 /etc/modprobe.d/blacklist.conf 不存在。"
fi

# 更新 initramfs
sudo update-initramfs -u