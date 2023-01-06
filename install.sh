#!/sbin/sh
mknod /dev/loop1 b 7 8
losetup /dev/loop1 /data/rootfs.img
mkdir /rootfs && mount /dev/loop1 /rootfs
mkdir -p /rootfs/etc/systemd/system/android-mount.service.d/
cp -r ./etc/systemd/system/android-mount.service.d/* /rootfs/etc/systemd/system/android-mount.service.d/
mkdir -p /rootfs/etc/systemd/system/phosh.service.d/
cp ./etc/systemd/system/phosh.service.d/* /rootfs/etc/systemd/system/phosh.service.d
cp ./etc/systemd/system/brightness.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/modules.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/ssh-fix.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/vendor-overlay.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/apt-fix.service /rootfs/etc/systemd/system/
cp ./etc/systemd/system/batman.service /rootfs/etc/systemd/system/
mkdir -p /rootfs/etc/systemd/user/pulseaudio.service.d/
cp ./etc/systemd/user/pulseaudio.service.d/* /rootfs/etc/systemd/user/pulseaudio.service.d/
cp ./etc/udev/rules.d/70-garden.rules /rootfs/etc/udev/rules.d/
cp ./etc/pulse/arm_droid_card_custom.pa /rootfs/etc/pulse/
cp ./etc/ofono/main.conf /rootfs/etc/ofono/
cp -r ./etc/phosh/ /rootfs/etc/
cp -r ./etc/modules-load.d/* /rootfs/etc/modules-load.d/
cp ./etc/apt/sources.list.d/garden.list /rootfs/etc/apt/sources.list.d/
cp ./etc/apt/sources.list.d/batman.list /rootfs/etc/apt/sources.list.d/
cp ./usr/share/keyrings/garden.gpg /rootfs/usr/share/keyrings/
cp ./usr/share/keyrings/fakeshell.gpg /rootfs/usr/share/keyrings/
cp -r ./usr/lib/droid-vendor-overlay/ /rootfs/usr/lib/
cp -r ./usr/bin/* /rootfs/usr/bin/
cp -r ./usr/share/applications/* /rootfs/usr/share/applications/
cp -r ./usr/share/icons/* /rootfs/usr/share/icons/
mkdir -p /rootfs/var/lib/bluetooth/
cp ./var/lib/bluetooth/board-address /rootfs/var/lib/bluetooth/
cp -r ./var/lib/batman/ /rootfs/var/lib/batman/
mkdir -p /rootfs/lib/systemd/system/bluebinder.service.d/
cp ./lib/systemd/system/bluebinder.service.d/* /rootfs/lib/systemd/system/bluebinder.service.d/
mkdir -p /rootfs/lib/systemd/system/systemd-modules-load.service.d/
cp -r ./lib/systemd/system/systemd-modules-load.service.d/* /rootfs/lib/systemd/system/systemd-modules-load.service.d/
chroot /rootfs/ /bin/bash -c 'export PATH="$PATH:/usr/bin:/usr/sbin:/bin:/sbin" && systemctl enable brightness ssh-fix modules vendor-overlay apt-fix batman'
echo "Now just reboot"
echo "After rebooting run: sudo apt update && sudo apt upgrade -y && sudo apt install droidian-sysfs-torch -y"
echo "to get flashlight working"
