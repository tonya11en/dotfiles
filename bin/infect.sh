#! /bin/bash

# Get local public key.
local_pub_key="$( cat ~/.ssh/id_rsa.pub )"

# Inject the local public key.
inject_key (){
  svmips_bin="/usr/local/nutanix/cluster/bin/svmips"
  ssh nutanix@$1 \
  "source /etc/profile ; for i in \`$svmips_bin\`; do ssh \$i \"echo $local_pub_key >> /home/nutanix/.ssh/authorized_keys2\"; done"
}
inject_key $1

# Get SVM IPs.
svmips="$( ssh nutanix@$1 "source /etc/profile; svmips" )"
echo Grabbed svmips: $svmips

# Commands to run on each node.
stop_iptables="sudo service iptables stop;"
make_agave_dir="mkdir -p /home/nutanix/agave;"
for i in $svmips; do ssh nutanix@$i $stop_iptables $make_agave_dir; done;

# Copy agave keys to cluster.
for i in $svmips; do scp $TOP/installer/ssh_keys/* nutanix@$i:/home/nutanix/agave/; done;
