#!/bin/bash

close=0
device="/dev/mmcblk0p1"
name="SD"
mountpoint="/mnt"
umount=0

usage() {
    echo "-h -> Show this help page."
    echo "-d -> Device to unlock, for example: /dev/sda1."
    echo "-n -> Name which the device will be identified with."
    echo "-m -> Mountpoint. For example: /mnt."
}

if [ $# -eq 0 ]; then
    echo "Using default device: ${device}, which will be identified as: ${name} and mounted to: ${mountpoint}."
fi

while getopts "chd:n:m:u" arg; do
    case ${arg} in
        c)
            close=1
            ;;
        h)
            usage
            exit 0
            ;;
        d)
            device=${OPTARG}
            ;;
        n)
            name=${OPTARG}
            ;;
        m)
            mountpoint=${OPTARG}
            ;;
        u)
            umount=1
            ;;
        \?)
            echo "Unknown option."
            ;;
    esac
done

if [ $USER != "root" ]; then
    echo "Must be root."
    exit 1
fi

if [ $umount -eq 1 ]; then
    path="/dev/mapper/${name}"
    umount "${path}"
    if [ $? -ne 0 ]; then
        echo "An error occurred while trying to umount device: ${path}."
        exit 1
    else
        echo "Device: ${path} was successfully unmounted."
    fi
fi

if [ $close -eq 1 ]; then
    path="/dev/mapper/${name}"
    cryptsetup luksClose "${path}"
    if [ $? -ne 0 ]; then
        echo "An error occurred while trying to close device: ${path}."
        exit 1
    fi
    echo "Device: ${path} was successfully closed."
    exit 0
fi

# If user didn't want to close device, then they want to unlock it.
cryptsetup luksOpen "${device}" "${name}"
if [ $? -ne 0 ]; then
    echo "An error occurred while trying to unlock device: ${device}."
    exit 1
fi

mount "/dev/mapper/${name}" /mnt
if [ $? -eq 0 ]; then
    echo "Device: ${device}, identified as: ${name} was successfully mounted at ${mountpoint}."
else
    echo "An error occurred while trying to mount device: ${device}."
    exit 1
fi

exit 0
