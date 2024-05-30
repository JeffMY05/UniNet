sudo ip link add br-test type bridge
sudo ip link set enp8s0 master br-test
sudo ip addr flush dev enp8s0
sudo ip addr add 99.99.99.4/24 dev br-test
sudo ip link set br-test up
