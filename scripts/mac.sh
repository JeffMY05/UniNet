#!/bin/bash
VF_num=${1:-1}
#sudo ip addr flush dev ens1f0
#sudo ip addr add 99.99.99.1/24 dev ens1f0
#sudo ip addr flush dev br-sriov
#sudo ifconfig br-sriov mtu 9000
#up_test=$(ip a show br-sriov up)
#echo $up_test
#if [ -z $up_test ] ; then
#	sudo ip link set br-sriov up
#fi
sudo ifconfig ens1f0 mtu 9000
sudo ifconfig br-sriov mtu 9000
pf_mac="00:0a:35:0b:34:"
base=0x21
for (( i=0; i<$VF_num; i++ )); do 
	vf_mac=$(printf '%x' $(($base+0x4*$i+0x4)))
	# set MAC addresses 
	sudo ip link set address ${pf_mac}${vf_mac} dev ens1f0v${i}rep
	sudo ip link set address ${pf_mac}${vf_mac} dev ens1f0v${i}
	# start vfs
	sudo ip link set ens1f0v${i}rep up
	sudo ip link set ens1f0v${i} up
	# set vf mtu size
	sudo ifconfig ens1f0v${i}rep mtu 9000
	sudo ifconfig ens1f0v${i} mtu 9000
	# print
	ip a | grep ens1f0v -A 1

	#this_ns=sriov-test-${i}
	#up_test=$(ip a show ens1f0v${i}rep up)
	#if [ -z $up_test ] ; then
	#	sudo ip link set ens1f0v${i}rep up
	#fi
	## set namespace
	#ns_test=$(sudo ip netns list | grep ${this_ns})
	#if [ -z $ns_test ] ; then
	#	sudo ip netns add ${this_ns} 
	#fi
	#sudo ip link set dev ens1f0v${i} netns ${this_ns}

	## set inf up 
	#up_test=$(sudo ip netns exec ${this_ns} ip a show ens1f0v${i} up)
	#if [ -z $up_test ] ; then
	#	sudo ip netns exec ${this_ns} sudo ip link set ens1f0v${i} up
	#fi
	#
	## assign new IP address 
	#sudo ip netns exec ${this_ns} ip addr add 99.99.99.$(($i+200))/24 dev ens1f0v${i}

	## check inf in ovs
	#ovs_test=$(sudo ovs-vsctl show | grep ens1f0v${i})
	#if [ -z $ovs_test ] ; then
	#	sudo ovs-vsctl add-port br-sriov ens1f0v${i}rep
	#fi
done

