#!/bin/sh
# 休眠唤醒后无线失效的恢复脚本（Broadcom BCM43602 / brcmfmac）。
#
# 手动执行（会断开 Wi-Fi 几秒，之后自动重连）：
#   sudo ~/.local/bin/power/wifi-resume.sh
#
# 安装为 systemd sleep hook，每次唤醒自动执行。
# systemd 只扫描 /usr/lib/systemd/system-sleep/，/etc 下的同名目录不会被读取：
#   sudo install -m 755 ~/.local/bin/power/wifi-resume.sh \
#       /usr/lib/systemd/system-sleep/brcmfmac-pci-reset.sh
#
# 卸载 hook：
#   sudo rm /usr/lib/systemd/system-sleep/brcmfmac-pci-reset.sh
set -u

# systemd-sleep 调用时参数为 post；手动执行没有参数。
case "${1:-now}" in
    post|now) ;;
    *) exit 0 ;;
esac

if [ "$(id -u)" -ne 0 ]; then
    echo "需要 root 权限: sudo $0"
    exit 1
fi

iface=""
for d in /sys/class/net/*; do
    if [ -d "$d/wireless" ]; then
        iface=${d##*/}
        break
    fi
done
if [ -z "$iface" ]; then
    echo "找不到无线接口"
    exit 1
fi

dev=$(readlink -f "/sys/class/net/$iface/device" 2>/dev/null)
if [ -z "$dev" ] || [ ! -d "$dev" ]; then
    echo "无法确定 $iface 对应的 PCI 设备"
    exit 1
fi

echo "重置无线设备 ${dev##*/}..."
echo 1 > "$dev/remove" || exit 1
sleep 1
echo 1 > /sys/bus/pci/rescan || exit 1

i=0
while [ "$i" -lt 30 ]; do
    [ -e "/sys/class/net/$iface" ] && break
    i=$((i + 1))
    sleep 0.5
done

if [ -e "/sys/class/net/$iface" ]; then
    echo "已恢复: $iface"
else
    echo "接口未重新出现，请检查: journalctl -k -b --since '-2 min'"
    exit 1
fi
