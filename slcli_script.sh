#!/bin/sh

## Chef WS Virtual Server
#slcli vs create \
# --domain=tvc.local --datacenter=tok02 --billing=monthly --os=CENTOS_LATEST_64 \
# --cpu=2 --memory=4096 --disk=100 --network=100 \
# --postinstall=https://raw.githubusercontent.com/kentarok/provisioning/master/tvcchefw_config \
# --key=chefw_public --vlan-private=xxxxxxx \
# --test --hostname=tvcws01

## Chef Node 1~26 Virtual Server
for i in {1..26}
  do name=$(printf tvcnode%02d $i)
    echo "\
slcli vs create \
 --domain=tvc.local --datacenter=tok02 --billing=hourly --os=CENTOS_LATEST_64 \
 --cpu=1 --memory=1024 --disk=25 --network=100 \
 --postinstall=https://raw.githubusercontent.com/kentarok/provisioning/master/tvcchefn_config \
 --key=chefn_public --vlan-private=xxxxxxx \
 --test --hostname=$name \n"
done
