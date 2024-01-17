#!/bin/bash

SMP=`nproc`
CDROM=
HDA=
NAME="VM"
AMOUNT_OF_RAM=`free -h | awk '{print $2;}' | head -n 2 | tail -n 1 | cut -d 'G' -f 1 | cut -d '.' -f 1`
AMOUNT_OF_RAM="$((AMOUNT_OF_RAM/2))G"
PRETEND=0
VERBOSE=0
NOCOLOR="\e[0m"
RED="\e[1;31m"

usage() {
    echo "$0 usage:"
    echo
    echo -e "-c\t<cdrom>"
    echo -e "-H\tThis help."
    echo -e "-h\t<hard disk drive file>."
    echo -e "-n\t<VM name>. (1)"
    echo -e "-p\tPretend. In other words, just show the options it'll be run with."
    echo -e "-r\t<Amount of RAM> (2)"
    echo -e "-s\t<Amount of cores> (3)"
    echo -e "-v\tBe verbose."
    echo
    echo "1) Try not to use whitespaces in the VM name. If you do, qemu will complain."
    echo "2) If you don't specify the amount of RAM, this script will default to half your system's RAM."
    echo "3) If you don't specify the amount of cores, this script will default to all of your processor cores."
    echo "   You can also use the placeholder 'half' to just use half your processor's cores."
    echo
    echo "Notice that you can combine all of the options, except -H."
}

if [ $# -eq 0 ]; then
    usage
    exit 0
fi

while getopts "c:Hh:n:pr:s:v" arg; do
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
        p)
            PRETEND=1
            ;;
        r)
            AMOUNT_OF_RAM="${OPTARG}"
            ;;
        s)
            if [ $OPTARG == "half" ]; then
                SMP=`nproc`
                SMP=$((SMP/2))
            elif [[ $OPTARG != ?(-)+([[:digit:]]) ]]; then
                echo -e "${RED}-s <number of cores>${NOCOLOR} must be a number."
                exit 1
                SMP=$OPTARG
            fi
            ;;
        v)
            VERBOSE=1
            ;;
    esac
done

ARGS="-cpu host -smp ${SMP} \
-enable-kvm -m ${AMOUNT_OF_RAM} \
-hda ${HDA} \
-netdev user,id=vmnic,hostname=${NAME} \
-device virtio-net,netdev=vmnic \
-name ${NAME}"

[ -z ${CDROM} ] && ARGS="${ARGS} -boot c" || ARGS="${ARGS} -boot d -cdrom ${CDROM}"

if [ $VERBOSE -eq 1 ]; then
    echo "Running with options:"
    echo "${ARGS}"
    echo
fi

if [ $PRETEND -gt 0 ]; then
    exit 0
fi

qemu-system-x86_64 ${ARGS}
