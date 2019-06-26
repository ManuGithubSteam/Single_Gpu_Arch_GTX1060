#!/bin/bash

if [ -f /tmp/from_kvm.txt ]; then

echo "Coming from VM, relaoding Plasma and VPN ...."

sleep 2
    
# restart plasma
killall plasmashell
killall plasmashell
sleep 15

plasmashell &

###

### wait till wlan is up again

sleep 15
systemctl restart openvpn-server@mullvad_se-got.service

xcalib -d :0 .local/share/DisplayCAL/display.icc 


# restart vpn
#nmcli device disconnect wlp0s26u1u4
#sleep 1
#sudo systemctl stop openvpn-server@mullvad_se-got.service
#sudo systemctl start openvpn-server@mullvad_se-got.service
#sleep 1
#nmcli device wifi connect CSN_Network
#rm /tmp/from_kvm.txt

echo "done"

fi

