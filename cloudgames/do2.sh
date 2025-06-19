#!/bin/bash

modprobe vfio
modprobe vfio_pci

# 获取 NVIDIA 设备的 ID 列表
ids=($(./getpci.sh))
printf "%s\n" $ids
for id in "${ids[@]}"; do
    # 获取 pcid
    pcid=${id//:/_}
    escaped_pcid="0000:${id}"
    echo "Processing $pcid"

    # 执行原始脚本中的操作
    for i in $(find /sys/devices/pci* -name boot_vga); do
        if [ $(cat "$i") -eq 0 ]; then
            GPU="${i%/boot_vga}"
            AUDIO="$(echo "$GPU" | sed -e "s/0$/1/")"
            echo "vfio-pci" > "$GPU/driver_override"

            echo $escaped_pcid > "/sys/bus/pci/devices/$escaped_pcid/driver/unbind"

            if [ -d "$AUDIO" ]; then
                echo "vfio-pci" > "$AUDIO/driver_override"
            fi
            echo $escaped_pcid > "/sys/bus/pci/drivers_probe"
        fi
    done
done
