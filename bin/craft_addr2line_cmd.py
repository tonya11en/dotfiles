# Paste in stack trace output and it'll spit out the addr2line command.

import os
import sys

addresses = []

sentinel = ''
for l in iter(raw_input, sentinel):
  if " @ " in l:
    tmp = filter(lambda x: x.startswith("0x"), l.split())
    if len(tmp) > 0:
      addresses.append(tmp[0])

print "addr2line -fCe stargate.dbg " + " ".join(addresses)
