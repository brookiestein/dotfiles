#!/bin/bash

CDROM=
HDA=
NAME="VM"
AMOUNT_OF_RAM="4G"
VERBOSE=0

usage() {
    echo "$0 usage:"
    echo
    echo -e "-c\t<cdrom>"
    echo -e "-H\tThis help."
    echo -e "-h\t<hard disk drive file>."
    echo -e "-n\t<VM name>."
    echo -e "-r\t<Amount of RAM> (Default is 4G)."
    echo -e "-v\tBe verbose."
    echo
    echo "Try not to use whitespaces in the VM name. If you do, qemu will complain."
    echo "Notice that you can combine all of the options, except -H."
}

while getopts "c:Hh:n:r:v" arg; do
    case ${arg} in
        c)
            CDROM=$OPTARG
            ;;
        h)
            HDA=$OPTARG
            ;;
        H)
            usage
            exit 0
            ;;
        n)
            NAME=$OPTARG
            ;;
        r)
            AMOUNT_OF_RAM=$OPTARG
            ;;
        v)
            VERBOSE=1
            ;;
    esac
done

ARGS="-cpu host -smp 4 -enable-kvm -m ${AMOUNT_OF_RAM} \
-hda ${HDA} \
-netdev user,id=vmnic,hostname=${NAME} \
-device virtio-net,netdev=vmnic \
-name ${NAME}"

[ -n ${CDROM} ] && ARGS="${ARGS} -boot d -cdrom ${CDROM}" || ARGS="${ARGS} -boot c"

if [ $VERBOSE -eq 1 ]; then
    echo "Running with options:"
    echo "${ARGS}"
    echo
fi

qemu-system-x86_64 ${ARGS}
