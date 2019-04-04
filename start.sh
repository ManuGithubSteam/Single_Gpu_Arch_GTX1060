#!/bin/bash
  
# Stop display manager
systemctl stop display-manager.service
systemctl stop sdd.service
systemctl stop pulseaudio.service

modprobe -r nvidia  
modprobe -r nvidia_drm
modprobe -r nvidia_modset

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind
# Unbind GPU VRAM
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove
echo 1 > /sys/bus/pci/rescan

  
# Unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

  
# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_04_00_0
virsh nodedev-detach pci_0000_04_00_1

# Unbind  USB Hubs
virsh nodedev-detach pci_0000_06_00_0
virsh nodedev-detach pci_0000_08_00_0
virsh nodedev-detach pci_0000_00_1d_0
virsh nodedev-detach pci_0000_00_1a_0
  
# Load VFIO Kernel Module  
modprobe vfio-pci  
 
sleep 1
