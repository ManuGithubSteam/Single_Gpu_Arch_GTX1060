#!/bin/bash
 
# Unload VFIO-PCI Kernel Driver
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# remove dev from windows
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove

# Ubind GPU VRAM
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.0/remove
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.1/remove
# Rescan for the new devies
echo 1 > /sys/bus/pci/rescan

# Reload the kernel modules
#modprobe -r snd_hda_intel
modprobe  -a nvidia_drm
modprobe  -a nvidia_modeset
modprobe  -a nvidia


# Re-Bind  USB Hubs
virsh nodedev-reattach pci_0000_06_00_0
virsh nodedev-reattach pci_0000_08_00_0
virsh nodedev-reattach pci_0000_00_1d_0
virsh nodedev-reattach pci_0000_00_1a_0

# Re-Bind the Tyys to linux
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Re-Bind the EFI Framebuffer
nvidia-xconfig --query-gpu-info > /dev/null 2>&1
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

sleep 2

# Restart Display Manager
systemctl start display-manager.service

###########
## Some convienice stuff
##########

## Get KDE recognise that we come from vm
touch /tmp/from_kvm.txt
chmod 777 /tmp/from_kvm.txt