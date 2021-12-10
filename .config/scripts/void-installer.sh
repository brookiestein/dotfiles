#!/bin/sh

# TODO: Create the partitions without user interaction
# /dev/sda1: EFI
# /dev/sda2: boot
# /dev/sda3: swap
# /dev/sda4: /, /home -> btrfs

# Format and encrypted the partitions
mkfs -t fat -F 32 -n "ESP" /dev/sda1
mkfs -t ext4 -L "boot" /dev/sda2
mkswap -L "swap" /dev/sda3
cryptsetup -c -y aes-xts-plain64 -s 512 -h sha512 -i 3000 --use-random luksFormat /dev/sda4
cryptsetup luksOpen /dev/sda4 void
mkfs -t btrfs -L "Linux" /dev/mapper/void

# Mount the partitions and subvolumes
mkdir /mnt/void
mount /dev/mapper/void /mnt/void
btrfs subvolume create /mnt/void/@
btrfs subvolume create /mnt/void/@home
umount /dev/mapper/void

mount -o noatime,relatime,compress=lzo,autodefrag,space_cache,subvol=@ /dev/mapper/void /mnt/void
cd /mnt/void
mkdir boot home
mount -o noatime,relatime,compress=lzo,autodefrag,space_cache,subvol=@home /dev/mapper/void /mnt/void
mount /dev/sda2 boot/
mkdir boot/efi
mount /dev/sda1 boot/efi/

# Mount important directories
for dir in dev sys proc run;
do
        mount --rbind /$dir $dir
        mount --make-rslave $dir
done

# Little configurations to the system
chroot . xbps-install -SyuR "https://repo-us.voidlinux.org/current/musl" -r . base-system cryptsetup grub-x86_64-efi
chroot . chown root:root /
chroot . chmod 755 /
chroot . passwd root
chroot . echo "BrayansVoid" > /etc/hostname
chroot . su - -c 'echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales'

# fstab
chroot . su - -c 'cat << EOF >> /etc/fstab
UUID=$(blkid -s UUID -o value /dev/mapper/void) / btrfs noatime,relatime,compress=lzo,autodefrag,space_cache,subvol=@ 0 0
UUID=$(blkid -s UUID -o value /dev/mapper/void) /home btrfs noatime,relatime,compress=lzo,autodefrag,space_cache,subvol=@home 0 0
UUID=$(blkid -s UUID -o value /dev/sda2) /boot ext4 noatime,nodiratime 0 0
UUID=$(blkid -s UUID -o value /dev/sda1) /boot/efi vfat defaults 0 0
UUID=$(blkid -s UUID -o value /dev/sda3) none swap sw 0 0
EOF'

# Make a backup if you want to modify it later...
# cp /etc/default/grub{,.bak}

chroot . su - -c 'cat << EOF > /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
GRUB_ENABLE_CRYPTODISK=y
GRUB_DISTRIBUTOR="BrayansVoid"
GRUB_CMDLINE_LINUX_DEFAULT="rd.luks.uuid=$(blkid -s UUID -o value /dev/sda4) root=UUID=$(blkid -s UUID -o value /dev/mapper/void) resume=UUID=$(blkid -s UUID -o value /dev/sda3) rootflags=subvol=@ zswap.compressor=lz4 quiet"
#GRUB_BACKGROUND="/boot/grub/backgrounds/wallhaven-x8l99z_1920x1080.png"
GRUB_DISABLE_OS_PROBER=true
EOF'

# For GRUB's wallpaper, and /dev/sdb1 key for decrypting
if [ ! -f /dev/mapper/data ]
then
        cryptsetup luksOpen /dev/sdb1 data
fi
mkdir /mnt/data
mount noatime,relatime,compress=lzo,autodefrag,space_cache,subvol=data /dev/mapper/data /mnt/data
cp /mnt/data/Wallpapers/PC/wallhaven-8x1el1_1920x1080.png
cp -r /mnt/data/Backups/luks/ etc/
umount /dev/mapper/data
cryptsetup luksClose /dev/mapper/data

# crypttab
chroot . su - -c 'cat << EOF >> /etc/crypttab
data    /dev/disk/by-id/ata-ST9250315AS_6VCXEBS3-part1  /etc/luks/ata-ST9250315AS_6VCXEBS3-part1.key    luks
EOF'

chroot . su - -c 'cat << EOF >> /etc/dracut.conf.d/10-crypt.conf
install_items+=" /etc/luks/ata-ST9250315AS_6VCXEBS3-part1.key /etc/crypttab "
EOF'

# GRUB
grub-install --modules="linux crypto search_fs_uuid luks" --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

xbps-reconfigure -fa

# Graphic environment, web browser, and other programs I use:
xbps-install -y xorg-minimal mate{,-extra,-tweak} firefox qbittorrent \
        keepassxc flameshot exa git clang gcc make mpv libreoffice{,-i18n-es} \
        nodejs telegram-desktop redshift-gtk pavucontrol qemu virt-manager \
        xse{l,t} translate-shell neofetch htop blueman qtcreator mesa-dri

# Libraries (for suckless's projects, for example)
xbps-install -y libXinerama-devel libXfixes-devel libXft-devel libXrandr-devel \
        pkg-config imlib2-devel gtk+3-devel automake

# Services
ln -sv /etc/sv/bluetoothd /var/service
ln -sv /etc/sv/dbus /var/service
ln -sv /etc/sv/dhcpcd /var/service
ln -sv /etc/sv/elogind /var/service
ln -sv /etc/sv/wpa_supplicant /var/service

# Umount everything
umount -l dev sys proc run
umount -R boot
umount home
cd ..
umount void

echo "Void Linux installed!"
