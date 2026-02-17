qemu-system-x86_64 \
-kernel ~/work/linux/arch/x86_64/boot/bzImage \
-initrd ~/initramfs-6.18.9-200.fc43.x86_64.img \
-append "root=/dev/sda3 rootflags=subvol=root rw console=ttyS0 nokaslr" \
-drive file=~/work/vms/fedora.qcow2,format=qcow2 \
-m 2G -nographic -s -S
