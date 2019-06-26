#!/bin/bash
  
#####
# NETWORK && GENERAL FUNCTION
######

# load some needed modules and start bridged net
modprobe virtio-net    
modprobe virtio-balloon
modprobe virtio-blk 
modprobe virtio-scsi   
systemctl start libvirtd.service 
virsh net-start default

#####
# GRAPHICS CARD
######

# Stop display manager
systemctl stop display-manager.service
systemctl stop sdd.service

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind GPU VRAM 
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.0/remove
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.1/remove
# Rescan devies so libvirt can claim them
echo 1 > /sys/bus/pci/rescan
  
# Unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

## Unload the nvidia drivers
modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia

# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_04_00_0
virsh nodedev-detach pci_0000_04_00_1

####
# USB Devices
####

# Unbind  USB Hubs - these must be added in the devices
virsh nodedev-detach pci_0000_06_00_0
virsh nodedev-detach pci_0000_08_00_0
virsh nodedev-detach pci_0000_00_1d_0
virsh nodedev-detach pci_0000_00_1a_0
# USB 3
virsh nodedev-detach pci_0000_06_00_0
virsh nodedev-detach pci_0000_08_00_0

####
# SOUND
####

# sound - remove the generic sound device and add the pci sound device 
virsh nodedev-detach pci_0000_00_1b_0
  
####
# START
####

# Load VFIO Kernel Module  
modprobe vfio-pci  
 
#sleep 1
