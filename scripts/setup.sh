sudo ovs-vsctl set Open_vSwitch . other_config:tc-policy=none
sudo ovs-vsctl set Open_vSwitch . other_config:hw-offload=true
sudo /usr/local/share/openvswitch/scripts/ovs-ctl --system-id=random restart
