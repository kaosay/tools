import subprocess

def run_command(command):
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode!= 0:
        print(f"Error running command: {command}")
        print(result.stderr)
    return result.stdout

def main():
    # 加载内核模块
    run_command("modprobe vfio")
    run_command("modprobe vfio_pci")

    # 获取 NVIDIA 设备的 ID 列表
    ids_output = run_command("./getpci_all.sh")
    ids = ids_output.split()
    print("ids: ",ids)
    for id in ids:
        # 获取 pcid
        pcid = id.replace(':', '_')
        escaped_pcid = "0000:" + id
        print(f"Processing {pcid}")
        print("escaped_pcid: ",escaped_pcid)
        # 执行类似操作
        for line in run_command("find /sys/devices/pci* -name boot_vga").splitlines():
            if int(run_command(f"cat {line}")) == 0:
                print(f'/sys/bus/pci/devices/{escaped_pcid}/driver_override')
                print(f'/sys/bus/pci/devices/{escaped_pcid}/driver/unbind')

                run_command(f'echo "vfio-pci" > "/sys/bus/pci/devices/{escaped_pcid}/driver_override"')
                run_command(f'echo "{escaped_pcid}" > "/sys/bus/pci/devices/{escaped_pcid}/driver/unbind"')
                run_command(f'echo "{escaped_pcid}" > "/sys/bus/pci/drivers_probe"')

if __name__ == "__main__":
    main()
