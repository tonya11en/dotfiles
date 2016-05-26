import sys

# Open all the files and add the lines to the stargate_info array
# TODO: use readline() for huge files...
stargate_info = []
for stargate_info_file in sys.argv[1:]:
  f = open(stargate_info_file, 'r')
  stargate_info += f.read().splitlines()
  f.close()

# Filter out all but the "Episode X primary/replica Y" lines we care about.
# At the end, we'll end up with lines like:
# 'I1221 11:52:32.848860 19443 stargate_cluster_state.cc:3958] Episode 16 primary 36'
def is_relevant_episode_replica_info(stargate_info_entry):
  relevant = "stargate_cluster_state.cc" in stargate_info_entry
  relevant = relevant and "Episode" in stargate_info_entry
  return relevant

episode_lines = filter(is_relevant_episode_replica_info, stargate_info)

# Count up the primary/replica disks.

# Episode info maps episode number -> primary/secondary -> disk ID -> count
episode_info = {}
for ll in episode_lines:
  tmp = ll.split("] ")[1]
  episode_num = tmp.split()[1]
  replica_type = tmp.split()[2]
  disk_id = tmp.split()[3]
  if not episode_num in episode_info.keys():
    episode_info.update({episode_num : {"primary" : {},
                                        "replica" : {}}})
  if disk_id in episode_info[episode_num][replica_type].keys():
    episode_info[episode_num][replica_type][disk_id] += 1
  else:
    episode_info[episode_num][replica_type][disk_id] = 1

node_wide_replicas = {}
for ep_number in episode_info.keys():
  print "====================================================================="
  print "Episode %s: " % ep_number
  print "Primary disks: " + str(episode_info[ep_number]["primary"].keys())
  primary_total = 0
  for disk in episode_info[ep_number]["primary"]:
    primary_total += episode_info[ep_number]["primary"][disk]
  print "Primary total: " + str(primary_total)
  for disk in episode_info[ep_number]["primary"]:
    print "Disk " + disk + " percentage: " + \
          str(float(episode_info[ep_number]["primary"][disk])/float(primary_total) * 100.0)
  print "Replica disks: " + str(episode_info[ep_number]["replica"].keys())
  replica_total = 0
  for disk in episode_info[ep_number]["replica"]:
    if not disk in node_wide_replicas.keys():
      node_wide_replicas[disk] = 1
    else:
      node_wide_replicas[disk] += 1
    replica_total += episode_info[ep_number]["replica"][disk]
  print "Replica total: " + str(replica_total)
  for disk in episode_info[ep_number]["replica"]:
    print "Disk " + disk + " percentage: " + \
          str(float(episode_info[ep_number]["replica"][disk])/float(primary_total) * 100.0)

node_wide_replica_total = 0
for num in node_wide_replicas.values():
  node_wide_replica_total += num

print "====================================================================="
print "Total replica count: " + str(node_wide_replica_total)
for k in node_wide_replicas.keys():
  print "Disk %s percentage: %s" % (str(k), str(100.0 * float(node_wide_replicas[k])/float(node_wide_replica_total)))
