"""
Author: tallen@nutanix.com

This is a script to give the % change in performance numbers between
diagnostics.py runs.
"""

import sys

if (len(sys.argv) != 3):
  print 'Invalid number of args.'
  sys.exit(1)

before = map(lambda x: x.split(), open(sys.argv[1]).read().splitlines())
after = map(lambda x: x.split(), open(sys.argv[2]).read().splitlines())
assert(len(before) == len(after))

def get_titles(line_list):
  title_lines = filter(lambda x: ("bandwidth\"" in x) or ("IOPS\"" in x),
                       line_list)
  return map(lambda l: " ".join(l).split("\"")[1], title_lines)


before_titles = get_titles(before)
after_titles = get_titles(after)
assert(len(before_titles) == len(after_titles))

def get_cpu(line_list):
  cpu_lines = filter(lambda x: "CPU:" in x, line_list)
  if len(cpu_lines) != len(before_titles):
    return cpu_lines[1:]
  else:
    return cpu_lines

before_cpu = get_cpu(before)
after_cpu = get_cpu(after)
assert(len(before_cpu) == len(after_cpu))

def get_numbers(line_list):
  line = filter(lambda x: ("bandwidth" in x) or ("IOPS" in x) or ("MBps" in x),
                line_list)
  return map(lambda x: x[0], line)

before_nums = get_numbers(before)
after_nums = get_numbers(after)
assert(len(before_nums) == len(after_nums))

assert(len(before_nums) == len(before_cpu) and
       (len(before_titles) == len(before_nums)))
def process():
  for i in range(len(before_titles)):
    print "\n-----\n"
    before_num_val = float(before_nums[i])
    after_num_val = float(after_nums[i])
    pct_diff = after_num_val / before_num_val
    print before_titles[i]
    if pct_diff < 100.0:
      print "-" + str(pct_diff) + '%'
    else:
      print "+" + str(pct_diff - 1) + '%'
    print "BEFORE - " + str(before_cpu[i])
    print "AFTER - " + str(after_cpu[i])
  print "\n-----\n"

process()
