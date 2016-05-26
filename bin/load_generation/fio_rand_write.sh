#
# Copyright (c) 2013 Nutanix Inc. All rights reserved.
#
# Author: rohit@nutanix.com
#
# $1 = number of disks
# $2 = runtime in seconds
# $3 = block size

# Disk names and the ioengine depend on the hypervisor hosting the uvms.
io_engine="libaio"
if [ -b "/dev/vdb" ]
then
  file_prefix="vd"
else
  file_prefix="sd"
fi

UNAME=`uname`
if [[ $UNAME == Linux* ]]; then
  disk_list=`python -c "
disk_list=[]
for ii in range($1):
  disk_list.append(\"/dev/$file_prefix%s\"%chr(ord(\"b\")+ii))
print \":\".join(disk_list)"`
elif [[ $UNAME == CYGWIN* ]]; then
  io_engine="windowsaio"
  disk_list='\\.\PhysicalDrive1'
  for i in `seq $1`; do if [ $i -ne 1 ]
  then disk_list=$disk_list':\\.\PhysicalDrive'$i; fi; done
else
  echo "Unknown UVM OS"
  exit -1
fi

time_based="--time_based"
num_outstanding=128

/home/nutanix/fio --filename=$disk_list --direct=1 --rw=randwrite --bs=$3 --iodepth=$num_outstanding --runtime=$2 --group_reporting --name=file1 --ioengine=$io_engine $time_based
