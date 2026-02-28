install busybox.x86_64
cd ~/work
mkdir rootfs
cd rootfs
mkdir -p bin sbin etc proc sys dev usr/bin usr/sbin
cp /usr/bin/busybox ./bin/
cd bin
for i in $(./busybox --list); do     ln -s busybox $i; done
cd ..
vim init

# Contents of init:
#!/bin/sh

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

echo "Booted minimal system"
exec /bin/sh
# content ends

chmod +x init
cd ..
mkdir initramfs
cd rootfs
find . | cpio -o --format=newc > ../initramfs/initramfs.cpio

qemu-system-x86_64 \
    -kernel ~/work/linux/arch/x86/boot/bzImage \
    -initrd ~/work/initramfs/initramfs.cpio \
    -append "console=ttyS0 nokaslr" \
    -nographic -s -S
