#!/bin/bash

sudo qemu-img create -f qcow2 gc-win7.img 16G

sudo kvm -m 2048 -cdrom win7.iso -drive file=gc-win7.img,if=virtio -drive file=virtio-win-0.1-52.iso,index=3,media=cdrom -net nic,model=virtio -net user -nographic -vnc :9 -usbdevice tablet
