#!/bin/bash
 
# Unload VFIO-PCI Kernel Driver
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# remove dev from windows
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove

echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.0/remove
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.1/remove

echo 1 > /sys/bus/pci/rescan

# Reload the kernel modules
#modprobe -r snd_hda_intel
modprobe  -a nvidia_drm
modprobe  -a nvidia_modeset
modprobe  -a nvidia

# Unbind GPU VRAM
#echo 0 > /sys/bus/pci/devices/0000\:00\:03.0/remove
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/enable

#echo  "0000:04:00.0" > /sys/bus/pci/drivers/nvidia/bind
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove
#echo 1 > /sys/bus/pci/rescan

#modprobe -r vfio-pci
#sleep 2
#modprobe -r vfio_iommu_type1
#sleep 2
#modprobe -r vfio
#sleep 2
# Reload the kernel modules. This loads the drivers for the GPU
#modprobe snd_hda_intel
#sleep 5
#modprobe nvidia
#sleep 5
#modprobe nvidia_drm
#sleep 2
#modprobe nvidia_modeset
#sleep 2
#modprobe nvidia
#sleep 5

  
# Re-Bind GPU to Nvidia Driver
#virsh nodedev-reattach pci_0000_04_00_1
#virsh nodedev-reattach pci_0000_04_00_0

# Unbind GPU VRAM
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove
#echo 1 > /sys/bus/pci/rescan


# Re-Bind  USB Hubs
virsh nodedev-reattach pci_0000_06_00_0
virsh nodedev-reattach pci_0000_08_00_0
virsh nodedev-reattach pci_0000_00_1d_0
virsh nodedev-reattach pci_0000_00_1a_0
# Re bind sound
#virsh nodedev-reattach pci_0000_00_1b_0


# Load nvidia ?
#modprobe nvidia
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

nvidia-xconfig --query-gpu-info > /dev/null 2>&1
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
 
#modprobe -f nvidia

#systemctl stop libvirtd

sleep 2

# Restart Display Manager
systemctl start display-manager.service


