#slcli vs create --test \
# --hostname=tvcws01 --domain=tvc.local \
# --datacenter=tok02 --billing=monthly --os=CENTOS_LATEST_64 \
# --cpu=2 --memory=4096 --disk=100 --network=100 \
# --postinstall=https://raw.githubusercontent.com/kentarok/provisioning/master/tvcchefw_config \
# --key=chefws_public --vlan-private=xxxxxxx

for i in {1..26};\
  do name=$(printf tvcnode%03d $i);\
    slcli vs create --test \
     --hostname=$tvcnode --domain=tvc.local \
     --datacenter=tok02 --billing=hourly --os=CENTOS_LATEST_64 \
     --cpu=1 --memory=1024 --disk=100 --network=100 \
     --postinstall=https://raw.githubusercontent.com/kentarok/provisioning/master/tvcchefn_config \
     --key=chefnode_public --vlan-private=xxxxxxx
done;

#slcli vs create --test \
# --hostname=tvcnode --domain=tvc.local \
# --datacenter=tok02 --billing=hourly --os=CENTOS_LATEST_64 \
# --cpu=1 --memory=1024 --disk=100 --network=100 \
# --postinstall=https://raw.githubusercontent.com/kentarok/provisioning/master/tvcchefn_config \
# --key=chefnode_public --vlan-private=xxxxxxx
