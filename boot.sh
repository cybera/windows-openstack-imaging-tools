#!/bin/bash

#IMAGE=windows-server-2012-r2.qcow2
IMAGE=win7.img
FLOPPY=Autounattend.vfd
#VIRTIO_ISO=virtio-win-0.1-74.iso
VIRTIO_ISO=virtio-win-0.1-52.iso
#ISO=9600.16384.WINBLUE_RTM.130821-1623_X64FRE_SERVER_EVAL_EN-US-IRM_SSS_X64FREE_EN-US_DV5.ISO
ISO=win7.iso

KVM=/usr/libexec/qemu-kvm
if [ ! -f "$KVM" ]; then
    KVM=/usr/bin/kvm
fi

qemu-img create -f qcow2 -o preallocation=metadata $IMAGE 16G

sudo $KVM -m 2048 -smp 2 -net nic -net user -cdrom $ISO -drive file=$VIRTIO_ISO,index=3,media=cdrom -fda $FLOPPY $IMAGE -boot d -vga std -k en-us -vnc 127.0.0.1:1

#
# This does not work, the install won't work if the disk is virtio
# sudo $KVM -m 2048 -smp 2 -net nic -net user -cdrom $ISO -drive file=$VIRTIO_ISO,index=3,media=cdrom -fda $FLOPPY -drive file=$IMAGE,if=virtio -boot d -vga std -k en-us -vnc :1


#
# To boot afterwards with virtio...
#
#  sudo /usr/bin/kvm -m 2048 -smp 2 -net nic,model=virtio -net user -drive file=win7.img,if=virtio -boot d -vga std -k en-us -vnc :1
