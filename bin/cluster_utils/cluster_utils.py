#! /usr/bin/python
# Author: tallen@nutanix.com

import json
import requests
import os

class ClusterConnector(object):

  def __init__(self, cvm_ip, username="nutanix", password="nutanix/4u"):
    self.username = username
    self.password = password
    self.default_cvm = cvm_ip
    self.svmips = []
    self.sp_name = ""
    self.fork_command("sudo service iptables stop")

  #----------------------------------------------------------------------------

  def run_cmd_cvm(self, cmd, cvm_ip=""):
    if cvm_ip == "":
      cvm_ip = self.default_cvm
    # Using os.popen because paramiko exec_command is non-blocking.
    real_cmd = "source /etc/profile; " + cmd
    return os.popen("sshpass -p %s ssh %s@%s \"%s\"" %
                    (self.password, self.username, cvm_ip, real_cmd)).read()

  #----------------------------------------------------------------------------

  def fork_command(self, cmd):
    for i in self.__svm_ips():
      print self.run_cmd_cvm(cmd, cvm_ip=i)

  #----------------------------------------------------------------------------

  def create_and_mount_ctr(self, ctr_name):
    print "Creating container named " + ctr_name + ":"
    print self.run_cmd_cvm("ncli ctr create sp-name=%s name=%s" %
                           (self.__sp_name(), ctr_name))
    self.run_cmd_cvm("sudo yum install -y showmount")
    self.run_cmd_cvm("mkdir -p ~/tony/%s" % ctr_name)
    self.run_cmd_cvm("sudo mount 192.168.5.2:/%s ~/tony/%s" %
                     (ctr_name, ctr_name))
    print "Mounted under ~/tony/" + ctr_name

  #----------------------------------------------------------------------------

  def run_fio_rand_write(self, run_time, ctr_name):
    io_engine = "libaio"
    fio_cmd = "fio --ioengine " + io_engine + " --bs=4k --rw=randwrite " + \
      "--direct=0 --size=4G --numjobs=8 --runtime=" + str(run_time) + \
      " --time_based --directory=/home/nutanix/tony/" + ctr_name + \
      " --filename=tony.test --name=randomtest --iodepth=64"
    # Install fio on CVM.
    self.run_cmd_cvm("sudo yum install -y fio")
    print "Running fio test cmd: " + fio_cmd
    self.run_cmd_cvm(fio_cmd)

  #----------------------------------------------------------------------------

  def drop_new_stargate(self, stargate_binary):
    os.system("sshpass -p %s scp %s %s@%s:/home/nutanix/stargate.new" %
      (self.password, stargate_binary, self.username, self.default_cvm))

  #----------------------------------------------------------------------------

  def install_new_stargate(self):
    self.fork_command("genesis stop stargate ; " +
                      "cp ~/bin/stargate ~/stargate.old ; " +
                      "cp ~/stargate.new ~/bin/stargate ; " +
                      "sleep 30")

  #----------------------------------------------------------------------------

  def get_rtp_diagnostics_images(self, hypervisor):
    assert(hypervisor == "kvm" or \
           hypervisor == "hyperv" or \
           hypervisor == "esx")
    server_ip = "filer.rtp.nutanix.com"
    location = \
      "/mnt/ZFS/GoldImages/diagnostics_GoldImage/latest/%s/" % hypervisor
    img_dir = "~/data/images/diagnostics"
    print "Creating directory on CVM: " + img_dir
    self.run_cmd_cvm("mkdir -p %s" % img_dir)
    print "Installing sshpass."
    self.run_cmd_cvm("sudo yum install -y sshpass")
    print "Copying diagnostics images."
    self.run_cmd_cvm("sshpass -p nutanix/4u scp %s:%s* %s" %
                     (server_ip, location, img_dir))

  #----------------------------------------------------------------------------

  def __sp_name(self):
    if self.sp_name == "":
      sp_raw = self.run_cmd_cvm("ncli sp ls")
      for l in sp_raw.splitlines():
        print l
        if (len(l.split()) > 2) and l.split()[0] == "Name":
          self.sp_name = l.split()[2]
          break
    return self.sp_name

  #----------------------------------------------------------------------------

  def __svm_ips(self):
    if self.svmips == []:
      self.svmips = self.run_cmd_cvm("svmips").split()
    return self.svmips
