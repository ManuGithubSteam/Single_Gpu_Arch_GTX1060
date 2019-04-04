#!/bin/bash

modprobe virtio-net
modprobe virtio-balloon
###modprobe virtio
modprobe virtio-blk
modprobe virtio-scsi
#modprobe virtio-serial
virsh net-start default
#modprobe vfio-pci
