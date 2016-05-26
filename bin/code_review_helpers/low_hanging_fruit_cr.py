import sys, re

assert(len(sys.argv[1]))

print sys.argv[1]
f = sys.argv[1]
data = open(f, 'r').readlines()

#------------------------------------------------------------------------------

def refs_and_ptr_placement(line):
  return re.search("[A-Za-z0-9]\* | &[A-Za-z0-9]", line)

#------------------------------------------------------------------------------

def ending_space(line):
  """
  Catch any trailing spaces.
  """
  return line.endswith(" \n") and line.startswith("+")

#------------------------------------------------------------------------------

def operator_spacing(line):
  if "#include" in line or line.startswith("+++"):
    return False

  exp = "[A-Za-z0-9][+,-,\*,\/][A-Za-z0-9]"
  return bool(re.search(exp, line)) and line.startswith("+")

#------------------------------------------------------------------------------

def double_newline(line1, line2):
  return line1 == line2 and line1 == "+\n"

#------------------------------------------------------------------------------

def plusplus(line):
  return re.search("[A-Za-z0-9]\+\+|[A-Za-z0-9]\-\-", line)

#------------------------------------------------------------------------------

def is_filename(line):
  return line.startswith("Index: ")

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

def badline(line):
  return ending_space(line)

def print_fail(err):
  print "\033[91m[ISSUE]" + err + "\033[0m"

def run():
  for idx, l in enumerate(data):
    if is_filename(l):
      print l
      continue
    if ending_space(l):
      print_fail("Ending space:")
      print l
      continue
    if operator_spacing(l):
      print_fail("Possible weird space issue around operator:")
      print l
      continue
    if idx + 1 < len(data) and double_newline(l, data[idx + 1]):
      print_fail("Double newline:")
      print l
      print data[idx + 1]
      continue
    if refs_and_ptr_placement(l):
      print_fail("* right, & left:")
      print l
      continue
    if plusplus(l):
      print_fail("pre-increment/decrement here:")
      print l


run()
