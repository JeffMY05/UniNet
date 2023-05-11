for (( i=0; i<$2; i++ ))
do
	virsh vcpupin $1 $(($3+$i)) $(($4+$i)) 
done
