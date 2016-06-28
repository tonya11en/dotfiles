#! /usr/bin/python

import os, sys, json

assert(len(sys.argv) == 3)

# Get the old json.
old_filename = sys.argv[1]
old_data = open(old_filename, 'r').readlines()
# Get the last json in the file.
start_idx = 0
for idx in range(len(old_data)):
  if old_data[idx].startswith("{\n"):
    start_idx = idx
old_dict = json.loads("".join(old_data[start_idx:]))

new_filename = sys.argv[2]
new_data = open(new_filename, 'r').readlines()
# Get the last json in the file.
start_idx = 0
for idx in range(len(new_data)):
  if new_data[idx].startswith("{\n"):
    start_idx = idx
new_dict = json.loads("".join(new_data[start_idx:]))

def print_general_info():
  hypervisor = old_dict["hypervisor"]
  old_release_version = old_dict["release_version"]
  new_release_version = new_dict["release_version"]
  print "================================================================"
  print "Old release version:"
  print old_release_version + "\n"
  print "New release version:"
  print new_release_version + "\n"

def print_result_comparison():
  def make_tuples(entry):
    return (entry["description"], entry["result"], entry["stddev_pct"])

  def filter_unwanted(tup):
    return (not tup[1] == "unavailable")

  old_results = map(make_tuples, old_dict["results"])
  old_results = filter(filter_unwanted, old_results)
  new_results = map(make_tuples, new_dict["results"])
  new_results = filter(filter_unwanted, new_results)

  print "| Description | Percent Change | Old/New Standard Dev. |"

  comparison_dict = {}
  for (desc, val, stddev) in old_results:
    comparison_dict[desc] = (float(val), str(stddev) + " / ")
  for (desc, val, stddev) in new_results:
    assert desc in comparison_dict.keys()
    if val == 0:
      pct_diff = "inf"
    else:
      pct_diff = 1 - float(comparison_dict[desc][0])/float(val)
    comparison_dict[desc] = (pct_diff, str(comparison_dict[desc][1]) + str(stddev))
    print "| %s | %.2f%% | %s |"   % (desc, float(comparison_dict[desc][0]), str(comparison_dict[desc][1]))

print_general_info()
print_result_comparison()
