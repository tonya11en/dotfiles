"""
tallen@nutanix.com

Usage: ./compare_release_perf.py before.txt after.txt
"""

import json, os, sys

before_fd = open(sys.argv[1], 'r')
before_raw = before_fd.read()

after_fd = open(sys.argv[2], 'r')
after_raw = after_fd.read()

before_json = json.load(before_fd)

print before_json

close(before_fd)
close(after_fd)
