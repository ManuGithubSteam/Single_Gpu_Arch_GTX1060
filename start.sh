#!/bin/bash
  
# Stop display manager
systemctl stop display-manager.service
systemctl stop sdd.service
#systemctl stop pulseaudio.service

# remove snd_hda

#modprobe -r snd_hda_intel

# was on

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind GPU VRAM -was on

#echo 0 > /sys/bus/pci/devices/0000\:00\:03.0/
#echo 0 > /sys/bus/pci/devices/0000:00:03.0/driver/bind
#echo 1 > /sys/bus/pci/devices/0000:00:03.0/driver/bind

# funbktioniert mit VRAM
#echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/remove

echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.0/remove
echo 1 > /sys/bus/pci/devices/0000\:00\:03.0/0000\:04\:00.1/remove

echo 1 > /sys/bus/pci/rescan

  
# Unbind EFI-Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind


## Unload the nvidia drivers
modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia
#modprobe -r snd_hda_intel

# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_04_00_0
virsh nodedev-detach pci_0000_04_00_1

# Unbind  USB Hubs
virsh nodedev-detach pci_0000_06_00_0
virsh nodedev-detach pci_0000_08_00_0
virsh nodedev-detach pci_0000_00_1d_0
virsh nodedev-detach pci_0000_00_1a_0
# sound 
#virsh nodedev-detach pci_0000_00_1b_0
  
# Load VFIO Kernel Module  
modprobe vfio-pci  
 
#sleep 1
